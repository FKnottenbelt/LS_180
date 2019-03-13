/*
06 ORDER BY

In the previous exercise, we had to use a GROUP BY clause
to obtain the expected output. In that exercise, we used an
SQL query like:

SELECT devices.name AS name, COUNT(parts.device_id)
FROM devices
JOIN parts ON devices.id = parts.device_id
GROUP BY devices.name;

Now, we want to work with the same query, but we want to
guarantee that the devices and the count of their parts are
listed in ascending alphabetical order. Alter the SQL query
above so that we get a result table that looks like the following.

name          | count
--------------+-------
Accelerometer |     3
Gyroscope     |     5
(2 rows)
*/

SELECT devices.name AS name, COUNT(parts.device_id)
FROM devices
JOIN parts ON devices.id = parts.device_id
GROUP BY devices.name
ORDER BY devices.name;