Create Proc spGetEmployeeCountbyGenderID
@ID int,
@total int output
as 
begin
 select @total = COUNT(*) FRom tbl_Person p
 where p.GenderID=@ID
 end


 DECLARE @TOTAL int
 Exec spGetEmployeeCountbyGenderID 1,@TOTAL output
 PRINT @TOTAL

 
 DECLARE @TOTAL int
 Exec spGetEmployeeCountbyGenderID @ID=2 ,@total=@TOTAL output
 PRINT @TOTAL

 sp_help spGetGenderID

  sp_depends spGetGenderID