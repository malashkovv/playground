CREATE SCHEMA test;

DROP TABLE IF EXISTS test.users;

CREATE TABLE test.users (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR NOT NULL,
    last_name VARCHAR NOT NULL
);

INSERT INTO test.users (first_name, last_name) VALUES('Greg', 'Lira');

SELECT * FROM test.users;