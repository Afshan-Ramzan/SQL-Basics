select * From tbl_Employee

select min(Salary) from tbl_Employee 

select City,  Sum(Salary) as totalsalary from tbl_Employee
where City = 'London'
group by City

select City,  Sum(Salary) as totalsalary from tbl_Employee
group by City
having City = 'London'

select EmployeeTypeID, SUM(Salary) as tSalary from tbl_Employee group by EmployeeTypeID

select City, SUM(Salary) as tSalary from tbl_Employee group by City having sum(Salary) >50000