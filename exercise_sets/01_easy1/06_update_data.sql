-- It seems there was a mistake when we were inserting data in the
-- birds table. One of the rows has a species of 'Crow', but that
-- bird is actually a Raven. Update the birds table so that a row
-- with a species of 'Crow' now reads 'Raven'.

update birds set species = 'Raven' where species = 'Crow';

-- Further Exploration

-- Oops. Jamie isn't an Owl - he's a Hawk. Correct his information.
update birds set species = 'Hawk' where name = 'Jamie';
