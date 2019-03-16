-- 06 Services With At Least 3 Customers

-- Write a query that displays the description for every service
-- that is subscribed to by at least 3 customers. Include the
-- customer count for each description in the report. The report
-- should look like this:

-- description  | count
-- --------------+-------
-- DNS          |     3
-- Unix Hosting |     5
-- (2 rows)

SELECT DISTINCT description,
       COUNT(customer_id)
  FROM services
    INNER JOIN customers_services cs ON cs.service_id = services.id
  GROUP BY description
    HAVING COUNT(customer_id) >= 3
  ORDER BY description;

