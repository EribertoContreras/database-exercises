USE employees;

SELECT *
FROM employees
LIMIT 100;

SELECT * FROM employees WHERE hire_date = '1985-01-01';

SELECT first_name
FROM employees
WHERE first_name LIKE '%sus%';

SELECT DISTINCT first_name
FROM employees
WHERE first_name LIKE '%sus%';

SELECT emp_no, first_name, last_name
FROM employees
WHERE emp_no BETWEEN 10026 AND 10082;

SELECT 
    emp_no, first_name, last_name
FROM
    employees
WHERE
    last_name IN ('Herber' , 'Dredge', 'Lipner', 'Baek');

SELECT emp_no, first_name, last_name
FROM employees
WHERE last_name = 'Baek';

SELECT emp_no, first_name, last_name
FROM employees
WHERE emp_no < 10026;

SELECT emp_no, first_name, last_name
FROM employees
WHERE emp_no <= 10026;

SELECT emp_no, title
FROM titles
WHERE to_date IS NOT NULL;

SELECT emp_no, first_name, last_name
FROM employees
WHERE last_name IN ('Herber','Baek')
  AND emp_no < 20000;
  
  SELECT emp_no, first_name, last_name
FROM employees
WHERE emp_no < 20000
  AND last_name IN ('Herber','Baek')
   OR first_name = 'Shridhar';

SELECT emp_no, first_name, last_name
FROM employees
WHERE emp_no < 20000
  AND (
      last_name IN ('Herber','Baek')
   OR first_name = 'Shridhar'
);

DESCRIBE employees;

-- 2)Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN. Enter a comment with the number of records returned.
SELECT COUNT(first_name)
	FROM employees
    WHERE first_name IN ('Irena', 'Vidya', 'Maya');
    -- count is 709
    
-- 3)Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q2, but use OR instead of IN. Enter a comment with the number of records returned. Does it match number of rows from Q2?
SELECT COUNT(first_name)
FROM employees
WHERE first_name = 'Irena' OR 'Vidya' OR 'Maya';
	-- count is 241, it does not match because it only counts 'Irena'
SELECT COUNT(first_name)
FROM employees
WHERE first_name = 'Irena' OR first_name = 'Vidya' OR first_name ='Maya';
	-- returns 709 (correct way to write it)

-- 4)Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, and who is male. Enter a comment with the number of records returned.
SELECT COUNT(first_name)
FROM employees
WHERE (first_name = 'Irena' OR first_name = 'Vidya' OR first_name ='Maya') AND gender = 'M';
-- count 441

-- 5)Find all current or previous employees whose last name starts with 'E'. Enter a comment with the number of employees whose last name starts with E.
SELECT COUNT(last_name)
	FROM employees
    WHERE last_name LIKE 'E%';
    -- answer is 7330
-- 6)Find all current or previous employees whose last name starts or ends with 'E'. Enter a comment with the number of employees whose last name starts or ends with E. How many employees have a last name that ends with E, but does not start with E?
SELECT *
	FROM employees
    WHERE last_name LIKE '%E' OR last_name LIKE 'E%';
    -- total ending in E = 30723
    SELECT *
		FROM employees 
        WHERE last_name LIKE '%E'
        AND NOT last_name LIKE 'E%';
	--  last name that ends with E, but does not start with E = 23393
    
-- 7)Find all current or previous employees employees whose last name starts and ends with 'E'. Enter a comment with the number of employees whose last name starts and ends with E. How many employees' last names end with E, regardless of whether they start with E?
SELECT *
	FROM employees
    WHERE last_name LIKE '%E';
    -- ending in E = 24292
    
SELECT *
	FROM employees
    WHERE last_name LIKE 'E%' AND last_name LIKE '%E';
    -- answer for ending and starting with E = 899 
    
-- 8)Find all current or previous employees hired in the 90s. Enter a comment with the number of employees returned.
SELECT * FROM employees WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31';
-- number of employees = 135214
    
-- 9)Find all current or previous employees born on Christmas. Enter a comment with the number of employees returned.
SELECT * FROM employees WHERE birth_date LIKE '%-12-25';
-- 842 
-- 10)Find all current or previous employees hired in the 90s and born on Christmas. Enter a comment with the number of employees returned.
SELECT * 
FROM employees 
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
AND birth_date LIKE '%-12-25';
-- answer is 362 

-- 11)Find all current or previous employees with a 'q' in their last name. Enter a comment with the number of records returned.
SELECT *
FROM employees
WHERE last_name lIKE '%q%';
-- answer 1873
-- 12)Find all current or previous employees with a 'q' in their last name but not 'qu'. How many employees are found? 
SELECT *
FROM employees
WHERE last_name lIKE '%q%'
AND NOT last_name LIKE '%qu%';
-- answer is 547 