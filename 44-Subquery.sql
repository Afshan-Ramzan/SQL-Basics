



--Using Subquery

Select ID,[Name],Age,City
from tbl_Person
where ID NOT IN(select PersonID from tbl_Employee)


Select * from tbl_Person
select * from tbl_Employee

--Using Join

Select p.ID,p.[Name],p.Age,p.City
from tbl_Person p
Join tbl_Employee e
on e.PersonID=p.ID
where e.PersonID is NULL


--Correlated Sub Query

Select Name , (Select Salary from tbl_Employee where PersonID=tbl_Person.ID) as Salary
from tbl_Person