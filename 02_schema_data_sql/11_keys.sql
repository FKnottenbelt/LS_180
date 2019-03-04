\i films3.sql

INSERT INTO films(title, year, genre, director, duration)
     VALUES ('Godzilla', 1998, 'scifi', 'Roland Emmerich', 139);
INSERT INTO films(title, year, genre, director, duration)
     VALUES ('Godzilla', 2014, 'scifi', 'Gareth Edwards', 123);

UPDATE films SET duration = 92 WHERE title = '1984';

-- practice problems

CREATE SEQUENCE counter;
SELECT nextval('counter');
DROP SEQUENCE counter;
CREATE SEQUENCE even_counter INCREMENT BY 2 MINVALUE 2;

CREATE TABLE regions (id serial PRIMARY KEY,
                      name text,
                      area integer);

ALTER TABLE films ADD COLUMN id serial PRIMARY KEY;

ALTER TABLE films DROP CONSTRAINT films_pkey;
