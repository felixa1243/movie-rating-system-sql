UPDATE ratings set rating = 5.5 WHERE movie_id = 2 and user_id = 1;

INSERT INTO ratings (movie_id, user_id, rating)
values (2, 1, 4.5),
       (2, 2, 3.5);
select * from ratings;

UPDATE movies SET rating = 1.0 where movie_id = 2;

select *
from movies
where movie_id = 2
order by movie_id
limit 10;