--TABLE EXPRESSIONS

--Create a derived table that returns the position name as position and count of employees at that position. (this can be done as a simple join, but do it in the format of a derived table. There still will be a join in the subquery portion).
SELECT Position , total
FROM (
SELECT PositionName as [Position] , Count(*) as [total]
FROM Position 
INNER JOIN EmployeePosition
ON Position.PositionKey = EmployeePosition.PositionKey
GROUP BY PositionName
) AS PositionCount;


--Create a derived table that returns a column HireYear and the count of employees who were hired that year. (Same comment as above).
SELECT HireYear , Total
FROM (
SELECT year(EmployeeHireDate) AS [HireYear] , COUNT(*) AS [Total]
FROM Employee
INNER JOIN Person
ON Employee.PersonKey = Person.PersonKey
GROUP BY year(EmployeeHireDate)
) AS EmployeeCount;


--Redo problem 1 as a Common Table Expression (CTE).
 WITH PositionCount AS 
(
SELECT PositionName as [Position] , Count(*) as [total]
FROM Position 
INNER JOIN EmployeePosition
ON Position.PositionKey = EmployeePosition.PositionKey
GROUP BY PositionName
) 
SELECT Position , total 
FROM PositionCount;

--Redo problem 2 as a CTE.
 WITH EmployeeCount AS
(
SELECT year(EmployeeHireDate) AS [HireYear] , COUNT(*) AS [Total]
FROM Employee
INNER JOIN Person
ON Employee.PersonKey = Person.PersonKey
GROUP BY year(EmployeeHireDate)
)
SELECT HireYear, Total 
FROM EmployeeCount;

--Create a CTE that takes a variable argument called @BusBarn and returns the count of busses grouped by the description of that bus type at a particular Bus barn. Set @BusBarn to 3.
Declare @BusBarn nvarchar(255) = 3;
WITH Buses AS
(
SELECT BustypeDescription AS BusType, COUNT(*) As Total
FROM Bus
INNER JOIN Bustype
ON Bus.BusTypeKey = Bustype. BusTypeKey
WHERE BusBarnKey = @BusBarn
GROUP BY BusTypeDescription
)
SELECT BusType, Total
FROM Buses;

--Create a View of Employees for Human Resources it should contain all the information in the Employee table plus their position and hourly pay rate
go
 CREATE VIEW Em_HumanResource
 AS
 SELECT Employee.EmployeeKey, PersonKey, EmployeeHireDate,      EmployeeAnnualSalary/2080 AS HourlyPayRate, PositionName AS Position
 FROM Employee
 INNER JOIN EmployeePosition
 ON Employee.EmployeeKey = EmployeePosition.EmployeeKey
 INNER JOIN Position
 ON EmployeePosition.PositionKey = Position.PositionKey

 go
 SELECT * FROM Em_HumanResource;

--Alter the view in 6 to bind the schema
go
ALTER VIEW Em_HumanResource with Schemabinding
AS
SELECT Employee.EmployeeKey, PersonKey, EmployeeHireDate,  EmployeeAnnualSalary/2080 AS HourlyPayRate, PositionName AS Position
FROM dbo.Employee
INNER JOIN dbo.EmployeePosition
ON dbo.Employee.EmployeeKey = dbo.EmployeePosition.EmployeeKey
 INNER JOIN dbo.Position
 ON dbo.EmployeePosition.PositionKey = dbo.Position.PositionKey;

--Create a view of the Bus Schedule assignment that returns the Shift times, The Employee first and last name, the bus route (key) and the Bus (key). Use the view to list the shifts for Neil Pangle in October of 2014
go
 Alter VIEW Vw_BusSchedule
AS
SELECT EmployeeFirstName, EmployeeLastName, BusRoute.BusRouteKey, Bus.BusKey, BusDriverShiftStartTime, 
BusDriverShiftStopTime, BusScheduleAssignmentDate
FROM Employee 
INNER JOIN BusScheduleAssignment
ON Employee.EmployeeKey = BusScheduleAssignment.EmployeeKey
INNER JOIN Bus
ON Bus.BusKey = BusScheduleAssignment.BusKey
INNER JOIN BusRoute
ON BusRoute.BusRouteKey = BusScheduleAssignment.BusRouteKey
INNER JOIN BusDriverShift
ON BusDriverShift.BusDriverShiftKey = BusScheduleAssignment.BusDriverShiftKey

go
SELECT * FROM Vw_BusSchedule
WHERE year(BusScheduleAssignmentDate) = 2014 AND month(BusScheduleAssignmentDate) = 10 
AND EmployeeFirstname = 'Neil' AND EmployeeLastName = 'Pangle';

--Create a table valued function that takes a parameter of city and returns all the employees who live in that city

CREATE Function Fn_CityFunction(@City nvarchar(255))
returns table
AS
return
	SELECT * FROM Employee
	Where EmployeeCity = @City

SELECT * FROM dbo.Fn_CityFunction('Seattle')



