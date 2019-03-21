-- 04 Conditional Subqueries: EXISTS

-- Write a SELECT query that returns a list of names of everyone
-- who has bid in the auction. While it is possible (and perhaps easier)
-- to do this with a JOIN clause, we're going to do things differently:
-- use a subquery with the EXISTS clause instead. Here is the expected
-- output:

--       name
-- -----------------
-- Alison Walker
-- James Quinn
-- Taylor Williams
-- Alexis Jones
-- Gwen Miller
-- Alan Parker
-- (6 rows)

SELECT name FROM bidders
WHERE EXISTS (SELECT 1 FROM bids WHERE bids.bidder_id = bidders.id);

-- Further Exploration

-- More often than not, we can get an equivalent result by using a
-- JOIN clause, instead of a subquery. Can you figure out a SELECT
-- query that uses a JOIN clause that returns the same output as our
-- solution above?


-- non orderd solutions:
SELECT DISTINCT bidders.name
  FROM bidders
  LEFT OUTER JOIN bids ON bidders.id = bids.bidder_id
  WHERE bids.bidder_id IS NOT NULL;

SELECT DISTINCT name FROM bidders
INNER JOIN bids ON bidders.id = bids.bidder_id;

-- orderd solutions
SELECT bidders.name
  FROM bidders
  LEFT OUTER JOIN bids ON bidders.id = bids.bidder_id
  WHERE bids.bidder_id IS NOT NULL
  GROUP BY bidders.id
  ORDER BY bidders.id;

SELECT bidders.name FROM bidders
JOIN bids ON bids.bidder_id = bidders.id
GROUP BY bidders.id
ORDER BY bidders.id;

