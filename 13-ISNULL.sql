--Use of ISNULL Function

Select E.Name as Employee, ISNULL(M.Name,'No Manager') as Manager
from tbl_Manager E
LEFT OUTER JOIN tbl_Manager M
ON E.ManagerID = M.ID

Select E.Name as Employee, (M.Name,'No Manager') as Manager
from tbl_Manager E
LEFT OUTER JOIN tbl_Manager M
ON E.ManagerID = M.ID

Select E.Name as Employee,
CASE  WHEN M.Name IS NULL THEN 'NO Manager' ELSE M.Name
END
from tbl_Manager E
LEFT OUTER JOIN tbl_Manager M
ON E.ManagerID = M.ID

