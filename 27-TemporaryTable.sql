--creating local Temporary table

Create Table #tbl_temp(Id int, Name nvarchar(50))


Insert into #tbl_temp Values(1,'miki')
Insert into #tbl_temp Values(2,'jani')
Insert into #tbl_temp Values(1,'hali')


select * from #tbl_temp

select name from tempdb..sysobjects
where name like '#tbl_temp%'

drop TABLE #tbl_temp
