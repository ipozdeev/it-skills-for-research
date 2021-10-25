# data management

<!-- TOC -->

- [data management](#data-management)
  - [introduction](#introduction)
  - [data storage](#data-storage)
  - [data flow](#data-flow)
  - [memoization](#memoization)
  - [chunking](#chunking)
  - [example: directory tree](#example-directory-tree)
    - [file types](#file-types)
    - [API](#api)
  - [example: SQL database](#example-sql-database)
    - [API](#api-1)
  - [resources](#resources)
  - [exercises](#exercises)

<!-- /TOC -->

## introduction

Efforts to optimize the way data enters your research pay off in the long run. Quite some time can be lost on finding that nice dataset of commodity prices you used two years ago; on updating it with fresh values; on sharing it with your colleagues or reusing in a different project. Even more time can get wasted on other people trying to reproduce your results with their own data. A well structured data management process could boost both your own efficiency and that of researchers following in your footsteps.

Data management consists of organizing both data storage and data flow. The former has to do with the structure and format of the stock of your data as well as whether data is project-specific or to be reused many times over; the latter deals with how that stock of data is being created and delivered to endpoint functions (for an example of an endpoint function, think calculation of descriptive statistics).

The following assumes that data can be represented as a table, as most economic and time series data does.


## data storage

In general (e.g. as suggested by the [cookiecutter data science project template](https://github.com/drivendata/cookiecutter-data-science)), each project is associated with project-specific data and calls for a dedicated storage within the project folder (here, `data/`):
```
my-project/
  data/
  src/
  ...
```
However, if a dataset is reused at least once in a different project, it might be a good idea to put it in a centralized database where all projects would be able to access it.

The centralized database can have any architecture: a directory tree with text or binary files, a local SQL database, an external provider etc. &ndash; as long as the data flow routines are coded *comme il faut*.


## data flow

Similar to oil, you can think of two ways data can flow:
*   **upstream**: into a database for storage;
*   **downstream**: from a database for usage in endpoint functions.

Separating up- from downstream is a matter of taste, but does keep the code repository tidier. Functions responsible for the two are quite different: upstreams tend to run either once or at regular intervals, whereas downstreams &ndash; each time an endpoint function is run (which happens dozens of times  early into the project); downstreams are often memoizable (to be discussed later), whereas the upstreams are not; upstreams involve authentication more frequently; downstreams are most often shareable, whereas upstreams are most often not or useless in being such (think proprietary datasets).

Together, the two constitute a database's application programming interface, or API &ndash; a way for endpoint functions to talk to the database. A good API would provide methods for:
1.  establishing a connection to;
2.  pulling data from;
3.  putting data into;
4.  updating data in

the database. A common layout for a database API would be, using Python as the example:
```python
research-data/
  __init__.py
  utilities.py
  connect.py
  downstream.py
  upstream.py
  recipes.py
```

Here, `connect` provides a way to establish a connection to the database to be reused in other modules. Functions and methods in `downstream` start with `get_`, those in `upstream` with `put_`. Module `recipes` keeps commonly used procedures to manipulate the raw data to deliver it to the endpoint functions, such as transformation of prices (delivered in the raw form by `downstream`) to returns.


## memoization

Functions can be expensive to evaluate, such that much time is lost on waiting for them to finish. If such an expensive function is deterministic (produces the same output given the same input), it can be [memoized](https://en.wikipedia.org/wiki/Memoization), or made to return a cached version of the output when run with the same input. Since datafeed operations can be expensive (in terms of time or, indeed, money, as subsequent calls to a commercial database such as Bloomberg can be costly), memoization saves the researcher hours, so let us quickly discuss it here.
Memoization refers to remembering the results of a function call based on the input arguments and then returning the remembered result rather than computing the result again. Its _raison d'etre_ is the diverging price of hard disk space and the human coder's time. Based on the idea, it is pretty easy to write memoization functions yourself, but of course there are several solutions available for popular languages.

For Python, the amazing [`joblib`](https://joblib.readthedocs.io/en/latest/) library does the trick. In the preamble to `datafeed.py`, you provide the path to keep cache in, set up a Memory object and use it to decorate every function to be memoized:
```python
from joblib import memory

cachedir = "./datacache"  # set up cache directory
memory = Memory(cachedir) # initialize Memory object

# define and decorate function
@memory.cache
def expensive_function():
  pass
```

For R, [memoize](https://cran.r-project.org/web/packages/memoise/index.html) looks like a solution.

## chunking
Sometimes (in machine learning applications, for instance) the amount of data needed for a task becomes large relative to the amount of RAM on your machine. When this happens, loading the complete dataset into the memory is no longer an option, and _chunking_ is needed. In most languages, _chunking_ is implemented as a [generator](https://en.wikipedia.org/wiki/Generator_(computer_programming)) and constitutes repeated calls to a database. See, for instance, `chunksize` parameter in `pandas` IO section.


## example: directory tree

A rather straightforward solution is to put all files that contain data in one folder outside your project &ndash; let's call it `research-database`. In general, it is a good idea is to upload this folder to cloud storage such as Google Drive, Yandex.Disk or the like and ensure it being synchronized. To be able to reference the folder without specifying its absolute or relative path, let us also set up an [environment variable](./project-environment.md#environment-variables) called `RESEARCH_DATA_PATH` and set its value to wherever the folder is located.


### file types

#### text
Text files such as `.csv`, `.xml` or `.json` are a frequent choice, being human- and Excel-readable and easily shareable. However, they are also bulky, slow to be input/output and subject to comma vs. dot, encoding and similar problems.

#### serialization of objects
Serialization is the action of transforming an object such as a data frame to a string of bytes from which it can be recovered without a loss. It is a quick solution to preserve data, fast and relatively memory efficient, but not easily shareable across languages and even versions of the software used to perform the serialization.
- Python: [`pickle`](https://docs.python.org/3/library/pickle.html) or [`pandas`/`pickle`](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.to_pickle.html)
- R: [`serialize`](https://stat.ethz.ch/R-manual/R-devel/library/base/html/serialize.html)

#### HDF
[HDF](https://www.hdfgroup.org/solutions/hdf5/) is a format for storing hierarchical data. It is best suited for large (even gigantic) organized and reasonably stationary (not changing too frequently) datasets and allows to store metadata. HDF lets you query data in chunks in a memory-efficient way and is shareable across languages. On the other hand, it is somewhat inflexible (hard to recover space after deleting data).

- Python: [`h5py`](https://www.h5py.org/) or [`pandas/hdf`](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.to_hdf.html)
- R: [`rhdf5`](https://bioconductor.org/packages/release/bioc/html/rhdf5.html)

#### feather
[Feather](https://arrow.apache.org/docs/python/feather.html) is a language-agnostic data frame storage, super handy for those switching between R, Python and Julia or having colleagues programming in a different language.

- Python: [`pyarrow`](https://arrow.apache.org/docs/python/feather.html) or [`pandas/feather`](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.to_feather.html)
- R: [`arrow`](http://arrow.apache.org/docs/r/)


### API
Since the database is but a folder and files therein do not follow any structure, establishing a connection simply implies locating the folder. We can do it using the environment variable previously created:
```python
# connect.py
import os

# point to the DB
DATAPATH = os.environ.get("RESEARCH_DATA_PATH")

```
Now, for every piece of data, we would have to know the filename where it is stored, so we have to hardcode this information in every function:
```python
# downstream.py
import pandas as pd
from connect import DATAPATH

def get_fx_data(subset, start_dt="1960", end_dt="2020"):
  """Get FX data from the DB."""
  filename = DATAPATH + "fx-data-1980-2020-d.ftr"

  data = pd.read_ftr(filename)

  return data
```

Putting data into the DB and updating it would be done in a similar way (note how the authentication is done to retrieve data from an external provider).
```python
# upstream.py
import pandas as pd
import quandl

from connect import DATAPATH

quandl.ApiConfig.api_key = os.environ.get("QUANDL_API_KEY")

def put_fx_data():
  """Store FX data to the DB."""

  data = quandl.get_table('FXCM/H1', date='2021-01-01', symbol='EUR/CAD')

  filename = DATAPATH + "eurcad-hf-data.ftr"

  data.to_feather(filename)

```


## example: SQL database
The directory tree is an example of an unstructured database. Things therein can be anything, and the only structure is the one noncommittally imposed by the user. An alternative is a relational databases powered by SQL.

SQL stands for Structured Query Language, and the SQL databases are characterized by data being stored and represented as rectangular tables with rows and columns. The power of such system comes from distributing different types of information across different tables, between which relations are created.

SQL databases are lightning fast and can store huge amounts of data at little marginal cost.

Lots of good introductions to SQL exist (see [resources](#resources) for some), way better than any effort we could produce, and we refer the reader to those. As an example, let's sketch the design of a toy database to keep FX exchange rates.

`fx.currency`:

|   id | name              | iso_3   |
|-----:|:------------------|:--------|
|    1 | australian dollar | aud     |
|    2 | swiss franc       | chf     |
|    3 | us dollar         | usd     |

`fx.data_type`:

|   id | description_long   |
|-----:|:-------------------|
|    1 | spot price         |
|    2 | forward price, 1m  |

`fx.timeseries_data`:

|   id |   base_id |   counter_id |   data_type_id | date       |   value |  |
|-----:|-------:|----------:|------------:|:-----------|--------:|--:
|    1 |      1 |         3 |           1 | 2021-01-05 |  0.1361 | <&ndash; audusd spot price |
|    2 |      1 |         3 |           1 | 2021-01-06 |  0.4488 | <&ndash; audusd spot price |
|    3 |      3 |         2 |           2 | 2021-01-05 |  0.6185 | <&ndash; usdchf 1m forward price |

Note how `timeseries_data` uses the id of currencies in table `currency` and of data types in table `data_type`, setting up a relation between the tables. SQL is all about these relations.


### API
To connect to a SQL database using a programming language, a special library is needed, e.g. `sqlalchemy` in Python. The user needs to specify the dialect (MySQL, PostgreSQL), and the database name, and provide valid credentials.
```python
# connect.py
import os
import sqlalchemy

dialect = "mysql"
username = os.environ.get("DB_USERNAME")
password = os.environ.get("DB_PASSWORD")
db_name = "mydatabase"
host = "localhost"
port = 3306

engine = f"{dialect}+pymysql://{username}:{password}@{host}:{port}/{db_name}"

```

The rest is easy, and along similar lines as in the example before.


## resources
*   [a brilliant SQL intro](https://www.youtube.com/watch?v=HXV3zeQKqGY).


## exercises
1.  create a toy database of your choice;
2.  organize up- and downstream to be able to put data into and get data from the database;
3.  play around with writing to and reading from different data formats.
