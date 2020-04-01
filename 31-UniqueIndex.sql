EXECUTE sp_Helpindex tbl_PakCustomers

Drop Index tbl_PakCustomers.PK_tbl_PakCustomer
--Two way to create Unique index in table

create Unique NonClustered Index 
UIX_tbl_PakCustomersEmail 
ON tbl_PakCustomers (Email)



Alter Table tbl_PakCustomers
ADD CONSTRAINT UQ__PakCustomers_ID
UNIQUE CLUSTERED (ID)