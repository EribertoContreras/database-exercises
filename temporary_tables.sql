use jemison_1754;

		#name here'_______'.employees_with_departments_with_salaries

-- 1)Using the example from the lesson, create a temporary table called employees_with_departments that contains first_name, last_name, and dept_name for employees currently with that department. Be absolutely sure to create this table on your own database. If you see "Access denied for user ...", it means that the query was attempting to write a new table to a database that you can only read.

CREATE TEMPORARY TABLE employees_with_departments AS
SELECT employees.first_name, employees.last_name, departments.dept_name
FROM employees.employees
JOIN employees.dept_emp on(dept_emp.emp_no = employees.emp_no)
JOIN employees.departments on(departments.dept_no = dept_emp.dept_no)
LIMIT 100;

select * from employees_with_departments;
show create table employees_with_departments;-- this helps bring out the count for varchar 

#a Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns
#b Update the table so that full name column contains the correct data
#c Remove the first_name and last_name columns from the table.
#d What is another way you could have ended up with this same table?

#a
ALTER TABLE employees_with_departments ADD full_name VARCHAR(30);

#b
UPDATE employees_with_departments
SET full_name
= CONCAT(first_name,' ', last_name);

#c
ALTER TABLE employees_with_departments drop first_name;
ALTER TABLE employees_with_departments drop last_name;
#d
-- SELECT concat(employees.first_name, ' ', employees.last_name) as full_name, departments.dept_name......

/*.   !!!!!!!
DELETE FROM my_numbers WHERE n % 2 = 0;

drop table employees_with_departments; #this helps delete everything !!!!!!!!
																*/ 


-- 2)Create a temporary table based on the payment table from the sakila database.Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.
use sakila;
describe sakila.payment;

CREATE TEMPORARY TABLE jemison_1754.integers_representing_cents AS
SELECT payment_id, customer_id, amount
FROM payment
where amount
limit 100;

show create table jemison_1754.integers_representing_cents; #friend !!!!!!!! to look up info.

alter table jemison_1754.integers_representing_cents modify amount decimal (6, 2);

alter table jemison_1754.integers_representing_cents modify amount integer;

UPDATE jemison_1754.integers_representing_cents
SET amount = amount * 100;

#updating is changing the value
#altering is changing the view like a suit.


select * from payment where amount like '%%';
select * from jemison_1754.integers_representing_cents;

'integers_representing_cents', 'CREATE TEMPORARY TABLE `integers_representing_cents` (\n  `payment_id` smallint unsigned NOT NULL DEFAULT \'0\',\n  `customer_id` smallint unsigned NOT NULL,\n  `amount` decimal(5,2) NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci'


-- 3)Find out how the current average pay in each department compares to the overall, historical average pay. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department right now to work for? The worst?
use jemison_1754;
use employees;

select * from employees;

CREATE TEMPORARY TABLE avg_data as
SELECT * FROM employees JOIN salaries USING(dept_name);


select salary, (select avg(salary) from salaries)
from salaries
join dept_emp using(emp_no)
join departments using (dept_no)
where salaries.to_date > now()
order by dept_name;


# teacher code


