CREATE TABLE time_series_value (
    id SERIAL PRIMARY KEY,
    date TIMESTAMP NOT NULL,
    value NUMERIC
);