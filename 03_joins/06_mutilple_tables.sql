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

SELECT customers.id, customers.email,
       COUNT(DISTINCT tickets.event_id)
  FROM customers INNER JOIN tickets on tickets.customer_id = customers.id
  GROUP BY customers.id
  HAVING COUNT(DISTINCT tickets.event_id) = 3;

SELECT events.name AS event,
       events.starts_at,
       sections.name AS section, s
       eats.row,
       seats.number AS seat
  FROM tickets
    INNER JOIN events ON tickets.event_id = events.id
    INNER JOIN customers ON tickets.customer_id = customers.id
    INNER JOIN seats ON tickets.seat_id = seats.id
    INNER JOIN sections ON seats.section_id = sections.id
WHERE customers.email = 'gennaro.rath@mcdermott.co';