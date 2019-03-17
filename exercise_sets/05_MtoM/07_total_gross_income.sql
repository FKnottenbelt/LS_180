-- 07 Total Gross Income

-- Assuming that everybody in our database has a bill coming due,
-- and that all of them will pay on time, write a query to compute
-- the total gross income we expect to receive.

-- Answer:

--   gross
-- --------
-- 678.50
-- (1 row)

SELECT sum(s.price) AS gross
  FROM services s
    INNER JOIN customers_services cs ON cs.service_id = s.id;
