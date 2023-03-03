drop table if exists movies,users,movie_ratings,genres cascade;
CREATE TABLE genres
(
    genre_id   SERIAL PRIMARY KEY,
    genre_name varchar(100)
);
CREATE TABLE movies
(
    movie_id     SERIAL PRIMARY KEY,
    title        varchar(100) NOT NULL,
    descriptions varchar(250),
    release_date DATE,
    genre_id     INT,
    FOREIGN KEY (genre_id) REFERENCES genres (genre_id)
);
CREATE TABLE users
(
    user_id  SERIAL PRIMARY KEY,
    email    varchar(100) NOT NULL,
    password varchar(100) NOT NULL
);
CREATE TABLE movie_ratings
(
    rating_id SERIAL PRIMARY KEY,
    movie_id  int,
    user_id   int,
    rating    int CHECK ( rating <= 5 and rating > 0),
    FOREIGN KEY (movie_id) REFERENCES movies (movie_id),
    FOREIGN KEY (user_id) REFERENCES users (user_id)
);
INSERT INTO genres(genre_name)
VALUES ('Action'),
       ('Slice of life'),
       ('Echi'),
       ('Yuri');
INSERT INTO movies(title, descriptions, release_date, genre_id)
VALUES ('Yuru yuri', 'Akari and friends', '2009-05-03', 4),
       ('Yuru camp', 'Nadeshiko and friends', '2016-04-04', 2);
SELECT title
FROM movies;
INSERT INTO users (email, password)
VALUES ('john@example.com', 'password123'),
       ('jane@example.com', 'password456'),
       ('bob@example.com', 'password789'),
       ('alice@example.com', 'passwordabc'),
       ('dave@example.com', 'passworddef'),
       ('susan@example.com', 'passwordghi'),
       ('mike@example.com', 'passwordjkl'),
       ('judy@example.com', 'passwordmno'),
       ('tim@example.com', 'passwordpqr'),
       ('amy@example.com', 'passwordstu');
INSERT INTO movie_ratings (movie_id, user_id, rating)
VALUES (1, 1, 4),
       (1, 2, 3),
       (1, 3, 5),
       (1, 4, 2),
       (1, 5, 4),
       (1, 6, 1),
       (1, 7, 5),
       (1, 8, 3),
       (1, 9, 4),
       (1, 10, 2),
       (2, 1, 3),
       (2, 2, 4),
       (2, 3, 2),
       (2, 4, 5),
       (2, 5, 3),
       (2, 6, 4),
       (2, 7, 2),
       (2, 8, 3),
       (2, 9, 5),
       (2, 10, 4);
SELECT rating
from movie_ratings
limit 5 OFFSET ((1 - 1) * 5 + 1);

INSERT INTO users (email, password)
SELECT 'user_' || generate_series(1, 1000) || '@example.com',
       substr(md5(random()::text), 1, 10)
FROM generate_series(1, 1000);
SELECT password
from users
LIMIT 10 offset 0;
-- SELECT CEIL(COUNT(*) / 20) as total_pages FROM users;


-- Insert 5 genres
INSERT INTO genres (genre_name)
VALUES ('Action'),
       ('Comedy'),
       ('Drama'),
       ('Horror'),
       ('Sci-Fi');

-- Insert 5000 movies
WITH movie_data AS (SELECT 'Movie ' || generate_series(1, 500)                              AS title,
                           'Description for movie ' || generate_series(1, 50)               AS descriptions,
                           '2023-02-16'::date - (floor(random() * 50) || ' days')::interval AS release_date,
                           (random() * 4 + 1)::int                                          AS genre_id
                    FROM generate_series(1, 500))
INSERT
INTO movies (title, descriptions, release_date, genre_id)
SELECT title, descriptions, release_date, genre_id
FROM movie_data;
select count(movie_id)
from movies;
select movie_id
from movies;
INSERT INTO movie_ratings (movie_id, user_id, rating)
SELECT (random() * 500 + 1)::int AS movie_id,
       (random() * 100 + 1)::int AS user_id,
       (random() * 4 + 1)::int   AS rating
FROM generate_series(1, 500) AS s;

select m.title, format(cast(mr.rating as varchar), '0.0#') avg_rating
from movie_ratings mr
         join movies m on m.movie_id = mr.movie_id
group by m.movie_id, m.title, mr.rating
order by m.title
limit 100 offset 0;
select m.title, format(cast(mr.rating as varchar), '0.0#') avg_rating, count(m.movie_id)
from movie_ratings mr
         join movies m on m.movie_id = mr.movie_id
         join users u on mr.user_id = u.user_id
group by m.movie_id, avg_rating
order by avg_rating desc
;
SELECT m.movie_id, m.title, rating
from movie_ratings mr
         join movies m on m.movie_id = mr.movie_id
where m.title = 'Movie 33';
-- SELECT movie_id,title from movies limit 20;
SELECT rating_id
from movie_ratings;

SELECT (SELECT to_char(count(email), '9,999,999')
        from users)  user_count,
       (SELECT to_char(count(movie_id), '9,999,999')
        from movies) movie_count,
       (SELECT to_char(count(rating_id), '9,999,999') from movie_ratings) movie_review
;