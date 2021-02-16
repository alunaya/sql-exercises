-- Q1
-- 0/1 points (graded)
-- Find the names of all students who are friends with someone named Gabriel.
select hg1.name from Highschooler hg1
inner join friend on hg1.ID = friend.ID1
inner join Highschooler hg2 on hg2.ID = friend.ID2
where hg2.name = "Gabriel";

-- Q2
-- 0/1 points (graded)
-- For every student who likes someone 2 or more grades younger than themselves, return that student's name and grade, and the name and grade of the student they like.
select hg1.name, hg1.grade, hg2.name, hg2.grade from Highschooler hg1
inner join likes on hg1.ID = likes.ID1
inner join Highschooler hg2 on hg2.ID = likes.ID2
where (hg1.grade - hg2.grade) >= 2;

-- Q3
-- 0/1 points (graded)
-- For every pair of students who both like each other, return the name and grade of both students. Include each pair only once, with the two names in alphabetical order.
select hg1.name, hg1.grade, hg2.name, hg2.grade
from highschooler hg1, highschooler hg2
inner join likes lk1 on hg1.ID = lk1.ID1
inner join likes lk2 on hg2.ID = lk2.ID1
where lk1.ID2 = lk2.ID1 AND lk1.ID1 = lk2.ID2 AND hg1.name < hg2.name;

-- Q4
-- 0/1 points (graded)
-- Find all students who do not appear in the Likes table (as a student who likes or is liked) and return their names and grades. Sort by grade, then by name within each grade.
Select name, grade
from highschooler
where ID not in (
	select ID1, ID2 from likes
	union
	select ID2 from likes
);

-- Q5
-- 0/1 points (graded)
-- For every situation where student A likes student B, but we have no information about whom B likes (that is, B does not appear as an ID1 in the Likes table), return A and B's names and grades.
select hg1.name, hg1.grade, hg2.name, hg2.grade
from highschooler hg1, highschooler hg2
inner join likes lk1 on hg1.ID = lk1.ID1
left outer join likes lk2 on hg2.ID = lk2.ID1
where lk2.ID1 is null AND lk1.ID2 = hg2.ID;

-- Q6
-- 0/1 points (graded)
-- Find names and grades of students who only have friends in the same grade. Return the result sorted by grade, then by name within each grade.
select name, grade from highschooler 
where ID not in
	(select hg1.ID
	from highschooler hg1
	left outer join friend on hg1.ID = friend.ID1
	inner join highschooler hg2 on hg2.ID = friend.ID2
	where friend.ID1 is not null and hg1.grade != hg2.grade)
order by grade, name

-- Q7 For each student A who likes a student B where the two are not friends, find if they have a friend C in common (who can introduce them!). For all such trios, return the name and grade of A, B, and C.

	
-- Q8 Find the difference between the number of students in the school and the number of different first names. 
select (select count(*) from Highschooler) - (select count(distinct name) from Highschooler);
 
-- Q9 Find the name and grade of all students who are liked by more than one other student. 
select H2.name, H2.grade
from Likes 
inner join Highschooler H1 on Likes.ID1 = H1.ID
inner join Highschooler H2 on Likes.ID2 = H2.ID
group by ID2
having count(*) > 1;


