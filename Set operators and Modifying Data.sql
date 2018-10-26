--SET OPERATORS AND MODIFYING DATA


--Create a Union between Person and PersonAddress in Community assist and Employee in MetroAlt. You will need to fully qualify the tables in the CommunityAssist part of the query:
--CommunityAssist.dbo.Person etc.
 SELECT PersonLastName as [LastName], PersonAddressCity as [City]
FROM Community_Assist.dbo.Person
JOIN Community_Assist.dbo.PersonAddress 
ON Community_Assist.dbo.Person.PersonKey = Community_Assist.dbo.PersonAddress.PersonKey

UNION 

SELECT EmployeeLastName as [LastName], EmployeeCity as [City]
FROM Employee;

--Do an intersect between the PersonAddress and Employee that returns the cities that are in both.
SELECT PersonAddressCity as [City]
FROM  Community_Assist.dbo.PersonAddress
INTERSECT
SELECT EmployeeCity as [City]
FROM Employee;

--Do an except between PersonAddress and Employee that returns the cities that are not in both.
SELECT PersonAddressCity 
FROM Community_Assist.dbo.PersonAddress
EXCEPT
SELECT EmployeeCity
FROM Employee

UNION

SELECT EmployeeCity
FROM Employee
EXCEPT
SELECT PersonAddressCity 
FROM Community_Assist.dbo.PersonAddress
;


--Insert a new employee. You can make up the information. Make him a Driver. To do this you will need to insert into employee and employee position. Assign him a shift driving a bus.
INSERT INTO Employee(EmployeeFirstName, EmployeeLastName, EmployeeHireDate, EmployeeAddress, 
EmployeeCity, EmployeeZipCode, EmployeeEmail)
VALUES ('Ash', 'Kans', '2018-07-15','29 EastSide Bld', 'Renton', '98059', 'ashkan@live.com')

Declare @EmployeeKey int = Ident_Current('Employee');

INSERT INTO EmployeePosition(EmployeeKey, PositionKey, EmployeePositionDateAssigned)
VALUES(@EmployeeKey, '3', '2018-07-15')

INSERT INTO BusScheduleAssignment(BusDriverShiftKey, BusScheduleAssignmentDate)
VALUES('1','2018-01-02')
;


--Create a table that has the same structure as Employee, name it Drivers. Use the Select form of an insert to copy all the employees whose position is driver (1) into the new table.
CREATE TABLE Drivers (
	DriverKey int, 
	DriverLastName nvarchar(255), 
	DriverFirstName nvarchar(255), 
	DriverAddress nvarchar(255), 
	DriverCity nvarchar(255), 
	DriverZipCode nchar(5), 
	DriverPhone nchar(10), 
	DriverEmail nvarchar(255),
	DriverHireDate date
);

INSERT INTO Drivers(DriverKey, DriverLastName, DriverFirstName, DriverAddress, DriverCity, DriverZipCode,
DriverPhone, DriverEmail, DriverHireDate)
SELECT Employee.*
FROM Employee
JOIN EmployeePosition
ON Employee.EmployeeKey = EmployeePosition.EmployeeKey
JOIN Position
ON EmployeePosition.PositionKey = Position.PositionKey
WHERE PositionName = 'Driver';

--Edit the record for Bob Carpenter (Key 3) so that his first name is Robert and is City is Bellevue
Update Employee
Set EmployeeFirstName='Robert',
EmployeeCity='Bellevue' 
Where EmployeeKey=3;


--Give everyone a 3% Cost of Living raise.
SELECT EmployeeHourlyPayRate + (EmployeeHourlyPayRate * .3) As [IncreasePay]
FROM EmployeePosition;

--Delete the position Detailer
DELETE FROM Position
Where PositionName = 'Detailer';



--NOTE:
--Except- the values that are not common in both tables.


