--SELECTS TWO


--List the years in which employees were hired, sort by year and then last name.
 SELECT Year(EmployeeHireDate) as [HireYear], EmployeeLastName
 FROM Employee
 ORDER BY EmployeeHireDate, EmployeeLastName;

--What is the difference in Months between the first employee hired and the last one.
SELECT  datediff(month, min(EmployeeHireDate),max(EmployeeHireDate)) As [Month]
FROM Employee;

--Output the employee phone number so it looks like (206)555-1234.
 SELECT Format(Cast(Employeephone as bigint),
 '(000)000-0000') [PhoneNumber] FROM Employee;


--Output the employee hourly wage so it looks like $45.00 (EmployeePosition).
 SELECT FORMAT(EmployeeHourlyPayRate , '$#,##0.00') [EmployeeHourlyWage] 
 FROM EmployeePosition;

--List only the employees who were hired between 2013 and 2015.
SELECT * FROM Employee WHERE year(EmployeeHireDate) BETWEEN 2013 AND 2015;


--Output the position, the hourly wage and the hourly wage multiplied by 40 to see what a weekly wage might look like.
SELECT PositionName, EmployeeHourlyPayRate, EmployeeHourlyPayRate * 40 as [EmployeeWeeklyPayRate] 
FROM Position, EmployeePosition 
WHERE Position.PositionKey = EmployeePosition.PositionKey;

--What is the highest hourly pay rate (EmployeePosition)
SELECT max(EmployeeHourlyPayRate) [HighestPaid] FROM EmployeePosition;


--What is the lowest hourly pay rate
SELECT Min(EmployeeHourlyPayRate) [LowestPaid] FROM EmployeePosition;


--What is the average hourly pay rate
SELECT Avg(EmployeeHourlyPayRate) [AveragPaid] FROM EmployeePosition;


--What is the average pay rate by position
SELECT PositionName, AVG(EmployeeHourlyPayRate) 
From EmployeePosition, Position 
WHERE Position.PositionKey = EmployeePosition.PositionKey
GROUP BY positionName;


--Provide a count of how many employees were hired each year and each month of the year
SELECT Year(EmployeeHireDate) [Year] , MONTH(EmployeeHireDate) [Month], COUNT(*) [Total]
FROM Employee
GROUP BY Year(EmployeeHireDate), MONTH(EmployeeHireDate)
ORDER BY Year(EmployeeHireDate) ;


--Do the query 11 again but with a case structure to output the months as words.
SELECT Year(EmployeeHireDate) [Year] , 
case MONTH(EmployeeHireDate) 
when 1 then 'January'
when 2 then 'Febuary'
when 3 then 'March'
when 4 then 'April'
when 5 then 'May'
when 6 then 'June'
when 7 then 'July'
when 8 then 'August'
when 9 then 'September'
when 10 then 'October'
when 11 then 'November'
when 12 then 'December'
end as [Month],
COUNT(*) [Total]
FROM Employee
GROUP BY Year(EmployeeHireDate), MONTH(EmployeeHireDate)
ORDER BY Year(EmployeeHireDate) ;


--Return which positions average more than $50 an hour.
SELECT PositionName, AVG(EmployeehourlyPayRate) 
FROM Position,EmployeePosition 
WHERE Position.PositionKey = EmployeePosition.PositionKey
GROUP BY PositionName
HAVING AVG(EmployeehourlyPayRate) > 50;

--List the total number of riders on Metroalt busses (RiderShip).
SELECT COUNT(Riders) as [Riders] FROM Ridership;


--List all the tables in the metroAlt databases (system views).
SELECT * FROM sys.Tables;


--List all the databases on server
SELECT * FROM sys.Databases;








