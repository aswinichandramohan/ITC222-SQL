--Triggers

--Create a trigger to fire when an employee is assigned to a second shift in a day. Have it write to an overtime table. the Trigger should create the overtime table if it doesn't exist. Add an employee for two shifts to test the trigger.
Use MetroAlt
go
Create trigger tr_EmployeeOvertime on BusScheduleAssignment
after Insert
as
Declare @employeeKey int
Declare @insertDate date
Declare @shiftCount int
Select @employeeKey = Employeekey from inserted
Select @insertDate = BusScheduleAssignmentDate from inserted
Select @shiftCount= COUNT(*) from BusScheduleAssignment 
	where EmployeeKey = @employeeKey and BusScheduleAssignmentDate = @insertDate

if(@shiftCount>1)
Begin
	if not exists 
		(Select name from sys.Tables Where name ='Overtime')
	Begin
		Create table Overtime 
		(
		 EmployeeKey int, 
		 ShiftDate date,
		 )
	End
	Insert into Overtime(EmployeeKey, ShiftDate)
	Values(@employeeKey, @insertDate)
End
;

Test:
Insert into BusScheduleAssignment
	(BusDriverShiftKey, EmployeeKey, BusRouteKey, BusScheduleAssignmentDate, BusKey)
Values
	(1, 1, 1, '2012-01-02', 1),
	(1, 6, 3, '2012-01-02', 2);


