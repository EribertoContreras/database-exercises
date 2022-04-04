use employees;
-- substring 
SELECT concat(substring(first_name,1,1), last_name) as username from employees;

-- replace (lower case and higher case does matter)
SELECT REPLACE('abcsdefg', 'abc', '123');

-- date time functions 
-- https://dev.mysql.com/doc/refman/5.7/en/date-and-time-functions.html


-- we can get the day or the month name of the week from the a date (or string that matches the data format)

SELECT dayname("1991-06-14");
SELECT monthname("2022-03-31");

-- current date, time stamp

SELECT curdate();
SELECT current_time();
SELECT current_timestamp;

-- how long has it been sice each employees original hire date and today?

SELECT 
    *, DATEDIFF(CURDATE(), hire_date) / 365 AS tenure
FROM
    employees;

-- unix time is the number of seconds since 1970-01-01
SELECT UNIX_TIMESTAMP('1971-01-01');

-- we can add our function outputs as new columns onto existing outpute e.g days someone was born.

SELECT 
    *, DAYNAME(birth_date) AS day_of_birth
FROM
    employees;

-- numeric/aggregate funcitons e.g min, max, avereage, stddev, count, sum etc.

SELECT 
    AVG(salary), MIN(salary), MAX(salary), STDDEV(salary)
FROM
    salaries;


#group by functions


-- what are the salary statistics for each employee

SELECT 
    AVG(salary), MAX(salary), MIN(salary), COUNT(salary)
FROM
    salaries;

-- group by 

SELECT 
    gender
FROM
    employees
GROUP BY gender;

SELECT 
    first_name
FROM
    employees
GROUP BY first_name;

-- group can only contain the columns by which you group by + some aggregation 
-- of other bariables/columns

-- always add an agregation like ---(to_date) to make it function.
SELECT 
    emp_no, AVG(salary), MIN(to_date)
FROM
    salaries
GROUP BY emp_no;

#is the average salary different for different genders:

SELECT 
    gender, AVG(salary), STDDEV(salary)
FROM
    employees
        JOIN
    salaries USING (emp_no)
GROUP BY gender;

#stddev means difference from average between two subjects

-- having 

select emp_no, avg(salary) as avg_salary from salaries
group by emp_no
having avg_salary > 50000;

select * from employees
where gender = 'F';

select last_name, count(*) as n_same_last_name
from employees
group by last_name
having n_same_last_name < 150;

important


CREATE TABLE quotes (
    id INT NOT NULL AUTO_INCREMENT,
    author VARCHAR(50) NOT NULL,
    content VARCHAR(240) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE authors (
    id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE (first_name, last_name)
);


use employees;
describe employees;
show create table employees;

create table 'employees' (
	'emp_no' int not null,
    'bith_date' date not null,
    'first_name' varchar(14) not null,
    'last_name' varchar(16) not null,
    'gender' enum('M', 'F') not null,
    'hire_date' date not null,
    primary key ('emp_no')
    ) engine=innoDB default CHARSET=latin1;
    
    
    #1
Use employees;
describe employees;
describe dept_manager;
describe dept;
#2
-- Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.

#my code

SELECT CONCAT(first_name, ' ', last_name) AS 'Department Manager', departments.dept_name as 'Department Name'
FROM employees
JOIN dept_manager as manager
  ON employees.emp_no = manager.emp_no
JOIN departments
  on departments.dept_no = manager.dept_no;
  
#teacher codes


#3
-- Find the name of all departments currently managed by women.

SELECT CONCAT(first_name, ' ', last_name) AS 'Department Manager', departments.dept_name as 'Department Name'
FROM employees
JOIN dept_manager as manager
  ON employees.emp_no = manager.emp_no
JOIN departments
  on departments.dept_no = manager.dept_no
where gender like 'F';


-- 
#4
-- Find the current titles of employees currently working in the Customer Service department.


select titles.title, count(*) #titles of employees first and then, total count
from titles #from titles of area since we are already using emplyees
join dept_emp on titles.emp_no = dept_emp.emp_no #we are joining department employees to the employee numbers under titles as dept_emp.emp_no. combing it as one 
join departments on dept_emp.dept_no = departments.dept_no # adding on and combining to create a smalled name 
where titles.to_date = '9999-01-01' #giving it a range of up to date info for titles themselves
  and dept_emp.to_date = '9999-01-01' #giving dept_emp up to date info for current
and departments.dept_name = 'Customer Service' #specifying which title we are pulling up.
group by titles.title;




#5
-- Find the current salary of all current managers.

  
  select departments.dept_name as 'Department Name',
       concat(employees.first_name, ' ', employees.last_name) as 'Name',
       salaries.salary as 'Salary' #writing the foundation
from departments #location
join dept_manager on departments.dept_no = dept_manager.dept_no
join employees on dept_manager.emp_no = employees.emp_no
join salaries on employees.emp_no = salaries.emp_no
where dept_manager.to_date = '9999-01-01'
and salaries.to_date = '9999-01-01'
order by departments.dept_name;


#6
-- Find the number of current employees in each department.
SELECT 
    d.dept_no AS 'dept_no',
    d.dept_name AS 'dept_name',
    COUNT(*) AS 'num_employees'
FROM
    departments AS d
        JOIN
    dept_emp de ON de.dept_no = d.dept_no
WHERE
    de.to_date > NOW()
GROUP BY d.dept_name, d.dept_no
ORDER BY d.dept_no;

#7
-- Which department has the highest average salary? Hint: Use current not historic information.

SELECT 
    d.dept_name AS 'dept_name', AVG(s.salary) AS 'salary'
FROM
    departments d
        JOIN
    dept_emp de ON d.dept_no = de.dept_no
        JOIN
    salaries s ON de.emp_no = s.emp_no
WHERE
    de.to_date > NOW() AND s.to_date > NOW()
GROUP BY d.dept_name
ORDER BY AVG(s.salary) DESC
LIMIT 1;

#8
-- Who is the highest paid employee in the Marketing department?

SELECT 
    e.first_name, e.last_name
FROM
    departments d
        JOIN
    dept_emp de ON d.dept_no = de.dept_no
        JOIN
    employees e ON de.emp_no = e.emp_no
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    d.dept_name = 'Marketing'
        AND de.to_date > NOW()
        AND s.to_date > NOW()
ORDER BY s.salary DESC
LIMIT 1;

#9
-- Which current department manager has the highest salary?

SELECT 
    e.first_name, e.last_name, s.salary, d.dept_name
FROM
    departments d
        JOIN
    dept_manager dm ON d.dept_no = dm.dept_no
        JOIN
    employees e ON dm.emp_no = e.emp_no
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    dm.to_date > NOW() AND s.to_date > NOW()
ORDER BY s.salary DESC
LIMIT 1;


#10
-- Determine the average salary for each department. Use all salary information and round your results.

SELECT 
     d.dept_name AS 'dept_name', round(AVG(s.salary)) AS 'salary'
FROM
    departments d
        JOIN
    dept_emp de ON d.dept_no = de.dept_no
        JOIN
    salaries s ON de.emp_no = s.emp_no
GROUP BY d.dept_name
ORDER BY AVG(s.salary) DESC;


-- Bonus Find the names of all current employees, their department name, and their current manager's name.

SELECT CONCAT(e.first_name, ' ', e.last_name) AS 'Employee Name', d.dept_name AS 'Department Name', CONCAT(e.first_name, ' ', e.last_name) AS 'Manager Name' FROM departments d
JOIN dept_emp de ON d.dept_no = de.dept_no
JOIN employees e ON de.emp_no = e.emp_no
JOIN dept_manager dm ON d.emp_no = dm.emp_no
JOIN employees e2 ON dm.emp_no = e.emp_no
GROUP BY CONCAT(e.first_name, ' ', e.last_name), d.dept_name;