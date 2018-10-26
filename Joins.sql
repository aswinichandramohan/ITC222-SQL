--JOINS


--Create a cross join between employees and bus routes to show all possible combinations of routes and drivers (better use position to distinguish only drivers this involves a cross join and an inner join. I will accept either)
SELECT EmployeeFirstname, EmployeeLastName, PositionName, BusRouteZone
FROM Employee 
JOIN EmployeePosition 
ON Employee.EmployeeKey = EmployeePosition.EmployeeKey 
JOIN Position
ON EmployeePosition.PositionKey = Position.PositionKey
CROSS JOIN BusRoute
WHERE PositionName = 'Driver';

--List all the bus type details for each bus assigned to bus barn 3
SELECT Bustype.*, BusKey, Bus.BusBarnKey
FROM BusType
JOIN Bus
ON Bustype.BusTypeKey = Bus.BusTypeKey
JOIN BusBarn
ON Bus.BusBarnKey = BusBarn.BusBarnKey
WHERE Bus.BusBarnKey = 3;


--What is the total cost of all the busses at bus barn 3
SELECT BusKey, Bus.BusBarnKey, BustypePurchasePrice 
From Bus 
JOIN Bustype 
ON Bus.BusTypeKey = Bustype.Bustypekey
JOIN BusBarn
ON Bus.BusBarnKey = BusBarn.BusBarnKey
Where Bus.BusBarnKey = 3;
---Step 2:
SELECT sum(BustypePurchasePrice)
From Bus 
JOIN Bustype 
ON Bus.BusTypeKey = Bustype.Bustypekey
JOIN BusBarn
ON Bus.BusBarnKey = BusBarn.BusBarnKey
Where Bus.BusBarnKey = 3;

--What is the total cost per type of bus at bus barn 3
SELECT BusTypeDescription, Bus.BusBarnKey, BustypePurchaseprice 
From Bus
JOIN BusType
ON Bus.BusTypeKey = Bustype.BusTypeKey 
JOIN BusBarn 
ON Bus.BusBarnKey = BusBarn.BusBarnKey 
Where Bus.BusBarnKey = 3 ;
Step 2:
SELECT BusTypeDescription, sum(BustypePurchaseprice) AS [Total] 
From Bus
JOIN BusType
ON Bus.BusTypeKey = Bustype.BusTypeKey 
JOIN BusBarn 
ON Bus.BusBarnKey = BusBarn.BusBarnKey 
Where Bus.BusBarnKey = 3 
GROUP BY BusTypeDescription;

--List the last name, first name, email, position name and hourly pay for each employee
SELECT EmployeeFirstName, EmployeeLastName, EmployeeEmail, PositionName, EmployeeHourlypayRate 
FROM EmployeePosition 
JOIN Employee
ON EmployeePosition.EmployeeKey = Employee.EmployeeKey
JOIN Position 
ON EmployeePosition.PositionKey = Position.PositionKey;

--List the bus driver’s last name  the shift times, the bus number (key)  and the bus type for each bus on route 43
SELECT EmployeeLastName, BusDriverShiftStartTime, BusDriverShiftStopTime, Bus.BusKey, Bus.BusTypeKey 
FROM Bus
JOIN BusScheduleAssignment
ON Bus.BusKey = BusScheduleAssignment.BusKey
JOIN Employee
ON  BusScheduleAssignment.EmployeeKey = Employee.EmployeeKey
JOIN BusDriverShift
ON BusScheduleAssignment.BusDriverShiftKey = BusDriverShift.BusDriverShiftKey
JOIN Bustype
ON Bus.BusTypekey = Bustype.BusTypeKey
WHERE BusRouteKey = 43;

--Return all the positions that no employee holds.
SELECT PositionName
From Position
LEFT OUTER JOIN EmployeePosition
ON EmployeePosition.PositionKey = Position.PositionKey
WHERE EmployeeKey IS NULL;


--Get the employee key, first name, last name, position key for every driver (position key=1) who has never been assigned to a shift. (This is hard it involves an inner join of several tables and then an outer join with BusscheduleAssignment.)
SELECT Employee.EmployeeKey, EmployeeFirstName, EmployeeLastName, Position.PositionKey, BusDriverShiftKey
FROM EmployeePosition
JOIN Employee
ON EmployeePosition.EmployeeKey = Employee.EmployeeKey
JOIN Position
ON EmployeePosition.PositionKey = Position.PositionKey
LEFT OUTER JOIN BusScheduleAssignment
ON Employee.EmployeeKey = BusScheduleAssignment.EmployeeKey
WHERE position.PositionKey = 1 And BusDriverShiftKey IS NULL;




