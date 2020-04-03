
--Use of Row NUMBER, dense Rank and Rak
Select *, ROW_NUMBER() OVER (PARTITION BY ID Order by ID) as rownum
, RANK() OVER (Order BY Salary Desc) AS [RANK],
DENSE_RANK() OVER (ORDER BY Salary desc) as [DenseRank]
from Customers
