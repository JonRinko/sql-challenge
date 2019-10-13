-- Used for making (many) updates while building 
-- 10/13 update: commented out tables that do not have a PK >-FK relationship 
drop table DepartmentData.departments CASCADE;
-- drop table DepartmentData.dept_emp CASCADE;
-- drop table DepartmentData.dept_manager CASCADE;
drop table EmployeeData.employees CASCADE;
-- drop table EmployeeData.titles CASCADE;
-- drop table EmployeeData.salaries CASCADE;

-- 10/13 update: removed cascade from tables w/out PK in dependent tables (test later) 

-- drop table DepartmentData.departments;
drop table DepartmentData.dept_emp;
drop table DepartmentData.dept_manager;
-- drop table EmployeeData.employees;
drop table EmployeeData.titles;
drop table EmployeeData.salaries;

CREATE SCHEMA DepartmentData;
CREATE SCHEMA EmployeeData;


-- DepartmentData Schema Tables: 

CREATE TABLE DepartmentData.departments (
dept_no varchar(100) primary key,
dept_name varchar(100)
);

CREATE TABLE DepartmentData.dept_emp(
emp_no varchar,
dept_no varchar(100) REFERENCES DepartmentData.departments(dept_no),
from_date date,
to_date date
);

CREATE TABLE DepartmentData.dept_manager (
dept_no varchar(100) REFERENCES DepartmentData.departments(dept_no),
emp_no int,
from_date date,
to_date date
);

-- EmployeeData Schema Tables:

CREATE TABLE EmployeeData.employees(
emp_no varchar primary key,
birth_date date,
first_name varchar(100),
last_name char(200),
gender varchar(100),
hire_date date
);

CREATE TABLE EmployeeData.titles(
emp_no varchar REFERENCES EmployeeData.employees(emp_no),
title varchar(100),
from_date date,
to_date date
);

CREATE TABLE EmployeeData.salaries(
emp_no varchar REFERENCES EmployeeData.employees(emp_no),
salary decimal(16,2),
from_date date,
to_date date
);

-- use below code to alter/add fk (did not use this code - used drops instead and recreated tables)
-- ALTER TABLE ORDERS 
--    ADD FOREIGN KEY (Customer_ID) REFERENCES CUSTOMERS (ID);

-- Testing/creating starting code for select statements
SELECT * FROM DepartmentData.departments;
SELECT * FROM DepartmentData.dept_emp;
SELECT * FROM DepartmentData.dept_manager;

SELECT * FROM EmployeeData.employees;
SELECT * FROM EmployeeData.titles;
SELECT * FROM EmployeeData.salaries;


-- DATA ANALYSIS OBJECTIVES: 
--(Using JOIN, UNION or Subqueries)

-- 1. List the following details of each employee: employee number, last name, first name, gender, and salary

-- From emp table we can get most of this data:
SELECT emp_no, last_name, first_name, gender FROM EmployeeData.employees;

-- Get the rest from the salary table:
SELECT emp_no, salary FROM EmployeeData.salaries;

-- join syntax example:
-- SELECT column-names
--   FROM table-name1 (INNER) JOIN table-name2 
--     ON column-name1 = column-name2
--  WHERE condition

-- all together now:
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.gender, salaries.salary
	FROM EmployeeData.employees INNER JOIN EmployeeData.salaries
		ON employees.emp_no = salaries.emp_no;

-- DROP TABLE EmployeeData.emp_salaries; (prev created tbl to insert into but this is not needed so dropped tbl   )

-- Let's put that query into a table:
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.gender, salaries.salary
	INTO EmployeeData.emp_salaries
		FROM EmployeeData.employees INNER JOIN EmployeeData.salaries
			ON employees.emp_no = salaries.emp_no;
			
SELECT * FROM EmployeeData.emp_salaries; 

-- 2. List employees who were hired in 1986:

SELECT emp_no, hire_date, first_name, last_name 
	FROM EmployeeData.employees
		WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';

-- making the hire date cronological 
SELECT emp_no, hire_date, first_name, last_name 
	FROM EmployeeData.employees
		WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31'
			ORDER BY hire_date;

--creating the 1986 employess hired data table
SELECT emp_no, hire_date, first_name, last_name 
	INTO EmployeeData.employees_hired_1986
		FROM EmployeeData.employees
			WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31'
				ORDER BY hire_date;
				
SELECT * FROM EmployeeData.employees_hired_1986; 

-- 3. List the manager of each department with the following information: 
--        department number, department name, the manager's employee number,
--			last name, first name, and start and end employment dates.

-- *** since many tables have a 'to_date' and none have and 'end employment date,' I am assuming the dates in these 
-- tables are the end employment dates and not specifically relating to the tables themselves, such as the date they
-- stopped managing the department but not necessarily left the company, or the date the title was held.  
-- ** Using employees.hire_date instead of 'from_date' for the start employment to avoid ambiguous data or 
-- having to test for equality between from and hire columns. 


-- get dept no, name manager no and to date in one table: 
SELECT departments.dept_no, departments.dept_name, dept_manager.emp_no as manager_no, dept_manager.to_date
	INTO Departmentdata.dep_name_mgr_info
		FROM Departmentdata.departments INNER JOIN Departmentdata.dept_manager
			ON departments.dept_no = dept_manager.dept_no;

SELECT * FROM departmentdata.dep_name_mgr_info;
-- 
-- employees.emp_no as Emp_Number, (employees.last_name) || ', ' || (employees.first_name) as Manager_Name,
-- employees.hire_date as Start_date
-- 	FROM DepartmentData.departments INNER JOIN EmployeeData.employees
-- 		ON dept_manager.emp_no = employees.emp_no;



-- one more thing to add
-- dept_emp.to_date as End_Date







-- 4. List the department of each employee with the following information: employee number, last name, first name, and department name.

-- 5. List all employees whose first name is "Hercules" and last names begin with "B."

-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.

-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name




