USE employees;

SELECT 
    *
FROM
    departments_dup;

alter table departments_dup
change column dept_no dept_no char(4) null;

alter table departments_dup
change column dept_name dept_name varchar(40) null;

insert into departments_dup (dept_name)
values
('Public Relations');

DELETE FROM departments_dup 
WHERE
    dept_no = 'd002';

insert into departments_dup (dept_no)
values
('d010'),('d011');

DROP TABLE IF EXISTS dept_manager_dup;

CREATE TABLE dept_manager_dup 
(
  emp_no int(11) NOT NULL,
  dept_no char(4) NULL,
  from_date date NOT NULL,
  to_date date NULL
);

INSERT INTO dept_manager_dup
select * from dept_manager;

INSERT INTO dept_manager_dup (emp_no, from_date)
VALUES                
(999904, '2017-01-01'),
(999905, '2017-01-01'),
(999906, '2017-01-01'),
(999907, '2017-01-01');

DELETE FROM dept_manager_dup
WHERE
    dept_no = 'd001';

# dept_manager_dup
SELECT 
    *
FROM
    dept_manager_dup
ORDER BY dept_no;

# departments_dup
SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;

DELETE FROM departments_dup 
WHERE
    dept_name = 'Business Analysis';
    
/*   Joins   */

select m.dept_no, m.emp_no, d.dept_name
from dept_manager_dup m
join departments_dup d on m.dept_no = d.dept_no
order by dept_no;

SELECT 
    *
FROM
    dept_manager_dup;
SELECT 
    *
FROM
    employees;

SELECT 
    m.emp_no, e.first_name, e.last_name, m.dept_no, e.hire_date
FROM
    dept_manager_dup m
        INNER JOIN
    employees e ON m.emp_no = e.emp_no
ORDER BY e.emp_no;

SELECT 
    m.dept_no, m.emp_no, m.from_date, m.to_date, d.dept_name
FROM
    dept_manager_dup m
        JOIN
    departments_dup d ON m.dept_no = d.dept_no
ORDER BY dept_no;
/* inner join = join, 'inner' could be omitted */

/* duplicate records */
insert into dept_manager_dup
values ('110228','d003','1992-03-21','9999-01-01');

insert into departments_dup
values ('d009', 'Customer Service');

SELECT 
    *
FROM
    dept_manager_dup
ORDER BY dept_no ASC;

SELECT 
     m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        JOIN
    departments_dup d ON m.dept_no = d.dept_no
GROUP BY m.dept_no, m.emp_no, d.dept_name
ORDER BY dept_no;

# remove the duplicates from the two tables
DELETE FROM dept_manager_dup 
WHERE
    emp_no = '110228';
DELETE FROM departments_dup 
WHERE
    dept_no = 'd009';
# add back the initial records
insert into dept_manager_dup 
values ('110228', 'd003', '1992-03-21', '9999-01-01');

insert into departments_dup
values ('d009', 'Customer Service');

/* left join */
select m.dept_no, m.emp_no, d.dept_name
from dept_manager_dup m
left join departments_dup d on m.dept_no = d.dept_no
group by m.emp_no
order by m.dept_no;

set @@global.sql_mode := replace(@@global.sql_mode, 'ONLY_FULL_GROUP_BY', '');
select @@global.sql_mode;

select d.dept_no, m.emp_no, d.dept_name
from departments_dup d
left outer join dept_manager_dup m on m.dept_no = d.dept_no
group by m.emp_no
order by d.dept_no;
# left join = left outer join

select * from employees;
select * from dept_manager_dup;

SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    m.dept_no,
    m.from_date
FROM
    employees e
        LEFT JOIN
    dept_manager_dup m ON e.emp_no = m.emp_no
WHERE
    e.last_name = 'Markovitch'
ORDER BY m.dept_no DESC , e.emp_no;

select * from dept_manager_dup;
select * from employees;
# old synax
SELECT 
    e.emp_no, m.dept_no, e.first_name, e.last_name, e.hire_date
FROM
    employees e,
    dept_manager_dup m
WHERE
    e.emp_no = m.emp_no;
    
SELECT 
    e.emp_no, m.dept_no, e.first_name, e.last_name, e.hire_date
FROM
    employees e
        JOIN
    dept_manager_dup m ON m.emp_no = e.emp_no;

SELECT 
    e.emp_no, e.first_name, e.last_name, s.salary
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    s.salary > 145000;
    
select * from employees;
select * from titles;
SELECT 
    e.first_name, e.last_name, e.hire_date, t.title
FROM
    employees e
        JOIN
    titles t ON e.emp_no = t.emp_no
WHERE
    e.first_name = 'Margareta'
        AND e.last_name = 'Markovitch'
ORDER BY e.emp_no;

/* cross join */
SELECT 
    m.*, d.*
FROM
    dept_manager m
        CROSS JOIN
    departments d
ORDER BY m.emp_no , d.dept_no;

SELECT 
    m.*, d.*
FROM
    dept_manager m,
    departments d
ORDER BY m.emp_no , d.dept_no;

SELECT 
    m.*, d.*
FROM
    dept_manager m
        INNER JOIN
    departments d
ORDER BY m.emp_no , d.dept_no;

SELECT 
    m.*, d.*
FROM
    departments d
        CROSS JOIN
    dept_manager m
WHERE
    d.dept_no <> m.dept_no
ORDER BY m.emp_no , d.dept_no;

/* Join two tables */
SELECT 
    e.*, d.*
FROM
    departments d
        CROSS JOIN
    dept_manager m
        JOIN
    employees e ON m.emp_no = e.emp_no
WHERE
    d.dept_no <> m.dept_no
ORDER BY m.emp_no , d.dept_no;

select * from dept_manager;
select * from departments;
SELECT 
    m.*, d.*
FROM
    departments d
        CROSS JOIN
    dept_manager m
WHERE
    d.dept_no = 'd009'
ORDER BY d.dept_no;

SELECT 
    d.*, e.*
FROM
    departments d
        CROSS JOIN
    employees e
WHERE
    e.emp_no < 10011
ORDER BY e.emp_no , d.dept_name;

/* Aggregate functions with Joins */
SELECT 
    e.gender, AVG(s.salary) AS average_salary
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
GROUP BY gender;

/* Join more than two tables */
SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    m.from_date,
    d.dept_name
FROM
    employees e
        JOIN
    dept_manager m ON e.emp_no = m.emp_no
        JOIN
    departments d ON m.dept_no = d.dept_no;

select * from titles;
select * from employees;
select * from departments;
select * from dept_manager;

SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    t.title,
    m.from_date,
    d.dept_name
FROM
    employees e
        JOIN
    dept_manager m ON e.emp_no = m.emp_no
        JOIN
    titles t ON e.emp_no = t.emp_no
        JOIN
    departments d ON m.dept_no = d.dept_no
WHERE
    title = 'Manager'
ORDER BY e.emp_no;
 #or
SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    t.title,
    m.from_date,
    d.dept_name
FROM
    employees e
        JOIN
    dept_manager m ON e.emp_no = m.emp_no
        JOIN
    titles t ON e.emp_no = t.emp_no and m.from_date = t.from_date
        JOIN
    departments d ON m.dept_no = d.dept_no
ORDER BY e.emp_no;

SELECT 
    d.dept_name, AVG(salary) AS average_salary
FROM
    departments d
        JOIN
    dept_manager m ON d.dept_no = m.dept_no
        JOIN
    salaries s ON m.emp_no = s.emp_no
GROUP BY d.dept_name
having average_salary > 60000
ORDER BY average_salary DESC;
# order by d.dept_no; order by avg(salary) desc;

select * from dept_manager;
select * from employees;

SELECT 
    e.gender, COUNT(m.emp_no) AS number_of_people
FROM
    employees e
        JOIN
    dept_manager m ON e.emp_no = m.emp_no
GROUP BY gender;

/* Union */
drop table if exists employees_dup;
CREATE TABLE employees_dup (
    emp_no INT(11),
    birth_date DATE,
    first_name VARCHAR(14),
    last_name VARCHAR(16),
    gender ENUM('M', 'F'),
    hire_date DATE
);
insert into employees_dup
select * from employees e limit 20;

insert into employees_dup 
values 
(
	'10001',
    '1953-09-02',
    'Georgi',
    'Facello',
    'M',
    '1986-06-26'
);

SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    NULL AS dept_no,
    NULL AS from_date
FROM
    employees_dup e
WHERE
    e.emp_no = '10001' 
UNION ALL SELECT 
    NULL AS emp_no,
    NULL AS first_name,
    NULL AS last_name,
    m.dept_no,
    m.from_date
FROM
    dept_manager m;
    
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    NULL AS dept_no,
    NULL AS from_date
FROM
    employees_dup e
WHERE
    e.emp_no = '10001' 
UNION SELECT 
    NULL AS emp_no,
    NULL AS first_name,
    NULL AS last_name,
    m.dept_no,
    m.from_date
FROM
    dept_manager m;
    
SELECT 
    *
FROM
    (SELECT 
        e.emp_no,
            e.first_name,
            e.last_name,
            NULL AS dept_no,
            NULL AS from_date
    FROM
        employees e
    WHERE
        last_name = 'Denis' UNION SELECT 
        NULL AS emp_no,
            NULL AS first_name,
            NULL AS last_name,
            dm.dept_no,
            dm.from_date
    FROM
        dept_manager dm) AS a
ORDER BY - a.emp_no DESC;
