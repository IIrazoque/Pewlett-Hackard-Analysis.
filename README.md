# Pewlett_Hackard_Analysis.

# Overview of the analysis: 
Pewlett Hackard (PH) is a large company with thousands of baby-boomers employees about to retire. As data analyst we are to provided PH retiring numbers. Using PostgresSQL to perform analysis on employee data to retrieve total upcoming retiring employees and mentorship counts.
CSV Files provided in data folder:
•	departments.csv 
•	dept_emp.csv 
•	dept_manager.csv 
•	employees.csv 
•	salaries.csv 
•	titles.csv

Using PostgresSQL queries we determined entity relationship diagram (ERD) in the datasets provided. We labeled primary keys, foreign keys, and data types to show the flow of information between these files. Table  queries found in Queries folder. 

Overview Schema – 

![This is an image](https://github.com/IIrazoque/Pewlett_Hackard_Analysis/blob/6d6e216983ee01ada2b10b57eaa80aa96b9df0a1/EmployeeDB.png)

# Results: 
## Deliverable 1: The Number of Retiring Employees by Title
A query was written to create a “retirement titles” table for employees who are born between January 1, 1952 and December 31, 1955. The employee number, first name, last name was pulled from the “employees” csv and INNER JOIN with attributes (titles, from date, and to date of employment) from the “titles” csv. The ON command was matched on employee number (figure 1). 
We used the SELECT DISTINCT ON command dropped duplicate titles for each employee to only show current roles (previous job titles/roles were dropped) as shown in figure 2. Lastly we created a summary table of unique titles by using the COUNT function and filtering to only show current employees (figure 3).

figure 1. *retirement_titles data table, also saved as a csv file*

![This is an image](https://github.com/IIrazoque/Pewlett_Hackard_Analysis/blob/6d6e216983ee01ada2b10b57eaa80aa96b9df0a1/Images/retirement_titles_table.PNG)

figure 2.  *unique_titles data table showing*

![This is an image]( https://github.com/IIrazoque/Pewlett_Hackard_Analysis/blob/6d6e216983ee01ada2b10b57eaa80aa96b9df0a1/Images/unique_titles_tables.PNG)

figure 3. *retiring_titles table showing an overview of unique job titles of retiring employees in descending order*

![This is an image]( https://github.com/IIrazoque/Pewlett_Hackard_Analysis/blob/6d6e216983ee01ada2b10b57eaa80aa96b9df0a1/Images/retiring_titles_table.PNG)

## Deliverable 2: The Employees Eligible for the Mentorship Program
We then collected numbers of employees eligible for mentorships born in the year of 1965 to compare against total counts of the next retiring generation; employees born between 1956 - 1964. 
To obtain mentorship eligibility data we ran the same query but with current employees born between January 1, 1965 and December 31, 1965. Three datasets “employees”, “dept_employees” and “titles” were used to created the mentorship_eligibility.csv (figure 4). The same query from above was used to create an overview table using the COUNT function  (figure 5). 
We re-factor the query for retiring_titles to create a new table of the “next generation of retiring employees” by changing the born years between 1956 – 1964 figure 6. 

Figure 4. *mentorship_eligibility dataset*

![This is an image]( https://github.com/IIrazoque/Pewlett_Hackard_Analysis/blob/6d6e216983ee01ada2b10b57eaa80aa96b9df0a1/Images/mentorship_eligibility_table.PNG)

Figure 5. *table of eligibility employees for the mentorship program based titles for employees born in year 1965*

![This is an image](https://github.com/IIrazoque/Pewlett_Hackard_Analysis/blob/6d6e216983ee01ada2b10b57eaa80aa96b9df0a1/Images/mentorship_titles_table.PNG)

Figure 6. *next generation of retiring employees born between 1956 – 1964*

![This is an image](https://github.com/IIrazoque/Pewlett_Hackard_Analysis/blob/6d6e216983ee01ada2b10b57eaa80aa96b9df0a1/Images/upcoming_retiring_titles_table.PNG)

Using excel we also create a pivot chart to display job titles of the next retiring generation of employee’s vs employees eligible for the mentorship. In figure 7 we can see a drastic number of employees retiring in blue, compared to those in yellow, employees eligible for the mentorship program. Note there are no “manager” roles eligible in the mentorship. 

Figure 7 . *Retiring Employees vs Employees Eligible for Mentorship chart* 

![This is an image](https://github.com/IIrazoque/Pewlett_Hackard_Analysis/blob/6d6e216983ee01ada2b10b57eaa80aa96b9df0a1/Images/Retiring%20vs%20Elegible.png)

Figure 8. *Pivot table of total counts of the next generation of retiring employees vs employees eligible for the mentorship program*

![This is an image]( https://github.com/IIrazoque/Pewlett_Hackard_Analysis/blob/6d6e216983ee01ada2b10b57eaa80aa96b9df0a1/Images/pivot%20summary.png)

# Summary: 
Based on our analysis we begin to see the “silver tsunami” of retiring employees born between the years 1956 – 1964 totaling  of 207,686 employees. Potential leaving the PW company is critical shortages in staffing if no action is taken. With only 1,549 employees eligible for the mentorship, they’ll need other plans to provide these services to those retiring.

