/*
04 Stellar Distance Precision

For many of the closest stars, we know the distance from Earth
fairly accurately; for instance, Proxima Centauri is roughly 4.3
light years away. Our database, as currently defined, only allows
integer distances, so the most accurate value we can enter is 4.
Modify the distance column in the stars table so that it allows
fractional light years to any degree of precision required
*/

ALTER TABLE stars
  ALTER COLUMN distance TYPE numeric;

/*
Further Exploration

Assume the stars table already contains one or more rows of data.
What will happen when you try to run the above command? To test
this, revert the modification and add a row or two of data:

ALTER TABLE stars
ALTER COLUMN distance TYPE integer;

INSERT INTO stars (name, distance, spectral_type, companions)
           VALUES ('Alpha Orionis', 643, 'M', 9);

ALTER TABLE stars
ALTER COLUMN distance TYPE numeric ;

*/

-- nothing, numeric is 'any precison', so no precision works fine
-- Going from numeric to int would round the decimal to the nearest
-- integer.
