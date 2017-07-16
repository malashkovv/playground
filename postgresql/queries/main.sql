CREATE SCHEMA test;

DROP TABLE IF EXISTS test.users;

CREATE TABLE test.users (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR NOT NULL,
    last_name VARCHAR NOT NULL
);

CREATE TABLE test.countries (
    country_code CHAR(2) PRIMARY KEY,
    country_name VARCHAR
);

INSERT INTO test.users (first_name, last_name) VALUES('Greg', 'Lira');

SELECT * FROM test.users;

ALTER TABLE test.users ADD COLUMN country_code CHAR(2) REFERENCES test.countries;

INSERT INTO test.countries
(
    country_code, country_name
)
VALUES
('AU', 'Australia'),
('US', 'United States of America');

UPDATE test.users SET country_code = 'AU' WHERE id = 1;

SELECT * FROM test.users
JOIN test.countries
USING (country_code);

SELECT * FROM test.users
JOIN test.countries
ON test.users.country_code = test.countries.country_code;

CREATE TABLE test.cities (
    city_name TEXT NOT NULL,
    postal_code VARCHAR(9) CHECK (postal_code <> ''),
    country_code CHAR(2) NOT NULL REFERENCES test.countries,
    PRIMARY KEY (country_code, postal_code)
);

INSERT INTO test.cities
(
    city_name, postal_code, country_code
)
VALUES ('Portland', '97250', 'AU'),('New York', '92562', 'US'), ('Los Angeles', '12253', 'US');

ALTER TABLE test.users ADD COLUMN postal_code VARCHAR(9) CHECK (postal_code <> '');

UPDATE test.users SET postal_code = '97250' WHERE id = 1;

ALTER TABLE test.users ADD FOREIGN KEY (country_code, postal_code) REFERENCES test.cities(country_code, postal_code) MATCH FULL;

EXPLAIN ANALYSE
SELECT * FROM test.users
LEFT JOIN test.cities
USING (postal_code, country_code)
-- LEFT JOIN test.countries
-- USING (country_code)
;

INSERT INTO test.users (first_name, last_name) VALUES ('Alexey', 'Povarkov') ;

DELETE FROM test.users WHERE last_name = 'Povarkov';

BEGIN TRANSACTION;
    INSERT INTO test.users (first_name, last_name, postal_code, country_code) VALUES ('Alexey', 'Povarkov', '12253', 'US');
    ROLLBACK ;
    INSERT INTO test.users (first_name, last_name, postal_code, country_code) VALUES ('Vadim', 'Yurchak', '12253', 'US');
END TRANSACTION;

DROP TABLE test.countries CASCADE;