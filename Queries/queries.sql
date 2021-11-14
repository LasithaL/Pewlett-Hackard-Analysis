-- Querries to check the presence of data in tables
SELECT * FROM departments;

SELECT * FROM dept_emp;

SELECT * FROM dept_manager;

SELECT * FROM employees;

SELECT * FROM salaries;

SELECT * FROM titles;

-- Practice querries
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';

-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Saving the retirement list to a new table
SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info;

DROP TABLE retirement_info;

-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
-- INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Check table
SELECT * FROM retirement_info;

-- Joining departments asn dept_manager tables
SELECT
--	departments.dept_name,
--	dept_manager.emp_no,
--	dept_manager.from_date,
--	dept_manger.to_date
	d.dept_name,
	dm.emp_no,
	dm.from_date,
	dm.to_date
--FROM departments
FROM departments as d
--INNER JOIN dept_manager
INNER JOIN dept_manager as dm
--ON depatment.dept_no = dept_manager.dept_no;
ON d.dept_no = dm.dept_no

-- Joining retirement_info and dept_emp tables
SELECT
--	retirement_info.first_name,
--	retirement_info.last_name,
--	dept_emp.to_date
	ri.first_name,
	ri.last_name,
	de.emp_no
--FROM retirement_info
FROM retirement_info as ri
--LEFT JOIN dept_emp
LEFT JOIN dept_emp as de
--ON retirement_info.emp_no = dept_emp.emp_no;
ON ri.emp_no = de.emp_no;

-- Creating a table with retirment info for current employees
SELECT
	ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

-- Employee count by department number
SELECT 
	COUNT(ce.emp_no), 
	de.dept_no
INTO retirement_by_dept
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

-- Creating the Employee Infomration list list 7.3.5
SELECT
	e.emp_no,
	e.first_name,
	e.last_name,
	e.gender,
	s.salary,
	de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
	AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	AND(de.to_date = '9999-01-01');

-- Creating the manager information
SELECT
	d.dept_no,
	d.dept_name,
	dm.emp_no,
	ce.last_name,
	ce.first_name,
	dm.from_date,
	dm.to_date
INTO manager_info
FROM dept_manager AS dm
	INNER JOIN departments AS d
		ON (dm.dept_no = d.dept_no)
	INNER JOIN current_emp AS ce
		ON (dm.emp_no = ce.emp_no);

-- Creating the depatment information
SELECT
	ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
INTO dept_info
FROM current_emp AS ce
	INNER JOIN dept_emp AS de
		ON (ce.emp_no = de.emp_no)
	INNER JOIN departments AS d
		ON (de.dept_no = d.dept_no);

-- Create Sales department retirement info
SELECT
	emp_no,
	first_name,
	last_name,
	dept_name
FROM dept_info
WHERE dept_name = 'Sales';

-- Create Sales and Development departments retirement info
SELECT
	emp_no,
	first_name,
	last_name,
	dept_name
FROM dept_info
WHERE dept_name IN ('Sales', 'Development');