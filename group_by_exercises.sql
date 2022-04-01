use employees;
describe employees;

#1Create a new file named group_by_exercises.sql
-- done
#2In your script, use DISTINCT to find the unique titles in the titles table. How many unique titles have there ever been? Answer that in a comment in your SQL file.

SELECT count(distinct title)
from titles;
-- answer is 7

#3Write a query to to find a list of all unique last names of all employees that start and end with 'E' using GROUP BY.
SELECT last_name, COUNT(distinct(last_name))
FROM employees
WHERE last_name LIKE '%E%'
GROUP BY last_name;

#4Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'.

SELECT 
    first_name,
    last_name,
    COUNT(DISTINCT(last_name))
FROM
    employees
WHERE
    last_name LIKE 'E%E'
GROUP BY first_name, last_name;

#5Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code.

SELECT 
    last_name
FROM
    employees
WHERE
    last_name LIKE '%q%'
    and last_name not like '%qu%'
GROUP BY last_name;

#6Add a COUNT() to your results (the query above) to find the number of employees with the same last name.

select last_name, count(last_name)
from employees
group by last_name
having last_name LIKE '%q%'
    and last_name not like '%qu%';

#7Find all all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.

select first_name, gender,
count(*)
from employees
where first_name in ('Irena', 'Vidya', 'Maya')
group by first_name, gender;

#8 Using your query that generates a username for all of the employees, generate a count employees for each unique username. Are there any duplicate usernames? BONUS: How many duplicate usernames are there?

SELECT concat(substr(lower(first_name), 1, 1),
		substr(lower(last_name), 1, 4),
        '_',
        substr(birth_date, 6, 2),
        substr(birth_date, 3, 2)) as username,
	count(*)
from
	employees
group by username
having count(username) > 1
order by count(username);



#9 (extra credit) More practice with aggregate functions:

#etermine the historic average salary for each employee. When you hear, read, or think "for each" with regard to SQL, you'll probably be grouping by that exact column.
#Using the dept_emp table, count how many current employees work in each department. The query result should show 9 rows, one for each department and the employee count.
#Determine how many different salaries each employee has had. This includes both historic and current.
#Find the maximum salary for each employee.
#Find the minimum salary for each employee.
#Find the standard deviation of salaries for each employee.
#Find the average salary for each employee where that average salary is between $80k and $90k.