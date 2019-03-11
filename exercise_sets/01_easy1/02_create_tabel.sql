-- Now that we have an animals database, we can lay the groundwork
-- needed to add some data to it.

-- Make a table called birds. It should have the following fields:

--     id (a primary key)
--     name (string with space for up to 25 characters)
--     age (integer)
--     species (string with space for up to 15 characters)

create table birds(
  id serial Primary Key,
  name varchar(25),
  age INT,
  species varchar(15)
);
