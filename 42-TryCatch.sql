Alter Procedure sp_PersonGet
@ID int,
@check nvarchar(50) out
as
Begin

	if(@ID is NUll)
	Begin
		Raiserror('Id can not be null',16,1)
	End
	Else
	Begin
		
		select @check = Name from 
		tbl_Person where ID=@ID
		if(@check is NULL)
		Begin
		Raiserror('Id not Found',16,1)
		End
	End

END

Declare @name nvarchar(50)
Execute sp_PersonGet null,@name out
Print @name

Declare @max int
Select max(ID) from tbl_Gender
Print @max


Begin try

	Insert into tbl_Person Values(2,'faisal','f@fsl.com',1,32,'hyderabad')
End try

Begin Catch
	select
	Error_Number() as en
	,ERROR_MESSAGE() as em,
	ERROR_LINE () as el
end catch
