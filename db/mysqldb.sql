-- keep some drops handy as I build and rebuild
-- drop table departments CASCADE;
-- drop table dept_emp CASCADE;
-- drop table employees CASCADE;
-- drop table dept_manager CASCADE;
-- drop table titles CASCADE;
-- drop table salaries CASCADE;
CREATE SCHEMA DepartmentData;
CREATE SCHEMA EmployeeData;

CREATE TABLE DepartmentData.departments (
dept_no varchar(100) primary key,
dept_name varchar(100)
);

CREATE TABLE DepartmentData.dept_emp(
emp_no varchar primary key,
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


CREATE TABLE EmployeeData.employees (
emp_no int primary key,
first_name varchar(100),
last_name varchar(100),
birth_date date,
gender varchar(100),
hire_date date
);

CREATE TABLE EmployeeData.titles(
emp_no int REFERENCES EmployeeData.employees(emp_no),
title varchar(100),
from_date date,
to_date date
);

CREATE TABLE EmployeeData.salaries(
emp_no int REFERENCES EmployeeData.employees(emp_no),
salary decimal(16,2),
from_date date,
to_date date
);

-- use below code to alter/add fk
-- ALTER TABLE ORDERS 
--    ADD FOREIGN KEY (Customer_ID) REFERENCES CUSTOMERS (ID);

-- now we can add the csv files to our existing tables