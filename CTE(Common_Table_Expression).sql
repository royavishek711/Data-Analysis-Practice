with CTE_Employee as
(
select First_name, Last_name, Gender, Salary,
count(Gender) over (partition by Gender) as TotGender
from Employee as e
join Salary as s
on s.E_ID=e.E_ID
)
--select *
--from CTE_Employee
 select First_name, Salary
 from CTE_Employee