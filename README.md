# HR_Database_Testing_Project
In this HR Database Testing Project,I created and tested an HR Management System database using MySQL.
The main goal was to validate data, check relationships, and perform business rule testing.
This project simulates an HR system containing tables for:

Employees.

Departments.

Job Roles.

Salaries.

Performance.

**Key SQL Queries & Their Purpose**

✅ Employee full name, department, and job role – tested join accuracy.

✅ Converted hire date from text to date format – validated data type.

✅ Found employees hired in the last 1 year – used date functions.

✅ Listed employees without managers – checked missing data.

✅ Filtered high-salary employees (> ₹80,000) – tested filtering logic.

✅ Counted employees per department – verified grouping logic.

✅ Calculated average age per department – tested aggregation.

✅ Found department with highest salary total – used SUM() and ORDER BY Group By

✅ Listed excellent performers by department – validated performance data.

**Testing Focus**
Data Validation: Making sure each employee is correctly mapped to their department and job role

Business Rule Testing: Checking salary limits, job levels, and hire dates

Null & Boundary Checks: Finding employees without assigned managers

Reporting Validation: Using aggregate queries to confirm totals, averages.

**What I learned**
Through this project, I learned how to:

Validate data accuracy and relationships between multiple tables

Use JOIN, GROUP BY, HAVING, and subqueries for real-time testing

Check business rules using salary, job level, and performance data

Analyze and report employee insights directly from SQL queries




✅ Calculated department-wise average performance score – used CASE and AVG()
