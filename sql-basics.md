# basics of sql

- [basics of sql](#basics-of-sql)
  - [building blocks](#building-blocks)
    - [table](#table)
    - [restrictions](#restrictions)
    - [primary key](#primary-key)
    - [foreign keys](#foreign-keys)
  - [flavours](#flavours)
  - [connectors](#connectors)
  - [data types](#data-types)

SQL is a language for data queries created to efficiently manipulate data in relational databases. Do not be discouraged be the effort it takes to learn it: once in your toolbox, it will improve your research and job market game significantly!

'Relational' means that there is a way to structure the data as a set of relations, whereby related things can be either placed in the same row of a table or explicitly linked across tables. Utilizing the established relations allows for a great computational power, and the better the structure of a relational database, the quicker data queries will be.

## building blocks

### table

A table (also sometimes called a relation) is a 2D structure of rows ('observations', or 'records') and columns ('variables', or 'fields'); every row in a table can be thought of as describing different manifestations of a concept along several dimensions. For instance, let's take the concept of currency: individual manifestations thereof have several attributes worth recording, e.g. the official name, the ISO-3 code and whether it is free-floating (TRUE/FALSE); the Swiss franc can be described as ('Swiss franc', 'CHF', 'TRUE') the yuan can be described as ('Chinese yuan', 'CNY', 'FALSE') and so on.

### restrictions

SQL allows the user to impose restrictions on columns: for instance, values in a certain column must be unique; when correctly placed, restrictions make the data less error-prone (e.g. by excluding duplicates where there must be none) and allow for faster queries. Since there cannot be two currencies with identical ISO-3 codes, it is a good idea to impose the uniqueness restriction here.

### primary key

One important restriction is called the 'primary key': it is a field or a collection of fields that uniquely identify one row in a table, such that stating it is enough to understand which observation is referred to. When talking about currency, the ISO-3 code uniquely identifies the currency such that knowing it allows to detect the only row with all the relevant attributes. To the same effect, instead of the ISO-3 code, we could have used a strictly increasing sequence of integers to identify rows, such that at some point CHF would have been assigned an integer which could be used to identify it. Indeed, many primary keys in SQL tables are integers derived from an auto-incremented sequence.

### foreign keys

A row from one table can be referenced in a different table using the 'foreign key'; for instance, imagine a table containing countries, each country having several attributes such as the name, the phone code and the official currency. The user can put any value in the currency column, of course: maybe the ISO code or the full name, &ndash; but if they choose to put there the primary key from table 'currency', they would add a layer of security by minimizing the chance of typos ('franc' vs 'franck') and also unlock the possibility to quickly look up the attributes of the currency from the other table and make questions such as 'is the currency of switzerland free-floating?' easy to answer.

## flavours

- postgres
- musql

## connectors

- sqlalchemy

## data types
- do not mix