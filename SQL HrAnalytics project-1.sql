use employee_retention;

-- Average Attrition rate for all Departments-------------------------------------------------------------------------------------------------------------1

SELECT 
    Department,
    CONCAT(ROUND(SUM(CASE
                            WHEN Attrition = 'Yes' THEN 1
                            ELSE 0
                        END)
                         / SUM(EmployeeCount) * 100,
                    2),
            '%') AS Attrition_rate
FROM
    hr_1
GROUP BY department;  

-- --Average Hourly rate of Male Research Scientist----------------------------------------------------------------------------------------------------2


SELECT Gender,
    cast(AVG(HourlyRate) AS DECIMAL (10 , 2 )) AS Average_Hourly_Rate
FROM
    HR_1
WHERE
    gender = 'Male' 
        AND JobRole = 'Research Scientist';

-- -Attrition rate Vs Monthly income stats------------------------------------------------------------------------------------------------------------3

SELECT 
    DEPARTMENT,
    CONCAT(ROUND(SUM(CASE
                        WHEN Attrition = 'Yes' THEN 1
                        ELSE 0
                    END) / SUM(EmployeeCount) * 100,
                    2),
            '%') AS ATTRITION_RATE,
    AVG(MonthlyIncome) AS MONTHLY_INCOME
FROM
    HR_1
        JOIN
    HR_2 ON HR_1.Employee_ID = HR_2.Employee_ID
GROUP BY DEPARTMENT;

-- --Average working years for each Department----------------------------------------------------------------------------------------------------4
SELECT 
    DEPARTMENT, ROUND(AVG(TotalWorkingYears), 4) WORKING_YEARS
FROM
    HR_1
        JOIN
    HR_2 ON HR_1.Employee_ID = HR_2.Employee_ID
GROUP BY DEPARTMENT;

-- --Departmentwise No of Employees---------------------------------------------------------------------------------------------------5
SELECT DEPARTMENT,sum(EmployeeCount)Employee_Count
FROM HR_1
GROUP BY DEPARTMENT;

-- -Count of Employees based on Educational Fields---------------------------------------------------------------------------------------6

SELECT EducationField ,sum(EmployeeCount)Employee_Count
FROM HR_1
GROUP BY EducationField;

-- Job Role Vs Work life balance--------------------------------------------------------------------------------------------------------7
select JobRole,sum(WorkLifeBalance)WorkLife_Balance
from hr_1
join 
    HR_2 ON HR_1.Employee_ID = HR_2.Employee_ID

group by JobRole;

-- Attrition rate Vs Year since last promotion relation----------------------------------------------------------------------------------8
SELECT 
    CASE
        WHEN YearsSinceLastPromotion BETWEEN 1 AND 10 THEN '1-10'
        WHEN YearsSinceLastPromotion BETWEEN 11 AND 20 THEN '11-20'
        WHEN YearsSinceLastPromotion BETWEEN 21 AND 30 THEN '21-30'
        WHEN YearsSinceLastPromotion BETWEEN 31 AND 40 THEN '31-40'
        ELSE 'Other'
    END AS number_range,
    COUNT(CASE
            WHEN attrition = 'yes' THEN 1
            ELSE NULL
        END)Attrition_count
FROM
    hr_1
        JOIN
    HR_2 ON HR_1.Employee_ID = HR_2.Employee_ID
GROUP BY number_range;

-- Gender based Percentage of Employee-------------------------------------------------------------------------------------------------------------9
SELECT 
    Gender,
    concat(
    (cast(SUM(EmployeeCount)* 100/(select
            SUM(EmployeeCount) from hr_1)as decimal(10,2))),'%')as Employee_Percentage
FROM
    hr_1
GROUP BY gender;

-- Monthly New Hire vs Attrition Trendline----------------------------------------------------------------------------------------------------------10
 SELECT 
        CASE 
        WHEN `Month of Joining` = 1 THEN 'January'
        WHEN `Month of Joining` = 2 THEN 'February'
        WHEN `Month of Joining` = 3 THEN 'March'
        WHEN `Month of Joining` = 4 THEN 'April'
        WHEN `Month of Joining` = 5 THEN 'May'
        WHEN `Month of Joining` = 6 THEN 'June'
        WHEN `Month of Joining` = 7 THEN 'July'
        WHEN `Month of Joining` = 8 THEN 'August'
        WHEN `Month of Joining` = 9 THEN 'September'
        WHEN `Month of Joining` = 10 THEN 'October'
        WHEN `Month of Joining` = 11 THEN 'November'
        WHEN `Month of Joining` = 12 THEN 'December'
        ELSE 'Invalid Month'
    END as month_date,
    CONCAT(ROUND(SUM(CASE
                            WHEN Attrition = 'Yes' THEN 1
                            ELSE 0
                        END)
                         / SUM(EmployeeCount) * 100,
                    2),
            '%') AS Attrition_rate
from hr_1
join 
hr_2 on hr_1.Employee_ID=hr_2.Employee_ID
group by `Month of Joining`;


-- Deptarment / Job Role wise job satisfaction-----------------------------------------------------------------------------------------------------11

select Department,jobRole as Job_Role,count(JobSatisfaction)Job_Satisfaction
from hr_1
group by Department,JobRole;

-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 
    Department,Attrition,
    COUNT(Attrition)ATT_Count,
    concat(round(cast(COUNT(*)as decimal) / (SELECT 
            cast(COUNT(*)as decimal)
        FROM
            hr_1) * 100,2),'%')ATT_Rate
FROM
    hr_1
WHERE
    attrition = 'yes'
GROUP BY Department
order by Attrition;
-- -----------------------------------------------------------------------------------------------------

 SELECT 
        `Month of Joining`,
    CONCAT(ROUND(SUM(CASE
                            WHEN Attrition = 'Yes' THEN 1
                            ELSE 0
                        END)
                         / SUM(EmployeeCount) * 100,
                    2),
            '%') AS Attrition_rate
from hr_1
join 
hr_2 on hr_1.Employee_ID=hr_2.Employee_ID
group by `Month of Joining`;
-- ------------------------------------------------------------
select Department,count(attrition),
SUM(CASE
                            WHEN Attrition = 'Yes' THEN 1
                            ELSE 0
                        END)
                         / SUM(EmployeeCount) * 100 as wwww
              
from hr_1
group by department;


select Department,count(attrition),
Attrition/ (select attrition from hr_1) as wwww
              
from hr_1
group by department;







