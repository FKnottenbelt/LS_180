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

INSERT INTO users (id, full_name) VALUES (4, 'Harry Potter');
INSERT INTO users (id, full_name) VALUES (5, 'Jane Smith');

UPDATE users SET enabled = false;
UPDATE users SET enabled = true
  WHERE full_name = 'Harry Potter' OR full_name = 'Jane Smith';
UPDATE users SET full_name='Alice Walker' WHERE id=2;
DELETE FROM users WHERE full_name='Harry Potter' AND id > 3;

-- one on one relationships
ALTER TABLE users ADD PRIMARY KEY (id);

CREATE TABLE addresses (
  user_id int, -- Both a primary and foreign key
  street varchar(30) NOT NULL,
  city varchar(30) NOT NULL,
  state varchar(30) NOT NULL,
  PRIMARY KEY (user_id),
  FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);

INSERT INTO addresses (user_id, street, city, state) VALUES
  (1, '1 Market Street', 'San Francisco', 'CA'),
  (2, '2 Elm Street', 'San Francisco', 'CA'),
  (3, '3 Main Street', 'Boston', 'MA');
