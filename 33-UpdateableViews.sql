ALTER View vwEmployee
as
select e.ID,Name, e.City
from tbl_Employee e
join tbl_Person
on tbl_Person.ID=e.PersonID

SELECT * FROM vwEmployee
--Update View
UPDATE vwEmployee
SET Name ='marky' where ID=2

--Not delete any thing because it based on multiple table.
--if vie depend on a single table it also delete the data
Delete vwEmployee where ID=2