--INTELLIGENT JOINS
-- Left join with only NULL value
Select Name, Gender from tbl_Person 
LEFT OUTER JOIN tbl_Gender
on tbl_Gender.ID = tbl_Person.GenderID
where tbl_Gender.ID is NULL 

--Right join for getting NULL value of right table

Select Name, Gender from tbl_Person 
RIGHT OUTER JOIN tbl_Gender
on tbl_Gender.ID = tbl_Person.GenderID
where tbl_Person.GenderID is NULL 

--full join for getting NULL value of both table

Select Name, Gender from tbl_Person 
FULL JOIN tbl_Gender
on tbl_Gender.ID = tbl_Person.GenderID
where tbl_Person.GenderID is NULL 
or  tbl_Gender.ID is NULL 