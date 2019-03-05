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

SELECT year / 10 * 10 as decade,
 ROUND(AVG(duration)) as average_duration
  FROM films
  GROUP BY decade
  ORDER BY decade;

SELECT * FROM films WHERE director LIKE 'John %';

SELECT genre, count(id)
  FROM films
  GROUP BY genre
  ORDER BY count DESC;

SELECT year / 10 * 10 AS decade,
       genre,
       string_agg(title, ', ') AS films
  FROM films
  GROUP BY decade, genre
  ORDER BY decade, genre;

SELECT genre,
       sum(duration) AS total_duration
  FROM films
  GROUP BY genre
  ORDER BY total_duration ASC;
