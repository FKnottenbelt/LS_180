\i films4.sql

INSERT INTO films (title, year, genre, director, duration)
  VALUES ('The Bourne Identity', 2002, 'espionage', 'Doug Liman', 118);
INSERT INTO films (title, year, genre, director, duration)
  VALUES ('Wayne''s World', 1992, 'comedy', 'Penelope Spheeris', 95);

SELECT DISTINCT genre FROM films;
SELECT genre FROM films GROUP BY genre;
SELECT ROUND(AVG(duration)) FROM films;

SELECT genre,
       ROUND(AVG(duration)) AS average_duration
  FROM films
  GROUP BY genre;

