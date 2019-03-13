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
