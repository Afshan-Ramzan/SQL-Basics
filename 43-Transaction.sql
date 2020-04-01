Begin try
	Begin Transaction
		
		UPDATE tbl_Manager Set Name='Afshan Ramzan'
		where ID=2
	Commit Transaction
End Try
Begin Catch
	RollBack Transaction
	Select ERROR_NUMBER() AS ErrorNumber,
			ERROR_MESSAGE() AS ERRORmessage,
			ERROR_LINE() AS ErrorLine
End Catch

--Integrity of database maintained


--If you use a transaction begin statement aand not use commit and rollback statement
--and another user want to access the same table data
--he will use below code to access Uncommited data in its connection.
Set TRANSACTION ISOLATION LEVEL READ UNCOMMITTED