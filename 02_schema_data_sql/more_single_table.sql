$ createdb residents

$ psql -d residents < residents_with_data.sql

-- or
psql -d residents
\i residents_with_data.sql

SELECT state, COUNT(id)
FROM people
GROUP BY state
ORDER BY count DESC LIMIT 10;


select distinct substring(email,'@.+') as domain,
       count(id)
  from people
  group by domain
  order by count desc;

-- or

SELECT substr(email, strpos(email, '@') + 1) as domain,
       COUNT(id)
  FROM people
  GROUP BY domain
  ORDER BY count DESC;

DELETE FROM people WHERE id = 3399;

DELETE FROM people WHERE state = 'CA';

UPDATE people SET given_name = UPPER(given_name)
 WHERE email LIKE '%teleworm.us';

DELETE FROM people;