select First_name, Last_name, Gender, Salary,
count(Gender) over (partition by Gender) as TotGender
from Employee as e
join Salary as s
on s.E_ID=e.E_ID

--diff between GROUP BY and PARTITION BY

select Gender, count(Gender) as TotGender
from Employee as e
join Salary as s
on s.E_ID=e.E_ID
group by Gender
