CREATE TABLE orders (
    id serial,
    customer_name varchar(100) NOT NULL,
    burger varchar(50),
    side varchar(50),
    drink varchar(50),
    order_total decimal(4,2) NOT NULL
);

INSERT INTO orders VALUES (1, 'Todd Perez', 'LS Burger', 'Fries', 'Lemonade');
INSERT INTO orders VALUES (2, 'Florence Jordan', 'LS Cheeseburger', 'Fries', 'Chocolate Shake');
INSERT INTO orders VALUES (3, 'Robin Barnes', 'LS Burger', 'Onion Rings', 'Vanilla Shake');
INSERT INTO orders VALUES (4, 'Joyce Silva', 'LS Double Deluxe Burger', 'Fries', 'Chocolate Shake');
INSERT INTO orders VALUES (5, 'Joyce Silva', 'LS Chicken Burger', 'Onion Rings', 'Cola');

ALTER TABLE orders ADD COLUMN customer_email varchar(50);
ALTER TABLE orders ADD COLUMN customer_loyalty_points INT DEFAULT 0;

ALTER TABLE orders
  ADD COLUMN burger_cost decimal(4,2) DEFAULT 0,
  ADD COLUMN side_cost decimal(4,2) DEFAULT 0,
  ADD COLUMN drink_cost decimal(4,2) DEFAULT 0;

ALTER TABLE orders drop COLUMN order_total;

INSERT INTO orders (customer_name, customer_email, customer_loyalty_points, burger, side, drink, burger_cost, side_cost, drink_cost)
  VALUES ('James Bergman', 'james1998@email.com', 28, 'LS Chicken Burger', 'Fries', 'Cola', 4.50, 0.99, 1.50),
         ('Natasha O''Shea', 'natasha@osheafamily.com', 18, 'LS Cheeseburger', 'Fries', NULL, 3.50, 0.99, DEFAULT),
         ('Natasha O''Shea', 'natasha@osheafamily.com', 42, 'LS Double Deluxe Burger', 'Onion Rings', 'Chocolate Shake', 6.00, 1.50, 2.00),
         ('Aaron Muller', NULL, 10, 'LS Burger', NULL, NULL, 3.00, DEFAULT, DEFAULT);

-- select query exercises
select burger from orders where burger_cost < 5.00 order by burger_cost;
select customer_name, customer_email, customer_loyalty_points
 from orders where customer_loyalty_points >= 20
 order by customer_loyalty_points desc;
select burger from orders where customer_name = 'Natasha O''Shea';
select customer_name from orders where drink is null;
select burger, side, drink from orders
  where side <> 'Fries' or side is null;
select burger, side, drink from orders
  where side is not null and drink is not null;

-- Exercises 'more on select' queries
select avg(burger_cost) from orders where side = 'Fries';
select min(side_cost) from orders where side is not null;
select side, count(id) from orders
  where side = 'Fries' or side = 'Onion Rings'
  group by side;

-- update and delete exercises
update orders set drink = 'Lemonade'
  where customer_name = 'James Bergman';
update orders set side = 'Fries',
   side_cost = '0.99',
   customer_loyalty_points = 3
   where id = 4;
update orders set side_cost = '1.20' where side = 'Fries';

-- table_relationships exercises
create table customers(
  id serial PRIMARY KEY UNIQUE,
  customer_name varchar(100) NOT NULL
);

create table email_addresses(
  customer_id INT PRIMARY KEY UNIQUE,
  customer_email varchar(50),
  FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE
);

INSERT INTO customers (customer_name)
 VALUES ('James Bergman'),
        ('Natasha O''Shea'),
        ('Aaron Muller');

INSERT INTO email_addresses (customer_id, customer_email)
  VALUES (1, 'james1998@email.com'),
         (2, 'natasha@osheafamily.com');

create table products(
  id serial PRIMARY KEY UNIQUE,
  product_name varchar(50) not null,
  product_cost decimal(4,2) DEFAULT 0,
  product_type varchar(20),
  product_loyalty_points INT DEFAULT 0
);

INSERT INTO products (product_name, product_cost, product_type, product_loyalty_points)
 VALUES ('LS Burger', 3.00, 'Burger', 10 ),
        ('LS Cheeseburger', 3.50, 'Burger', 15 ),
        ('LS Chicken Burger', 4.50, 'Burger', 20 ),
        ('LS Double Deluxe Burger', 6.00, 'Burger', 30 ),
        ('Fries', 1.20, 'Side', 3 ),
        ('Onion Rings', 1.50, 'Side', 5 ),
        ('Cola', 1.50, 'Drink', 5 ),
        ('Lemonade', 1.50, 'Drink', 5 ),
        ('Vanilla Shake', 2.00, 'Drink', 7 ),
        ('Chocolate Shake', 2.00, 'Drink', 7 ),
        ('Strawberry Shake', 2.00, 'Drink', 7);

--
DROP TABLE orders;

CREATE TABLE orders (
  id serial PRIMARY KEY,
  customer_id integer,
  order_status varchar(20),
  FOREIGN KEY (customer_id) REFERENCES customers (id) ON DELETE CASCADE
 );

create table order_items(
  id serial PRIMARY KEY UNIQUE,
  order_id INT ,
  product_id INT,
  FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
  FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

INSERT INTO orders (customer_id, order_status)
  VALUES (1, 'In Progress'),
         (2, 'Placed'),
         (2, 'Complete'),
         (3, 'Placed');

INSERT INTO order_items (order_id, product_id)
  VALUES (1, 3),
         (1, 5),
         (1, 6),
         (1, 8),
         (2, 2),
         (2, 5),
         (2, 7),
         (3, 4),
         (3, 2),
         (3, 5),
         (3, 5),
         (3, 6),
         (3, 10),
         (3, 9),
         (4, 1),
         (4, 5);

-- join exercises
select o.*, p.*
  from orders o
  join order_items oi on o.id = oi.order_id
  join products p on p.id = oi.product_id;

select  DISTINCT c.customer_name AS "Customers who like Fries"
  from orders
  join customers c on c.id = orders.customer_id
  join order_items on order_items.order_id = orders.id
  join products on products.id = order_items.product_id
  where products.product_name = 'Fries';

SELECT sum(products.product_cost)
  from orders
  join customers c on c.id = orders.customer_id
  join order_items on order_items.order_id = orders.id
  join products on products.id = order_items.product_id
  where c.customer_name = 'Natasha O''Shea';
