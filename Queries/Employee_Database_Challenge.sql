-- Deliverable 1
-- The Number of Retiring Employees by Title
-- Creating the Retirement_Titles table
SELECT
	em.emp_no,
	em.first_name,
	em.last_name,
	ti.title,
	ti.from_date,
	ti.to_date
INTO Retirement_Titles
FROM
	employees AS em
	INNER JOIN
		titles AS ti
		ON em.emp_no = ti.emp_no
WHERE
	em.birth_date BETWEEN '1952-01-01'
	AND '1955-12-31'
ORDER BY
	em.emp_no;
	

-- Creating the Unique_Titles table
-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) 
emp_no,
first_name,
last_name,
title
INTO Unique_Titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;


-- Creating the Retiring_Titles table
SELECT
	COUNT(title) as "count",
	title
INTO Retiring_Titles
FROM
	unique_titles
GROUP BY
	title
ORDER BY
	"count" DESC;
	
	
-- Deliverable 2
-- The Employees Eligible for the Mentorship Program
SELECT DISTINCT ON (em.emp_no)
	em.emp_no,
	em.first_name,
	em.last_name,
	em.birth_date,
	de.from_date,
	de.to_date,
	ti.title
INTO Mentorship_Eligibility
FROM
	employees as em
	INNER JOIN
		dept_emp as de
		ON em.emp_no = de.emp_no
	INNER JOIN
		titles as ti
		ON em.emp_no = ti.emp_no
WHERE
	de.to_date = '9999-01-01'
	AND em.birth_date BETWEEN '1965-01-01'
		AND '1965-12-31'
ORDER BY
	em.emp_no;


-- Additional Data
-- Mentorship Counts by Department
SELECT
	COUNT(me.emp_no) AS emp_count,
	dp.dept_name
FROM
	mentorship_eligibility AS me
	INNER JOIN
		dept_emp AS de
		ON me.emp_no = de.emp_no
		AND de.to_date = '9999-01-01'
	INNER JOIN
		departments AS dp
		ON de.dept_no = dp.dept_no
GROUP BY
	dp.dept_name
ORDER BY
	emp_count DESC;


-- Retirement Count by Department
SELECT
	rt.first_name,
	rt.last_name,
	dp.dept_name
FROM retirement_titles AS rt
INNER JOIN
	dept_emp AS de
	ON rt.emp_no = de.emp_no
INNEr JOIN
	departments AS dp
	ON de.dept_no = dp.dept_no
WHERE rt.to_date = '9999-01-01'
	AND rt.title = 'Manager';
	
	
-- Retirement by Department
SELECT
	COUNT(em.emp_no) AS emp_count,
	dp.dept_name
FROM
	employees AS em
	INNER JOIN
		dept_emp AS de
		ON em.emp_no = de.emp_no
	INNER JOIN
		departments AS dp
		ON de.dept_no = dp.dept_no
WHERE
	em.birth_date BETWEEN '1952-01-01'
		AND '1955-12-31'
	AND de.to_date = '9999-01-01'
GROUP BY
	dp.dept_name
ORDER BY
	emp_count DESC;