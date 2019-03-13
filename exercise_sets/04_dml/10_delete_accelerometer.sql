/*
10 Delete Accelerometer

Our workshop has decided to not make an Accelerometer after
all. Delete any data related to "Accelerometer", this includes
the parts associated with an Accelerometer.
*/

DELETE FROM parts
WHERE device_id = 1;

DELETE FROM devices
WHERE name = 'Accelerometer';


/*
Further Exploration

This process may have been a bit simpler if we had initially
defined our devices tables a bit differently. We could delete
both a device and its associated parts with one SQL statement
if that were the case. What change would have to be made to
table parts to make this possible? Also, what SQL statement
would you have to write that can delete both a device and
its parts all in one go?
*/

-- if we had defined our foreign key with ON DELETE CASCADE;
-- (FOREIGN KEY(device_id) REFERENCES devices(id) ON DELETE CASCADE;)
DELETE FROM devices WHERE id = 1;