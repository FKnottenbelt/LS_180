/*
03 Increase Star Name Length

Hmm... it turns out that 25 characters isn't enough room to store
a star's complete name. For instance, the star "Epsilon Trianguli
Australis A" requires 30 characters. Modify the column so that
it allows star names as long as 50 characters.
*/

ALTER TABLE stars ALTER COLUMN name TYPE varchar(50);


/*
Further Exploration

ALTER TABLE stars
ALTER COLUMN name TYPE varchar(25);

INSERT INTO stars (name, distance, spectral_type, companions)
           VALUES ('Alpha Centauri B', 4, 'K', 3);

ALTER TABLE stars
ALTER COLUMN name TYPE varchar(50);
*/

-- nothing, runs just fine. (as long as you make it bigger)