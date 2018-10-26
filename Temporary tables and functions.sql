--Temporary tables and functions

--Create a temp table to show how many stops each route has. the table should have fields for the route number and the number of stops. Insert into it from BusRouteStops and then select from the temp table.
Create table #tempBusStops
(
	BusRouteKey int,
	BusStopKey int,
	BusRouteStopKey int,
);

insert into #tempBusStops(BusRouteKey , BusStopKey , BusRouteStopKey)
Select * From BusRouteStops;

Select * from #tempBusStops;

--Do the same but using a global temp table.
 Create table ##tempBusStops
(
	BusRouteKey int,
	BusStopKey int,
	BusRouteStopKey int,
);

 insert into ##tempBusStops(BusRouteKey , BusStopKey , BusRouteStopKey)
 Select * From BusRouteStops;

 Select * from ##tempBusStops;

--Create a function to create an employee email address. Every employee Email follows the pattern of "firstName.lastName@metroalt.com"
Alter function fx_Email
(@EmployeeLastName nvarchar(255), 
 @EmployeeFirstName nvarchar(255), 
 @EmployeeEmail nvarchar(255))
 Returns nvarchar(255)
AS
Begin
	Declare @Email nvarchar(255)
	if @EmployeeFirstName is null
		Begin
			set @Email = @EmployeeLastName + '@metroalt'+ '.' + 'com'
		End
	else
		Begin
			set @Email = @EmployeeFirstName + '.' + @EmployeeLastName + '@metroalt'+ '.' + 'com'
		End
		Return @Email
End
Go

Select EmployeeFirstName, EmployeeLastName,
dbo.fx_Email(EmployeeFirstName , EmployeeLastName,
EmployeeEmail) [Employee_Email]
From Employee


--Create a function to determine a two week pay check of an individual employee.
Create function fx_PayCheck
(
@pay decimal(5,2))
returns decimal
As 
Begin
	Declare @TwoWeek decimal
	Set @TwoWeek = @pay * 80
	Return @TwoWeek 
End
Go

Select EmployeeKey, dbo.fx_PayCheck
(EmployeeHourlyPayRate ) as BiWeeklyPayRate
From EmployeePosition


--Create a function to determine a hourly rate for a new employee. Take difference between top and bottom pay for the new employees position (say driver) and then subtract the difference from the maximum pay. (and yes this is very arbitrary).
 Create function fx_NewEmployee
 (
 @TopPay decimal(5,2),
 @LowPay decimal (5,2))
 Returns decimal
AS
Begin
	Declare @NewPay DECIMAL
	Set @NewPay = (@TopPay - @LowPay) 
	Return @NewPay
End

Select dbo.fx_NewEmployee(MAX(EmployeeHourlyPayRate), MIN(EmployeeHourlyPayRate))
From EmployeePosition
inner join Position
On EmployeePosition.PositionKey = Position.PositionKey where PositionName = 'Driver'


