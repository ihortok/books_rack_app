CREATE TABLE books (
  id serial PRIMARY KEY,
  name VARCHAR(100),
  author VARCHAR(100)
);

CREATE TABLE users (
  id serial PRIMARY KEY,
  first_name VARCHAR(25),
  last_name VARCHAR(25),
  email VARCHAR(50) NOT NULL,
  password VARCHAR(255) NOT NULL,
  admin BOOLEAN
);
