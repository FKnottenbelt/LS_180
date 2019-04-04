DROP DATABASE IF EXISTS encyclopedia;

CREATE DATABASE encyclopedia;

\c encyclopedia

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

-- alter table exercises

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

-- update and delete exercises
Alter table animals add column class varchar(100);
update animals set class = 'Aves';
Alter table animals
  add column phylum varchar(100),
  add column kingdom varchar(100);
update animals set phylum = 'Chordata',
                   kingdom = 'Animalia';
alter table countries add column continent varchar(50);

update countries
   set continent = 'Europe' where name = 'France' or name = 'Germany';
update countries
   set continent = 'Asia' where name = 'Japan';
update countries
   set continent = 'North America' where name = 'USA';

update celebrities set deceased = true where first_name = 'Elvis';
alter table celebrities alter column deceased set not null;
delete from celebrities where first_name = 'Tom' and last_name = 'Cruise';
Alter table celebrities rename to singers;
update singers set occupation = 'Singer-songwriter' where id = 1;
delete from singers where occupation not like '%Singer%';
delete from countries;

-- table_relationships exercises
create table continents (
  id serial,
  continent_name varchar(50),
  PRIMARY KEY (id)
);

alter table countries drop column continent;

alter table countries add column continent_id INT;

alter table countries add foreign key (continent_id)
  references continents (id);

INSERT INTO continents (continent_name) VALUES
  ('Africa'),
  ('Asia'),
  ('Europe'),
  ('North America'),
  ('South America');

INSERT INTO countries (name, capital, population, continent_id)
  VALUES  ('Brazil', 'Brasilia', 208385000, 5),
          ('Egypt', 'Cairo', 96308900, 1),
          ('France', 'Pais', 67158000, 3),
          ('Germany', 'Berlin', 82349400, 3),
          ('Japan', 'Tokyo', 126672000, 2),
          ('USA', 'Washington D.C.', 325365189, 4);


select c.name, c.capital, c.population, co.continent_name
  from countries c
  join continents co ON c.continent_id = co.id ;

--
alter table singers ADD CONSTRAINT unique_id UNIQUE (id);

create table albums (
  id serial PRIMARY KEY UNIQUE,
  album_name varchar(100),
  released date,
  genre varchar(100),
  label varchar(100),
  singer_id int,
  FOREIGN KEY (singer_id) REFERENCES singers(id) ON DELETE CASCADE
);

INSERT INTO albums (album_name, released, genre, label, singer_id)
VALUES ('Born to Run', '1975-08-25', 'Rock and roll', 'Columbia', 1),
 ('Purple Rain', '1984-06-25', 'Pop, R&B, Rock', 'Warner Bros', 6),
 ('Born in the USA', '1984-06-04', 'Rock and roll, pop', 'Columbia', 1),
 ('Madonna', '1983-07-27', 'Dance-pop, post-disco', 'Warner Bros', 5),
 ('True Blue', '1986-06-30', 'Dance-pop, Pop', 'Warner Bros', 5),
 ('Elvis', '1956-10-19', 'Rock and roll, Rhythm and Blues', 'RCA Victor', 7),
 ('Sign o'' the Times', '1987-03-30', 'Pop, R&B, Rock, Funk', 'Paisley Park, Warner Bros', 6),
 ('G.I. Blues', '1960-10-01', 'Rock and roll, Pop', 'RCA Victor', 7);

select a.album_name, a.released, a.genre, a.label, s.first_name, s.last_name
  from albums a
  join singers s ON a.singer_id = s.id ;

-- join exercises
select c.name, cont.continent_name
  from countries c
  join continents cont on (c.continent_id = cont.id);

select c.name, c.capital
  from countries c
  join continents cont on (c.continent_id = cont.id)
  where cont.continent_name = 'Europe';

select distinct s.first_name from singers s
  join albums a on s.id = a.singer_id
  where a.label = 'Warner Bros';

select s.first_name, s.last_name,
       a.album_name, a.released
  from singers s
  join albums a on s.id = a.singer_id
  where (a.released >= '1980-01-01' AND
        a.released <= '1989-12-31')
    AND s.deceased = false
    order by s.date_of_birth desc;

select s.first_name, s.last_name
  from singers s
  left join albums a on s.id = a.singer_id
  where a.id is null;

select first_name, last_name
  from singers
  where id not in (select singer_id from albums);

