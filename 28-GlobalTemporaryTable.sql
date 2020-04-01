
--Gobal Temporary Table


Create Table ##tbl_temp(Id int, Name nvarchar(50))


Insert into ##tbl_temp Values(1,'miki')
Insert into ##tbl_temp Values(2,'jani')
Insert into ##tbl_temp Values(3,'hali')


select * from ##tbl_temp