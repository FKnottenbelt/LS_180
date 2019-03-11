/*
05 Check Values in List

The spectral_type column in the stars table is currently
defined as a one-character string that contains one of the
following 7 values: 'O', 'B', 'A', 'F', 'G', 'K', and 'M'.
However, there is currently no enforcement on the values
that may be entered. Add a constraint to the table stars
that will enforce the requirement that a row must hold one
of the 7 listed values above. Also, make sure that a value
is required for this column.
*/

-- already did that earlier:
ALTER TABLE stars ADD CONSTRAINT spectral_types
  CHECK (spectral_type IN ('O','B','A','F','G','K','M'));

-- not null
ALTER TABLE stars ALTER COLUMN spectral_type SET NOT NULL;

-- solution in one go:
ALTER TABLE stars
ADD CHECK (spectral_type IN ('O', 'B', 'A', 'F', 'G', 'K', 'M')),
ALTER COLUMN spectral_type SET NOT NULL;

-- as mentioned in exercise 01. Enum is fun too.

/*
Further Exploration

Assume the stars table contains one or more rows that are
missing a spectral_type value, or that have an illegal value.
What will happen when you try to alter the table schema? How
would you go about adjusting the data to work around this problem.
To test this, revert the modification and add some data:


ALTER TABLE stars
DROP CONSTRAINT stars_spectral_type_check,
ALTER COLUMN spectral_type DROP NOT NULL;

INSERT INTO stars (name, distance, companions)
           VALUES ('Epsilon Eridani', 10.5, 0);

INSERT INTO stars (name, distance, spectral_type, companions)
           VALUES ('Lacaille 9352', 10.68, 'X', 0);

ALTER TABLE stars
ADD CHECK (spectral_type IN ('O', 'B', 'A', 'F', 'G', 'K', 'M')),
ALTER COLUMN spectral_type SET NOT NULL;
*/

/*
extrasolar=# select * from stars;
 id |      name       | distance | spectral_type | companions
----+-----------------+----------+---------------+------------
  1 | Epsilon Eridani |     10.5 |               |          0
  2 | Lacaille 9352   |    10.68 | X             |          0
(2 rows)

ERROR:  column "spectral_type" contains null values
and later it will complain about the check violation X

so: alter the data or the checks..
*/
