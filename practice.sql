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

SELECT *, datediff(curdate(), hire_date)/365 AS tenure FROM employees;

-- unix time is the number of seconds since 1970-01-01
SELECT unix_timestamp('1971-01-01');

-- we can add our function outputs as new columns onto existing outpute e.g days someone was born.

select *, dayname(birth_date) as day_of_birth from employees;

-- numeric/aggregate funcitons e.g min, max, avereage, stddev, count, sum etc.

select avg(salary), min(salary), max(salary), stddev(salary) from salaries;

