# data management

<!-- TOC -->

- [introduction](#introduction)
- [downstream](#downstream)
  - [memoization](#memoization)
  - [chunking](#chunking)
- [upstream](#upstream)
  - [api](#api)
- [database](#database)
  - [database api structure](#database-api-structure)
  - [example: folder with text files](#example-folder-with-text-files)
- [data file formats](#data-file-formats)
  - [serialization of dataframes](#serialization-of-dataframes)
  - [HDF](#hdf)
  - [feather](#feather)
- [example: SQL database](#example-sql-database)

<!-- /TOC -->

## introduction

If your project is at least partially has to do with data manipulation, it is in general a good idea to organize the way your data is stored, updated and fed to the functions which produce any desired output.

Similar to oil, you can think of two steps it takes for data to enter your calculations:
*   **upstream**: raw data from a data supplier enters your machine;
*   **downstream**: data is delivered to your programs which process it.

Sometimes the two are merged into one, but it is in general a good idea to keep them separate.

## downstream
Let us suppose you have a set of project-specific functions to fetch this or that piece of data for calculations, all stored in the script called `datafeed.*` (`*` substituted with `py`, `jl`, `R` etc. dependent on whatever software is in use) located in the project folder:
```
my-project/
  readings/
  text/
  output/
  datacache/
  datafeed.py
  core.py
  ...
```
and the contents of `datafeed.py` resemble:
```python
def fetch_stock_prices(s_dt="1960", e_dt=None, mkt_cap_percentile=0.0):
  pass

def fetch_index_return() -> DataFrame:
  pass
```
These functions ensure that whenever you need data to perform data manipulations in, say, `core.py`, you do not import data in `core.py`, but rather call a corresponding function from `datafeed.py`, which in turn would fetch the data from wherever it is located.

Separating down- from upstream has two advantages. First, whenever you might change your data sources (for instance, switching from IMF to World Bank for GDP values), you would not have to mess with the calculations code, but with the data retrieval code and only make sure that the output is in the same format. Second, this allows to [memoise](https://en.wikipedia.org/wiki/Memoization) functions, that is, to return a cached version of the function output when the function is run with the same arguments. Since datafeed operations can be expensive (in terms of running time or literally, as the case with Bloomberg), memoization saves the researcher hours, so let us quickly discuss it here.

### memoization
Again, memoization refers to remembering the results of a function call based on the input arguments and then returning the remembered result rather than computing the result again. Its _raison d'etre_ is the diverging price of hard disk space and the human coder's time. Based on the idea, it is pretty easy to write memoization functions yourself, but of course there are several solutions available for popular languages.

For Python, the amazing [`joblib`](https://joblib.readthedocs.io/en/latest/) library does the trick. In the preamble to `datafeed.py`, you provide the path to keep cache in, set up a Memory object and use it to decorate every function to be memoised:
```python
from joblib import memory

cachedir = "./datacache"  # set up cache directory
memory = Memory(cachedir) # initialize Memory object

# define and decorate function
@memory.cache
def expensive_function():
  pass
```

For R, [memoise](https://cran.r-project.org/web/packages/memoise/index.html) is one solution, although this we cannot vouch for.

### chunking
Sometimes (with machine learning, for instance) the amount of data needed for a task is comparable to the amount of RAM on your machine. When this happens, it becomes infeasible to load the complete dataset into the memory, and _chunking_ is needed. In most languages, _chunking_ is implemented as a [generator](https://en.wikipedia.org/wiki/Generator_(computer_programming)) and constitutes repeated calls to a database. See, for instance, `chunksize` parameter in `pandas` IO section.

## upstream
### api
A common way to have data ready for manipulation is to download it to a `.csv` or `.xlsx` before reading in into the software of choice such as R or Julia. However, some data suppliers allow to skip the (rather cumbersome and often costly) intermediate step and streamline data retrieval by providing what is called an application programming interface, or API. For a website such as **quandl** or **WRDS**, the API usually gives the user access to a text file located under a URL link and containing the desired data.

As an example, let us take a look at [**quandl**](https://www.quandl.com/tools/api), where section 'API Features' provides the details, and at the [**IMF**](http://datahelp.imf.org/knowledgebase/articles/667681-json-restful-web-service).

Since these are just text documents, you would have to write wrapper functions to further ease the upstream. More often than not however (all hail the XXI century), someone would have already written these functions for your favorite language, probably even the data supplier themselves. For example, **quandl** provides [libraries for Python](https://www.quandl.com/tools/python) &ndash; collections of wrappers to ease your access to their data. The **IMF**, on the other hand, did not bother, but helpful tips prepared by other users are available [here and there](https://www.bd-econ.com/imfapi1.html).


## database
If you store any amount of research data locally, it is a good idea to do so in a centralized way, in other words, to set up an own database (DB). In the simplest case, the database can be a folder somewhere outside of all of your research project folders, where .csv files, possibly of different structure and format, are located. In a more complicated setup, it can be a SQL database of multiple tables and dependencies.

With a database comes your own API! When using Python or R, it is best organized as a package, called e.g. `mydatabase`, which you or everyone else can install and use. Functions therein provide apparatus to write to and fetch from the DB, update data and so on.

With that being said, our `datafeed.py` file in the project above could start as follows:
```python
from joblib import memory
from mydatabase.api import fetch_fx_data, fetch_gdp_data

cachedir = "./datacache"
memory = Memory(cachedir, verbose=0)

@memory.cache
def prepare_fx_data(...):
  data_from_db = fetch_fx_data(...)
```
Here, `fetch_fx_data` is the database-level function from the database API, and `prepare_fx_data` is the project-level function to fetch the data from the DB, maybe transform it somehow and return in a form suitable to project needs.

### database api structure
Necessary utilities include:
1.  establishing a connection to;
2.  pulling data from;
3.  putting data into;
4.  updating data in.

### example: folder with text files
A rather straightforward solution is to put all files that contain any data in one folder outside any project &ndash; let's call it `research_data`. To be able to detect the folder without specifying its absolute or relative path, let us also set up an [environment variable](https://www.architectryan.com/2018/08/31/how-to-change-environment-variables-on-windows-10/) called `$RESEARCHDATA` and set its value to wherever the folder is located.

Now, let us write some API code. Since files in the DB do not follow any structure, establishing a connection is just to locate the DB folder. We can do it using the environment variable previously created:
```python
from os import path

# point to the DB
datapath = path.expandvars("$RESEARCHDATA")

```
Now, for every piece of data, we would have to know the filename where it is stored, so we have to hardcode this information in every function:
```python
import pandas as pd

def fetch_fx_data(subset, s_dt="1960", e_dt="2020"):
  """Fetch FX data from the DB."""
  filename = "fx-data-1980-2020-d.csv"

  data = pd.read_csv(filename)

  return data
```
Putting data into the DB and updating it would be done in a similar way.

## data file formats
You would be surprised, but `.csv` (or `.xml` or `.json` or any text file for that matter) might be not the best format to choose for storing your data. Sure, it is human-readable, Excel-readable and shareable, but also bulky, slow to input/output and subject to comma vs. dot and similar problems. Some alternatives are:

### serialization of dataframes
Serialization is the action of transforming an object to a string of bytes from which it is possible to uniquely recover the object. It is a quick solution to preserve the data as it appears in your code, fast and relatively memory efficient, but not shareable across languages.
- Python: [pickle](https://docs.python.org/3/library/pickle.html)
- R: [serialize](https://stat.ethz.ch/R-manual/R-devel/library/base/html/serialize.html)

### HDF
[HDF](https://www.hdfgroup.org/solutions/hdf5/) is a format for storing hierarchical data. It is best suited for large (even gigantic) organized and reasonably stationary (not changing too frequently) datasets and allows to store metadata. HDF lets you query data in chunks in a memory-efficient way and is shareable across languages. On the other hand, it is somehwat inflexible (hard to recover space after deleting data).

- Python: `h5py` + support in `pandas`
- R: `rhdf5`

### feather
[Feather](https://arrow.apache.org/docs/python/feather.html) is a language-agnostic data frame storage. Not possilbe to read in chunks, but handy for those working with R, Python and Julia at the same time.

- Python: `pyarrow` + support in `pandas`
- R: `arrow`

## example: SQL database
to be discussed in a separate section

## exercises
1.  create file structure for a database of your own...
2.  ...keeping upstream separate from downstream;
3.  take a look at [iexfinance](https://addisonlynch.github.io/iexfinance/)'s api;
4.  play around with writing to and reading from different data formats.
