
--without Parameter
CREATE PROCEDURE spGetPerson
AS
BEGIN 
SELECT Name,Email,Age,City from tbl_Person
END


ALTER  PROCEDURE spGetPerson
WITH ENCRYPTION
AS
BEGIN 
SELECT Name,Email,Age,City from tbl_Person
END

sp_helptext spGetPerson

--With parameter

CREATE PROCEDURE spGetEmployee
@City nvarchar(50)
AS
BEGIN 
SELECT p.Name,e.City from tbl_Employee e
Join tbl_Person p 
ON p.ID = e.PersonID
AND e.City = @City
END

spGetEmployee 'New York'
