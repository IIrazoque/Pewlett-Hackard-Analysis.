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
--SELECT * FROM  retirement_titles;

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