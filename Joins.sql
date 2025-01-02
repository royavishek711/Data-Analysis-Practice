select * 
from Employee
inner join Salary
on Employee.E_ID=Salary.E_ID

select * 
from Employee
full outer join Salary
on Employee.E_ID=Salary.E_ID

select * 
from Employee
left outer join Salary
on Employee.E_ID=Salary.E_ID

select * 
from Employee
right outer join Salary
on Employee.E_ID=Salary.E_ID


select First_name, Gender, Max(Salary) as Max_Sal
from Employee
inner join Salary
on Employee.E_ID=Salary.E_ID
where Gender='Male'
group by First_name, Gender

select Gender, Max(Salary) as Max_Sal
from Employee
inner join Salary
on Employee.E_ID=Salary.E_ID
where Gender='Male'
group by Gender