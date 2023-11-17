# Use the official PostgreSQL image as a base
FROM postgres

# Set environment variables for the PostgreSQL service
ENV POSTGRES_DB=example_db
ENV POSTGRES_PASSWORD=drowssap

# Copy initialization scripts if you have any. They will be executed on container startup.
COPY ./example-db.sql /docker-entrypoint-initdb.d/

# Expose the PostgreSQL port
EXPOSE 5432
