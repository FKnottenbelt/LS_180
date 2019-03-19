-- 02 Conditional Subqueries: IN

-- Write a SQL query that shows all items that have had bids
-- put on them. Use the logical operator IN for this exercise, as
-- well as a subquery.

-- Here is the expected output:

-- Bid on Items
-- ---------------
-- Video Game
-- Outdoor Grill
-- Painting
-- Tent
-- Vase
-- (5 rows)

SELECT items.name as "Bid on Items"
  FROM items
  WHERE items.id IN
    (SELECT DISTINCT item_id FROM bids);