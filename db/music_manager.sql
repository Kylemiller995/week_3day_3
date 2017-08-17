DROP TABLE IF EXISTS artists;
DROP TABLE IF EXISTS albums;

CREATE TABLE artists(
  id SERIAL PRIMARY KEY,
  name VARCHAR (225)
);

CREATE TABLE albums(
  id SERIAL PRIMARY KEY,
  artist_id INT REFERENCES artists(id),
  title VARCHAR (225),
  genre VARCHAR (225)
);
