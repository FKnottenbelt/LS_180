CREATE TABLE countries (
  id serial,
  name varchar(50) UNIQUE NOT NULL,
  capital varchar(50) NOT NULL,
  population integer
);

CREATE TABLE famous_people (
  id serial,
  name varchar(100) NOT NULL,
  occupation varchar(150),
  date_of_birth varchar(50),
  deceased BOOLEAN DEFAULT FALSE
);

CREATE TABLE animals (
  id serial,
  name varchar(100) NOT NULL,
  binomial_name varchar(100) NOT NULL,
  max_weight_kg decimal(8,3),
  max_age_years int,
  conservation_status varchar(2)
);

ALTER TABLE famous_people RENAME TO celebrities;

ALTER TABLE celebrities RENAME COLUMN name TO first_name;
ALTER TABLE celebrities ALTER COLUMN first_name TYPE varchar(80);

ALTER TABLE celebrities ADD COLUMN last_name varchar(100) NOT NULL;

ALTER TABLE celebrities ALTER COlUMN date_of_birth TYPE date
  USING date_of_birth::date,
  ALTER COLUMN date_of_birth SET NOT NULL;

ALTER TABLE animals ALTER COLUMN max_weight_kg TYPE decimal(10,4);

ALTER TABLE animals ADD CONSTRAINT unique_binomial_name
UNIQUE (binomial_name);

INSERT INTO countries (name, Capital, Population)
  VALUES ('France', 'Paris' , 67158000);

INSERT INTO countries (name, capital, population)
  VALUES ('USA', 'Washington D.C.', 325365189),
        ('Germany', 'Berlin', 82349400),
        ('Japan', 'Tokyo', 126672000);

INSERT INTO celebrities (first_name, last_name, occupation, date_of_birth)
  VALUES ('Bruce', 'Springsteen', 'singer-songwriter', '1949-09-23');

INSERT INTO celebrities (first_name, last_name, occupation, date_of_birth)
  VALUES ('Scarlett', 'Johansson', 'actress', '1984-11-22');

INSERT INTO celebrities (first_name, last_name, occupation, date_of_birth,
  deceased)
  VALUES ('Frank', 'Sinatra', 'Singer, Actor', '1915-12-12', true),
  ('Tom', 'Cruise', 'Actor', '1962-07-03', false);

ALTER TABLE celebrities ALTER COLUMN last_name DROP NOT NULL;

INSERT INTO celebrities (first_name, occupation, date_of_birth, deceased)
  VALUES ('Madonna', 'Singer, Actress', '1958-08-16', false),
        ('Prince', 'Singer, Songwriter, Musician, Actor', '1958-06-07', true);

INSERT INTO celebrities (first_name, last_name, occupation, date_of_birth, deceased)
 VALUES ('Elvis', 'Presley', 'Singer, Musician, Actor', '1935-08-01', NULL);

ALTER TABLE animals
  DROP CONSTRAINT unique_binomial_name;

INSERT INTO animals (name, binomial_name, max_weight_kg, max_age_years, conservation_status)
 VALUES ('Dove', 'Columbidae Columbiformes', 2, 15, 'LC'),
        ('Golden Eagle', 'Aquila Chrysaetos', 6.35, 24, 'LC'),
        ('Peregrine Falcon', 'Falco Peregrinus', 1.5, 15, 'LC'),
        ('Pigeon', 'Columbidae Columbiformes', 2, 15, 'LC'),
        ('Kakapo', 'Strigops habroptila', 4, 60,'CR');

-- Exercises select queries
select population from countries where name = 'USA';
select population, capital from countries;
select name from countries order by name;
select name, capital from countries order by population;
select name, capital from countries order by population desc;
select name, binomial_name, max_weight_kg, max_age_years from animals
  order by max_age_years, max_weight_kg, name DESC;
select name from countries where population > 70000000;
select name from countries where population between 70000000 and 200000000;
select first_name, last_name from celebrities where deceased = false
  OR deceased IS NULL;
select first_name, last_name from celebrities
  where occupation like '%Singer%';
select first_name, last_name from celebrities where occupation like '%Act%';
select first_name, last_name from celebrities
  where occupation like '%Act%' and occupation like '%Singer%';

-- Exercises 'more on select' queries
select * from countries limit 1;
select name from countries order by population desc limit 1;
select name from countries order by population desc limit 1 offset 1;
select distinct binomial_name from animals;
select length(binomial_name) from animals
  order by length(binomial_name) DESC limit 1;
select first_name from celebrities
  where date_part('year',date_of_birth) = '1958' ;
select max(max_age_years) from animals;
select avg(max_weight_kg) from animals;
select count(id) from countries;
select distinct conservation_status, count(name)
  from animals group by conservation_status;
