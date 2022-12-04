# basics of sql

- [basics of sql](#basics-of-sql)
  - [dialects](#dialects)
  - [building blocks](#building-blocks)
    - [table](#table)
    - [restrictions](#restrictions)
    - [primary key](#primary-key)
    - [foreign keys](#foreign-keys)
    - [data types](#data-types)
  - [language api](#language-api)
  - [database design](#database-design)
  - [resources](#resources)
  - [homework](#homework)

SQL is a language for data queries created to efficiently manipulate data in relational databases. Do not be discouraged be the effort it takes to learn it: once in your toolbox, it will improve your research and job market game significantly!

'Relational' means that there is a way to structure the data as a set of relations, whereby related things can be either placed in the same row of a table or explicitly linked across tables. Utilizing the established relations allows for a great computational power, and the better the structure of a relational database, the quicker data queries will be.

## dialects

SQL itself and the databases that it services come in several varieties called dialects, such as PostgreSQL and MySQL. The dialects differ but slightly, and knowing one and this fact makes transitioning easy. We will be using Postgres here.

## building blocks

### table

A table (also sometimes called a relation) is a 2D structure of rows ('observations', or 'records') and columns ('variables', or 'fields'); every row in a table can be thought of as describing different manifestations of a concept along several dimensions. For instance, let's take the concept of currency: individual manifestations thereof have several attributes worth recording, e.g. the official name, the ISO-3 code and whether it is free-floating (TRUE/FALSE); the Swiss franc can be described as ('Swiss franc', 'CHF', 'TRUE') the yuan can be described as ('Chinese yuan', 'CNY', 'FALSE') and so on.

The design of tables is the most important part of SQL database management, so do put some thought into it. Some choices are far from obvious: should different dimensions of, say, price: bid/ask/mid, open/close/best etc. &ndash; be assigned different fields: `(side='bid', snapped='last')` &ndash; or squeezed into one field: `(data_type='bid_last')`?

### restrictions

SQL allows the user to impose restrictions on columns: for instance, values in a certain column must be unique; when correctly placed, restrictions make the data less error-prone (e.g. by excluding duplicates where there must be none) and allow for faster queries. Since there cannot be two currencies with identical ISO-3 codes, it is a good idea to impose the uniqueness restriction here.

### primary key

One important restriction is called the 'primary key': it is a field or a collection of fields that uniquely identify one row in a table, such that stating it is enough to understand which observation is referred to. When talking about currency, the ISO-3 code uniquely identifies the currency such that knowing it allows to detect the only row with all the relevant attributes. To the same effect, instead of the ISO-3 code, we could have used a strictly increasing sequence of integers to identify rows, such that at some point CHF would have been assigned an integer which could be used to identify it. Indeed, many primary keys in SQL tables are integers derived from an auto-incremented sequence.

### foreign keys

A row from one table can be referenced in a different table using the 'foreign key'; for instance, imagine a table containing countries, each country having several attributes such as the name, the phone code and the official currency. The user can put any value in the currency column, of course: maybe the ISO code or the full name, &ndash; but if they choose to put there the primary key from table 'currency', they would add a layer of security by minimizing the chance of typos ('franc' vs 'franck') and also unlock the possibility to quickly look up the attributes of the currency from the other table and make questions such as 'is the currency of switzerland free-floating?' easy to answer.

### data types

Every SQL field must be of a certain data type. The lists of valid data types are similar though not the same across dialects, the one for Postgres to be found here: [link](https://www.postgresql.org/docs/current/datatype.html). For the sake of efficiency it is worth utilizing the 'proper' type for the values to be stored in a database: store dates as `DATE` and dates with time as `TIMESTAMP`, age as `INTEGER`, decimals as `NUMERIC` etc.

## language api

Programming languages feature interface for working with SQL databases (duh).

## database design

1. Think of the data points that you have: EURCHF spot exchange rate on 14-Jan-2015 and 15-Jan-2015 (from Bloomberg), USDCHF 1 month forward points on 15-Jan-2015 (from Bloomberg) and on 22-Jan-2015 (from Quandl), EURCHF 12 month forward points on 22-Jan-2015 (from Bloomberg), etc.;
2. For each of *N* data points think of *k* possible attributes that would *uniquely identify every data point*, arriving at a *Nxk* table:
   > base currency, counter currency, data type, provider, observation date, observation value;
3. Think of data points that you might have later on: CPI index in Switzerland in May 2022 (including vintage data), musical sentiment in the Eurozone in May 2022, etc. &ndash; and all the extra attributes, extending the number of attributes to *K*;
4. Think of how you might want to to query the data, for instance, select all spot rates, select all data relating to a particular currency etc.
5. Pivot this table to maximize readability.

Point 3, the thinking ahead, is underrated.

## resources

- [postgres manual](https://www.postgresql.org/docs/), the go-to reference on all things postgresql;
- [postgres from docker](https://youtu.be/aHbE3pTyG-Q).

## homework

1. sketch the design of the SQL database for your project.
