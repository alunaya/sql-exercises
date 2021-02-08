-- Q1
-- 0/1 points (graded)
-- Find the titles of all movies directed by Steven Spielberg.
select title from Movie where director = "Steven Spielberg";

-- Q2
-- 0/1 points (graded)
-- Find all years that have a movie that received a rating of 4 or 5, and sort them in increasing order.
select distinct year from Movie
inner join Rating on Movie.mID = Rating.mID
where stars in (4,5)
order by year asc;

-- Q3
-- 0/1 points (graded)
-- Find the titles of all movies that have no ratings.
select distinct title from Movie
left outer join Rating on Movie.mID = Rating.mID
where Rating.mID is null;

-- Q4
-- 0/1 points (graded)
-- Some reviewers didn't provide a date with their rating. Find the names of all reviewers who have ratings with a NULL value for the date.
select name from Reviewer
inner join Rating on Reviewer.rID = Rating.rID
where ratingDate is null;

-- Q5
-- 0/1 points (graded)
-- Write a query to return the ratings data in a more readable format: reviewer name, movie title, stars, and ratingDate. Also, sort the data, first by reviewer name, then by movie title, and lastly by number of stars.
select name, title, stars, ratingDate from Rating
inner join Reviewer on Rating.rID = Reviewer.rID
inner join Movie on Rating.mID = Movie.mID
order by name, title, stars asc;

-- Q6
-- 0/1 points (graded)
-- For all cases where the same reviewer rated the same movie twice and gave it a higher rating the second time, return the reviewer's name and the title of the movie.
SELECT name, title
FROM Rating r1
inner join Rating r2 on r1.rID = r2.rID AND r1.mID = r2.mID
inner join Reviewer on r1.rID = Reviewer.rID
inner join Movie on r1.mID = Movie.mID
where r1.ratingDate < r2.ratingDate AND r1.stars < r2.stars;

-- Q7
-- 0/1 points (graded)
-- For each movie that has at least one rating, find the highest number of stars that movie received. Return the movie title and number of stars. Sort by movie title.
select title, max(stars)
from Movie
inner join Rating on Movie.mID = Rating.mID
group by title
order by title asc;

-- Q8
-- 0/1 points (graded)
-- For each movie, return the title and the 'rating spread', that is, the difference between highest and lowest ratings given to that movie. Sort by rating spread from highest to lowest, then by movie title.
select title, (max(stars) - min(stars)) as rating_spread
from Rating
inner join Movie on Rating.mID = Movie.mID
group by title
order by rating_spread desc, title asc;

-- Q9
-- 0/1 points (graded)
-- Find the difference between the average rating of movies released before 1980 and the average rating of movies released after 1980. (Make sure to calculate the average rating for each movie, then the average of those averages for movies before 1980 and movies after. Don't just calculate the overall average rating before and after 1980.)
select AVG(Before1980.avg) - AVG(After1980.avg)
from (
  select AVG(stars) as avg
  from Movie
  inner join Rating on Movie.mID = Rating.mID
  where year < 1980
  group by Rating.mID
) as Before1980, (
  select AVG(stars) AS avg
  from Movie
  inner join Rating on Movie.mID = Rating.mID
  where year > 1980
  group by Rating.mID
) as After1980;
