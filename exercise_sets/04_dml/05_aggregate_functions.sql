/*
05 Aggregate Functions

Write an SQL query that returns a result table with the name
of each device in our database together with the number of
parts for that device.
*/

SELECT devices.name, COUNT(parts.part_number)
FROM devices
INNER JOIN parts on parts.device_id = devices.id
GROUP BY devices.name;