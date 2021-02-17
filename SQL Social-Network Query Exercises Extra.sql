-- q1
-- for every situation where student a likes student b, 
-- but student b likes a different student c, return the names and grades of a, b, and c. 

select h1.name, h1.grade, h2.name, h2.grade, h3.name, h3.grade
from highschooler h1, highschooler h2, highschooler h3, likes l1, likes l2
where (h1.id = l1.id1 and h2.id = l1.id2) and (h2.id = l2.id1 and h3.id = l2.id2 and h3.id <> h1.id);

-- q2
-- find those students for whom all of their friends are in different grades from themselves. 
-- return the students' names and grades. 

select h1.name, h1.grade
from highschooler h1 
where h1.grade not in (
						select h2.grade
						from highschooler h2, friend f
						where h1.id = f.id1 and h2.id = f.id2);
            
-- q3
-- what is the average number of friends per student? (your result should be just one number.) 

select avg(count_per_student)
from (	select count(*) as count_per_student
		from friend 
		group by id1);

-- q4
-- find the number of students who are either friends with cassandra or are friends of friends of cassandra. 
-- do not count cassandra, even though technically she is a friend of a friend. 
select count(*)
from friend
where id1 in(select id2
			from friend 
where id1 in (select id 
			  from highschooler
			  where name = 'cassandra'));
	      
	      	      
-- q5
-- find the name and grade of the student(s) with the greatest number of friends. 
select name, grade
from highschooler inner join friend f
on highschooler.id = f.id1
group by f.id1
having count(*) = (
	select max(count_of_friends)
	from (select count(*) as count_of_friends
			from friend
			group by id1));