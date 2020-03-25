
Select E.Name as Employee, M.Name from tbl_Manager E
LEFT OUTER JOIN tbl_Manager M
ON E.ManagerID = M.ID


Select E.Name as Employee, M.Name from tbl_Manager E
INNER JOIN tbl_Manager M
ON E.ManagerID = M.ID

Select E.Name as Employee, M.Name from tbl_Manager E
Right OUTER JOIN tbl_Manager M
ON E.ManagerID = M.ID

Select E.Name as Employee, M.Name from tbl_Manager E
CROSS JOIN tbl_Manager M

