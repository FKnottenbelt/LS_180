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
