/*
09 UPDATE device_id

We've realized that the last two parts we're using for device
number 2, "Gyroscope", actually belong to an "Accelerometer".
Write an SQL statement that will associate the last two parts
from our parts table with an "Accelerometer" instead of a
"Gyroscope".

*/

-- last 2 of gyro (id 2): parts id 30 and 31
-- need to go to acc(id 1)

UPDATE parts SET device_id = 1
WHERE id IN (30, 31);

-- or

UPDATE parts SET device_id = 1
WHERE part_number=37 OR part_number=39;

/*
Further Exploration

What if we wanted to set the part with the smallest part_number
to be associated with "Gyroscope"? How would we go about doing that?
*/

UPDATE parts SET device_id = 2
WHERE part_number = (SELECT min(part_number) FROM parts);

