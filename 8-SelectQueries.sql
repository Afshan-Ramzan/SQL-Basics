<!-- All Distinct Values from Table -->
Select DISTINCT EmployeeID from tbl_Person

<!-- All  Values having Gender id 1 from Table -->
select * From tbl_Person Where GenderId = 1

<!-- All Values Not having Genderid 1 from Table -->
select * From tbl_Person Where GenderId <> 1

<!-- All Values Age greater than 30 from Table -->
select * From tbl_Person Where Age > 30

<!-- All Values  having Age 20 25from Table -->
select * from tbl_Person where Age IN(20,25)

<!-- All Values  Between the specfied age from Table --> 
select * from tbl_Person where Age BETWEEN 20 AND 30

<!-- All Values City start from New Word from Table -->
select * from tbl_Person where City LIKE 'New%'

<!-- All  Values from Table  where Email not having @ symbol-->
select * from tbl_Person where Email NOT LIKE '%@%'

<!-- All  Values from Table having specfic email format-->
select * from tbl_Person where Email LIKE '_@_.com'


<!-- All Values from Table when city is London or New York and Age is 40  -->
select * from tbl_Person where (City = 'London' or City = 'New York') AND Age = 40

<!-- Arrange in desending order --->
select * from tbl_Person Order by Name DESC

<!-- Top Row -->
select Top 2 Name,Age from tbl_Person


<!-- Top 50 % Row -->
select top 50 Percent Name,Age from tbl_Person