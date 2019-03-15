/*
02 Get Customers With Services

Write a query to retrieve the customer data for every customer
who currently subscribes to at least one service.

*/

SELECT DISTINCT customers.*
FROM customers
  INNER JOIN customers_services ON customer_id = customers.id;

