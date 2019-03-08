\i theater_full.sql

SELECT COUNT(*) FROM tickets;
SELECT COUNT(DISTINCT customer_id) FROM tickets;

SELECT COUNT(DISTINCT tickets.customer_id) /
       COUNT(DISTINCT customers.id)::float * 100 AS percent
  FROM customers
  LEFT OUTER JOIN tickets ON tickets.customer_id = customers.id;

SELECT events.name, count(tickets.id) AS popularity
  FROM events
  JOIN tickets ON events.id = tickets.event_id
  GROUP BY events.name
  ORDER BY popularity DESC;