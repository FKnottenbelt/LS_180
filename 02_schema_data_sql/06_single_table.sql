CREATE TABLE people (
  id serial PRIMARY KEY,
  name varchar(50) NOT NULL,
  age int,
  occupation varchar(50)
);

INSERT INTO people (name, age, occupation)
  VALUES ('Abby', 34, 'biologist'),
  ('Mu''nisah', 26, NULL),
  ('Mirabelle', 40, 'contractor');

SELECT *
FROM people
WHERE id = 2;

SELECT *
FROM people
WHERE age = 26;

SELECT *
FROM people
WHERE name = 'Mu''nisah';

SELECT *
FROM people
WHERE occupation IS NULL;

CREATE TABLE birds (
  id serial PRIMARY KEY,
  name varchar(50),
  lenght decimal(3, 1),
  wingspan decimal(3, 1),
  family varchar(50),
  extinct boolean
);

INSERT INTO birds (name, lenght, wingspan, family, extinct)
  VALUES ('Spotted Towhee', 21.6, 26.7, 'Emberizidae', FALSE),
  ('American Robin', 25.5, 36.0, 'Turdidae', FALSE),
  ('Greater Koa Finch', 19.0, 24.0, 'Fringillidae', TRUE),
  ('Carolina Parakeet', 33.0, 55.8, 'Psittacidae', TRUE),
  ('Common Kestrel', 35.5, 73.5, 'Falconidae', FALSE);

SELECT
  name,
  family
FROM birds
WHERE extinct = FALSE
ORDER BY lenght DESC;

SELECT
  ROUND(AVG(wingspan)) AS avg,
  MIN(wingspan),
  MAX(wingspan)
FROM birds;

CREATE TABLE menu_items (
  item text,
  prep_time integer,
  ingredient_cost numeric(4, 2),
  sales integer,
  menu_price numeric(4, 2)
);

INSERT INTO menu_items
  VALUES ('omelette', 10, 1.50, 182, 7.99);
INSERT INTO menu_items
  VALUES ('tacos', 5, 2.00, 254, 8.99);
INSERT INTO menu_items
  VALUES ('oatmeal', 1, 0.50, 79, 5.99);

SELECT
  item,
  (menu_price - ingredient_cost) AS profit
FROM menu_items
ORDER BY profit DESC
LIMIT 1;

SELECT
  item,
  menu_price,
  ingredient_cost,
  ROUND(prep_time / 60.0 * 13.0, 2) AS labor,
  menu_price - ingredient_cost - ROUND(prep_time / 60.0 * 13.0, 2) AS profit
FROM menu_items
ORDER BY profit DESC;