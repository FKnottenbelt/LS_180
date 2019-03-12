-- recreate state of database

-- CREATE DATABASE extrasolar;

-- \c extrasolar

DROP TABLE IF EXISTS planets;
DROP TABLE IF EXISTS stars;

-- 01

CREATE TABLE stars (
  id serial PRIMARY KEY,
  name varchar(25) UNIQUE NOT NULL,
  distance integer NOT NULL CHECK (distance > 0),
  spectral_type char(1),
  companions integer NOT NULL CHECK (companions >= 0)
);

CREATE TABLE planets (
  id serial PRIMARY KEY,
  designation char(1),
  mass integer
);

-- 02

ALTER TABLE planets
ADD COLUMN star_id integer NOT NULL REFERENCES stars (id);

-- 03
ALTER TABLE stars
ALTER COLUMN name TYPE varchar(50);

-- Further Exploration
-- ALTER TABLE stars
-- ALTER COLUMN name TYPE varchar(25);

-- INSERT INTO stars (name, distance, spectral_type, companions)
--           VALUES ('Alpha Centauri B', 4, 'K', 3);

-- ALTER TABLE stars
-- ALTER COLUMN name TYPE varchar(50);

-- 04
ALTER TABLE stars
ALTER COLUMN distance TYPE numeric;

-- Further Exploration
-- ALTER TABLE stars
-- ALTER COLUMN distance TYPE integer;

-- INSERT INTO stars (name, distance, spectral_type, companions)
--           VALUES ('Alpha Orionis', 643, 'M', 9);

-- ALTER TABLE stars
-- ALTER COLUMN distance TYPE numeric ;

-- 05
ALTER TABLE stars
ADD CHECK (spectral_type IN ('O', 'B', 'A', 'F', 'G', 'K', 'M')),
ALTER COLUMN spectral_type SET NOT NULL;

-- ALTER TABLE stars
-- ADD CHECK (spectral_type IN ('O', 'B', 'A', 'F', 'G', 'K', 'M'));

-- ALTER TABLE stars
-- ALTER COLUMN spectral_type SET NOT NULL;

-- Further Exploration
-- ALTER TABLE stars
-- DROP CONSTRAINT stars_spectral_type_check,
-- ALTER COLUMN spectral_type DROP NOT NULL;

-- INSERT INTO stars (name, distance, companions)
--           VALUES ('Epsilon Eridani', 10.5, 0);

-- INSERT INTO stars (name, distance, spectral_type, companions)
--           VALUES ('Lacaille 9352', 10.68, 'X', 0);

-- ALTER TABLE stars
-- ADD CHECK (spectral_type IN ('O', 'B', 'A', 'F', 'G', 'K', 'M')),
-- ALTER COLUMN spectral_type SET NOT NULL;

-- 06
ALTER TABLE stars
DROP CONSTRAINT stars_spectral_type_check;

CREATE TYPE spectral_type_enum AS ENUM('O', 'B', 'A', 'F', 'G', 'K', 'M');

ALTER TABLE stars
ALTER COLUMN spectral_type TYPE spectral_type_enum
                           USING spectral_type::spectral_type_enum;
