-- create PH employee tables 
CREATE TABLE employees (
	 emp_no INT NOT NULL,
     birth_date DATE NOT NULL,
     first_name VARCHAR NOT NULL,
     last_name VARCHAR NOT NULL,
     gender VARCHAR NOT NULL,
     hire_date DATE NOT NULL,
     PRIMARY KEY (emp_no));

CREATE TABLE dept_manager (
dept_no VARCHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no));


CREATE TABLE SALARIES (EMP_NO INT NOT NULL,
   SALARY INT NOT NULL,
   FROM_DATE DATE NOT NULL,
   TO_DATE DATE NOT NULL,
 FOREIGN KEY (EMP_NO) REFERENCES EMPLOYEES (EMP_NO),
 PRIMARY KEY (EMP_NO));


CREATE TABLE DEPT_EMPLOYEES (
    DEPT_NO VARCHAR(4) NOT NULL,
    EMP_NO INT NOT NULL,
    FROM_DATE DATE NOT NULL,
    TO_DATE DATE NOT NULL,
FOREIGN KEY (EMP_NO) REFERENCES EMPLOYEES (EMP_NO),
FOREIGN KEY (DEPT_NO) REFERENCES DEPARTMENTS (DEPT_NO),
    PRIMARY KEY (DEPT_NO, EMP_NO));

CREATE TABLE TITLES (EMP_NO INT NOT NULL,
    TITLE VARCHAR NOT NULL,
    FROM_DATE DATE NOT NULL,
    TO_DATE DATE NOT NULL,
FOREIGN KEY (EMP_NO) REFERENCES EMPLOYEES (EMP_NO),
PRIMARY KEY (EMP_NO, TITLE, TO_DATE));

CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name));


SELECT * FROM DEPARTMENTS

ALTER TABLE dept_employees
  ALTER COLUMN dept_no TYPE varchar(10);


-- retirement queries 
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


-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
    retirement_info.first_name,
retirement_info.last_name,
    dept_employees.to_date
FROM retirement_info
LEFT JOIN dept_employees
ON retirement_info.emp_no = dept_employees.emp_no;


-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;


SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;


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
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_employees as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no;

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_employees as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

--look into salaries table
SELECT * FROM salaries
ORDER BY to_date DESC;

-- create a new retirement info table including gender 
SELECT e.emp_no,
    e.first_name,
e.last_name,
    e.gender,
    s.salary,
    de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_employees as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01');

SELECT * FROM emp_info

-- List of managers per department 
SELECT dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
INTO manager_info
FROM dept_manager as dm
    INNER JOIN departments as d
        ON (dm.dept_no = d.dept_no)
    INNER JOIN current_emp as ce
        ON (dm.emp_no = ce.emp_no);
        
        SELECT * FROM manager_info;
        
-- joining Dept_Emp and Departments
SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
INTO dept_info
FROM current_emp as ce
    INNER JOIN dept_employees as de
        ON (ce.emp_no = de.emp_no)
    INNER JOIN departments as d
        ON (de.dept_no = d.dept_no);
        
        SELECT * FROM retirement_info;
        
        
-- sales tables
SELECT ri.emp_no,
    ri.first_name,
ri.last_name,
    d.dept_name
INTO sales_info
FROM retirement_info as ri
    INNER JOIN dept_employees as de
        ON (ri.emp_no = de.emp_no)
    INNER JOIN departments as d
        ON (de.dept_no = d.dept_no)
WHERE (d.dept_name = 'Sales');

SELECT * FROM sales_info;


-- create table to view retirement employees vs titles 
SELECT e.emp_no,
        e.first_name,
        e.last_name,
        tt.title,
        tt.from_date,
        tt.to_date
INTO retirement_titles        
FROM employees as e
INNER JOIN titles as tt
    ON (e.emp_no = tt.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')

-- run to view table
SELECT * FROM  retirement_titles;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
                first_name,
                last_name,
                title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;
-- run to view table
SELECT * FROM unique_titles;


--number of employees by their most recent job title who are about to retire
SELECT COUNT (ut.title), ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY ut.count DESC;
SELECT * FROM retiring_titles;

-- create table that holds the employees who are eligible MSP
SELECT DISTINCT ON (e.emp_no) e.emp_no,
        e.first_name,
        e.last_name,
        e.birth_date,
        de.from_date,
        de.to_date,
        tt.title
INTO mentorship_eligibilty    
FROM employees as e
    INNER JOIN dept_employees as de
        ON (e.emp_no = de.emp_no)
    INNER JOIN titles as tt
        ON (e.emp_no = tt.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
    AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no DESC;

-- run the query 
SELECT * FROM mentorship_eligibilty;