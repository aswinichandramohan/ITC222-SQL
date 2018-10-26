--SUBQUERIES


--This involves joining tables, then using a subquery. Return the employee key, last name and first name, position name and hourly rate for those employees receiving the maximum pay rate.
SELECT Employee.EmployeeKey, EmployeeLastName, EmployeeFirstName, PositionName, EmployeeHourlyPayRate
FROM EmployeePosition
JOIN Employee
ON EmployeePosition.EmployeeKey = Employee.EmployeeKey
JOIN Position
ON EmployeePosition.PositionKey = Position.PositionKey
WHERE EmployeeHourlyPayRate = (SELECT MAX(EmployeeHourlyPayRate) FROM EmployeePosition);

--Use only subqueries to do this. Return the key, last name and first name of every employee who has the position name “manager.”
SELECT EmployeeKey, EmployeeLastName, EmployeeFirstName
FROM Employee
WHERE EmployeeKey IN (
	SELECT EmployeeKey
	FROM EmployeePosition
	WHERE PositionKey = (
		SELECT PositionKey 
		FROM Position 
		WHERE PositionName = 'Manager'
	)
);

--It combines regular aggregate functions, a scalar function, a cast, subqueries and a join. But it produces a useful result. The results should look like this: User Ridership totals for the numbers.
SELECT YEAR(BusScheduleAssignmentDate)AS [Year], SUM(riders) AS Annual,
AVG(riders) AS Average,
(SELECT SUM(riders) FROM Ridership) AS Total,
(Cast(Sum(riders)as decimal(10,2))/(Select sum(riders) From Ridership))*100 [Percent]
FROM ridership
INNER JOIN BusScheduleAssignment
on Ridership.BusScheduleAssigmentKey=BusScheduleAssignment.BusScheduleAssignmentKey
GROUP BY YEAR(BusScheduleAssignmentDate)
ORDER BY YEAR;


--Create a new table called EmployeeZ. It should have the following structure:
---EmployeeKey int,
---EmployeeLastName nvarchar(255),
---EmployeeFirstName nvarchar(255),
---EmployeeEmail Nvarchar(255)
--Use an insert with a subquery to copy all the employees from the employee table whose last name starts with “Z.”
CREATE TABLE EmployeeZ (
EmployeeKey int,
EmployeeLastName nvarchar(255),
EmployeeFirstName nvarchar(255),
EmployeeEmail nvarchar(255);
--Step:2
INSERT INTO EmployeeZ (EmployeeKey, EmployeeLastName, EmployeeFirstName, EmployeeEmail)
SELECT EmployeeKey, EmployeeLastName, EmployeeFirstName, EmployeeEmail 
FROM Employee 
WHERE Employee.EmployeeLastName LIKE 'Z%';


--This is a correlated subquery. Return the position key, the employee key and the hourly pay rate for those employees who are receiving the highest pay in their positions. Order it by position key.
SELECT ep1.PositionKey, ep1.EmployeeKey, ep1.EmployeeHourlyPayRate
FROM EmployeePosition ep1
WHERE ep1.EmployeeHourlyPayRate = (
	SELECT max(ep2.EmployeeHourlyPayRate)
	FROM EmployeePosition ep2
	WHERE ep2.PositionKey = ep1.PositionKey
);


