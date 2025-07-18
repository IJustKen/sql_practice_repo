-- Write your PostgreSQL query statement below

select tweets.tweet_id from tweets where char_length(tweets.content) > 15;

--select tweets.id from tweets where length(tweets.content) > 15; also works if all chars are 1 byte only
