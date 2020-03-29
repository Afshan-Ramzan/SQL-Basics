-- Sp using Return
Create proc spGetTotalCountEmployee2
as 
begin
Return (select  COUNT(ID) from tbl_Employee)
end

Declare @Total int 
Exec @Total=  spGetTotalCountEmployee2
PRINT @TOTAL

-- Sp using output parameter

create proc spGetNamebyID
@Id int,
@Name nvarchar(50) output
as
begin
 select @Name=Name from tbl_Person
 where ID= @Id
end

Declare @Name nvarchar(50)
EXEC spGetNamebyID 1,@Name output
print @Name


-- Sp using Return
Create proc  spgetNamebyID1
@Id int
as Begin
 return (select Name from tbl_Person
 where ID= @Id)
end

-- call sp using return value but there is error due to conversion of datatype from int to char
Declare @Name nvarchar(50)
EXEC @Name = spGetNamebyID1 1
print @Name

