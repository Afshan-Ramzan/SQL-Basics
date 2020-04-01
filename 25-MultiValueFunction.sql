

ALTER FUNCTION fn_MSTVF_GetEmployee(@Gender nvarchar(50))
RETURNS @table TABLE (id int, Name nvarchar(50), Age INT , Gender nvarchar(50))
as 
Begin
	declare @ID int
	select @ID= g.ID from tbl_Gender g where g.Gender = @Gender
	INSERT INTO @table
	Select P.ID, Name, Age ,j.Gender FROM tbl_Person P, tbl_Gender j
	where P.GenderID=@ID AND  j.Gender = @Gender
	Return
END

Update dbo.fn_EmployeeByGender(2) SET Name='marrium' where ID=1
Select * from  dbo.fn_EmployeeByGender(2)

SELECT * FROM fn_MSTVF_GetEmployee('Female')

