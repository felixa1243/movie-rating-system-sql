CREATE OR REPLACE FUNCTION update_movie_rating() RETURNS TRIGGER AS
$$
BEGIN
    UPDATE movies
    SET rating = (SELECT ROUND(AVG(rating), 1) FROM ratings WHERE movie_id = NEW.movie_id)
    WHERE movie_id = NEW.movie_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;