WITH movie_genre_data AS (
    SELECT DISTINCT
        (1 + floor(random() * 5)) AS genre_id,
        (1 + floor(random() * 500)) AS movie_id
    FROM generate_series(1, 1000)
)
INSERT INTO movies_genre (genre_id, movie_id)
SELECT genre_id, movie_id
FROM movie_genre_data;

SELECT count(*)
from movies_genre;
--show all movie genres
SELECT movies.title, array_agg(genres.genre_name) AS genres
FROM movies
         JOIN movies_genre ON movies.movie_id = movies_genre.movie_id
         JOIN genres ON genres.genre_id = movies_genre.genre_id
GROUP BY movies.movie_id
LIMIT 10 OFFSET 0;