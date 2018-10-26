--Creating Tables
 

--Add the following tables to metroAlt with the following columns and constraints
	--BusService
	--BusServiceKey int identity primary key
	--BusServiceName variable character, required
	--BusServiceDescription variable character
Create Table BusService
(
BusServiceKey int identity primary key,
BusServiceName nvarchar(255) not null,
BusServiceDescription nvarchar(255) null
);


--Maintenance
	--MaintenanceKey int, an identity, primary key
	--MainenanceDate Date, required
	--Buskey int foreign key related to Bus, required
Create Table Maintenance
(
MaintenanceKey int identity(1,1) primary key,
MainenanceDate Date not null,
Buskey int foreign key 
references Bus(BusKey) not null
);


--MaintenanceDetail (we will use Alter table statements to add Keys to this table)
	--MaintenanceDetailKey int identity 
	--Maintenancekey int  required
	--EmployeeKey int  required
	--BusServiceKey int  required
	--MaintenanceNotes  variable character
Alter Table MaintenanceDetail
Add Constraint FK_MaintenanceDetail int Foreign Key(Maintenancekey) not null
	References Maintenanace(Maintenancekey),
Constraint FK_MaintenanceEmployee int Foreign Key(EmployeeKey) not null
	References Employee(EmployeeKey),
Constraint FK_MaintenanceBusService int Foreign Key(BusServiceKey) not null
	References BusService(BusServiceKey);

--Use alter table to add a primary key constraint to Maintenance detail setting MaintenanceDetailKey as the primary key	     
Alter Table MaintenanceDetail
Add Constraint PK_MaintenanceDetail Primary Key(MaintenanceDetailKey)

--Use alter table to set MaintenceKey as a foreign key
Alter Table MaintenanceDetail
Add Constraint FK_MaintenanceDetail Foreign Key(MaintenanceKey)
References Maintenance(MaintenanceKey)

--Use alter table to set EmployeeKey as a foreign key
Alter Table MaintenanceDetail
Add Constraint FK_MaintenanceEmployee Foreign Key(EmployeeKey)
	References Employee(EmployeeKey)

--Use alter table to set BusServiceKey as a foreign key
Alter Table MaintenanceDetail
Add Constraint FK_MaintenanceBusService Foreign Key(BusServiceKey) 
	References BusService(BusServiceKey)

--Add a column to BusType named BusTypeAccessible. Its data type should be bit 0 for no and 1 for yes.
ALTER TABLE BusType 
ADD BusTypeAccessible bit DEFAULT 0 NOT NULL;

--Use alter table to Add a constraint to email in the Employee table to make sure each email is unique
Alter table Employee
Add Constraint UC_Employee_EmployeeEmail unique(EmployeeEmail)


