# data management

- [data management](#data-management)
  - [introduction](#introduction)
  - [data storage](#data-storage)
  - [data flow](#data-flow)
  - [memoization](#memoization)
  - [chunking](#chunking)
  - [example: directory tree](#example-directory-tree)
    - [file types](#file-types)
      - [text](#text)
      - [column data formats](#column-data-formats)
      - [serialized objects](#serialized-objects)
    - [directory tree API](#directory-tree-api)
  - [data and git](#data-and-git)
  - [exercises](#exercises)

## introduction

Efforts to optimize the way data enters your research pay off in the long run. Quite some time can be lost on finding that nice dataset of commodity prices you used two years ago; on updating it with fresh values; on sharing it with your colleagues or reusing in a different project. Even more time can get wasted on other people trying to reproduce your results with their own data. A well structured data management process could boost both your own efficiency and that of researchers following in your footsteps.

Data management consists of organizing both data storage and data flow. The former has to do with the structure and format of the stock of your data as well as whether data is project-specific or to be reused many times over; the latter deals with how that stock of data is being created and delivered to endpoint functions (for an example of an endpoint function, think calculation of descriptive statistics).

The following assumes that data can be represented as a table, as most economic and time series data does.

## data storage

In general (e.g. as suggested by the [cookiecutter data science project template](https://github.com/drivendata/cookiecutter-data-science)), each project is associated with project-specific data and calls for a dedicated storage within the project folder (here, `data/`):

```bash
|-- my-project/
|   |-- data/
|   |-- src/
|   |-- ...
```

However, if a dataset is reused at least once in a different project, it might be a good idea to put it in a centralized database where all projects would be able to access it.

The centralized database can have any architecture: a directory tree with text or binary files, a local SQL database, an external provider etc. &ndash; as long as the data flow routines are coded *comme il faut*.

## data flow

Similar to oil, you can think of two ways data can flow:

- **upstream**: into a database for storage;
- **downstream**: from a database for usage in endpoint functions.

Separating up- from downstream is a matter of taste, but does keep the code repository tidier. Functions responsible for the two are quite different: upstreams tend to run either once or at regular intervals, whereas downstreams &ndash; each time an endpoint function is run (which happens dozens of times  early into the project); downstreams are often memoizable (to be discussed later), whereas the upstreams are not; upstreams involve authentication more frequently; downstreams are most often shareable, whereas upstreams are most often not or useless in being such (think proprietary datasets).

Together, the two constitute a database's application programming interface, or API &ndash; a way for endpoint functions to talk to the database. A good API would provide methods for:

1. establishing a connection to;
1. pulling data from;
1. putting data into;
1. updating data in

the database. A common layout for a database API would be, using Python as the example:

```bash
|-- datafeed/
|   |-- __init__.py
|   |-- utilities.py
|   |-- connect.py
|   |-- downstream.py
|   |-- upstream.py
|   |-- recipes.py
```

Here, `connect` provides a way to establish a connection to the database to be reused in other modules. Functions and methods in `downstream` start with `get_`, those in `upstream` with `put_`. Module `recipes` keeps commonly used procedures to manipulate the raw data to deliver it to the endpoint functions, such as transformation of prices (delivered in the raw form by `downstream`) to returns.

## memoization

Functions can be expensive to evaluate, such that much time is lost on waiting for them to finish. If such an expensive function is deterministic (produces the same output given the same input), it can be [memoized](https://en.wikipedia.org/wiki/Memoization), or made to return a cached version of the output when run with the same input. Since datafeed operations can be expensive (in terms of time or, indeed, money, as subsequent calls to a commercial database such as Bloomberg can be costly), memoization saves the researcher hours, so let us quickly discuss it here.
Memoization refers to remembering the results of a function call based on the input arguments and then returning the remembered result rather than computing the result again. Its *raison d'etre* is the diverging price of hard disk space and the human coder's time. Based on the idea, it is pretty easy to write memoization functions yourself, but of course there are several solutions available for popular languages.

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

A similar solution exists in other languages, e.g. [memoize](https://cran.r-project.org/web/packages/memoise/index.html) in R or [Memoize.jl](https://www.juliapackages.com/p/memoization) in Julia.

## chunking

Sometimes (in machine learning applications, for instance) the amount of data needed for a task becomes large relative to the amount of RAM on your machine. When this happens, loading the complete dataset into the memory is no longer an option, and *chunking* is needed. In most languages, *chunking* is implemented as a [generator](https://en.wikipedia.org/wiki/Generator_(computer_programming)) and constitutes repeated calls to a database. See, for instance, `chunksize` parameter in `pandas` IO section.

## example: directory tree

A rather straightforward solution is to put all files that contain data in one folder outside your project &ndash; let's call it `research-database`. In general, it is a good idea is to upload this folder to cloud storage such as Google Drive, Yandex.Disk or the like and ensure it being synchronized. To be able to reference the folder without specifying its absolute or relative path, let us also set up an [environment variable](./project-environment.md#environment-variables) called `RESEARCH_DATA_PATH` and set its value to wherever the folder is located.

### file types

#### text

Text files such as `.csv`, `.xml`, `.json` or `.yaml` are a frequent choice, being human-readable and easily shareable. However, they are also bulky, slow to be read in/write out and subject to comma vs. dot, encoding and similar problems.

#### column data formats

- [HDF](https://www.hdfgroup.org/solutions/hdf5/) is a format for storing hierarchical data. It is best suited for large organized and reasonably stationary (not changing too frequently) datasets and allows to store metadata. HDF lets you query data in chunks in a memory-efficient way and is shareable across languages. On the other hand, it is somewhat inflexible (hard to recover space after deleting data).

  - Python: [`h5py`](https://www.h5py.org/) or [`pandas/hdf`](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.to_hdf.html);
  - R: [`rhdf5`](https://bioconductor.org/packages/release/bioc/html/rhdf5.html).

- [Feather](https://arrow.apache.org/docs/python/feather.html) is a language-agnostic data frame storage, super handy for those switching between R, Python and Julia or having colleagues programming in a different language.

  - Python: [`pyarrow`](https://arrow.apache.org/docs/python/feather.html) or [`pandas/feather`](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.to_feather.html);
  - R: [`arrow`](http://arrow.apache.org/docs/r/).

- [Parquet](https://parquet.apache.org/docs/overview/motivation/) is similar to Feather.
  - Python: [`pyarrow`](https://arrow.apache.org/docs/python/parquet.html) or [pandas/parquet](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.to_parquet.html);
  - R: [`arrow`](http://arrow.apache.org/docs/r/).

#### serialized objects

Serialization is the action of transforming an object such as a data frame to a string of bytes from which it can be recovered without a loss. It is a quick solution to preserve data, fast and relatively memory efficient, but not easily shareable across languages and even versions of the software used to perform the serialization.

- Python: [`pickle`](https://docs.python.org/3/library/pickle.html) or [`pandas`/`pickle`](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.to_pickle.html)
- R: [`serialize`](https://stat.ethz.ch/R-manual/R-devel/library/base/html/serialize.html)


### directory tree API

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
  filename = DATAPATH + "/fx-data-d.ftr"

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

## data and git

In general, you should avoid tracking your data files, especially if they are in a binary format such as HDF or Feather: uploading these to a cloud storage where other people can fetch them from is a better option. Nor is it an easy thing to do: if you try to push a file larger than 50 MB, git will issue a warning, and it will block files larger than 100 MB altogether. For large files, `git lfs` is a solution.

## exercises

1. in your favorite language, create a non-empty dataframe with 1e06 rows and 5 columns, making two of the columns completely identical;
2. dump it to a file in `homework5/` using HDF, Feather and Parquet format, recording the amount of time required for this, and save the three times to a .txt file in the same folder;
3. using `git lfs` start tracking the Feather file you created above, commit it and push to GitHub.
