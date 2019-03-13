-- 01

CREATE DATABASE workshop;

\c workshop

CREATE TABLE devices(
  id serial PRIMARY KEY,
  name text NOT NULL,
  created_at timestamp DEFAULT NOW()
);

CREATE TABLE parts(
  id serial PRIMARY KEY,
  part_number INT NOT NULL UNIQUE,
  device_id INT REFERENCES devices(id)
);

-- 02
INSERT INTO devices (name) VALUES ('Accelerometer');
INSERT INTO devices (name) VALUES ('Gyroscope');

INSERT INTO parts (part_number, device_id) VALUES (12, 1);
INSERT INTO parts (part_number, device_id) VALUES (14, 1);
INSERT INTO parts (part_number, device_id) VALUES (16, 1);

INSERT INTO parts (part_number, device_id) VALUES (31, 2);
INSERT INTO parts (part_number, device_id) VALUES (33, 2);
INSERT INTO parts (part_number, device_id) VALUES (35, 2);
INSERT INTO parts (part_number, device_id) VALUES (37, 2);
INSERT INTO parts (part_number, device_id) VALUES (39, 2);

INSERT INTO parts (part_number) VALUES (50);
INSERT INTO parts (part_number) VALUES (54);
INSERT INTO parts (part_number) VALUES (58);

-- 03
SELECT devices.name,
       parts.part_number
FROM devices
INNER JOIN parts ON parts.device_id = devices.id;

-- 04
SELECT * FROM parts WHERE part_number::text LIKE '3%';

-- 05
SELECT devices.name, COUNT(parts.part_number)
FROM devices
INNER JOIN parts on parts.device_id = devices.id
GROUP BY devices.name;

-- 06

SELECT devices.name AS name, COUNT(parts.device_id)
FROM devices
JOIN parts ON devices.id = parts.device_id
GROUP BY devices.name
ORDER BY devices.name;

-- 07
SELECT part_number, device_id
FROM parts
WHERE device_id IS NOT NULL;

SELECT part_number, device_id
FROM parts
WHERE device_id IS NULL;

-- 08
SELECT name AS oldest_device
FROM devices
ORDER BY created_at
LIMIT 1;

-- 09
UPDATE parts SET device_id = 1
WHERE id IN (30, 31);

-- Further Exploration
-- UPDATE parts SET device_id = 2
-- WHERE part_number = (SELECT min(part_number) FROM parts);

-- 10
DELETE FROM parts
WHERE device_id = 1;

DELETE FROM devices
WHERE name = 'Accelerometer';
