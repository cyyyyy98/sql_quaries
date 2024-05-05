SELECT 
    dept_no
FROM
    departments;
    
SELECT 
    *
FROM
    departments;

SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Elvis';

SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Kellie' AND gender = 'F';

SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Kellie'
        OR first_name = 'Aruna';
        
SELECT 
    *
FROM
    employees
WHERE
    last_name = 'Denis' AND gender = 'M'
        OR gender = 'F';
-- logical operator precedence: 'AND' > 'OR' --
-- rewrite as:
SELECT 
    *
FROM
    employees
WHERE
    last_name = 'Denis'
        AND (gender = 'M' OR gender = 'F');

SELECT 
    *
FROM
    employees
WHERE
    gender = 'F'
        AND (first_name = 'Kellie'
        OR first_name = 'Aruna');

SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Cathie'
        OR first_name = 'Mark'
        OR first_name = 'Nathan';

SELECT 
    *
FROM
    employees
WHERE
    first_name IN ('cathie' , 'Mark', 'Nathan');
    
SELECT 
    *
FROM
    employees
WHERE
    first_name NOT IN ('cathie' , 'Mark', 'Nathan');
    
SELECT 
    *
FROM
    employees
WHERE
    first_name IN ('Denis' , 'Elvis');
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Denis'
        OR first_name = 'Elvis';
        
SELECT 
    *
FROM
    employees
WHERE
    first_name NOT IN ('John' , 'Mark', 'Jacob');

/* wildcard characters
%: a substitute for a sequence of characters
_: to match a single character
*: to select all column; to count
*/

SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE ('mark%');
SELECT 
    *
FROM
    employees
WHERE
    hire_date LIKE ('2000-%-%');
SELECT 
    *
FROM
    employees
WHERE
    hire_date LIKE ('%2000%');
SELECT 
    *
FROM
    employees
WHERE
    emp_no LIKE ('1000_');

SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE ('%jack%');
    
SELECT 
    *
FROM
    employees
WHERE
    hire_date BETWEEN '1990-01-01' AND '2000-01-01';
    
SELECT 
    *
FROM
    employees
WHERE
    hire_date NOT BETWEEN '1990-01-01' AND '2000-01-01';

SELECT 
    *
FROM
    salaries
WHERE
    salary BETWEEN 66000 AND 70000;
 
 SELECT 
    *
FROM
    employees
WHERE
    emp_no NOT BETWEEN '10004' AND '10012';
 
SELECT 
    *
FROM
    departments
WHERE
    dept_no BETWEEN 'd003' AND 'd006';
    
SELECT 
    *
FROM
    departments
WHERE
    dept_no IS NOT NULL;

SELECT 
    *
FROM
    employees
WHERE
    gender = 'F'
        AND hire_date >= '2000-01-01';
        
SELECT 
    *
FROM
    salaries
WHERE
    salary > 150000;

SELECT DISTINCT
    hire_date
FROM
    employees;
    
-- How many enployees are registered --
SELECT 
    *
FROM
    employees;
SELECT 
    COUNT(emp_no)
FROM
    employees;
-- 300024 --

SELECT 
    *
FROM
    employees
WHERE
    first_name IS NULL;

SELECT 
    COUNT(first_name)
FROM
    employees;
-- 300024 --

-- How many different names --
SELECT 
    COUNT(DISTINCT first_name)
FROM
    employees;
-- 1275 --

SELECT 
    *
FROM
    salaries;
SELECT 
    COUNT(*)
FROM
    salaries
WHERE
    salary >= 100000;

SELECT 
    *
FROM
    dept_manager;
SELECT 
    COUNT(*)
FROM
    dept_manager
WHERE
    emp_no IS NOT NULL;
-- 24
SELECT 
    COUNT(*)
FROM
    dept_manager;
-- 24

SELECT 
    *
FROM
    employees
ORDER BY first_name;

/*
ASC - ascending (implicitly) A-Z
DESC - descending Z-A
*/

SELECT 
    *
FROM
    employees
ORDER BY first_name DESC;

SELECT 
    *
FROM
    employees
ORDER BY first_name , last_name ASC;

SELECT 
    *
FROM
    employees
ORDER BY hire_date DESC;

SELECT 
    first_name, COUNT(first_name) AS names_count
FROM
    employees
GROUP BY first_name
ORDER BY first_name DESC;
-- Aliases (AS): to rename

SELECT 
    *
FROM
    salaries;
SELECT 
    salary, COUNT(emp_no) AS emps_with_same_salary
FROM
    salaries
WHERE
    salary > 80000
GROUP BY salary
ORDER BY salary;

SELECT 
    first_name, COUNT(first_name) AS names_count
FROM
    employees
GROUP BY first_name
HAVING COUNT(first_name) > 250
ORDER BY first_name;

SELECT 
    emp_no, AVG(salary)
FROM
    salaries
GROUP BY emp_no
HAVING AVG(salary) > 120000
ORDER BY emp_no;

SELECT 
    *, AVG(salary)
FROM
    salaries
WHERE
    salary > 120000
GROUP BY emp_no
ORDER BY emp_no;

SELECT 
    *, AVG(salary)
FROM
    salaries
GROUP BY emp_no
HAVING AVG(salary) > 120000;

SELECT 
    first_name, COUNT(first_name) AS names_count
FROM
    employees
WHERE
    hire_date > '1999-01-01'
GROUP BY first_name
HAVING COUNT(first_name) < 200
ORDER BY first_name DESC;

SELECT 
    *
FROM
    dept_emp;
    
SELECT 
    emp_no
FROM
    dept_emp
WHERE
    from_date > '2000-01-01'
GROUP BY emp_no
HAVING COUNT(dept_no) > 1
ORDER BY emp_no;

SELECT 
    *
FROM
    salaries
ORDER BY emp_no DESC
LIMIT 10;

SELECT 
    *
FROM
    dept_emp
LIMIT 100;