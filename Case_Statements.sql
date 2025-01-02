select E_ID, First_name, Age,
case
when Age >=30 then 'Eligible'
when Age between 24 and 29 then 'Waiting'
else 'Not Eligible'
end as Eligibility
from Employee
where age is not null
order by Age


select First_name, Last_name, Employee.Job_role, Salary,
case 
when Employee.Job_role like 'Data%' then Salary + (Salary * .2)
else Salary + (Salary * .1)
end as HikedSal
from Employee
join Salary
on Employee.E_ID=Salary.E_ID
order by Job_role