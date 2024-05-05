use employees;

SELECT 
    *
FROM
    salaries
ORDER BY salary DESC
LIMIT 10;

SELECT 
    COUNT(DISTINCT from_date)
FROM
    salaries;
    
SELECT 
    *
FROM
    dept_emp;
SELECT 
    COUNT(distinct emp_no)
FROM
    dept_emp;
    
SELECT 
    SUM(salary)
FROM
    salaries;

SELECT 
    *
FROM
    salaries;

SELECT 
    SUM(salary)
FROM
    salaries
WHERE
    from_date > '1997-01-01';
    
SELECT 
    MAX(salary)
FROM
    salaries;
    
SELECT 
    MIN(salary)
FROM
    salaries;
    
SELECT 
    *
FROM
    employees;

 SELECT 
    MAX(emp_no)
FROM
    employees;
-- higest employee no
 SELECT 
    MIN(emp_no)
FROM
    employees;
-- lowest employee no

SELECT 
    AVG(salary)
FROM
    salaries;
    
SELECT 
    AVG(salary)
FROM
    salaries
WHERE
    from_date > '1997-01-01';
    
SELECT 
    ROUND(AVG(salary), 2)
FROM
    salaries;
    
SELECT 
    ROUND(AVG(salary),2)
FROM
    salaries
WHERE
    from_date > '1997-01-01';

alter table departments_dup
change column dept_name dept_name varchar(40) null;
    
/*
DELETE FROM departments_dup 
WHERE
    dept_no = 'd010';

 insert into departments_dup(dept_no) values ('d010');

SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no ASC;

DELETE FROM departments_dup 
WHERE
    dept_no = 'd010';
*/

alter table employees.departments_dup
add column dept_manager varchar(255) null
after dept_name;

SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;

COMMIT;

SELECT 
    dept_no,
    IFNULL(dept_name,
            'Department name not provided') AS dept_name
FROM
    departments_dup;

SELECT 
    dept_no,
    COALESCE(dept_name,
            'Department name not provided') AS dept_name
FROM
    departments_dup;
    
ROLLBACK;

SELECT 
    dept_no,
    dept_name,
    COALESCE(dept_manager, dept_name, 'N/A') AS dept_manager
FROM
    departments_dup
ORDER BY dept_no ASC;

SELECT 
    dept_no,
    dept_name,
    COALESCE('department manager name') AS fake_col
FROM
    departments_dup;

SELECT 
    dept_no,
    dept_name,
    COALESCE(dept_no, dept_name) AS dept_info
FROM
    departments_dup
ORDER BY dept_no ASC;

SELECT 
    IFNULL(dept_no, 'N/A') AS dept_no,
    IFNULL(dept_name, 'Department name not provided' ) AS dept_name,
    COALESCE(dept_no, dept_name) AS dept_info
FROM
    departments_dup
ORDER BY dept_no ASC;

