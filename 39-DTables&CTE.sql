-- using View 

Create View vwEmployeeCount
as
Select et.ID,et.Type , Count(*) as TotalEmployee from tbl_Employee e
join tbl_EmployeeType et
on et.ID=e.EmployeeTypeID
group by et.ID, et.Type

Select Type ,TotalEmployee from vwEmployeeCount
where TotalEmployee >=2


--Using Temp Table
Select et.ID,et.Type , Count(*) as TotalEmployee
into #TempTable
from tbl_Employee e
join tbl_EmployeeType et
on et.ID=e.EmployeeTypeID
group by et.ID, et.Type


Select *from  #TempTable

Select  Type ,TotalEmployee from  #TempTable
where TotalEmployee >=2

Drop Table #TempTable
--Using Table Variable

Declare @TableEmployeeCount Table (TypeID int,Employeetype  nvarchar(50), TotalEmployee int)

INsert @TableEmployeeCount
Select et.ID,et.Type , Count(*) as TotalEmployee
from tbl_Employee e
join tbl_EmployeeType et
on et.ID=e.EmployeeTypeID
group by et.ID, et.Type


Select * from @TableEmployeeCount


--Using derived Table

Select Type, TotalEmployees
from
	(	Select et.ID,et.Type , Count(*) as TotalEmployees
		from tbl_Employee e
		join tbl_EmployeeType et
		on et.ID=e.EmployeeTypeID
		group by et.ID, et.Type
	)
as EmployeeCount
Where TotalEmployees >=2

--Using CTE

with EmployeeCount
as
	(	Select et.ID,et.Type , Count(*) as TotalEmployees
		from tbl_Employee e
		join tbl_EmployeeType et
		on et.ID=e.EmployeeTypeID
		group by et.ID, et.Type
	)
select Type,TotalEmployees 
from EmployeeCount
Where TotalEmployees >=2




