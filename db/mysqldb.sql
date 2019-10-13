-- drop table departments;
-- drop table dept_emp;
-- drop table employees;
-- drop table dept_manager;
-- drop table titles;
-- drop table salaries;


CREATE TABLE departments as d(
dept_no varchar(100) PK NOT NULL,
dept_name varchar(100) NOT NULL
);

CREATE TABLE dept_emp(
emp_no int PK NOT NULL,
dept_no varchar(100) REFERENCES d[dept_no],
from_date date NOT NULL,
to_date date
);

CREATE TABLE employees(
emp_no int,
first_name varchar(100),
last_name varchar(100),
birth_date date,
gender varchar(100),
hire_date date
);

CREATE TABLE dept_manager(
dept_no varchar(100),
emp_no int,
from_date date NOT NULL,
to_date date
);

CREATE TABLE titles(
emp_no int,
title varchar(100),
from_date date NOT NULL,
to_date date
);

CREATE TABLE salaries(
emp_no int,
salary decimal(18,2),
from_date date NOT NULL,
to_date date
);

-- use below code to alter/add fk
-- ALTER TABLE ORDERS 
--    ADD FOREIGN KEY (Customer_ID) REFERENCES CUSTOMERS (ID);