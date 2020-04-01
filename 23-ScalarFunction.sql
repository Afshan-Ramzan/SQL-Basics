Create FUNCTION CalacluateAge (@Dob Date)
Returns int
as
begin
DECLARE @Age int
SET @Age = DATEDIFF(YEAR,@Dob,GetDATE()) -
		CASE
			WHEN (MONTH(@Dob) > Month(GETDATE())) OR
			(MONTH (@Dob) = MONTH(GETDATE()) AND DAY(@Dob) > Day(GETDATE()))
			THEN 1 ELSE 0
			END
			Return @Age
END


SELECT Sample2.dbo.CalacluateAge('10/08/2000') as Age

Select * from tbl_Employee

Select ID , DOB , dbo.CalacluateAge(DOB) as Age from tbl_Employee
where dbo.CalacluateAge(DOB) > 30
