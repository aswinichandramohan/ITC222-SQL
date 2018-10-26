--XML
 
--Alter the table MaintenanceDetail. Drop the column MaintenanceNotes.
Alter table MaintenanceDetail
drop column MaintenanceNotes;
 
--Create a new xml schema collection called "MaintenanceNoteSchemaCollection" using the following schema:
<?xml version="1.0" encoding="utf-8"?>
<xs:schema attributeFormDefault="unqualified"
           elementFormDefault="qualified"
           targetNamespace="http://www.metroalt.com/maintenancenote"
           xmlns:xs="http://www.w3.org/2001/XMLSchema">
  <xs:element name="maintenancenote">
	<xs:complexType>
  	<xs:sequence>
    	<xs:element name="title" />
    	<xs:element name="note">
      	<xs:complexType>
        	<xs:sequence>
          	<xs:element maxOccurs="unbounded" name="p" />
        	</xs:sequence>
      	</xs:complexType>
    	</xs:element>
    	<xs:element name="followup" />
  	</xs:sequence>
	</xs:complexType>
  </xs:element>
</xs:schema>
Ans:
Create xml schema collection MaintenanceNoteSchemaCollection
As
'<?xml version="1.0" encoding="utf-8"?>
<xs:schema attributeFormDefault="unqualified" elementFormDefault="qualified" targetNamespace="http://www.metroalt.com/maintenancenote" xmlns:xs="http://www.w3.org/2001/XMLSchema">
  <xs:element name="maintenancenote">
    <xs:complexType>
      <xs:sequence>
        <xs:element name="title" type="xs:string" />
        <xs:element name="note">
          <xs:complexType>
        	<xs:sequence>
          	<xs:element maxOccurs="unbounded" name="p" type="xs:string" />
        	</xs:sequence>
          </xs:complexType>
        </xs:element>
        <xs:element name="followup" type="xs:string" />
      </xs:sequence>
    </xs:complexType>
  </xs:element>
</xs:schema>'
 
--Now alter the table MaintenanceDetail. Add the column MaintenanceNotes as XML using the Schema "MaintenanceNoteSchemaCollection".
Alter table MaintenanceDetail
Add MaintenanceNotes xml (MaintenanceNoteSchemaCollection)
 
--Insert a record using the xml above and then add two more records. You can invent the values.
insert into Maintenance([MaintenanceNotes])
values(
'<?xml version="1.0" encoding="utf-8"?>
<maintenancenote xmlns="http://www.metroalt.com/maintenancenote">
  <title>Wear and Tear on Hydralic units</title>
<note>
  <p>The hydralic units are showing signs of stress</p>
  <p>I recommend the replacement of the units</p>
</note>
  <followup>Schedule replacement for June 2016</followup>
</maintenancenote>
 
<maintenancenote xmlns="http://www.metroalt.com/maintenancenote">
  <title>Failed suspension</title>
<note>
  <p>suspension has failed</p>
</note>
  <followup>Schedule replacement for July 2016</followup>
</maintenancenote>
 
<maintenancenote xmlns="http://www.metroalt.com/maintenancenote">
  <title>Worn out wipers</title>
<note>
  <p>Wipers have worn out</p>>
</note>
  <followup>Schedule replacement for June 2016</followup>
</maintenancenote>
');
 
--Set up an xquery that searches for one of the titles
Select MaintenanceKey, MaintenanceDate,
maintenanceNotes.query
('declare namespace mn="http://www.metroalt.com/maintenancenote";//mn:maintenancenote/mn:title') titles
From Maintenance
 
 
 

