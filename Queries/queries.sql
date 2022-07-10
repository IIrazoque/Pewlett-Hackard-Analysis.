SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

--three more queries for 1953,1954, 1955 
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';

--Retirement eligibility 
SELECT first_name, last_name
FROM  employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31' )
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--Number of employees retiring 
SELECT COUNT (first_name)
FROM  employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31' )
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--export retirement eligibility
SELECT first_name, last_name
INTO retirement_info
FROM  employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31' )
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info;

-- update the retirement_info table to include emp_no
DROP TABLE retirement_info;

SELECT emp_no, first_name, last_name
INTO retirement_info
FROM  employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31' )
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--check the table
SELECT * FROM retirement_info

--Joining departments and dept_manager tables
SELECT d.dept_name,
    dm.emp_no,
    dm.from_date,
    dm.to_date
    
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no

--joining retirement_info and dept_emp Tables
SELECT retirement_info.emp_no,
    retirement_info.first_name,
retirement_info.last_name,
    dept_employees.to_date
FROM retirement_info
LEFT JOIN dept_employees
ON retirement_info.emp_no = dept_employees.emp_no;

--joining retirement_info and dept_emp Tables
SELECT ri.emp_no,
    ri.first_name,
    ri.last_name,
de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_employees as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

-- Employee count by department number
SELECT COUNT (ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_employees as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;