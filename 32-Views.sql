Select tbl_Person.ID,Name,Gender,Age from tbl_Person
JOIN tbl_Gender
on tbl_Person.GenderID=tbl_Gender.ID

CREATE VIEW vwPersonBYGender
as
Select tbl_Person.ID,Name,Gender,Age from tbl_Person
JOIN tbl_Gender
on tbl_Person.GenderID=tbl_Gender.ID

--treat like a table ,nothing more than select query

Select * from vwPersonBYGender


CREATE VIEW vwPersonFemale
as
Select tbl_Person.ID,Name,Gender,Age from tbl_Person
JOIN tbl_Gender
on tbl_Person.GenderID=tbl_Gender.ID
where tbl_Gender.Gender='Female'


Select * from vwPersonFemale


CREATE VIEW vwnonConfidentail
as
Select tbl_Person.ID,Name,Gender from tbl_Person
JOIN tbl_Gender
on tbl_Person.GenderID=tbl_Gender.ID


Select * from vwnonConfidentail

CREATE VIEW vwFemalePerson
as
Select Gender , Count(g.ID) as Total
FROM tbl_Person
JOIN tbl_Gender g
on tbl_Person.GenderID=g.ID
Group by Gender 

Select * from vwFemalePerson
sp_HelpText vwPersonBYGender