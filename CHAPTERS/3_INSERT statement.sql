use employees;

SELECT 
    *
FROM
    employees
ORDER BY emp_no DESC
LIMIT 10;

INSERT INTO employees 
(
	emp_no,
    birth_date,
    first_name,
    last_name,
    gender,
    hire_date
) VALUES 
(999901,
'1986-04-21',
'John',
'Smith',
'M',
'2011-01-01'
);

insert into employees 
values
(
	999902,
    '1997-01-01',
    'Alice',
    'Smith',
    'F',
    '2018-01-01'
);
insert into employees 
values
(
	999903,
    '1977-01-01',
    'Ben',
    'Creek',
    'M',
    '1999-01-01'
);

SELECT 
    *
FROM
    titles
ORDER BY emp_no DESC
LIMIT 10;

insert into titles 
(
	emp_no,
    title,
    from_date
) values
(
	'999903',
	'Senior Engineer',
    '1997-10-01'
);

SELECT 
    *
FROM
    dept_emp
ORDER BY emp_no DESC
LIMIT 10;

insert into dept_emp 
values 
(
	999903,
    'd005',
    '1997-10-01',
    '9999-01-01'
);

SELECT 
    *
FROM
    departments
LIMIT 10;

CREATE TABLE department_dup (
    dept_no CHAR(4) NOT NULL,
    dept_name VARCHAR(40) NOT NULL
);

SELECT 
    *
FROM
    department_dup;

insert into department_dup (dept_no, dept_name) select * from departments;

insert into departments values ('d010', 'Businsee Analysis');

