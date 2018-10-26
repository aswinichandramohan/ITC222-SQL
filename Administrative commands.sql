--Administrative commands

--Create a Schema called "ManagementSchema."
CREATE SCHEMA ManagementSchema

--Create a view owned by the schema that shows the annual ridership.
Create view ManagementSchema.vw_AnnualRidership
AS
Select YEAR(BusScheduleAssignment) AS [year],
Count(riders) as TotalRiders
From BusScheduleAssignment 
inner join Ridership
on BusScheduleAssignment .BusScheduleAssignmentKey  = Ridership.BusScheduleAssignmentKey

--Create a view owned by the schema that shows the employee information including their position and pay rate.
Create view ManagementSchema.vw_EmployeeInfo
AS
Select EmployeeKey,
EmployeeLastName,
EmployeeFirstName,
EmployeeAddress,
EmployeeCity,
EmployeeZipCode,
EmployeePhone,
EmployeeEmail,
EmployeeHireDate,
PositionName,
EmployeeHourlyPayRate
From Employee
Join EmployeePosition
On Employee.EmployeeKey = EmployeePosition.EmployeeKey
Join Position
On Position.PositionKey = EmployeePosition.PositionKey  

--Create a role ManagementRole
Create Role ManagementRole

--Give the ManagementRole select permissions on the ManagementSchema and Exec permissions on the new employee stored procedure we created earlier.
grant Select on schema::managementSchema to managementRole
Grant exec on dbo.usp_AddEmployee to managementRole


--Create a new login for one of the employees who holds the manager position.
Create login EAdams with PositionName = 'manager',
default_database = MetroAlt


--Create a new user for that login.
Create user EAdams for login EAdams


--Add that user to the Role
Alter Role managementrole add member Eadams


--Back up the database MetroAlt
Backup database MetroAlt to Disk = 'C:\backup\metroalt.bak'
Backup log MetroAlt to Disk = 'C:\backup\metroalt.log'



