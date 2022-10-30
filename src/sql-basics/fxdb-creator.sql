CREATE TABLE currency (
    id    SERIAL        PRIMARY KEY ,
    iso_3 VARCHAR(3)    UNIQUE      , 
    name  VARCHAR(79)
);

INSERT INTO currency (iso_3, name) VALUES 
    ('chf', 'swiss franc')          ,
    ('eur', 'euro')                 ,
    ('usd', 'united states dollar') ;

CREATE TABLE data_type (
    id              SERIAL       PRIMARY KEY ,
    meta_data_type  VARCHAR(3)               , -- one of 'str', 'num'
    name_long       VARCHAR(79)              , 
    name_short      VARCHAR(20)  NOT NULL
);

INSERT INTO data_type (meta_data_type, name_long, name_short) VALUES
    ('num', 'spot price',    'p')      ,
    ('num', 'forward price', 'fwd_1m') ;

CREATE TABLE provider (
    id              SERIAL      PRIMARY KEY ,
    vendor          VARCHAR(20) NOT NULL    , -- e.g. 'bloomberg'
    source          VARCHAR(20)               -- e.g. 'msci'
);

INSERT INTO provider (vendor) VALUES
    ('bloomberg') ,
    ('quandl')    ;

CREATE TABLE series (
    id                  SERIAL  PRIMARY KEY,
    base_currency_id    INTEGER REFERENCES currency,
    counter_currency_id INTEGER REFERENCES currency,
    data_type_id        INTEGER REFERENCES data_type,
    provider_id         INTEGER REFERENCES provider
);

INSERT INTO series (base_currency_id, 
                    counter_currency_id, 
                    data_type_id,
                    provider_id) VALUES
    (2, 1, 1, 1) , -- eurchf spot
    (3, 1, 1, 1) ; -- usdchf spot

CREATE TABLE time_series_num (
    id          SERIAL  PRIMARY KEY,
    series_id   INTEGER REFERENCES series,
    obs_date    DATE,
    value       NUMERIC,
    add_date    DATE 
);

INSERT INTO time_series_num (series_id, 
                             obs_date, 
                             value) VALUES
    (1, '2015-01-14', 1.20),
    (1, '2015-01-15', 1.00),
    (1, '2015-01-16', 1.01);