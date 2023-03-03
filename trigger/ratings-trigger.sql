CREATE TRIGGER update_movie_rating_trigger
    AFTER INSERT OR UPDATE OR DELETE
    ON ratings
    FOR EACH ROW
EXECUTE FUNCTION update_movie_rating();