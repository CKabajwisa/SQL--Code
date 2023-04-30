--Display first_name,last_name,email,hire_date,job_id,salary of employees who work in department no 70.  
select first_name,last_name,email,hire_date,job_id,salary from employees where  department_id='70';

--Retrieve employee details of the employee whose first name ends with f, last name starts with e and fist name concatenated with last name has a letter s  
select * from employees where first_name like'S%' and last_name like 'K%' and first_name || '' || last_name like '%S%';

--Retrieve the name and salary of every employee  
select first_name,last_name,salary from employees;  

--Retrieve all distinct salary values  
select distinct salary from employees;

-- Subquery in Select

Select Employee_ID, Salary, (Select AVG(Salary) From employees) as "All Avg Salary"
From employees;


--Group By(Columns must be in the select and not part of the aggregate functions
Select Employee_ID, job_id, Salary, (Select AVG(Salary) From employees) as "All Avg Salary"
From employees
group by job_id, employee_id,salary
order by employee_id;


-- Subquery in From
Select a.Employee_ID, AllAvgSalary
From 
	(Select Employee_ID, Salary, min(Salary) over () as AllAvgSalary
	 From employees) a
Order by a.employee_id;


-- Subquery in Where
select * from employees e  
inner join departments d on d.department_id in (select d.department_id from departments where department_id in(10,20,70,80)) 
where e.salary >=6000 order by e.salary
	
	
/*

String Functions - TRIM, LTRIM, RTRIM, Replace, Substring, Upper, Lower

*/


Select *
From employees

-- Using Trim, LTRIM, RTRIM

select TRIM(first_name) "First Name",TRIM(last_name) "Last Name",TRIM(SUBSTR(first_name || ' ' || last_name, 1,20)) Name from employees; 

select TRIM(first_name) "First Name",LTRIM(last_name) "Last Name",RTRIM(SUBSTR(first_name || ' ' || last_name, 1,20)) Name from employees;



-- Using Replace

select distinct REPLACE(first_name,'e','i') 
,SUBSTR(last_name,1,4) LastName
,SUBSTR(first_name || ' ' || last_name, 1,7) Name
from employees;


-- Using Substring

Select distinct SUBSTR(first_name,1,4) FirstName
,SUBSTR(last_name,1,4) LastName
,SUBSTR(first_name || ' ' || last_name, 1,7) Name
from employees e right join departments d on SUBSTR(e.department_id,1,1) = SUBSTR(d.department_id,1,1);


-- Using UPPER,lower and concatenating strings

Select first_name, LOWER(first_name), last_name, lower(last_name), first_name || ' ' || last_name
from employees;


--Views
--Creating Views
CREATE VIEW EMP_DETAILS_VIEW
AS SELECT
  e.employee_id, 
  e.job_id, 
  e.manager_id, 
  e.department_id,
  d.location_id,
  l.country_id,
  e.first_name,
  e.last_name,
  e.salary,
  e.commission_pct,
  d.department_name,
  j.job_title,
  l.city,
  l.state_province,
  c.country_name,
  r.region_name
FROM
  employees e,
  departments d,
  jobs j,
  locations l,
  countries c,
  regions r
WHERE e.department_id = d.department_id
  AND d.location_id = l.location_id
  AND l.country_id = c.country_id
  AND c.region_id = r.region_id
  AND j.job_id = e.job_id WITH READ ONLY;



--Select from View
SELECT
  e.employee_id, 
  e.job_id, 
  e.manager_id, 
  e.department_id,
  d.location_id,
  l.country_id,
  e.first_name,
  e.last_name,
  e.salary,
  e.commission_pct,
  d.department_name,
  j.job_title,
  l.city,
  l.state_province,
  c.country_name,
  r.region_name
FROM
  employees e,
  departments d,
  jobs j,
  locations l,
  countries c,
  regions r
WHERE e.department_id = d.department_id
  AND d.location_id = l.location_id
  AND l.country_id = c.country_id
  AND c.region_id = r.region_id
  AND j.job_id = e.job_id