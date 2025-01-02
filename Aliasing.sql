select First_name + ' ' + Last_name as FullName
from Employee

select First_name, Gender, Max(Salary) as Max_Sal
from Employee as e
inner join Salary as s
on s.E_ID=e.E_ID
where Gender='Male'
group by First_name, Gender