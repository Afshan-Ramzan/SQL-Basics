ALTER FUNCTION fn_EmployeeByGender(@Gender INT)
Returns TABLE
AS

RETURN ( 
       

	   select P.Name , P.City , P.GenderID from tbl_Person P
	   where GenderID=@Gender
	   )

	   
select * from  fn_EmployeeByGender(2)
