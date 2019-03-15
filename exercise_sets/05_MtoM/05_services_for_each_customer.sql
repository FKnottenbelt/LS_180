-- 05 Services for each Customer

-- Write a query to display a list of all customer names together
-- with a comma-separated list of the services they use. Your output
-- should look like this:

--     name      |                                services
-- ---------------+-------------------------------------------------------------------------
-- Pat Johnson   | Unix Hosting, DNS, Whois Registration
-- Nancy Monreal |
-- Lynn Blake    | DNS, Whois Registration, High Bandwidth, Business Support, Unix Hosting
-- Chen Ke-Hua   | High Bandwidth, Unix Hosting
-- Scott Lakso   | DNS, Dedicated Hosting, Unix Hosting
-- Jim Pornot    | Unix Hosting, Dedicated Hosting, Bulk Email
-- (6 rows)

SELECT c.name,
       string_agg(s.description, ', ') AS services
  FROM customers c
    LEFT OUTER JOIN customers_services cs ON c.id = cs.customer_id
    LEFT OUTER JOIN services s ON s.id = cs.service_id
  GROUP BY c.name;

-- Further Exploration

-- Can you modify the above command so the output looks like this?

--     name      |    description
-- ---------------+--------------------
-- Chen Ke-Hua   | High Bandwidth
--               | Unix Hosting
-- Jim Pornot    | Dedicated Hosting
--               | Unix Hosting
--               | Bulk Email
-- Lynn Blake    | Whois Registration
--               | High Bandwidth
--               | Business Support
--               | DNS
--               | Unix Hosting
-- Nancy Monreal |
-- Pat Johnson   | Whois Registration
--               | DNS
--               | Unix Hosting
-- Scott Lakso   | DNS
--               | Dedicated Hosting
--               | Unix Hosting
-- (17 rows)

-- This won't be easy! Hint: you will need to use the window
-- lag function together with a CASE condition in your SELECT.
-- To get you started, try this command:

-- SELECT customers.name,
--       lag(customers.name)
--         OVER (ORDER BY customers.name)
--         AS previous,
--       services.description
-- FROM customers
-- LEFT OUTER JOIN customers_services
--             ON customer_id = customers.id
-- LEFT OUTER JOIN services
--             ON services.id = service_id;

-- Examine the relationship between the previous column and the
-- rest of the table to get a handle on what lag does.
