USE employees;

SELECT first_name, last_name
FROM employees
ORDER BY last_name;

SELECT first_name, last_name
FROM employees
ORDER BY last_name DESC;

SELECT first_name, last_name
FROM employees
ORDER BY last_name ASC;

DESCRIBE employees;

#2 Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?

SELECT first_name, last_name
FROM employees
WHERE first_name = 'Irena' OR first_name = 'Vidya' OR first_name ='Maya' ORDER BY first_name;

-- Irena(first_name) Reutenauer(last_name) is the first name on list.  Vidya(first_name) Simmen(last_name) is last person on lit. 

#3Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name and then last name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?

SELECT *
FROM employees
WHERE first_name = 'Irena' OR first_name = 'Vidya' OR first_name ='Maya' ORDER BY first_name, last_name;

-- What was the first and last name in the first row of the results? Irena(first_name) Acton(last_name)
-- What was the first and last name of the last person in the table? Vidya(first_name) Zweizig(last_name)

#4Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by last name and then first name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?

SELECT *
FROM employees
WHERE first_name = 'Irena' OR first_name = 'Vidya' OR first_name ='Maya' ORDER BY last_name, first_name;

-- What was the first and last name in the first row of the results? Irena Acton
-- What was the first and last name of the last person in the table? Maya Zyda

#5Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their employee number. Enter a comment with the number of employees returned, the first employee number and their first and last name, and the last employee number with their first and last name.

SELECT *
FROM employees
WHERE last_name LIKE 'E%E' ORDER BY emp_no;

-- the first employee number and their first and last name: 10021, Ramzi Erde
-- the last employee number with their first and last name: 499648, Tadahiro Erde

#6Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their hire date, so that the newest employees are listed first. Enter a comment with the number of employees returned, the name of the newest employee, and the name of the oldest employee.

SELECT *
FROM employees
WHERE last_name LIKE 'E%E' AND '1%9-%-%' ORDER BY hire_date DESC;

-- Enter a comment with the number of employees returned: 899
-- he name of the newest employee: Teiji(first_name) Eldridge(last_name)
-- the name of the oldest employee: Sergi(first_name) Erde(last_name)

 #Find all employees hired in the 90s and born on Christmas. Sort the results so that the oldest employee who was hired last is the first result. Enter a comment with the number of employees returned, the name of the oldest employee who was hired last, and the name of the youngest employee who was hired first.
 
 SELECT *
FROM employees
WHERE hire_date 
LIKE '199%'
AND birth_date
LIKE '%-12-25'
ORDER BY birth_date, hire_date DESC;

-- Enter a comment with the number of employees returned: 362
-- he name of the oldest employee who was hired last: Tremaine Eugenio
-- the name of the youngest employee who was hired first: Gudjon Vakili