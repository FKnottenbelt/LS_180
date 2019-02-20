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