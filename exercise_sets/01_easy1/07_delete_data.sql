-- Write an SQL statement that deletes the record that describes
-- a 3 year-old finch.

select * from birds where species = 'Finch' and age = 3;

delete from birds where species = 'Finch' and age = 3;