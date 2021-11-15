# Pewlett-Hackard-Analysis

## Overview of Analysis
Pewlett Hackard Company has hired out the task of determining the impact of a retirement package that will be offered to their employees. The company would like to know how many employees are eligible for retirement under the set guidelines and the number of employees available for a mentorship program. This analysis will guide you through the steps of the process and the recommendations for the program.

The retirement criteria for the employees are set as any employee that was born between the dates of January 1, 1952 and December 31, 1955.

The mentorship eligibility is granted to employees that were born between the dates of January 1, 1965 and December 31, 1965.

## Procedures
### Create a Database Table Containing the Number of Retiring Employees.
1. Create a query to extract employee number, first name and last name from the Employees table.
2. Add the work title, title start date and title end date extracted from the Titles table.
3. Join the Employee table and the Titles table using the primary key emp_no.
4. Filter the data on the employees' birth date to retrieve only the employees that were born between 1952 and 1955.
5. Filter the data on to_data column on the Titles table to get the current employees.
6. Order the data in ascending order of the employee number.
7. Save the data into a database table named **retirement_titles**.
8. Export the Retirement Titles data into a comma separated values file, retirement_titles.csv for future use.
9. Write a second query to retrieve the first name, last name and the title columns from the Retirement Titles table.
10. Use the **DISTINCT ON** statement to retrieve the first occurrence of the employee number for each set of rows defined by the **ON ()** clause.
11. Save the extracted data into a database table named **unique_titles**.
12. Export the data into a comma separated values file, unique_titles.csv for later use.
13. Write a third query to retrieve the number of employees by their most recent job title.
14. Retrieve the **COUNT** of employees by groupings of title.
15. Sort the data in descending order of the count.
16. Save the data into a database table named **retiring_titles**.
17. Export the data into a comma separated values file, retiring_titles.csv to be presented to management.

### Provide a List of Employees Eligible for the Mentorship Program.
1. Retrieve the employee number, first name, last name, and birth date columns form the Employees table.
2. Retrieve the department start date and department end date columns form the Departments table.
3. Retrieve the title column from the Titles table.
4. Use the **DISTINCT ON** statement to retrieve the first occurrence of the employee number for each set of rows defined by the **ON ()** clause.
5. Join the Employees and Department Employee tables on the primary key emp_no.
6. Join the Employees and the Titles tables on the primary key emp_no.
7. Set a filter on to_date column of Department Employee table to limit the dataset to the current employees.
8. Set a second filter on the birth_date column of the Employees tables to restrict the data to include employees born in 1965.
9. Sort the result set in ascending order of the employee number.
10. Save the data into a database table named **mentorship_eligibility**.
11. Export the data into a comma separated values file, mentorship_eligibility.csv for future reference.

## Results
- Retirement Titles: Two tables, Employees and Titles were joined to produce the list of retirement eligible employees and their titles. This list contained 133,776 entries which included multiple titles for some employees who had held more than one title during their careers at Pewlet Hackard.  Further refinement was needed. A sample of the table contents is shown below. The blue highlights show the duplicates and the red highlights a record that is of an employee no longer at Pewlett Hackard.

Sample - Retirement Titles Table
![Retirement_Titles_Content](Images/retirement_titles_content.png)

- Unique Titles: The refined query returned 90,398 unique entries. Closer examination of the Unique Titles data revealed that the dataset still included some records of employees that were no longer employed at Pewlett Hackard. Further refinement was done to the dataset by filtering the Retirement Titles data by limiting the to_date column to only retrieve the most current title by setting the value to be 9999-01-01. The adjusted final count of retirement eligible employees is now at 72,458.

Unique Titles Table Contents (Pre to_date Filter)
![Unique_Titles_Content_Unclean](Images/unique_no_filter.png)

Unique Titles Table Contents (Post to_date Filter)
![Unique_Titles_Content_Clean](Images/unique_with_filter.png)

Retiring Titles: A summary breakdown of the retirement eligible employees are shown below. As you can see, the refined data in this report is different than the module summary capture image.

Module Summary Capture Image
![Module_Summary_Capture](Images/module_summary_capture.png)

Retiring Titles Summary
![Retiring_Titles_Summary](Images/retiring_titles.png)

- Mentorship Program Eligibility: A total count of 1,549 employees are eligible to participate in the mentorship program.

## Summary
- How many roles will need to be filled as the "silver tsunami" begins to make an impact?
    - If all who are eligible for retirement would proceed, a total of 72,458 roles will be left open.

- Are there enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees?
    - A summary of the breakdown of retirement eligible employees by department and mentorship eligible employees by department are shown below. According to the Retirement Eligible Employees by Department data, yes there is enough qualified retirement-ready employees to mentor the next generation.

Retirement Eligible Employees by Department
![Retiring_by_Department](Images/retiring_by_dept.png)

Mentorship Eligible Employees by Department
![Mentorship_by_Department](Images/mentees_by_dept.png)

- The querries for the count of retiring and mentorship eligible employees by department cam be found at Employee_Database_Challenge [Employee_Database_Queries](Queries/Employee_Database_Challenge.sql)