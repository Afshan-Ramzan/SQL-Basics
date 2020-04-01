-- To create Index view you must have these properties
-- 1 use with schemabinding
-- 2 use count_big
-- 3 use aggregate function with isnull

ALTER VIEW vwEmployeeType
with schemabinding
as
Select ET.Type,
sum(ISNULL(E.Salary,0)) as SalarySum,
COUNT_BIG(*) as Total
From dbo.tbl_EmployeeType ET
JOIN dbo.tbl_Employee E
on E.EmployeeTypeID= ET.ID
Group by ET.Type

Select * from vwEmployeeType


EXECUTE sp_helpindex  tbl_EmployeeType

EXECUTE sp_helpindex  vwEmployeeType

create UNIQUE clustered index UIX_vwEmployeeType
ON vwEmployeeType(Type)