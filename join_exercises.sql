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
  




#3
-- Find the name of all departments currently managed by women.

SELECT CONCAT(first_name, ' ', last_name) AS 'Department Manager', departments.dept_name as 'Department Name'
FROM employees
JOIN dept_manager as manager
  ON employees.emp_no = manager.emp_no
JOIN departments
  on departments.dept_no = manager.dept_no
where gender like 'F' and to_date > now();


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
where dept_manager.to_date > now()
and salaries.to_date > now()
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


-- 11 Bonus Find the names of all current employees, their department name, and their current manager's name.

SELECT CONCAT(emplyee.first_name, ' ', employee.last_name) AS 'Current Employees', departments.dept_name as 'Department Name', CONCAT(first_name, ' ', last_name) AS 'Department Manager'
FROM employees
JOIN dept_emp as employees
  ON employees.emp_no = emplyees.emp_no
JOIN departments
  on departments.dept_no = manager.dept_no
  JOIN dept_manager as manager
  ON employees.emp_no = manager.emp_no
  group by department_name;




-- 12 Bonus Who is the highest paid employee within each department?????
