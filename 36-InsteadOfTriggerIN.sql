Create View vwEmployeeAdd
AS

Select E.ID,P.Name,ET.Type,E.Salary,E.City,E.DOB
from tbl_Employee E
Join tbl_EmployeeType ET
ON ET.ID=E.EmployeeTypeID
Join tbl_Person P
ON P.ID=E.PersonID
--QUESTION
--WHY NOT IS ASC ORDER
Insert into vwEmployeeAdd Values(9,'afaan','Temporary',34300,'abu dahbi',Cast('12/8/1990' as Date))


ALTER TRIGGER tr_vwEmployeeAdd_InsteadOfInsert
on vwEmployeeAdd
Instead of Insert
AS
BEGIN
	Declare @PId int, @TypeId int 
	
	Select @PId=p.ID from tbl_Person p
	join inserted
	on inserted.Name=p.Name


	Select @TypeId=et.ID from tbl_EmployeeType et
	join inserted
	on inserted.Type=et.Type

	if(@PId is NULL)
		begin 
			Raiserror('Invalid Person Name, Statement Terminated ' ,16,1)
			return
		end

	if(@TypeId is NULL)
		begin 
			Raiserror('Invalid Employee Type, Statement Terminated ' ,16,1)
			return
		end
	Insert into tbl_Employee (ID,PersonID,EmployeeTypeID,Salary,City,DOB)
	Select Id,@PId,@TypeId,Salary,City,DOB
	from inserted

End

SELECT * FROM vwEmployeeAdd