
--Table 1 Query:
Create Table EmployeeDemographics 
(EmployeeID int, 
FirstName varchar(50), 
LastName varchar(50), 
Age int, 
Gender varchar(50)
)

--Table 2 Query:
Create Table EmployeeSalary 
(EmployeeID int, 
JobTitle varchar(50), 
Salary int
)



--Table 1 Insert:
Insert into Employee VALUES
(1001, 'Jim', 'Halpert', 30, 'Male', 'QA Engineer'),
(1002, 'Pam', 'Beasley', 30, 'Female', 'Tester'),
(1003, 'Dwight', 'Schrute', 29, 'Male', 'DevOps Engineer')


--Table 2 Insert:
Insert Into Salary VALUES
(1001, 'Salesman', 45000),
(1002, 'Receptionist', 36000)