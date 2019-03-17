-- 09 Hypothetically

-- The company president is looking to increase revenue. As a prelude
-- to his decision making, he asks for two numbers: the amount of
-- expected income from "big ticket" services (those services that
-- cost more than $100) and the maximum income the company could
-- achieve if it managed to convince all of its customers to select
-- all of the company's big ticket items.

-- For simplicity, your solution should involve two separate SQL
-- queries: one that reports the current expected income level,
-- and one that reports the hypothetical maximum. The outputs should
-- look like this:

-- sum
-- --------
-- 500.00
-- (1 row)

--   sum
-- ---------
-- 10493.00
-- (1 row)

SELECT * FROM services
  WHERE price > 100;

 id |     description     | price
----+---------------------+--------
  5 | Business Support    | 250.00
  7 | Bulk Email          | 250.00
  8 | One-to-one Training | 999.00
(3 rows)

SELECT cs.customer_id, s.description, s.price
  FROM customers_services cs
    INNER JOIN services s ON cs.service_id = s.id
  WHERE price > 100;

 customer_id |   description    | price
-------------+------------------+--------
           3 | Business Support | 250.00
           6 | Bulk Email       | 250.00
(2 rows)

SELECT sum(s.price) as current_expected_income_level
  FROM customers_services cs
    INNER JOIN services s ON cs.service_id = s.id
  WHERE price >= 100;

 current_expected_income_level
-------------------------------
                        500.00
(1 row)

SELECT *
  FROM customers
    CROSS JOIN services;
 id |     name      | payment_token | id |     description     | price
----+---------------+---------------+----+---------------------+--------
  1 | Pat Johnson   | XHGOAHEQ      |  1 | Unix Hosting        |   5.95
  2 | Nancy Monreal | JKWQPJKL      |  1 | Unix Hosting        |   5.95
  3 | Lynn Blake    | KLZXWEEE      |  1 | Unix Hosting        |   5.95
  4 | Chen Ke-Hua   | KWETYCVX      |  1 | Unix Hosting        |   5.95
  5 | Scott Lakso   | UUEAPQPS      |  1 | Unix Hosting        |   5.95
  6 | Jim Pornot    | XKJEYAZA      |  1 | Unix Hosting        |   5.95
  7 | John Doe      | EYODHLCN      |  1 | Unix Hosting        |   5.95
  1 | Pat Johnson   | XHGOAHEQ      |  2 | DNS                 |   4.95
  2 | Nancy Monreal | JKWQPJKL      |  2 | DNS                 |   4.95
  3 | Lynn Blake    | KLZXWEEE      |  2 | DNS                 |   4.95
  4 | Chen Ke-Hua   | KWETYCVX      |  2 | DNS                 |   4.95
  5 | Scott Lakso   | UUEAPQPS      |  2 | DNS                 |   4.95
  6 | Jim Pornot    | XKJEYAZA      |  2 | DNS                 |   4.95
  7 | John Doe      | EYODHLCN      |  2 | DNS                 |   4.95
  1 | Pat Johnson   | XHGOAHEQ      |  3 | Whois Registration  |   1.95
  2 | Nancy Monreal | JKWQPJKL      |  3 | Whois Registration  |   1.95
  3 | Lynn Blake    | KLZXWEEE      |  3 | Whois Registration  |   1.95
  4 | Chen Ke-Hua   | KWETYCVX      |  3 | Whois Registration  |   1.95
  5 | Scott Lakso   | UUEAPQPS      |  3 | Whois Registration  |   1.95
  6 | Jim Pornot    | XKJEYAZA      |  3 | Whois Registration  |   1.95
  7 | John Doe      | EYODHLCN      |  3 | Whois Registration  |   1.95
  1 | Pat Johnson   | XHGOAHEQ      |  4 | High Bandwidth      |  15.00
  2 | Nancy Monreal | JKWQPJKL      |  4 | High Bandwidth      |  15.00
  3 | Lynn Blake    | KLZXWEEE      |  4 | High Bandwidth      |  15.00
  4 | Chen Ke-Hua   | KWETYCVX      |  4 | High Bandwidth      |  15.00
  5 | Scott Lakso   | UUEAPQPS      |  4 | High Bandwidth      |  15.00
  6 | Jim Pornot    | XKJEYAZA      |  4 | High Bandwidth      |  15.00
  7 | John Doe      | EYODHLCN      |  4 | High Bandwidth      |  15.00
  1 | Pat Johnson   | XHGOAHEQ      |  5 | Business Support    | 250.00
  2 | Nancy Monreal | JKWQPJKL      |  5 | Business Support    | 250.00
  3 | Lynn Blake    | KLZXWEEE      |  5 | Business Support    | 250.00
  4 | Chen Ke-Hua   | KWETYCVX      |  5 | Business Support    | 250.00
  5 | Scott Lakso   | UUEAPQPS      |  5 | Business Support    | 250.00
  6 | Jim Pornot    | XKJEYAZA      |  5 | Business Support    | 250.00
  7 | John Doe      | EYODHLCN      |  5 | Business Support    | 250.00
  1 | Pat Johnson   | XHGOAHEQ      |  6 | Dedicated Hosting   |  50.00
  2 | Nancy Monreal | JKWQPJKL      |  6 | Dedicated Hosting   |  50.00
  3 | Lynn Blake    | KLZXWEEE      |  6 | Dedicated Hosting   |  50.00
  4 | Chen Ke-Hua   | KWETYCVX      |  6 | Dedicated Hosting   |  50.00
  5 | Scott Lakso   | UUEAPQPS      |  6 | Dedicated Hosting   |  50.00
  6 | Jim Pornot    | XKJEYAZA      |  6 | Dedicated Hosting   |  50.00
  7 | John Doe      | EYODHLCN      |  6 | Dedicated Hosting   |  50.00
  1 | Pat Johnson   | XHGOAHEQ      |  7 | Bulk Email          | 250.00
  2 | Nancy Monreal | JKWQPJKL      |  7 | Bulk Email          | 250.00
  3 | Lynn Blake    | KLZXWEEE      |  7 | Bulk Email          | 250.00
  4 | Chen Ke-Hua   | KWETYCVX      |  7 | Bulk Email          | 250.00
  5 | Scott Lakso   | UUEAPQPS      |  7 | Bulk Email          | 250.00
  6 | Jim Pornot    | XKJEYAZA      |  7 | Bulk Email          | 250.00
  7 | John Doe      | EYODHLCN      |  7 | Bulk Email          | 250.00
  1 | Pat Johnson   | XHGOAHEQ      |  8 | One-to-one Training | 999.00
  2 | Nancy Monreal | JKWQPJKL      |  8 | One-to-one Training | 999.00
  3 | Lynn Blake    | KLZXWEEE      |  8 | One-to-one Training | 999.00
  4 | Chen Ke-Hua   | KWETYCVX      |  8 | One-to-one Training | 999.00
  5 | Scott Lakso   | UUEAPQPS      |  8 | One-to-one Training | 999.00
  6 | Jim Pornot    | XKJEYAZA      |  8 | One-to-one Training | 999.00
  7 | John Doe      | EYODHLCN      |  8 | One-to-one Training | 999.00
(56 rows)

SELECT *
  FROM customers
    CROSS JOIN services
  WHERE price > 100;

 id |     name      | payment_token | id |     description     | price
----+---------------+---------------+----+---------------------+--------
  1 | Pat Johnson   | XHGOAHEQ      |  5 | Business Support    | 250.00
  1 | Pat Johnson   | XHGOAHEQ      |  7 | Bulk Email          | 250.00
  1 | Pat Johnson   | XHGOAHEQ      |  8 | One-to-one Training | 999.00
  2 | Nancy Monreal | JKWQPJKL      |  5 | Business Support    | 250.00
  2 | Nancy Monreal | JKWQPJKL      |  7 | Bulk Email          | 250.00
  2 | Nancy Monreal | JKWQPJKL      |  8 | One-to-one Training | 999.00
  3 | Lynn Blake    | KLZXWEEE      |  5 | Business Support    | 250.00
  3 | Lynn Blake    | KLZXWEEE      |  7 | Bulk Email          | 250.00
  3 | Lynn Blake    | KLZXWEEE      |  8 | One-to-one Training | 999.00
  4 | Chen Ke-Hua   | KWETYCVX      |  5 | Business Support    | 250.00
  4 | Chen Ke-Hua   | KWETYCVX      |  7 | Bulk Email          | 250.00
  4 | Chen Ke-Hua   | KWETYCVX      |  8 | One-to-one Training | 999.00
  5 | Scott Lakso   | UUEAPQPS      |  5 | Business Support    | 250.00
  5 | Scott Lakso   | UUEAPQPS      |  7 | Bulk Email          | 250.00
  5 | Scott Lakso   | UUEAPQPS      |  8 | One-to-one Training | 999.00
  6 | Jim Pornot    | XKJEYAZA      |  5 | Business Support    | 250.00
  6 | Jim Pornot    | XKJEYAZA      |  7 | Bulk Email          | 250.00
  6 | Jim Pornot    | XKJEYAZA      |  8 | One-to-one Training | 999.00
  7 | John Doe      | EYODHLCN      |  5 | Business Support    | 250.00
  7 | John Doe      | EYODHLCN      |  7 | Bulk Email          | 250.00
  7 | John Doe      | EYODHLCN      |  8 | One-to-one Training | 999.00
(21 rows)

SELECT SUM(price)
  FROM customers
    CROSS JOIN services
  WHERE price > 100;

   sum
----------
 10493.00
(1 row)