-- create table the next retiring employees vs titles 
SELECT e.emp_no,
        e.first_name,
        e.last_name,
        tt.title,
        tt.from_date,
        tt.to_date
INTO next_retirement_titles        
FROM employees as e
INNER JOIN titles as tt
    ON (e.emp_no = tt.emp_no)
WHERE (e.birth_date BETWEEN '1956-01-01' AND '1964-12-31')

SELECT * FROM next_retirement_titles;
-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
                first_name,
                last_name,
                title
INTO new_unique_titles
FROM next_retirement_titles
ORDER BY emp_no, to_date DESC;

--create overview table
SELECT COUNT (nut.title), nut.title
INTO upcoming_retiring_titles
FROM new_unique_titles as nut
GROUP BY nut.title
ORDER BY nut.count DESC;

SELECT * FROM upcoming_retiring_titles;