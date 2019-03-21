-- 01
CREATE DATABASE auction;

\c auction

CREATE TABLE bidders(
  id serial PRIMARY KEY,
  name text NOT NULL
);

CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  initial_price DECIMAL(6,2) NOT NULL CHECK(initial_price BETWEEN 0.01 AND 1000.00),
  sales_price DECIMAL(6,2) CHECK(sales_price BETWEEN 0.01 AND 1000.00)
);

CREATE TABLE bids (
  id SERIAL PRIMARY KEY,
  bidder_id integer NOT NULL REFERENCES bidders(id) ON DELETE CASCADE,
  item_id integer NOT NULL REFERENCES items(id) ON DELETE CASCADE,
  amount DECIMAL(6,2) NOT NULL CHECK(amount BETWEEN 0.01 AND 1000.00)
);

CREATE INDEX bidder_item_id ON bids (bidder_id, item_id);

\copy bidders FROM 'bidders.csv' WITH DELIMITER ',' CSV HEADER;
\copy items FROM 'items.csv' WITH DELIMITER ',' CSV HEADER;
\copy bids FROM 'bids.csv' WITH DELIMITER ',' CSV HEADER;

-- 02
SELECT items.name as "Bid on Items"
  FROM items
  WHERE items.id IN
    (SELECT DISTINCT item_id FROM bids);

-- 03

SELECT items.name AS "Not Bid On"
  FROM items
  WHERE items.id NOT IN
    (SELECT DISTINCT item_id FROM bids);

-- 04
SELECT name FROM bidders
WHERE EXISTS (SELECT 1 FROM bids WHERE bids.bidder_id = bidders.id);

-- further exploration
SELECT bidders.name FROM bidders
  JOIN bids ON bids.bidder_id = bidders.id
  GROUP BY bidders.id
  ORDER BY bidders.id;

-- 05
SELECT name AS "Bids Less Than 100 Dollars" FROM items
WHERE 100.00 > ANY
  (SELECT amount FROM bids WHERE item_id = items.id);

SELECT items.name AS "Bids Less Than 100 Dollars"
  FROM items
  WHERE items.id = ANY
   (SELECT item_id FROM bids WHERE amount < 100.00);

SELECT name AS "Bids Less Than 100 Dollars" FROM items
WHERE 100.00 > ALL
  (SELECT amount FROM bids WHERE item_id = items.id);

-- 06
SELECT max(total_bids.count) FROM
  (SELECT COUNT(item_id)
     FROM bids GROUP by bidder_id) AS total_bids;

-- 07
SELECT items.name,
       (SELECT COUNT(item_id) FROM bids
           WHERE items.id = bids.item_id)
  FROM items;

-- Further Exploration
SELECT items.name,
       count(bids.item_id)
  FROM items
  LEFT OUTER JOIN bids ON bids.item_id = items.id
  GROUP BY items.name;
