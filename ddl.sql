CREATE TABLE movies
(
    movie_id     SERIAL PRIMARY KEY,
    title        varchar(100) NOT NULL,
    release_date date         NOT NULL,
    rating       numeric(3, 1) CHECK ( rating >= 1 AND rating <= 10 ) default 10
);

CREATE TABLE genres
(
    genre_id   SERIAL PRIMARY KEY,
    genre_name varchar(100)
);

CREATE TABLE movies_genre
(
    genre_id int REFERENCES genres (genre_id),
    movie_id int REFERENCES movies (movie_id),
    PRIMARY KEY (genre_id, movie_id)
);

CREATE TABLE users
(
    user_id  SERIAL PRIMARY KEY,
    email    varchar(100) NOT NULL,
    password text         NOT NULL
);

CREATE TABLE ratings
(
    rating_id SERIAL PRIMARY KEY,
    movie_id  int REFERENCES movies (movie_id),
    user_id   int REFERENCES users (user_id),
    rating    NUMERIC(3, 1) CHECK (rating >= 1 AND rating <= 10),
    unique (user_id,movie_id)
);