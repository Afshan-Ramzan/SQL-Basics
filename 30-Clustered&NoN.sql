--Clustered index only one in table.
--it tell how data stored in table
--faster as compered to non clustored

EXECUTE sp_Helpindex tbl_UKCustomers

Select * from tbl_UKCustomers


DROP INDEX tbl_person.PK_tbl_UKCustomers

CREATE CLUSTERED INDEX IX_TBL_UKCustomers_COMPOSITE 
ON tbl_UKCustomers (ID Desc,Name ASC)


--More than one non clustered index,data and index stored on sperate place
--need extra space on disk
CREATE NONCLUSTERED INDEX IX_TBL_UKCustomers_EMAIL
ON tbl_UKCustomers (Email Desc)