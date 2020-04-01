Select  * from vwEmployeeAdd

Create TRIGGER tr_vwEmployeeAddInsteadofDelete
on vwEmployeeAdd
Instead of Delete
AS
Begin
	Delete tbl_Employee
	from tbl_Employee
	join deleted
	on deleted.ID= tbl_Employee.ID
End


Delete vwEmployeeAdd where ID=2