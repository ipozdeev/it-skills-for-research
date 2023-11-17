First, study the Dokerfile and build the image called 'example_postgres' with your password and database name specified therein:
```bash
docker build -t example_postgres .
```
Second, run a container in the detached mode from this image. specifying the password to connect to the database (must match the password set upon creation of the postgres instance!) and mapping the port:
```bash
docker run -e POSTGRES_PASSWORD=<password_from_Dockerfile> -p 5432:5432 -d example_postgres
```
You can check if it is indeed running via:
```bash
docker ps
```
In the Postgres instance in the running container, database 'example_db' will be created, together with the single table 'time_series_value' (by virtue of copying script 'example-db.sql' in line 9 of the Dockerfile into the appropriate folder). Now, you can connect to this database using your favorite tool, e.g. `psql` or an appropriate library in your programming language, e.g. `sqlalchemy` in Python (see the example in 'example-sqlalchemy.ipynb').
