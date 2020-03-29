
--Eliminate Duplicated row
select * from tbl_PakCustomers
UNION 
select * from tbl_UKCustomers

--show all Duplicated row
select * from tbl_PakCustomers
UNION ALL
select * from tbl_UKCustomers