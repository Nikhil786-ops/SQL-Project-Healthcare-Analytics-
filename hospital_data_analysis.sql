SQL Project: Hospital Data Analysis

Project Overview

- This project demonstrates foundational SQL skills by analyzing a dataset of hospital records. 

  The goal is to extract meaningful insights related to patient demographics,
  
  expenses, and operational efficiency through a series of carefully crafted queries.

# Database Schema and Setup

  The analysis is based on the Hosp_data table, designed to store comprehensive information for each patient record. 
  The table schema is defined below.

-   CREATE TABLE Hosp_data (
    Hospital_Name VARCHAR(255),
    Location VARCHAR(255),
    Department VARCHAR(255),
    Doctors_Count INT,
    Patients_Count INT,
    Admission_Date DATE,
    Discharge_Date DATE,
    Medical_Expenses DECIMAL(10, 2));

  For clarity and consistency, the Location column was renamed to City.

  ALTER TABLE HOSP_DATA
  RENAME COLUMN LOCATION TO CITY;

#  Key Data Queries
   Each query below addresses a specific analytical question, with the results providing insights into the hospitals performance.

1. Total Patient Count

*  This query calculates the total number of patients across all records in the dataset using the SUM aggregate function.

  SELECT SUM(PATIENTS_COUNT) AS TOTAL_PATIENTS
  FROM HOSP_DATA;
  
2. Average Doctors per Hospital

*  his query computes the average number of doctors for each hospital, providing a high-level view of staffing.

   SELECT HOSPITAL_NAME, AVG(DOCTORS_COUNT) 
   AS AVERAGE_NO_DOCTORS
   FROM HOSP_DATA
   GROUP BY HOSPITAL_NAME;

3. Top 3 Departments with the Most Patients

This query identifies the three departments that have treated the highest total number of patients by summing the patient counts and then ordering the results.

Note: The query uses SUM and GROUP BY to correctly aggregate the patient counts for each department before ranking.

SELECT DEPARTMENT, SUM(PATIENTS_COUNT) AS TOTAL_PATIENTS
FROM HOSP_DATA
GROUP BY DEPARTMENT
ORDER BY TOTAL_PATIENTS DESC
LIMIT 3;

4. Hospital with the Maximum Medical Expenses

This query efficiently retrieves the single record with the highest medical expenses by sorting the data in descending order and limiting the result to one row.

SELECT HOSPITAL_NAME, CITY, MEDICAL_EXPENSES
FROM HOSP_DATA
ORDER BY MEDICAL_EXPENSES DESC
LIMIT 1;

5. Average Medical Expenses per Hospital

This query calculates the average medical expenses for each hospital, offering a metric for cost analysis.

SELECT HOSPITAL_NAME, AVG(MEDICAL_EXPENSES) AS AVG_MEDICAL_EXPENSES
FROM HOSP_DATA
GROUP BY HOSPITAL_NAME;

6. Longest Hospital Stay

This query determines the single longest patient stay by subtracting the admission date from the discharge date and finding the maximum value.

Note: The original querys date subtraction is correct for PostgreSQL.

SELECT HOSPITAL_NAME, DEPARTMENT, (DISCHARGE_DATE - ADMISSION_DATE) AS HOSPITAL_STAY
FROM HOSP_DATA
ORDER BY HOSPITAL_STAY DESC
LIMIT 1;

7. Total Patients Treated per City

This query provides a geographical analysis of patient volume by summing the total patients for each city.

SELECT CITY, SUM(PATIENTS_COUNT) AS TOTAL_PATIENTS
FROM HOSP_DATA
GROUP BY CITY
ORDER BY TOTAL_PATIENTS DESC;

8. Average Length of Stay per Department

This query calculates the average patient stay duration, broken down by department.

SELECT HOSPITAL_NAME, department, AVG(DISCHARGE_DATE - ADMISSION_DATE) AS AVG_STAY
FROM HOSP_DATA
GROUP BY HOSPITAL_NAME, DEPARTMENT
ORDER BY AVG_STAY DESC;

9. Department with the Lowest Patient Count

This query identifies the department with the lowest total number of patients.

Note: Similar to query 3, SUM and GROUP BY are used to accurately determine the total patient count for each department before ranking.

SELECT DEPARTMENT, SUM(PATIENTS_COUNT) AS TOTAL_PATIENTS
FROM HOSP_DATA
GROUP BY DEPARTMENT
ORDER BY TOTAL_PATIENTS ASC
LIMIT 1;

10. Monthly Medical Expenses Report

This final query generates a monthly report of total medical expenses. It uses PostgreSQL's TO_CHAR function to group the data by month.

Note: The query uses TO_CHAR because it 's the standard function for date formatting in PostgreSQL, providing a more robust and professional solution than other alternatives.

SELECT
    HOSPITAL_NAME,
    DEPARTMENT,
    TO_CHAR(ADMISSION_DATE, 'YYYY-MM') AS EXPENSE_MONTH,
    SUM(MEDICAL_EXPENSES) AS TOTAL_MEDICAL_EXPENSES
FROM
    HOSP_DATA
GROUP BY
    HOSPITAL_NAME,
    DEPARTMENT,
    EXPENSE_MONTH
ORDER BY
    EXPENSE_MONTH,
    HOSPITAL_NAME,
    DEPARTMENT;




