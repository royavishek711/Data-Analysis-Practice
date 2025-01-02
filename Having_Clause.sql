select Employee.Job_role, count(Employee.Job_role)
from Employee
join Salary
on Employee.E_ID=Salary.E_ID
group by Employee.Job_role
having count(Employee.Job_role)>1