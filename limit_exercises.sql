USE employees;

SELECT emp_no, first_name, last_name
FROM employees
WHERE first_name LIKE 'M%'
LIMIT 10;

SELECT emp_no, first_name, last_name
FROM employees
WHERE first_name LIKE 'M%'
LIMIT 25 OFFSET 50;

#exercises 

SELECT DISTINCT title FROM titles;


#Create a new SQL script named limit_exercises.sql.

#MySQL provides a way to return only unique results from our queries with the keyword DISTINCT. For example, to find all the unique titles within the company, we could run the following query:


SELECT DISTINCT title FROM titles;
#List the first 10 distinct last name sorted in descending order.

#Find all previous or current employees hired in the 90s and born on Christmas. Find the first 5 employees hired in the 90's by sorting by hire date and limiting your results to the first 5 records. Write a comment in your code that lists the five names of the employees returned.

#Try to think of your results as batches, sets, or pages. The first five results are your first page. The five after that would be your second page, etc. Update the query to find the tenth page of results.

#LIMIT and OFFSET can be used to create multiple pages of data. What is the relationship between OFFSET (number of results to skip), LIMIT (number of results per page), and the page number?

SELECT * FROM employees WHERE hire_date LIKE '199%' AND birth_date ORDER BY birth_date, hire_date LIMIT 5;

-- select distinct last_name
-- FROM employees
-- order by
