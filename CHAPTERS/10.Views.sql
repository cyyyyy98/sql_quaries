SELECT 
    *
FROM
    dept_emp;

SELECT 
   emp_no, from_date, to_date, count(emp_no) AS num
FROM
    dept_emp
GROUP BY emp_no
HAVING num > 1;

CREATE VIEW v_dept_emp_latest_date AS
    SELECT 
        emp_no, MAX(from_date) AS from_date, MAX(to_date) AS to_date
    FROM
        dept_emp
    GROUP BY emp_no;
    
CREATE OR REPLACE VIEW v_manager_avg_salary AS
    SELECT 
        ROUND(AVG(salary), 2)
    FROM
        salaries s
            JOIN
        dept_manager m ON s.emp_no = m.emp_no;