DROP DATABASE IF EXISTS lesson0307;

CREATE DATABASE lesson0307;

\c lesson0307

\i orders_products1.sql

ALTER TABLE orders
ADD CONSTRAINT orders_product_id_fkey FOREIGN KEY (product_id)
REFERENCES products(id);

INSERT INTO products
  VALUES(DEFAULT,'small bolt'),
        (DEFAULT, 'large bolt');
INSERT INTO orders (quantity, product_id)
   VALUES (10, 1),
          (25, 1),
          (15, 2);

SELECT orders.quantity, products.name
  FROM orders
  INNER JOIN products ON products.id = orders.product_id;

INSERT INTO orders (quantity) VALUES (0);

DELETE FROM orders WHERE product_id IS NULL;
ALTER TABLE orders ALTER COLUMN product_id SET NOT NULL;

-- CREATE TABLE reviews (
--   id serial PRIMARY KEY,
--   product_id INT NOT NULL,
--   review text NOT NULL,
--   FOREIGN KEY (product_id) REFERENCES products(id)
-- );

CREATE TABLE reviews (
  id serial PRIMARY KEY,
  body text NOT NULL,
  product_id integer REFERENCES products (id)
);

INSERT INTO reviews (product_id, body)
  VALUES (1, 'a little small'),
         (1, 'very round!'),
         (2, 'could have been smaller');

