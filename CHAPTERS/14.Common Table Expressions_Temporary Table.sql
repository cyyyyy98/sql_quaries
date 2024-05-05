# Common Table Expressions (ctes)
select avg(salary) as avg_salary
from salaries;

# with cte_name as (select... from...)
# select...
# from cte_name...;

with cte as(
	select avg(salary) as avg_salary
    from salaries
	)
select sum(case when s.salary > c.avg_salary then 1 else 0 end) as no_f_salaries_above_avg,
		count(s.salary) as total_no_of_salary_contracts
from salaries s
join employees e on s.emp_no = e.emp_no
	and e.gender = 'F'
cross join cte c;

with cte as(
	select avg(salary) as avg_salary from salaries
	)
select *
from cte;

with cte as (
	select avg(salary) as avg_salary from salaries
	)
select *
from salaries s
join cte c;

with cte as (
	select avg(salary) as avg_salary from salaries
	)
select *
from salaries s
join employees e on s.emp_no = e.emp_no
	and e.gender = 'F'
join cte c;

with cte as (
	select avg(salary) as avg_salary from salaries
	)
select sum(case
			when s.salary > c.avg_salary then 1 else 0
            end
	) as no_f_salaries_above_avg,
		count(s.salary) as total_no_of_salary_contracts
from salaries s
join employees e on s.emp_no = e.emp_no
	and e.gender = 'F'
join cte c;

select sum(case
			when s.salary > a.avg_salary then 1 else 0
            end
	) as no_f_salaries_above_avg,
		count(s.salary) as total_no_of_salary_contracts
from salaries s
join employees e on s.emp_no = e.emp_no
	and e.gender = 'F'
join (select avg(salary) as avg_salary from salaries) a;

with cte as (
	select avg(salary) as avg_salary from salaries
	)
select sum(case when
			s.salary < c.avg_saalry then 1 else 0
            end
	) as no_salaries_blow_avg,
	   count(s.salary) as no_of_salary_contracts
from salaries s
join employees on s.emp_no = e.emp_no
	and e.gender = 'M'
join cte c;

with cte as (select avg(salary) as avg_salary from salaries)
select count(case when
				s.salary < c.avg_salary
					then ss.alary else NULL
						end) as no_salaries_blow_avg_w_count,
		count(s.salary) as no_of_salary_contracts
from salaries s
join employees e on s.emp_no = e.emp_no
	and e.gender = 'M'
join cte c;

select sum(case
				when s.salary < a.avg_salary
				then 1 else 0
                end) as no_salaries_blow_avg,
		count(s.salary) as no_of_salary_contracts
from (select avg(salary) as avg_salary
	  from salaries s) a
join salaries s
join employees e on e.emp_no = s.emp_no
	and e.gender = 'M';
    
# with cte_name_1 as (select..., from...),
#		cte_name_2 as (select..., from...)
# select...
# from cte_name_1
# join cte_name_2;

# Temporaty Table
# create temporary table temporary_table_name
# select...
# from...;

# drop table if exists temporary_table_name;

create temporary table f_highest_salaries
select max(s.salary) as f_highest_salary, s.emp_no
from salaries s
join employees e on e.emp_no = s.emp_no
	and e.gender = 'F'
group by s.emp_no;

create temporary table male_max_salaries
select s.emp_no, max(s.salary) as m_highest_salary
from salaries s
join employees e on e.emp_no = s.emp_no	
	and e.gender = 'M'
group by s.emp_no;

select * from male_max_salaries;

drop table if exists f_highest_salaries;

create temporary table f_highest_salaries
select max(s.salary) as f_highest_salary, s.emp_no
from salaries s
join employees e on e.emp_no = s.emp_no
	and e.gender = 'F'
group by s.emp_no
limit 10;

select * from f_highest_salaries
union
select * from f_highest_salaries;
# error 1137 >>> using a cte

create temporary table dates
select
	now() as current_date_and_time,
    date_sub(now(), interval 1 month) as a_month_earlier,
    date_sub(now(), interval -1 year) as a_year_later;

drop table if exists dates;

create temporary table dates
select
	now() as current_date_and_time,
    date_sub(now(), interval 2 month) as earlier_month_date_and_time,
    date_sub(now(), interval -2 year) as later_year_date_and_time;

select * from dates;

with cte as (select now(),
			 date_sub(now(), interval 2 month) as earlier_month_date_and_time,
             date_sub(now(), interval -2 year) as later_year_date_and_time
			)
select * from dates d1 join cte c;

with cte as (select now(),
			 date_sub(now(), interval 2 month) as earlier_month_date_and_time,
             date_sub(now(), interval -2 year) as later_year_date_and_time
			)
select * from dates
union select * from cte;

drop table if exists male_max_salaries;
drop table if exists dates;
