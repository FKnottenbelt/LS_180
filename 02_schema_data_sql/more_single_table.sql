$ createdb residents

$ psql -d residents < residents_with_data.sql

-- or
psql -d residents
\i residents_with_data.sql

SELECT state, COUNT(id)
FROM people
GROUP BY state
ORDER BY count DESC LIMIT 10;