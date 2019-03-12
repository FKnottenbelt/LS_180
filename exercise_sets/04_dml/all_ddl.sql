-- 01

CREATE DATABASE workshop;

\c workshop

CREATE TABLE devices(
  id serial PRIMARY KEY,
  name text NOT NULL,
  created_at timestamp DEFAULT NOW()
);

CREATE TABLE parts(
  id serial PRIMARY KEY,
  part_number INT NOT NULL UNIQUE,
  device_id INT REFERENCES devices(id)
);
