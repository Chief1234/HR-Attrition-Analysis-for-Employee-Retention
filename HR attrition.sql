CREATE DATABASE IF NOT EXISTS employee_data;
Use employee_data;

CREATE TABLE employee_data (
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
    Age INT,
    Gender ENUM('Male', 'Female', 'Other'),
    Department VARCHAR(100),
    JobRole VARCHAR(100),
    MonthlyIncome DECIMAL(10,2),
    Education ENUM(
        'Below College',
        'College',
        'Bachelor',
        'Master',
        'Doctor'
    ),
    MaritalStatus ENUM('Single', 'Married', 'Divorced'),
    OverTime ENUM('Yes', 'No'),
    JobSatisfaction INT CHECK (JobSatisfaction BETWEEN 1 AND 4),
    WorkLifeBalance INT CHECK (WorkLifeBalance BETWEEN 1 AND 4),
    YearsAtCompany INT,
    BusinessTravel ENUM(
        'Travel_Rarely',
        'Travel_Frequently',
        'Non-Travel'
    ),
    Attrition ENUM('Yes', 'No'),
    Created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

SELECT *FROM employee_data;


-- 1. Basic Dataset Overview Queries

--  Total Employee
SELECT COUNT(*) AS TotalEmployees
FROM employee_data;

-- Total Attrition count
SELECT COUNT(*) AS TotalAttrition
FROM employee_data
WHERE Attrition = 'Yes';

-- Attrition Rate(%)
SELECT  ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 2 AS AttritionRatePercent From employee_data;

-- 2. Attrition Breakdown by Categories

-- Attrition by Department
SELECT 
    Department,
    COUNT(*) AS TotalEmployees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS AttritionCount,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS AttritionRate
FROM employee_data
GROUP BY Department
ORDER BY AttritionCount DESC; 

-- Attrition by Job role
SELECT 
    JobRole,
    COUNT(*) AS TotalEmployees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS AttritionCount
FROM employee_data
GROUP BY JobRole
ORDER BY AttritionCount DESC; 

-- Attrition by Gender
SELECT 
    Gender,
    COUNT(*) AS TotalEmployees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS AttritionCount
FROM employee_data
GROUP BY Gender;

-- Attrition by Marital Status
SELECT 
    MaritalStatus,
    COUNT(*) AS TotalEmployees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS AttritionCount
FROM employee_data
GROUP BY MaritalStatus
ORDER BY AttritionCount DESC; 

-- 3. Salary-Based Analysis

-- Attrition by Salary Band
SELECT 
    CASE 
        WHEN MonthlyIncome < 3000 THEN 'Low'
        WHEN MonthlyIncome BETWEEN 3000 AND 7000 THEN 'Medium'
        ELSE 'High'
    END AS SalaryBand,
    COUNT(*) AS TotalEmployees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS AttritionCount
FROM employee_data
GROUP BY SalaryBand
ORDER BY AttritionCount DESC;  

