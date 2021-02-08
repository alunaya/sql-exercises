-- Q1
-- 0 points (ungraded)
-- Find the names of all reviewers who rated Gone with the Wind.
select distinct name from Rating
inner join Movie on Movie.mID = Rating.mID
inner join Reviewer on Reviewer.rID = Rating.rID
where title = "Gone with the Wind";

-- Q2
-- 0 points (ungraded)
-- For any rating where the reviewer is the same as the director of the movie, return the reviewer name, movie title, and number of stars.
select distinct name, title, stars from Rating
inner join Movie on Movie.mID = Rating.mID
inner join Reviewer on Reviewer.rID = Rating.rID
where director = name;

-- Q3
-- 0 points (ungraded)
-- Return all reviewer names and movie names together in a single list, alphabetized. (Sorting by the first name of the reviewer and first word in the title is fine; no need for special processing on last names or removing "The".)
select title from Movie
union
select name from Reviewer
order by Reviewer.name, Movie.title ASC;

-- Q4
-- 0 points (ungraded)
-- Find the titles of all movies not reviewed by Chris Jackson.
select title from Movie
where mID not in (
	select mID from Rating
	inner join Reviewer on Reviewer.rID = Rating.rID
	where name == "Chris Jackson";
)

-- Q5
-- 0 points (ungraded)
-- For all pairs of reviewers such that both reviewers gave a rating to the same movie, return the names of both reviewers. Eliminate duplicates, don't pair reviewers with themselves, and include each pair only once. For each pair, return the names in the pair in alphabetical order.
select distinct re1.name, re2.name
from Rating ra1, Rating ra2
inner join Reviewer re1 on ra1.rID = re1.rID
inner join Reviewer re2 on ra2.rID = re2.rID
where ra1.mID = ra2.mID
and re1.name < re2.name
order by re1.name, re2.name asc;

-- Q6
-- 0 points (ungraded)
-- For each rating that is the lowest (fewest stars) currently in the database, return the reviewer name, movie title, and number of stars.
select distinct name, title, stars
from Rating
inner join Movie on Rating.mID = Movie.mID
inner join Reviewer on Rating.rID = Reviewer.rID
where stars = (
	select min(stars) from Rating;
)

-- Q7
-- 0 points (ungraded)
-- List movie titles and average ratings, from highest-rated to lowest-rated. If two or more movies have the same average rating, list them in alphabetical order.
select title, AVG(stars) as average_rating from movie
inner join rating on movie.mID = rating.mID
group by title
order by average_rating desc, title asc;

-- Q8
-- 0 points (ungraded)
-- Find the names of all reviewers who have contributed three or more ratings. (As an extra challenge, try writing the query without HAVING or without COUNT.)
select name from Reviewer
inner join Rating on Reviewer.rID = Rating.rID
group by Reviewer.rID
having (Count(Reviewer.rID))>=3;

-- Q9
-- 0 points (ungraded)
-- Some directors directed more than one movie. For all such directors, return the titles of all movies directed by them, along with the director name. Sort by director name, then movie title. (As an extra challenge, try writing the query both with and without COUNT.)
select title, director from movie
where director in (
select director from movie
group by director
having (Count(mID)) > 1
);

-- Q10
-- 0 points (ungraded)
-- Find the movie(s) with the highest average rating. Return the movie title(s) and average rating. (Hint: This query is more difficult to write in SQLite than other systems; you might think of it as finding the highest average rating and then choosing the movie(s) with that average rating.)
select title, avg(stars) from movie
inner join rating on rating.mID = movie.mID
group by rating.mID
having (avg(stars) in (
	select max(averge_rating) from (
		select avg(stars) as averge_rating
		from rating						
		group by mID)
));

-- Q11
-- 0 points (ungraded)
-- Find the movie(s) with the lowest average rating. Return the movie title(s) and average rating. (Hint: This query may be more difficult to write in SQLite than other systems; you might think of it as finding the lowest average rating and then choosing the movie(s) with that average rating.)
select title, avg(stars) from movie
inner join rating on rating.mID = movie.mID
group by rating.mID
having (avg(stars) in (
	select min(averge_rating) from (
		select avg(stars) as averge_rating
		from rating						
		group by mID)
));

-- Q12
-- 0 points (ungraded)
-- For each director, return the director's name together with the title(s) of the movie(s) they directed that received the highest rating among all of their movies, and the value of that rating. Ignore movies whose director is NULL.
select director, title, max(stars)
from movie
inner join rating on movie.mID = rating.mID
where director is not null
group by director;
