use employees;

CREATE TABLE departments_dup (
    dept_no CHAR(4) NOT NULL,
    dept_name VARCHAR(40) NOT NULL
);

insert into departments_dup select * from departments;

SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;


SELECT 
    *
FROM
    employees
WHERE
    emp_no = 999901;
    
UPDATE employees 
SET 
    first_name = 'sss',
    last_name = 'SSS',
    birth_date = '1919-04-15'
WHERE
    emp_no = 999901;
    
SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;

COMMIT;

UPDATE departments_dup 
SET 
    dept_no = 'd011',
    dept_name = 'Quanlity Control';
    
ROLLBACK;

COMMIT;

SELECT 
    *
FROM
    departments;
    
UPDATE departments 
SET 
    dept_name = 'Data Analysis'
WHERE
    dept_no = 'd010';
    
