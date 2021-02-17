-- q1
-- add the reviewer roger ebert to your database, with an rid of 209. 
insert into reviewer values (209, 'roger ebert');

-- q2
-- insert 5-star ratings by james cameron for all movies in the database. 
-- leave the review date as null. 
insert into rating 
select rid, mid, 5, null
from reviewer, movie
where name = 'james cameron';

-- q3
-- for all movies that have an average rating of 4 stars or higher, add 25 to the release year. 
-- (update the existing tuples; don't insert new tuples.) 
update movie
set year = year + 25
where movie.mid in(select mid 
	from rating 
        group by mid
        having avg(stars) >= 4);
	
-- q4
-- remove all ratings where the movie's year is before 1970 or after 2000, and the rating is fewer than 4 stars. 
delete from rating
where mid in (select mid
		from movie 
		where year < 1970 or year > 2000)
and stars < 4;