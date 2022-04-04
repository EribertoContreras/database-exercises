use employees;

SELECT emp_no, salary
FROM salaries
WHERE salary > (SELECT AVG(salary) FROM salaries WHERE to_date > CURDATE())
AND to_date > CURDATE();

select round(avg(salary)) from salaries;
#use select feature to find simple answers like avereage salary

select emp_no from dept_manager where dept_manager.to_date > now();

select round(avg(salary)) from salaries where to_date > now();

#examples
SELECT emp_no, salary
FROM salaries
WHERE salary > (SELECT AVG(salary) FROM salaries WHERE to_date > CURDATE())
AND to_date > CURDATE();

SELECT emp_no, salary
FROM salaries
WHERE salary > 2 * (SELECT AVG(salary) FROM salaries WHERE to_date > CURDATE())
AND to_date > CURDATE();

SELECT column_a, column_b, column_c
FROM table_a
WHERE column_a IN (
    SELECT column_a
    FROM table_b
); #??????



SELECT 
    first_name, last_name, birth_date
FROM
    employees
WHERE
    emp_no IN (SELECT 
            emp_no
        FROM
            dept_manager)
LIMIT 10;


SELECT first_name, last_name, birth_date
FROM employees
WHERE emp_no = (
    SELECT emp_no
    FROM employees
    WHERE emp_no = 101010
);

SELECT g.birth_date, g.emp_no, g.first_name from
(
    SELECT *
    FROM employees
    WHERE first_name like 'Geor%'
) as g;


SELECT g.first_name, g.last_name, salaries.salary
FROM
    (
        SELECT *
        FROM employees
        WHERE first_name like 'Geor%'
    ) as g
JOIN salaries ON g.emp_no = salaries.emp_no
WHERE to_date > CURDATE();


#exercises

-- 1)Find all the current employees with the same hire date as employee 101010 using a sub-query.
select * from employees where emp_no= 101010;

#answer
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date IN (
SELECT hire_date
FROM employees 
WHERE emp_no='101010');


-- 2)Find all the titles ever held by all current employees with the first name Aamod.

select * from employees where first_name like 'Aamod';

select e.first_name,  t.title
from titles as t
join employees as e on (t.emp_no = e.emp_no)
where e.first_name  = 'Aamod' and to_date > now()
group by title; #simple as grouping how to



-- 3)How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.
select emp_no from dept_emp group by emp_no having max(to_date) < now(); # make sure to max the date.... important

SELECT 
    COUNT(*)
FROM
    employees
WHERE
    emp_no IN (SELECT 
            emp_no
        FROM
            dept_emp
        GROUP BY emp_no
        HAVING MAX(to_date) < NOW());


select distinct emp_no
from employees
where emp_no not in (select distinct emp_no
from dept_emp
where to_date > now());
-- 4)Find all the current department managers that are female. List their names in a comment in your code.
SELECT 
            emp_no
        FROM
            dept_manager

WHERE to_date > NOW();
            
SELECT 
    first_name, last_name
FROM
    employees
WHERE
    emp_no IN (SELECT 
            emp_no
        FROM
            dept_manager

WHERE to_date > NOW()) AND gender = 'F';




-- 5)Find all the employees who currently have a higher salary than the companies overall, historical average salary.
select avg(salary) from salaries; #up to_date salaries code .... 63810.7448

SELECT 
    first_name, last_name, salary
FROM
    employees AS e
        JOIN
    salaries AS s ON (e.emp_no = s.emp_no)
WHERE
    s.salary > (SELECT 
            AVG(salary)
        FROM
            salaries)
        AND s.to_date > NOW();

-- 6)How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?
SELECT MAX(salary)-STDDEV(salary) FROM salaries;


USE employees;
SELECT COUNT(*),
COUNT(*) / (SELECT COUNT(*) FROM salaries WHERE to_date > NOW()) * 100
FROM salaries
WHERE to_date > NOW() AND salary >(SELECT MAX(salary) - STDDEV(salary) FROM salaries);

/* Hint Number 1 You will likely use a combination of different kinds of subqueries.
Hint Number 2 Consider that the following code will produce the z score for current salaries.

-- Returns the historic z-scores for each salary
-- Notice that there are 2 separate scalar subqueries involved
SELECT salary,
    (salary - (SELECT AVG(salary) FROM salaries))
    /
    (SELECT stddev(salary) FROM salaries) AS zscore
FROM salaries;

*/

-- BONUS

-- 1)Find all the department names that currently have female managers.



-- 2)Find the first and last name of the employee with the highest salary.



-- 3)Find the department name that the employee with the highest salary works in.



-- ......