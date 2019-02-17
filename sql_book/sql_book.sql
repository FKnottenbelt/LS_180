CREATE TABLE users (
  id serial UNIQUE NOT NULL,
  username CHAR(25) NOT NULL,
  enabled boolean DEFAULT TRUE
  );

-- Renaming a Table
ALTER TABLE users RENAME TO all_users;

-- Renaming a Column
ALTER TABLE all_users RENAME COLUMN username TO full_name;

-- Changing a Column's Datatype
ALTER TABLE all_users ALTER COLUMN full_name TYPE VARCHAR(25);

-- Removing a column Constraint (removing sequence)
ALTER TABLE all_users ALTER COLUMN id DROP DEFAULT;

-- alter table test alter column id drop not null;

-- add column
ALTER TABLE all_users
  ADD COLUMN last_login timestamp NOT NULL DEFAULT NOW();

-- delete column
ALTER TABLE all_users DROP COLUMN enabled;

CREATE TABLE users (
    id serial UNIQUE NOT NULL,
    full_name character varying(25) NOT NULL,
    enabled boolean DEFAULT true,
    last_login timestamp without time zone DEFAULT now()
);

INSERT INTO users (full_name, enabled)
  VALUES ('John Smith', false);

INSERT INTO users (full_name)
  VALUES ('Jane Smith'), ('Harry Potter');

ALTER TABLE users ADD CHECK (full_name <> '');
