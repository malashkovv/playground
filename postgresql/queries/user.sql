DROP TABLE users;

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR NOT NULL,
    last_name VARCHAR NOT NULL
);

INSERT INTO users (first_name, last_name) VALUES('Greg', 'Lira');

SELECT * FROM users;