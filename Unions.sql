create table NewEmp
(
E_ID int,
First_name varchar(50),
Last_name varchar(50),
Age int,
Gender varchar(50),
Job_role varchar(50)
)

insert into NewEmp values
(301, 'Avi', 'Bose', 30, 'Male', 'Site Engineer'),
(302, 'Rupali', 'Sen', 33, 'Female', 'Cloud Engineer'),
(303, 'Sonu', 'Giri', 20, 'Male', 'Junior Engineer'),
(304, 'Renu', 'Samanta', 35, 'Female', 'HR'),
(305, 'Nirab', 'Sil', 29, 'Male', 'Writer')

insert into Employee values
(401, 'Kelly', 'Wilson', NULL, 'Female', null),
(302, 'Rupali', 'Sen', 33, 'Female', 'Cloud Engineer'),
(402, null, 'Sen', 33, null, 'Cloud Engineer'),
(403, 'Sonu', null, 20, 'Male', null)

select * from Employee

select * 
from Employee
full outer join NewEmp
on Employee.E_ID=NewEmp.E_ID

select *
from Employee
Union all
select *
from NewEmp
order by E_ID desc

