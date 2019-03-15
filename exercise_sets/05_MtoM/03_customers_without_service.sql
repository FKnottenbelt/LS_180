-- 03 Get Customers With No Services

-- Write a query to retrieve the customer data for every customer
-- who does not currently subscribe to any services.

SELECT customers.*
FROM customers
WHERE id NOT IN (SELECT customer_id FROM customers_services);

-- or
SELECT customers.* FROM customers
LEFT OUTER JOIN customers_services
             ON customer_id = customers.id
WHERE service_id IS NULL;

-- Further Exploration

-- Can you write a query that displays all customers with no services
-- and all services that currently don't have any customers? The output
-- should look like this:

-- id |     name      | payment_token | id |     description     | price
-- ----+---------------+---------------+----+---------------------+--------
--   2 | Nancy Monreal | JKWQPJKL      |    |                     |
--     |               |               |  8 | One-to-one Training | 999.00
-- (2 rows)

-- Hint: read the documentation for the JOIN clause in the SELECT
-- statement.

SELECT customers.* ,
       services.*
  FROM customers
    FULL JOIN customers_services ON customer_id = customers.id
    FULL JOIN services ON service_id = services.id
  WHERE service_id IS NULL OR customer_id is null;

