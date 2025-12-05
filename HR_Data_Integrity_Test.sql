create database HR;
use HR;
select * from employees;
select * from departments;
select * from job_roles;
-- ---1.List each employees full name department name and job role--
SELECT 
    CONCAT(e.first_name, ' ', e.last_name) AS full_name,
    d.dept_name,
    jr.job_role
FROM
    employees AS e
        INNER JOIN
    departments AS d ON e.dept_id = d.dept_id
        INNER JOIN
    job_roles AS jr ON e.job_id = jr.job_id;
-- ------Change hire date from text to date------
update employees set hire_date=str_to_date(hire_date,"%d-%m-%Y"); 
-- ----2.show all employees who were hired in last 1 year---
alter table employees add column Full_Name  varchar(40);
update employees set full_name=concat(first_name," ",last_name);
-- ----2.show all employees who were hired in last 1 year---
select full_name,hire_date from employees where year(hire_date)>
(SELECT 
       YEAR(hire_date) AS last_year
FROM
    employees
GROUP BY last_year
ORDER BY last_year DESC limit 1 offset 1);
-- ----------------------------------------------    
select max(hire_date) from employees;
select hire_date from employees order by hire_date desc limit 1;
-- - ------------------------------
-- ----Find employees who dont have any manager assigned--
select * from employees where manager_id is null or trim(manager_id)='';
-- ----3.Display employee name, manager name and department--- 
SELECT 
    e.emp_id,
    m.manager_id,
    e.full_name AS employee_name,
    m.full_name AS manager_name,
    dept_name AS department_name
FROM
    employees AS e
        LEFT JOIN
    employees AS m ON e.manager_id = m.emp_id
        LEFT JOIN
    departments AS d ON e.dept_id = d.dept_id;
--  ---4.list all employee whose salary is above 80,000---- 
select e.full_name,s.salary_amount from employees as e
inner join salaries as s
on
e.emp_id = s.emp_id
where salary_amount>80000;
-- ---6.Find total number of employee in each department----
select count(e.emp_id) as total_employee ,d.dept_name  from employees as e 
right join 
departments as d
on
e.dept_id=d.dept_id
group by d.dept_name
order by count(e.emp_id) desc;
-- ----7.Show the average age of employee per department----
select avg(e.age) as average_age,d.dept_name from employees as e 
inner join
departments as d 
on e.dept_id=d.dept_id
group by d.dept_name
order by avg(e.age) desc;
-- ----8.Find the department with the highesh total salary---
select sum(e.salary) as max_salary,d.dept_name 
from employees as e
right join departments as d on e.dept_id=d.dept_id
group by dept_name
order by max_salary desc limit 1; 
-- -----9.Count how many departments have more than 10 employee----
select count(*) as number_of_employee,d.dept_name from employees as e 
right join 
departments as d on d.dept_id=e.dept_id 
group by d.dept_name
having number_of_employee>10;
-- ------10.list all the departments that have employees with excellent performance-----------
select d.dept_name,p.performance_score from employees as e 
inner join
performance as p on e.emp_id=p.emp_id 
inner join
departments as d on d.dept_id=e.dept_id
group by d.dept_name,p.performance_score
having  p.performance_score in ("Excellent");
-- -----11.show total and average salary by department---
select sum(e.salary) as total_salary,avg(e.salary) as avg_salary,d.dept_name from employees as e 
left join
departments as d on e.dept_id=d.dept_id
group by d.dept_name;
-- -----12.Find the top 5 highest paid employee-----
select emp_id,full_name,salary from employees 
order by salary desc limit 5 ;
-- -----13.Show salary trend by year for each employee---
select e.emp_id,s.salary_amount,s.`year`  from employees as e
left join salaries as s on e.emp_id=s.emp_id
group by e.emp_id,s.salary_amount,s.`year`
order by e.emp_id asc,s.year desc;
-- -----14.Find employees whoose salary is higher than their job levels average----
select e.emp_id,e.salary,jr.job_level,jr.job_level from employees as e
join 
job_roles as jr on e.job_id=jr.job_id
where
 e.salary>(
		select avg(e2.salary) from employees as e2 
        join job_roles as jr2 on jr2.job_id = e2.job_id
        where jr2.job_level=jr.job_level);		
-- ----16.count how many employees fall in each performance category in last year-----
select count(e.emp_id),p.performance_score from employees as e 
join performance as p on e.emp_id=p.emp_id
where p.year = (select max(p.year) from performance)
group by p.performance_score 
order by count(e.emp_id) desc;
-- ---------17.find top performing employees in each department----------------
select e.emp_id,e.full_name,d.dept_name,p.performance_score from departments as d 
join employees as e on e.dept_id=d.dept_id
join performance as p on e.emp_id=p.emp_id
where p.performance_score="Excellent";
-- ----18.show department wise average performance score-------------
select d.dept_name,
	   round(avg(
            case p.performance_score 
				 when "Excellent" then 5
                 when "Good" then 4
                 when "Average" then 3
                 when "Below Average" then 2
                 when "poor" then 1
            end     
	      ),2) as average_performance_score
from departments as d 
join employees as e on e.dept_id=d.dept_id
join performance as p on e.emp_id=p.emp_id
group by d.dept_name
order by average_performance_score desc;










