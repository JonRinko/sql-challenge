-- Used for making (many) updates while building 
drop table DepartmentData.departments CASCADE;
drop table DepartmentData.dept_emp CASCADE;
drop table DepartmentData.dept_manager CASCADE;
drop table EmployeeData.employees CASCADE;
drop table EmployeeData.titles CASCADE;
drop table EmployeeData.salaries CASCADE;

CREATE SCHEMA DepartmentData;
CREATE SCHEMA EmployeeData;

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

------

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

-- use below code to alter/add fk
-- ALTER TABLE ORDERS 
--    ADD FOREIGN KEY (Customer_ID) REFERENCES CUSTOMERS (ID);

-- Testing 
SELECT * FROM DepartmentData.departments;
SELECT * FROM DepartmentData.dept_emp;
SELECT * FROM DepartmentData.dept_manager;

SELECT * FROM EmployeeData.employees;
SELECT * FROM EmployeeData.titles;
SELECT * FROM EmployeeData.salaries;


-- Analysis Using SQL!
-- List the following details of each employee: employee number, last name, first name, gender, and salary
