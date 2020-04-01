
with EmployeeCount
as
	(	Select e.EmployeeTypeID , Count(*) as TotalEmployees
		from tbl_Employee e 
		group by e.EmployeeTypeID
	)

--select 'Hello'
select et.Type,TotalEmployees 
from EmployeeCount ec
join tbl_EmployeeType et
on et.ID=ec.EmployeeTypeID
order by TotalEmployees

-- We can make Multiple CTE
