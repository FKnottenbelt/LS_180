-- 05 Conditional Subqueries: ANY, SOME, ALL

-- This exercise will be a bit longer than the previous ones, but
-- the logical operators we'll cover are all closely related.

-- Write an SQL query that returns the names of all items that have
-- bids of less than 100 dollars. To accomplish this, use an ANY
-- clause, along with a subquery.

-- Expected Output:

-- Bids Less Than 100 Dollars
-- ----------------------------------
-- Video Game
-- Outdoor Grill
-- Vase
-- (3 rows)

-- Finally, write the same query that you used to get the result
-- above, but replace your ANY clause with an ALL clause. You
-- shouldn't have to use any JOINs to finish this exercise.

-- Expected Output:

-- Bids Less Than 100 Dollars
-- ----------------------------------
-- Video Game
-- Outdoor Grill
-- Vase
-- Television
-- (4 rows)


-- Using ANY
SELECT name AS "Bids Less Than 100 Dollars" FROM items
WHERE 100.00 > ANY
  (SELECT amount FROM bids WHERE item_id = items.id);

SELECT items.name AS "Bids Less Than 100 Dollars"
  FROM items
  WHERE items.id = ANY
   (SELECT item_id FROM bids WHERE amount < 100.00);

-- Using ALL
SELECT name AS "Bids Less Than 100 Dollars" FROM items
WHERE 100.00 > ALL
  (SELECT amount FROM bids WHERE item_id = items.id);


-- Further Exploration

-- There is a way to get the same result table back using ALL for
-- this exercise. How would you go about doing this? Note that the
-- answer lies in the previous exercises for this set.

SELECT name AS "Highest Bid Less Than 100 Dollars" FROM items
  WHERE id <> ALL
   (SELECT item_id FROM bids WHERE amount >= 100)
  AND sales_price IS NOT NULL;


