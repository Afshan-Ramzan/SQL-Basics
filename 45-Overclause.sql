
--We can not use not aggregated column in select
Select GenderID , COUNT(*) AS TotalGender , AVG(Age)
as Average_age from tbl_Person
group by GenderID

--Here is how we use Subquery method to display non aggregated column 

Select [Name], Genders.GenderID, Genders.Average_age, Genders.TotalGender from  tbl_Person
INNER JOIN
(Select GenderID , COUNT(*) AS TotalGender , AVG(Age)
as Average_age from tbl_Person
group by GenderID) AS Genders
ON Genders.GenderID = tbl_Person.GenderID

--Using Over caluse

Select [Name],GenderID,
COUNT(GenderID) Over (PARTITION by GenderID) as GenderTotal,
AVG(Age) Over (PARTITION by Age) as Average
from tbl_Person