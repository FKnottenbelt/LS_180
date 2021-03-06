-- 01
DROP DATABASE IF EXISTS billing;
CREATE DATABASE billing;

\c billing

CREATE TABLE customers(
  id serial PRIMARY KEY,
  name text NOT NULL,
  payment_token CHAR(8) UNIQUE CHECK (payment_token ~ '[A-Z]{8}')
);

CREATE TABLE services(
  id serial PRIMARY KEY,
  description text NOT NULL,
  price numeric(10,2) NOT NULL CHECK (price >= 0.00)
);

INSERT INTO customers (name, payment_token)
VALUES
  ('Pat Johnson', 'XHGOAHEQ'),
  ('Nancy Monreal', 'JKWQPJKL'),
  ('Lynn Blake', 'KLZXWEEE'),
  ('Chen Ke-Hua', 'KWETYCVX'),
  ('Scott Lakso', 'UUEAPQPS'),
  ('Jim Pornot', 'XKJEYAZA');

INSERT INTO services (description, price)
VALUES
  ('Unix Hosting', 5.95),
  ('DNS', 4.95),
  ('Whois Registration', 1.95),
  ('High Bandwidth', 15.00),
  ('Business Support', 250.00),
  ('Dedicated Hosting', 50.00),
  ('Bulk Email', 250.00),
  ('One-to-one Training', 999.00);

CREATE TABLE customers_services (
  id serial PRIMARY KEY,
  customer_id integer REFERENCES customers (id)
    ON DELETE CASCADE,
  service_id integer REFERENCES services (id),
  UNIQUE(customer_id, service_id)
);

INSERT INTO customers_services (customer_id, service_id)
VALUES
  (1, 1), -- Pat Johnson/Unix Hosting
  (1, 2), --            /DNS
  (1, 3), --            /Whois Registration
  (3, 1), -- Lynn Blake/Unix Hosting
  (3, 2), --           /DNS
  (3, 3), --           /Whois Registration
  (3, 4), --           /High Bandwidth
  (3, 5), --           /Business Support
  (4, 1), -- Chen Ke-Hua/Unix Hosting
  (4, 4), --            /High Bandwidth
  (5, 1), -- Scott Lakso/Unix Hosting
  (5, 2), --            /DNS
  (5, 6), --            /Dedicated Hosting
  (6, 1), -- Jim Pornot/Unix Hosting
  (6, 6), --           /Dedicated Hosting
  (6, 7); --           /Bulk Email

-- 02
SELECT DISTINCT customers.*
FROM customers
  INNER JOIN customers_services ON customer_id = customers.id;

-- 03
SELECT customers.* FROM customers
LEFT OUTER JOIN customers_services
             ON customer_id = customers.id
WHERE service_id IS NULL;

-- Further Exploration
SELECT customers.* ,
       services.*
  FROM customers
    FULL JOIN customers_services ON customer_id = customers.id
    FULL JOIN services ON service_id = services.id
  WHERE service_id IS NULL OR customer_id is null;

-- 04
SELECT description FROM customers_services
RIGHT OUTER JOIN services
              ON services.id = service_id
WHERE service_id IS NULL;

-- 05
SELECT c.name,
       string_agg(s.description, ', ') AS services
  FROM customers c
    LEFT OUTER JOIN customers_services cs ON c.id = cs.customer_id
    LEFT OUTER JOIN services s ON s.id = cs.service_id
  GROUP BY c.name;

-- Further Exploration

-- 06
SELECT DISTINCT description,
       COUNT(customer_id)
  FROM services
    INNER JOIN customers_services cs ON cs.service_id = services.id
  GROUP BY description
    HAVING COUNT(customer_id) >= 3
  ORDER BY description;

-- 07
SELECT sum(s.price) AS gross
  FROM services s
    INNER JOIN customers_services cs ON cs.service_id = s.id;

-- 08
INSERT INTO customers (name, payment_token)
  VALUES ('John Doe','EYODHLCN') RETURNING ID;

SELECT id, description FROM services;

INSERT INTO customers_services (customer_id, service_id)
  VALUES (7, 1),
         (7, 2),
         (7, 3);

-- 09
SELECT cs.customer_id, s.description, s.price
  FROM customers_services cs
    INNER JOIN services s ON cs.service_id = s.id
  WHERE price > 100;

SELECT SUM(price)
  FROM customers
    CROSS JOIN services
  WHERE price > 100;

-- 10
DELETE FROM customers WHERE name = 'Chen Ke-Hua';

DELETE FROM customers_services
  WHERE service_id = 7;

DELETE FROM services
  WHERE id = 7;
