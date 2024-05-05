# row_number()
select emp_no, salary
from salaries;

select emp_no, salary,
	row_number() over () as row_num
from salaries;

select emp_no, salary,
	row_number() over (partition by emp_no) as row_num
from salaries;

select emp_no, salary,
	row_number() over (order by salary desc) as row_num
from salaries;

select emp_no, dept_no,
	row_number() over (order by emp_no) as row_num
from dept_manager;

select emp_no, first_name, last_name,
	row_number () over (partition by first_name order by last_name) as row_num
from employees;

select emp_no, salary,
	row_number() over() as row_num1,
    row_number() over (partition by emp_no) as row_num2,
    row_number() over (partition by emp_no order by salary desc) as row_num3,
    row_number() over (order by salary desc) as row_num4
from salaries;
# messy

# 1.add an order by clause to the outer query
select emp_no, salary,
	row_number() over() as row_num1,
    row_number() over (partition by emp_no) as row_num2,
    row_number() over (partition by emp_no order by salary desc) as row_num3,
    row_number() over (order by salary desc) as row_num4
from salaries
order by emp_no, salary;

# 2.use only window specifications requiring identical partitions
select emp_no, salary,
    row_number() over (partition by emp_no) as row_num2,
    row_number() over (partition by emp_no order by salary desc) as row_num3
from salaries;

select dm.emp_no, salary,
	row_number() over () as row_num1,
    row_number() over (partition by emp_no order by salary desc) as row_num2
from dept_manager dm
join salaries s on dm.emp_no = s.emp_no
order by row_num1, emp_no, salary;

select emp_no, salary,
	row_number() over (partition by emp_no order by salary desc) as row_num
from salaries;

select emp_no, salary,
	row_number() over w as row_num
from salaries
window w as (partition by emp_no order by salary desc);

select emp_no, first_name,
	row_number() over w as row_num
from employees
window w as (partition by first_name order by emp_no);

select a.emp_no,
	min(salary) as min_salary
from (
	select emp_no, salary,
		row_number() over w as row_num
	from salaries
    window w as (partition by emp_no order by salary)) as a
group by emp_no;

select a.emp_no,
	min(salary) as min_salary
from (
	select emp_no, salary,
		row_number() over (partition by emp_no order by salary) as row_num
	from salaries) a
group by emp_no;

# rank() & dense_rank()
select emp_no, salary,
	row_number() over w as row_num
from salaries
where emp_no = '10001'
window w as (partition by emp_no order by salary desc);

select emp_no, (count(salary) - count(distinct salary)) as diff
from salaries
group by emp_no
having diff > 0
order by emp_no;

select emp_no, salary,
	rank() over w as rank_num
from salaries
where emp_no = '10001'
window w as (partition by emp_no order by salary desc);

select emp_no, salary,
	dense_rank() over w as rank_num
from salaries
where emp_no = '10001'
window w as (partition by emp_no order by salary desc);

# ranking window # joins
select d.dept_no, d.dept_name, dm.emp_no,
	rank() over w as department_salary_ranking,
		s.salary, s.from_date as salary_from_date, s.to_date as salary_to_date,
        dm.from_date as dept_manager_from_date, dm.to_date as dept_manager_to_date
from dept_manager dm
join salaries s on s.emp_no = dm.emp_no
	and s.from_date between dm.from_date and dm.to_date
    and s.to_date between dm.from_date and dm.to_date
join departments d on d.dept_no = dm.dept_no
window w as (partition by dm.dept_no order by s.salary);

select * from departments;

select e.emp_no, s.salary,
	rank() over w as employee_salary_ranking
from employees e
join salaries s on s.emp_no = e.emp_no
where e.emp_no between '10500' and '10600'
window w as (partition by e.emp_no order by s.salary desc);

select e.emp_no, s.salary,
	dense_rank() over w as employee_salary_ranking,
	e.hire_date, s.from_date,
    (year(s.from_date)-year(e.hire_date)) as years_from_start
from employees e
join salaries s on s.emp_no = e.emp_no
	and year(s.from_date)-year(e.hire_date)>=5
where e.emp_no between '10500' and '10600'
window w as (partition by e.emp_no order by s.salary desc);

# lag() & lead()
select emp_no, salary,
	lag(salary) over w as previous_salary,
    lead(salary) over w as next_salary,
    salary-lag(salary) over w as diff_salary_cureent_previous,
    lead(salary) over w -salary as diff_salary_next_current
from salaries
where emp_no = 10001
window w as (order by salary);

select emp_no,salary,
	lag(salary) over w as previous_salary,
    lead(salary) over w as next_salary,
    salary - lag(salary) over w as diff_salary_current_previous,
    lead(salary) over w - salary as diff_salary_next_current
from salaries
where salary > 80000 and emp_no between 10500 and 10600
window w as (partition by emp_no order by salary);

# aggregate window functions
select sysdate();

select emp_no, salary, from_date, to_date
from salaries
where to_date > sysdate();

select * from salaries;

select emp_no, salary, max(from_date), to_date
from salaries
where to_date > sysdate()
group by emp_no;
#error 1055

select s1.emp_no, s.salary, s.from_date, s.to_date
from salaries s
join
	(select emp_no, max(from_date) as from_date
     from salaries
     group by emp_no) s1 on s.emp_no = s1.emp_no
where s.to_date > sysdate()
	and s.from_date = s1.from_date;

select s1.emp_no, s.salary, s.from_date, s.to_date
from salaries s
join
	(select emp_no, min(from_date) as from_date
     from salaries
     group by emp_no) s1 on s.emp_no = s1.emp_no
where s.from_date = s1.from_date;

select * from dept_emp limit 1000;

select de.emp_no, de.dept_no, de.from_date, de.to_date
from dept_emp de
join
	(select emp_no, max(from_date) as from_date
     from dept_emp
     group by emp_no) de1 on de1.emp_no = de.emp_no
where de.to_date > sysdate()
	and de.from_date = de1.from_date;

select de2.emp_no, d.dept_name, s2.salary, avg(s2.salary) over w as average_salary_per_department
from
	(select de.emp_no, de.dept_no, de.from_date, de.to_date
     from dept_emp de
     join
		(select emp_no, max(from_date) as from_date
         from dept_emp
         group by emp_no
        ) de1 on de1.emp_no = de.emp_no
	 where de.to_date < '2002-01-01'
		and de.from_date > '2000-01-01'
        and de.from_date = de1.from_date
    ) de2
join
	(select s1.emp_no, s.salary, s.from_date, s.to_date
	 from salaries s
	 join
		(select emp_no, max(from_date) as from_date
		 from salaries
		 group by emp_no
		) s1 on s.emp_no = s1.emp_no
	 where s.to_date < '2002-01-01'
		and s.from_date > '2000-01-01'
        and s.from_date = s1.from_date
    ) s2 on s2.emp_no = de2.emp_no
join
	departments d on d.dept_no = de2.dept_no
group by de2.emp_no, d.dept_name
window w as (partition by de2.dept_no)
order by de2.emp_no, salary;

# Consider the employees' contracts that have been signed after the 1st of January 2000
# and terminated before the 1st of January 2002 (as registered in the "dept_emp" table).
# Create a MySQL query that will extract the following information about these employees:
# - Their employee number
# - The salary values of the latest contracts they have signed during the suggested
# time period
# - The department they have been working in (as specified in the latest contract
# they've signed during the suggested time period)
# - Use a window function to create a fourth field containing the average salary paid
# in the department the employee was last working in during the suggested time period.
# Name that field "average_salary_per_department".
# Note1: This exercise is not related neither to the query you created nor to the output
# you obtained while solving the exercises after the previous lecture.
# Note2: Now we are asking you to practically create the same query as the one we worked on
# during the video lecture; the only difference being to refer to contracts
# that have been valid within the period between the 1st of January 2000
# and the 1st of January 2002.
# Note3: We invite you solve this task after assuming that the "to_date" values stored
# in the "salaries" and "dept_emp" tables are greater than the "from_date" values stored 
# in these same tables. If you doubt that, you could include a couple of lines 
# in your code to ensure that this is the case anyway!

