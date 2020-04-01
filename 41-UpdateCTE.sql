--it is possible to update CTE IF it is based on one tablr
--Example of one base table
with EmployeeDetails
as
	(select * from tbl_Employee
	)
update EmployeeDetails set EmployeeTypeID= 1 
where ID=3

--If CTE based on two based table but update is alllowed to 
--one base table at a time
with EmployeeDetails
as
(
	Select E.ID,P.Name,E.EmployeeTypeID,E.Salary
	from tbl_Employee E
	JOIN tbl_Person P
	on P.ID=E.PersonID
	)
Update EmployeeDetails set Name = 'Maria' 
where ID=5
-- Error on below query
-- Update EmployeeDetails set Name = 'faraha' , EmployeeTypeID=1 where ID=6

