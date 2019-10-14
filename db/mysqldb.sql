-- Used for making updates while building 
drop table DepartmentData.departments CASCADE;
drop table EmployeeData.employees CASCADE;
drop table DepartmentData.dept_emp;
drop table DepartmentData.dept_manager;
drop table EmployeeData.titles;
drop table EmployeeData.salaries;


-- per Instructions, create schemas:
CREATE SCHEMA DepartmentData;
CREATE SCHEMA EmployeeData;


-- DepartmentData Schema Tables: 

CREATE TABLE DepartmentData.departments (
dept_no varchar(100) primary key,
dept_name varchar(100)
);

CREATE TABLE DepartmentData.dept_emp(
emp_no integer,
dept_no varchar(100) REFERENCES DepartmentData.departments(dept_no),
from_date date,
to_date date
);

CREATE TABLE DepartmentData.dept_manager (
dept_no varchar(100) REFERENCES DepartmentData.departments(dept_no),
emp_no integer,
from_date date,
to_date date
);

-- EmployeeData Schema Tables:

CREATE TABLE EmployeeData.employees(
emp_no integer primary key,
birth_date date,
first_name varchar(100),
last_name char(200),
gender varchar(100),
hire_date date
);

CREATE TABLE EmployeeData.titles(
emp_no integer REFERENCES EmployeeData.employees(emp_no),
title varchar(100),
from_date date,
to_date date
);

CREATE TABLE EmployeeData.salaries(
emp_no integer REFERENCES EmployeeData.employees(emp_no),
salary decimal(16,2),
from_date date,
to_date date
);


-- Testing/creating starting code for select statements
SELECT * FROM DepartmentData.departments;  
SELECT * FROM DepartmentData.dept_emp; 
SELECT * FROM DepartmentData.dept_manager;  

SELECT * FROM EmployeeData.employees;  
SELECT * FROM EmployeeData.titles;   
SELECT * FROM EmployeeData.salaries;

-- ambiguous data present in 'to_date' columns and ambiguous relation of dates to csv title.


-- DATA ANALYSIS OBJECTIVES: 
--(Using JOIN, UNION or Subqueries)

-- join syntax example:
-- SELECT column-names
--   FROM table-name1 (INNER) JOIN table-name2 
--     ON column-name1 = column-name2
--  WHERE condition

-- 1. List the following details of each employee: employee number, last name, first name, gender, and salary

SELECT emp_no, last_name, first_name, gender FROM EmployeeData.employees;

-- Get the rest from the salary table:
SELECT emp_no, salary FROM EmployeeData.salaries;

-- all together now:
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.gender, salaries.salary
	FROM EmployeeData.employees INNER JOIN EmployeeData.salaries
		ON employees.emp_no = salaries.emp_no;

-- Let's put that query into a table:
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.gender, salaries.salary
	INTO EmployeeData.emp_salaries
		FROM EmployeeData.employees INNER JOIN EmployeeData.salaries
			ON employees.emp_no = salaries.emp_no;
			
SELECT * FROM EmployeeData.emp_salaries; 
DROP TAble Employeedata.emp_salaries;

-- 2. List employees who were hired in 1986:

SELECT emp_no, hire_date, first_name, last_name 
	FROM EmployeeData.employees
		WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31'
			ORDER BY hire_date;

--creating the 1986 employees hired data table
SELECT emp_no, hire_date, first_name, last_name 
	INTO EmployeeData.employees_hired_1986
		FROM EmployeeData.employees
			WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31'
				ORDER BY hire_date;
				
SELECT * FROM EmployeeData.employees_hired_1986; 

-- 3. List the manager of each department with the following information: 
--        department number, department name, the manager's employee number,
--			last name, first name, and start and end employment dates.

-- get dept no, name manager,emp_no and to date in one table: 
SELECT departments.dept_no, departments.dept_name, dept_manager.emp_no, dept_manager.to_date
	INTO Departmentdata.dep_name_emp_no
		FROM Departmentdata.departments INNER JOIN Departmentdata.dept_manager
			ON departments.dept_no = dept_manager.dept_no;
			
DROP TABLE Departmentdata.dep_name_emp_no;

SELECT * FROM departmentdata.dep_name_emp_no;

-- add last name, first, to and from_date from emp:

SELECT dep_name_emp_no.dept_no, dep_name_emp_no.dept_name, dep_name_emp_no.emp_no as manager_emp_no, employees.last_name, 
employees.first_name, employees.hire_date as start_date, dep_name_emp_no.to_date as end_date
	INTO Departmentdata.combined_managers
		FROM departmentdata.dep_name_emp_no INNER JOIN Employeedata.employees
			ON dep_name_emp_no.emp_no = employees.emp_no;
			
SELECT * FROM DepartmentData.combined_managers;
DROP TABLE DepartmentData.combined_managers;

-- 4. List the department of each employee with the following information: employee number, last name, first name, and department name.
-- need to join 3 tables: employees, dept_emp and departments

SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
		FROM EmployeeData.employees INNER JOIN DepartmentData.dept_emp ON employees.emp_no = dept_emp.emp_no
									INNER JOIN DepartmentData.departments ON dept_emp.dept_no = departments.dept_no

--celebrate!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

-- 5. List all employees whose first name is "Hercules" and last names begin with "B."
SELECT * FROM EmployeeData.employees
	WHERE employees.first_name LIKE '%Hercules%' AND employees.last_name LIKE '%B%';

-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.

-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each 
--last name.

--Comment Section: 
-- illogical data in 'to_date' columns of all except salaries.csv. 
-- As this data is not really used in the assignment, it is ok.

-- use below code to alter/add fk although did not use this code - used drops instead and recreated tables)
-- ALTER TABLE ORDERS 
--    ADD FOREIGN KEY (Customer_ID) REFERENCES CUSTOMERS (ID);

-- Figure out how to do objective 3 in less steps... solved for objective 4 see below
-- review assigning alias to table names...

-- joining 3 tables:
-- SELECT t1.col, t3.col FROM table1 join table2 ON table1.primarykey = table2.foreignkey
--                                   join table3 ON table2.primarykey = table3.foreignkey

--mysql> SELECT emp_name, dept_name FROM Employee e JOIN Register r ON e.emp_id=r.emp_id 
--JOIN Department d ON r.dept_id=d.dept_id






