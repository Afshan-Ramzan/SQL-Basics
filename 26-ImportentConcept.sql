-- Deterministic function
--ALways have same result with specfic set of input

select ABs(-30.98)
select SQUARE(3)


-- NON-Deterministic function
--ALways have different result with specfic set of input

select GETDATE()
select CURRENT_TIMESTAMP

--Rand Function as NON-Deterministic function and Deterministic function
--if we give SAME SEED ALWAYS in rand it behave like Deterministic function
select RAND(1)
--if we not provide the seed value it behave like NON -Deterministic function
select RAND()

ALTER FUNCTION fn_EmpolyeeNamebyID(@id int)
ReturnS nvarchar(50)
WITH SCHEMABINDING
as
Begin
 RETURN (select Name  from dbo.tbl_Person where ID= @id)
END

select dbo.fn_EmpolyeeNamebyID(5)

sp_helptext fn_EmpolyeeNamebyID