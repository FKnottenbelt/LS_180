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

-- one-on-many
CREATE TABLE books (
  id serial,
  title varchar(100) NOT NULL,
  author varchar(100) NOT NULL,
  published_date timestamp NOT NULL,
  isbn char(12),
  PRIMARY KEY (id),
  UNIQUE (isbn)
);

/*
 one to many: Book has many reviews
*/

CREATE TABLE reviews (
  id serial,
  book_id integer NOT NULL,
  reviewer_name varchar(255),
  content varchar(255),
  rating integer,
  published_date timestamp DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE
);

INSERT INTO books (id, title, author, published_date, isbn) VALUES
  (1, 'My First SQL Book', 'Mary Parker', '2012-02-22 12:08:17.320053-03', '981483029127'),
  (2, 'My Second SQL Book', 'John Mayer', '1972-07-03 09:22:45.050088-07', '857300923713'),
  (3, 'My First SQL Book', 'Cary Flint', '2015-10-18 14:05:44.547516-07', '523120967812');


INSERT INTO reviews (id, book_id, reviewer_name, content, rating, published_date) VALUES
  (1, 1, 'John Smith', 'My first review', 4, '2017-12-10 05:50:11.127281-02'),
  (2, 2, 'John Smith', 'My second review', 5, '2017-10-13 15:05:12.673382-05'),
  (3, 2, 'Alice Walker', 'Another review', 1, '2017-10-22 23:47:10.407569-07');

-- many-to-many
CREATE TABLE checkouts (
  id serial,
  user_id int NOT NULL,
  book_id int NOT NULL,
  checkout_date timestamp,
  return_date timestamp,
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE
);

INSERT INTO checkouts (id, user_id, book_id, checkout_date, return_date) VALUES
  (1, 1, 1, '2017-10-15 14:43:18.095143-07', NULL),
  (2, 1, 2, '2017-10-05 16:22:44.593188-07', '2017-10-13 13:0:12.673382-05'),
  (3, 2, 2, '2017-10-15 11:11:24.994973-07', '2017-10-22 17:47:10.407569-07'),
  (4, 5, 3, '2017-10-15 09:27:07.215217-07', NULL);
