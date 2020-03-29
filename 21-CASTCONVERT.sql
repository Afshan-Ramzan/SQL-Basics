SELECT p.Name,  e.DOB ,CAST( e.DOB as nvarchar ) as casts from tbl_Employee e
join tbl_Person p
on p.ID= e.PersonID

SELECT ID,DOB , CONVERT(nvarchar,DOB,103) as conver from tbl_Employee

select ID, Name , Name+' - '+ CAST(ID as nvarchar)
as NAMEID from tbl_Person