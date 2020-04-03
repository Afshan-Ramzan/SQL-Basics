

Select p.Name ,Salary ,
RANK() OVER (Order BY Salary Desc) AS [RANK],
DENSE_RANK() OVER (ORDER BY Salary desc) as [DenseRank]
from tbl_Employee 
join tbl_Person p
on p.ID=tbl_Employee.PersonID

--Rank CTE
With RankCTE
as
(
Select p.Name, g.Gender,Salary ,
RANK() OVER (PARTITION BY g.Gender Order BY Salary Desc) AS [RANK]
from tbl_Employee 
join tbl_Person p
on p.ID=tbl_Employee.PersonID
join tbl_Gender g
on g.ID=p.GenderID
)
Select * from RankCTE where Gender='Female' AND RANK = 2

--Dense Rank CTE
With RankCTE
as
(
Select p.Name, g.Gender,Salary ,
DENSE_RANK() OVER (PARTITION BY g.Gender Order BY Salary Desc) AS [RANK]
from tbl_Employee 
join tbl_Person p
on p.ID=tbl_Employee.PersonID
join tbl_Gender g
on g.ID=p.GenderID
)
Select * from RankCTE where Gender='Female' AND RANK = 2