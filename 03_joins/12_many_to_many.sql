create database lesson0312;
\c lesson0312;
\i many_to_many.sql

SELECT b.id, b.author, string_agg(c.name, ', ') as categories
FROM books b
INNER JOIN books_categories bc ON b.id = bc.book_id
INNER JOIN categories c ON c.id = bc.category_id
GROUP BY b.id, b.author;

ALTER TABLE books ALTER COLUMN title TYPE text;

INSERT INTO books (title, author) VALUES ('Sally Ride: America''s First Woman in Space', 'Lynn Sherr');
INSERT INTO books_categories VALUES (4, 1);
INSERT INTO books_categories VALUES (4, 5);
INSERT INTO categories (name) VALUES ('Space Exploration');
INSERT INTO books_categories VALUES (4, 7);

INSERT INTO books (title, author) VALUES ('Jane Eyre', 'Charlotte Brontë');
INSERT INTO books_categories VALUES (5, 2);
INSERT INTO books_categories VALUES (5, 4);

INSERT INTO books (title, author) VALUES ('Vij''s: Elegant and Inspired Indian Cuisine', 'Meeru Dhalwala and Vikram Vij');
INSERT INTO categories (name) VALUES ('Cookbook');
INSERT INTO categories (name) VALUES ('South Asia');
INSERT INTO books_categories VALUES (6, 1);
INSERT INTO books_categories VALUES (6, 8);
INSERT INTO books_categories VALUES (6, 9);

ALTER TABLE books_categories ADD UNIQUE (book_id, category_id);

SELECT c.name, 
       COUNT(bc.book_id), 
       string_agg(b.title, ', ') as book_titles
FROM books b
  INNER JOIN books_categories bc ON bc.book_id = b.id
  INNER JOIN categories c ON bc.category_id = c.id
GROUP BY c.name
ORDER BY c.name;