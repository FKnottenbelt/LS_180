CREATE TABLE users (
  id serial UNIQUE NOT NULL,
  username CHAR(25),
  enabled boolean DEFAULT TRUE
  );
