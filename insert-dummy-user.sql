INSERT INTO users (email, password)
SELECT 'user_' || generate_series(1, 1000) || '@example.com',
       substr(md5(random()::text), 1, 10)
FROM generate_series(1, 1000);


SELECT to_char(count(user_id),'9,999,999') user_count from users;
--expected 1,000,000