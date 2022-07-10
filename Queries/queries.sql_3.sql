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


-- Create sales and development
SELECT ri.emp_no,
    ri.first_name,
ri.last_name,
    d.dept_name
INTO salesdev_info
FROM retirement_info as ri
    INNER JOIN dept_employees as de
        ON (ri.emp_no = de.emp_no)
    INNER JOIN departments as d
        ON (de.dept_no = d.dept_no)
WHERE dept_name IN ('Sales', 'Development');

SELECT * FROM salesdev_info;