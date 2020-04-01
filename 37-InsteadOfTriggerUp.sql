Update vwEmployeeAdd set DOB='2003/1/4' where ID=7

Select  * from vwEmployeeAdd

Create TRIGGER tr_vwEmployeeAdd
on vwEmployeeAdd
Instead of Update
AS
Begin
	-- if id is updated
	If(Update(ID))
	Begin
		RaisError('Id cannot be changed',16,1)
	END


	-- if employee type is updated

	if(update(Type))
	Begin
		declare @EtypeId int
		Select @EtypeId=et.ID from tbl_EmployeeType et
		Join inserted
		on inserted.Type= et.Type
	
	 if (@EtypeId is NULL)
	 Begin
		Raiserror('Invalid Employee Type, Statement Terminated ' ,16,1)
			return
		end
	Update tbl_Employee set EmployeeTypeID=@EtypeId
	from inserted
	join tbl_Employee
	on tbl_Employee.ID=inserted.ID
	END

	-- if employee Name is updated

	if(update(Name))
	Begin
		declare @pID nvarchar(50)
		Select @pID=p.ID from tbl_Person p
		Join inserted
		on inserted.Name = p.Name
	
	 if (@pID is NULL)
	 Begin
		Raiserror('Invalid Employee Name, Statement Terminated ' ,16,1)
			return
		end
	Update tbl_Employee set PersonID=@pId
	from inserted
	join tbl_Employee
	on tbl_Employee.ID=inserted.ID
	END

	--If salary is updated

	if(Update(Salary))
	Begin
	Update tbl_Employee set Salary=inserted.Salary
	from inserted
	join tbl_Employee
	on tbl_Employee.ID=inserted.ID
	END

	--If City is updated

	if(Update(City))
	Begin
	Update tbl_Employee set City=inserted.City
	from inserted
	join tbl_Employee
	on tbl_Employee.ID=inserted.ID
	END

	--If DOB is updated

	if(Update(DOB))
	Begin
	Update tbl_Employee set DOB=inserted.DOB
	from inserted
	join tbl_Employee
	on tbl_Employee.ID=inserted.ID
	END

END


