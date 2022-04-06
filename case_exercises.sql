use employees;
#boolean

select
dept_name,
dept_name = 'Research' as is_research
from departments;

#if

select
dept_name,
if(dept_name = 'Research' , 'TRUE', 'FALSE') as is_research
from departments;

select
dept_name,
if(dept_name = 'Research' , 'yes', 'no') as is_research
from departments;

#case-simple

select
	dept_name,
    case dept_name
		when 'Research' then 1
        else 0
	end as is_research
    from departments;
    
#case-complex
    
    SELECT dept_name,
   CASE
       WHEN dept_name IN ('Marketing', 'Sales') THEN 'Money Makers'
       WHEN dept_name like '%research%' or dept_name like '%resources%' then 'People People'
       ELSE 'others'
   END AS department_categories
FROM departments;

#bonus material 

-- Here, I'm building up my columns and values before I group by departments and use an aggregate function to get a count of values in each column.
SELECT
    dept_name,
    CASE WHEN title = 'Senior Engineer' THEN title ELSE NULL END AS 'Senior Engineer',
    CASE WHEN title = 'Staff' THEN title ELSE NULL END AS 'Staff',
    CASE WHEN title = 'Engineer' THEN title ELSE NULL END AS 'Engineer',
    CASE WHEN title = 'Senior Staff' THEN title ELSE NULL END AS 'Senior Staff',
    CASE WHEN title = 'Assistant Engineer' THEN title ELSE NULL END AS 'Assistant Engineer',
    CASE WHEN title = 'Technique Leader' THEN title ELSE NULL END AS 'Technique Leader',
    CASE WHEN title = 'Manager' THEN title ELSE NULL END AS 'Manager'
FROM departments
JOIN dept_emp USING(dept_no)
JOIN titles USING(emp_no);

-- Next, I add my GROUP BY clause and COUNT function to get a count of all employees who have historically ever held a title by department. (I'm not filtering for current employees or current titles.)
SELECT
    dept_name,
    COUNT(CASE WHEN title = 'Senior Engineer' THEN title ELSE NULL END) AS 'Senior Engineer',
    COUNT(CASE WHEN title = 'Staff' THEN title ELSE NULL END) AS 'Staff',
    COUNT(CASE WHEN title = 'Engineer' THEN title ELSE NULL END) AS 'Engineer',
    COUNT(CASE WHEN title = 'Senior Staff' THEN title ELSE NULL END) AS 'Senior Staff',
    COUNT(CASE WHEN title = 'Assistant Engineer' THEN title ELSE NULL END) AS 'Assistant Engineer',
    COUNT(CASE WHEN title = 'Technique Leader' THEN title ELSE NULL END) AS 'Technique Leader',
    COUNT(CASE WHEN title = 'Manager' THEN title ELSE NULL END) AS 'Manager'
FROM departments
JOIN dept_emp USING(dept_no)
JOIN titles USING(emp_no)
GROUP BY dept_name
ORDER BY dept_name;


-- In this query, I filter in my JOINs for current employees who currently hold each title.
SELECT
    dept_name,
    COUNT(CASE WHEN title = 'Senior Engineer' THEN title ELSE NULL END) AS 'Senior Engineer',
    COUNT(CASE WHEN title = 'Staff' THEN title ELSE NULL END) AS 'Staff',
    COUNT(CASE WHEN title = 'Engineer' THEN title ELSE NULL END) AS 'Engineer',
    COUNT(CASE WHEN title = 'Senior Staff' THEN title ELSE NULL END) AS 'Senior Staff',
    COUNT(CASE WHEN title = 'Assistant Engineer' THEN title ELSE NULL END) AS 'Assistant Engineer',
    COUNT(CASE WHEN title = 'Technique Leader' THEN title ELSE NULL END) AS 'Technique Leader',
    COUNT(CASE WHEN title = 'Manager' THEN title ELSE NULL END) AS 'Manager'
FROM departments
JOIN dept_emp
    ON departments.dept_no = dept_emp.dept_no AND dept_emp.to_date > CURDATE()
JOIN titles
    ON dept_emp.emp_no = titles.emp_no AND titles.to_date > CURDATE()
GROUP BY dept_name
ORDER BY dept_name;



#------------------[   Use CASE statements or IF() function to explore information in the employees database.    ]----------------------

-- 1) Write a query that returns all employees, their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.

SELECT DISTINCT emp_no, dept_no, hire_date, dept_emp.to_date, 
	CASE 
		WHEN dept_emp.to_date AND salaries.to_date LIKE '9999-01-01' THEN 1
		ELSE 0
		END AS 'is_current_employee'
FROM employees
JOIN dept_emp USING (emp_no)
JOIN salaries USING (emp_no)
;

SELECT DISTINCT  
	CASE 
		WHEN dept_emp.to_date AND salaries.to_date LIKE '9999-01-01' THEN 1
		ELSE 0
		END AS 'is_current_employee', count(*)
FROM employees
JOIN dept_emp USING (emp_no)
JOIN salaries USING (emp_no)
GROUP BY is_current_employee
;

SELECT *
FROM dept_emp
WHERE to_date LIKE '9999%'
;


-- 2)Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.

SELECT CONCAT(first_name,' ', last_name) AS full_name, 
	CASE 
		WHEN last_name REGEXP '^[A-H]' THEN 'A-H'
		WHEN last_name REGEXP '^[I-Q]' THEN 'I-Q'
		ELSE 'R-Z'
	END AS 'alpha_group'
FROM employees
;

#Gives a count for each group
SELECT  
	CASE 
		WHEN last_name REGEXP '^[A-H]' THEN 'A-H'
		WHEN last_name REGEXP '^[I-Q]' THEN 'I-Q'
		ELSE 'R-Z'
	END AS 'alpha_group', count(*) AS n_emp
FROM employees
GROUP BY alpha_group
;

SELECT *
FROM employees
WHERE last_name REGEXP '^[A-B]'
;

-- 3)How many employees (current or previous) were born in each decade?

SELECT CASE 
	WHEN YEAR(birth_date) BETWEEN 1940 AND 1949 THEN '1940s'
	WHEN YEAR(birth_date) BETWEEN 1950 AND 1959 THEN '1950s'
	WHEN YEAR(birth_date) BETWEEN 1960 AND 1969 THEN '1960s'
	WHEN YEAR(birth_date) BETWEEN 1970 AND 1979 THEN '1970s'
	WHEN YEAR(birth_date) BETWEEN 1980 AND 1989 THEN '1980s'
	WHEN YEAR(birth_date) BETWEEN 1990 AND 1999 THEN '1990s'
    WHEN YEAR(birth_date) BETWEEN 2000 AND 2009 THEN '2000s'
    WHEN YEAR(birth_date) BETWEEN 2010 AND 2019 THEN '2010'
	ELSE 'too young'
END AS 'decade_born', Count(*) AS n_born
FROM employees
GROUP BY decade_born
;

SELECT count(*)
FROM employees
WHERE YEAR(birth_date) BETWEEN 1980 AND 1999
;

SELECT YEAR(birth_date)
FROM employees
;


-- 4)What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?


SELECT DISTINCT CASE
	 WHEN dept_name IN ('research', 'development') THEN 'R&D'
            WHEN dept_name IN ('sales', 'marketing') THEN 'Sales & Marketing' 
            WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
            WHEN dept_name IN ('Finance', 'Human Resources') THEN 'Finance & HR'
            ELSE dept_name
            END AS dept_group, 
     AVG(salary)
FROM departments
JOIN dept_emp USING (dept_no)
JOIN salaries USING (emp_no)
WHERE salaries.to_date > NOW() AND dept_emp.to_date > NOW()
GROUP BY dept_group;


#To compare - regular average by deparment
SELECT dept_name, AVG(salary)
FROM departments
JOIN dept_emp USING (dept_no)
JOIN salaries USING (emp_no)
WHERE dept_emp.to_date > NOW() AND salaries.to_date > NOW()
GROUP BY dept_name
;








