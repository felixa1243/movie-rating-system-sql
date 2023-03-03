WITH movie_data AS (SELECT 'Movie ' || generate_series(1, 500)                              title,
                           '2023-02-16'::date - (floor(random() * 50) || ' days')::interval  release_date
                    FROM generate_series(1, 500))
INSERT
INTO movies (title, release_date)
SELECT title, release_date
FROM movie_data;

SELECT to_char(count(movie_id),'9,999,999') movies_count from movies;
--expected 250.000