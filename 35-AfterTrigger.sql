-- For insert

Alter TRIGGER tr_tbl_Person_ForInsert
ON tbl_Person
FOR INSERT
AS
BEGIN
	DECLARE @id int
	Select @id = ID from inserted
	Insert Into tbl_PersonAudit Values
	('The Person Data having ID ' +
	 CAST(@id as nvarchar(4)) + ' is added at ' +
	 CAST(GETDATE() AS NVARCHAR(20)))

END

INSERT INTO tbl_Person VALUES (10,'faizan','faiz@aaa.com',1,39,'Karachi')

-- for Delete 
ALTER TRIGGER tr_tbl_Person_ForDelete
ON tbl_Person
FOR DELETE
AS
BEGIN
	DECLARE @id int
	Select @id = ID from deleted
	Insert Into tbl_PersonAuditD Values
	('The Person Data having ID ' +
	 CAST(@id as nvarchar(4)) + ' is DELETED at ' +
	 CAST(GETDATE() AS NVARCHAR(20)))

END

Delete from tbl_Person where ID=10

--For update

Create TRIGGER tr_tbl_Person_forUpdate
ON tbl_Person
FOR UPDATE
AS 
BEGIN
	DECLARE @Id int
	Declare @OldName nvarchar(50), @NewName nvarchar(50)
	Declare @OldAge int, @NewAge int

	Declare @AuditString nvarchar(100)

	Select * into #TempTable from inserted

	While(EXISTS(SELECT ID from #TempTable))
	Begin 
		set @AuditString = ' '
		select TOP 1 @Id= ID , @NewName=Name,
		@NewAge=Age from #TempTable

		select @OldName=Name,@OldAge=Age
		from deleted

		Set @AuditString = 'Employee With Id = ' + Cast(@Id as nvarchar(3))+' Changes '
		if(@OldName<> @NewName)
			Set @AuditString = @AuditString + ' NAME FROM '+@OldName+' to '+@NewName
		if(@OldAge<>@NewAge)
			Set @AuditString = @AuditString + ' Age From ' + CAST(@OldAge as nvarchar(5))+
			' to ' +CAST(@NewAge as nvarchar(5))
		Insert into tbl_PersonAudit Values(@AuditString)
		Delete from #TempTable Where ID=@Id
		END

END

Update  tbl_Person SET Name='Kasshish' ,Age = 27
where ID= 3