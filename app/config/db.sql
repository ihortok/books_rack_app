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

CREATE TABLE sessions (
  id serial PRIMARY KEY,
  key VARCHAR(255),
  user_id INT NOT NULL,
  start_at TIMESTAMP NOT NULL,
  terminate_at TIMESTAMP NOT NULL,
  CONSTRAINT fk_user
    FOREIGN KEY(user_id) 
	    REFERENCES users(id)
);
