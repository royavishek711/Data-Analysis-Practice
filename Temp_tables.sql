Create Table #temp_sal 
(EmployeeID int, 
JobTitle varchar(50), 
Salary int
)
select * from #temp_sal

Insert Into #temp_sal VALUES
(1001, 'Salesman', 45000),
(1002, 'Receptionist', 36000)

drop table if exists #temp_sal
Create Table #temp_sal 
(First_name varchar(50), 
Last_name varchar(50),
Job_role varchar(50),
Salary int
)

Insert Into #temp_sal 
select First_name, Last_name, Employee.Job_role, Salary
from Employee
join Salary
on Employee.E_ID=Salary.E_ID
order by Job_role
