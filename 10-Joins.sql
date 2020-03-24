
--select cloumnname from lefttable jointype Righttable on join condition -->

--Intersection of both table 

Select  Name, Gender from tbl_Person
INNER JOIN tbl_Gender
ON tbl_Gender.ID = tbl_Person.GenderID
 
 --LeftTable - Right table, all record of left table

Select  Name, Gender from tbl_Person
LEFT OUTER JOIN tbl_Gender
ON tbl_Gender.ID = tbl_Person.GenderID

 --RightTable - Left table, all record of right table

Select  Name, Gender from tbl_Person
RIGHT OUTER JOIN tbl_Gender
ON tbl_Gender.ID = tbl_Person.GenderID

-- Full outer Join , All data of both table addition

Select  Name, Gender from tbl_Person
FULL OUTER JOIN tbl_Gender
ON tbl_Gender.ID = tbl_Person.GenderID

-- Cross join Multiplication of both table rows

Select  Name, Gender from tbl_Person
CROSS JOIN tbl_Gender