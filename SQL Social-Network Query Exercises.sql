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



