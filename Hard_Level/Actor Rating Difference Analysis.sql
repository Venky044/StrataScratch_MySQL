                  -- Actor Rating Difference Analysis

-- You are given a dataset of actors and the films they have been involved in, including each film's release date and rating. 
-- For each actor, calculate the difference between the rating of their most recent film and their average rating 
-- across all previous films (the average rating excludes the most recent one).

-- Return a list of actors along with their average lifetime rating, the rating of their most recent film, 
-- and the difference between the two ratings. Round the difference calculation to 2 decimal places. 
-- If an actor has only one film, return 0 for the difference and their only film’s rating for both the average 
-- and latest rating fields.

-- Table:
--       actor_rating_shift
-- actor_name: text
-- film_title: text
-- release_date: date
-- film_rating: double

-- O/P
-- actor_name	    avg_rating	latest_rating	rating_difference
-- Alex Taylor	      7.52	      8.5	            0.98
-- Angelina Jolie	  6	          6	                0
-- Brad Pitt	        6	          6	                0
-- Chris Evans	      5.75	      7.7            	1.95
-- Emma Stone	      7.62	      6.2	            -1.42

-- Solution:
with recent_movie_rank As (
    select 
        actor_name,
        film_rating,
        ROW_NUMBER() over(partition by actor_name order by release_date desc) as rn
    from actor_rating_shift
),
total_avg As (
    select actor_name, avg(film_rating) as avg_rating
    from recent_movie_rank
    where rn > 1
    group by actor_name
),
latest_rating As(
    select actor_name, film_rating as "latest_rating"
    from recent_movie_rank
    where rn = 1
    group by actor_name
)
select 
    t1.actor_name, ifnull(t3.avg_rating, avg(t1.film_rating)) as avg_rating,
    t2.latest_rating, (t2.latest_rating-ifnull(t3.avg_rating, avg(t1.film_rating))) as rating_difference
from recent_movie_rank t1
inner join latest_rating t2 on t1.actor_name = t2.actor_name
left join total_avg t3 on t1.actor_name = t3.actor_name
group by t1.actor_name;
