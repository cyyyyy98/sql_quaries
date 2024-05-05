show VARIABLES like 'max_join_size';
show VARIABLES like 'max_connections';

# Triggers
USE employees;

COMMIT;

# before insert
delimiter $$
create trigger before_salaries_insert
before insert on salaries
for each row
begin
if new.salary < 0 then
set new.salary = 0;
end if;
end $$
delimiter ;

select *
from salaries
where emp_no = '10001';

insert into salaries values ('10001',-92891,'2010-06-22','9999-01-01');

delimiter $$
create trigger before_salaries_update
before update on salaries
for each row
begin
if new.salary < 0 then
set new.salary = old.salary;
end if;
end$$
delimiter ;

update salaries
set salary = 98765
where emp_no = '10001' and from_date = '2010-06-22';

select *
from salaries
where emp_no = '10001'and from_date = '2010-06-22';

update salaries
set salary = -50000
where emp_no = '10001' and from_date = '2010-06-22';

select sysdate();
select date_format(sysdate(), '%y-%m-%d') as today;

delimiter $$
create trigger trig_ins_dept_mng
after insert on dept_manager
for each row
begin
declare v_curr_salary int;
select max(salary)
into v_curr_salary
from salaries
where emp_no = new.emp_no;
if v_curr_salary is not null then
update salaries
set to_date = sysdate()
where emp_no = new.emp_no and to_date = new.to_date;
insert into salaries
values (new.emp_no, v_curr_salary + 20000, new.from_date, new.to_date);
end if;
end$$
delimiter ;

insert into dept_manager values ('111534','d009',date_format(sysdate(), '%Y-%m-%d'),'999-01-01');
update salaries
set to_date = '9999-01-01'
where emp_no = '111534' and from_date = '2024-03-11';

select *
from dept_manager
where emp_no = 111534;

select *
from salaries
where emp_no = 111534;

rollback;

commit;

delimiter $$
create trigger trig_hire_date  
before insert on employees
for each row
begin
if new.hire_date > date_format(sysdate(), '%Y-%m-%d') then
set new.hire_date = date_format(sysdate(), '%Y-%m-%d'); 
end if;
end $$
delimiter ;

insert employees values ('999904', '1970-01-31', 'John', 'Johnson', 'M', '2025-01-01');
select *
from employees
order by emp_no desc;


# Indexes
select *
from employees
where hire_date > '2000-01-01';

create index i_hire_date on
employees (hire_date);

select *
from employees
where first_name = 'Georgi' and last_name = 'Facello';

create index i_composite on
employees (first_name, last_name);

show index from employees from employees;

alter table employees
drop index i_hire_date;

select *
from salaries
where salary > 89999;

create index i_salary on
salaries (salary);


# Case
select 
	emp_no,
    first_name,
    last_name,
    case
		when gender = 'M' then 'Male'
        else 'Female'
	end as gender
from employees;

select
	emp_no,
    first_name,
    last_name,
    case gender
		when 'M' then 'Male'
        else 'Female'
	end as gender
from employees;

select
	emp_no,
    first_name,
    last_name,
	if(gender = 'M','Male','Female') as gender
from employees;

select
	e.emp_no,
    e.first_name,
    e.last_name,
    case
		when dm.emp_no is not null then 'Manager'
        else 'Employee'
	end as is_manager
from employees e
left join dept_manager dm on dm.emp_no = e.emp_no
where e.emp_no > 109990;

select
	 e.emp_no,
     e.first_name,
     e.last_name,
     case
		when dm.emp_no is not null then 'Manager'
        else 'Employee'
	end as is_manager
from employees e
left join dept_manager dm on dm.emp_no = e.emp_no
where e.emp_no > 109990;

select
	e.emp_no,
    e.first_name,
    e.last_name,
    max(s.salary)-min(s.salary) as salary_diff,
    case
		when max(s.salary)-min(s.salary) > 30000 then
        'Salary was raised by more than $30,000'
        else 'Not'
	end as salary_raise
from dept_manager dm
left join employees e on e.emp_no = dm.emp_no
join salaries s on s.emp_no = dm.emp_no
group by s.emp_no;

select
	e.emp_no,
    e.first_name,
    e.last_name,
    case
		when max(de.to_date) > sysdate() then
        'still employed'
        else 'not employee anymore'
	end as current_employee
from employees e
join dept_emp de on de.emp_no = e.emp_no
group by de.emp_no
limit 100;