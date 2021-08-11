-- Create a table for current employees eligible for retirement 
SELECT e.emp_no, e.first_name, e.last_name
INTO cr_emp--
FROM employees as e
	LEFT JOIN dept_emp as de
		ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
	AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	AND (de.to_date = '9999-01-01')
	
-- Create a table for titles retiring 
SELECT ce.emp_no, ce.first_name,ce.last_name,ttl.title, ttl.from_date, ttl.to_date, s.salary
--INTO titles_retiring
FROM current_emp as ce
	INNER JOIN titles as ttl 
		ON (ce.emp_no = ttl.emp_no)
	INNER JOIN salaries as s
		ON (ce.emp_no = s.emp_no)
ORDER BY emp_no ASC, to_date DESC;

-- Use Dictinct with Orderby to remove duplicate rows

SELECT DISTINCT ON (ti.emp_no) ti.emp_no,
ti.first_name,
ti.last_name,
ti.title

INTO unique_titles
FROM titles_retiring as ti
ORDER BY emp_no, to_date DESC;

-- Get the number of employees retiring.
SELECT COUNT(ut.emp_no), ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY title
ORDER BY COUNT(title) DESC;