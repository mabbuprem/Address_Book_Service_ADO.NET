--UC1 Creating Database
CREATE DATABASE Address_Book_Service
USE Address_Book_Service;

--UC2 Adding Attributes to Table
CREATE TABLE AddressBookTable
(
FirstName VARCHAR(15) NOT NULL,
LastName VARCHAR(20),
Address VARCHAR(50) NOT NULL,
City VARCHAR(15) NOT NULL,
State VARCHAR(15) NOT NULL,
Zip CHAR(6) NOT NULL,
PhoneNo CHAR(10) NOT NULL,
Email VARCHAR(30) NOT NULL
)
SELECT * FROM AddressBookTable

ALTER TABLE AddressBookTable
ALTER COLUMN Zip INT;
ALTER TABLE AddressBookTable
ALTER COLUMN PhoneNo BIGINT;

--UC3 Inserting Values into the Table
INSERT INTO AddressBookTable(FirstName,LastName,Address,City,State,Zip,PhoneNo,Email)
VALUES
('PREM','KUMAR','Salanuthala,Prakasam','Ongole','AndhraPradesh',523241,7981587635,'mabbupremkumar@gmail.com'),
('PRAVEEN','KUMAR','Salanuthala,Prakasam','Ongole','AndhraPradesh',523241,7730002849,'mabbupraveen@gmail.com'),
('KIRAN','KUMAR','Salanuthala,Prakasam','Ongole','AndhraPradesh',523241,7015906292,'kiran@gmail.com');

--UC4 Updating or Editing Records by Name
UPDATE AddressBookTable SET Zip = 500014 WHERE FirstName = 'PREM';
UPDATE AddressBookTable SET City = 'Hyderabad' WHERE FirstName = 'PREM';
UPDATE AddressBookTable SET State = 'Telangana' WHERE FirstName = 'PREM';
SELECT * FROM AddressBookTable

--UC5 Deleting a Person Contact using Name
DELETE FROM AddressBookTable WHERE FirstName = 'KIRAN';

--UC6 Retrieving Person Details from His state or City Name
SELECT * FROM AddressBookTable WHERE City = 'Hyderabad' OR State = 'Telangana';
SELECT * FROM AddressBookTable WHERE City = 'Ongole' AND State = 'AndhraPradesh';

INSERT INTO AddressBookTable(FirstName,LastName,Address,City,State,Zip,PhoneNo,Email)
VALUES
('KALYAN','KUMAR','Nellore,sullurpetta','Nellore','AndhraPradesh',567483,8952147891,'kalyan999@gmail.com'),
('YASH','ARORA','odalarevu,allavaram','Amalapuram','AndhraPradesh',567387,7015906292,'yasharora999@gmail.com');

--UC7 Size Of AddressBook By City & State
SELECT COUNT(*) AS CityCount,City FROM AddressBookTable GROUP BY City;

SELECT COUNT(*) AS StateCount,State FROM AddressBookTable GROUP BY State;

--UC8 Retrive Entries Sorted Alphabatically by Person's Name For Given City
SELECT * FROM AddressBookTable WHERE City = 'Hyderabad' ORDER BY FirstName;

--UC9 Ability to Identify Contacts by Type & AddressBookName
ALTER TABLE AddressBookTable
ADD Type VARCHAR(15);
ALTER TABLE AddressBookTable
ADD AddressBookName VARCHAR(30);

UPDATE AddressBookTable SET Type = 'Friends' WHERE City = 'Hyderabad';
UPDATE AddressBookTable SET Type = 'Family' WHERE NOT City  = 'Hyderabad';
UPDATE AddressBookTable SET Type = 'Profession' WHERE FirstName  = 'prem';
UPDATE AddressBookTable SET AddressBookName = 'Jigri Yaar' WHERE FirstName  = 'anil';
UPDATE AddressBookTable SET AddressBookName = 'Jigri Yaar' WHERE FirstName  = 'prem';
UPDATE AddressBookTable SET AddressBookName = 'Normal Yaar' WHERE FirstName  = 'jagan';
UPDATE AddressBookTable SET AddressBookName = 'Normal Yaar' WHERE FirstName  = 'Rahul';

--UC10 Ability to get Number Of Contact Persons by Count By Type
SELECT Type,COUNT(Type) AS NumberOfContactPersons FROM AddressBookTable GROUP BY Type;

--UC11 Ability to Add Person to both Friend & Family
INSERT INTO AddressBookTable(FirstName,LastName,Address,City,State,Zip,PhoneNo,Email,Type)
VALUES
('PREM','KUMAR','Salanuthala,Prakasam','Hyderabad','Telangana',500014,7206594149,'mabbupremkumar@gmail.com','Family');

--UC12 Drawing ER Diagrams after identifying Entities using Normalization
--Creating Entities of AddressBookName, ConactDetails, TypeDetais & Type Manager

DROP TABLE AddressBookTable;

CREATE TABLE AddressBookNameTable
(
AddressBookId INT IDENTITY (1,1) PRIMARY KEY,
AddressBookName VARCHAR(50)
);
SELECT * FROM AddressBookNameTable;
INSERT INTO AddressBookNameTable
VALUES('JigriYaar'),('NormalYaar');

CREATE TABLE PersonContactsTable
(
PersonID INT IDENTITY (1,1) PRIMARY KEY,
FirstName VARCHAR(30),
LastName VARCHAR(50),
AddressDetails VARCHAR(150),
City VARCHAR(50),
StateName VARCHAR (50),
Zip INT,
PhoneNo BIGINT,
Email VARCHAR(60),
AddressBookSelect INT,
FOREIGN KEY (AddressBookSelect) REFERENCES AddressBookNameTable(AddressBookId)
);

SELECT * FROM PersonContactsTable

INSERT INTO PersonContactsTable
VALUES
('PREM','KUMAR','Salanuthala,konakana metla','Ongole','AndhraPradesh',523241,7206594149,'mabbupremkumar@gmail.com',1),
('PRAVEEN','KUMAR','Salanuthala,konakana metla','Ongole','AndhraPradesh',523241,8950595579,'pravennkumar@gmail.com',1),
('KIRAN','KUMAR','AnnaNagar,Avadi','Turuvallur','Chennai',135001,7015906292,'kirangmail.com',2),
('KALYAN','KUMAR','ChottaPanna,VPOKalanaur','Rohtak','Haryana',124001,8952147891,'kalyan999@gmail.com',2),
('JEEVAN','SAI','ModelTown','Hisar','Haryana',140001,9034267666,'jeevan@gmail.com',1);



CREATE TABLE TypeEntityTable
(
TypeID INT IDENTITY (1,1) PRIMARY KEY,
TypeName VARCHAR(30)
);
SELECT * FROM TypeEntityTable

INSERT INTO TypeEntityTable
VALUES ('Friend'),('Professional'),('Family'),('BusinessMan'),('College');


CREATE TABLE TypeHandler
(
TypeSelect INT,
PersonSelect INT,
FOREIGN KEY (TypeSelect) REFERENCES TypeEntityTable(TypeID),
FOREIGN KEY (PersonSelect) REFERENCES PersonContactsTable(PersonID)
)

INSERT INTO TypeHandler
VALUES (1,1),(3,1),(1,2),(3,2),(2,3),(4,4),(1,5),(3,5),(5,5);
SELECT * FROM TypeHandler

SELECT PersonID,AddressBookName,FirstName,LastName,AddressDetails,City,StateName,Zip,PhoneNo,Email,TypeName FROM AddressBookNameTable
INNER JOIN PersonContactsTable ON AddressBookNameTable.AddressBookId = PersonContactsTable.AddressBookSelect
INNER JOIN TypeHandler ON PersonContactsTable.PersonID = TypeHandler.PersonSelect
INNER JOIN TypeEntityTable ON TypeHandler.TypeSelect = TypeEntityTable.TypeID

--UC13 Retrieving All data as Demanded in Prevoius UC's

--Retrieving Person Details from A Particular City or State
SELECT PersonID,AddressBookName,FirstName,LastName,AddressDetails,City,StateName,Zip,PhoneNo,Email,TypeName FROM AddressBookNameTable
INNER JOIN PersonContactsTable ON AddressBookNameTable.AddressBookId = PersonContactsTable.AddressBookSelect AND City = 'Rohtak'
INNER JOIN TypeHandler ON PersonContactsTable.PersonID = TypeHandler.PersonSelect
INNER JOIN TypeEntityTable ON TypeHandler.TypeSelect = TypeEntityTable.TypeID

SELECT PersonID,AddressBookName,FirstName,LastName,AddressDetails,City,StateName,Zip,PhoneNo,Email FROM AddressBookNameTable
INNER JOIN PersonContactsTable ON AddressBookNameTable.AddressBookId = PersonContactsTable.AddressBookSelect AND (City = 'Rohtak' AND StateName = 'Haryana')

SELECT PersonID,AddressBookName,CONCAT(FirstName,' ',LastName) AS FullName,CONCAT(AddressDetails,',',City,',',StateName,',',Zip) AS FullAddress,PhoneNo,Email FROM AddressBookNameTable
INNER JOIN PersonContactsTable ON AddressBookNameTable.AddressBookId = PersonContactsTable.AddressBookSelect AND (City = 'Rohtak' AND StateName = 'Haryana')

SELECT COUNT(*),City FROM PersonContactsTable 
GROUP BY City

SELECT COUNT(*),City,StateName FROM PersonContactsTable 
GROUP BY City,StateName

--Sorting Alphabatically by First Name
SELECT PersonID,AddressBookName,CONCAT(FirstName,' ',LastName) AS FullName,CONCAT(AddressDetails,',',City,',',StateName,',',Zip) AS FullAddress,PhoneNo,Email,TypeName FROM PersonContactsTable
INNER JOIN AddressBookNameTable ON AddressBookNameTable.AddressBookId = PersonContactsTable.AddressBookSelect
INNER JOIN TypeHandler ON PersonContactsTable.PersonID = TypeHandler.PersonSelect
INNER JOIN TypeEntityTable ON TypeHandler.TypeSelect = TypeEntityTable.TypeID
ORDER BY FirstName

SELECT COUNT(*) AS NoOfContacts,TypeName FROM PersonContactsTable
INNER JOIN AddressBookNameTable ON AddressBookNameTable.AddressBookId = PersonContactsTable.AddressBookSelect
INNER JOIN TypeHandler ON PersonContactsTable.PersonID = TypeHandler.PersonSelect
INNER JOIN TypeEntityTable ON TypeHandler.TypeSelect = TypeEntityTable.TypeID
GROUP BY TypeName

GO
CREATE PROCEDURE spUpdateContacts
(
@FirstName VARCHAR(30),
@LastName VARCHAR(40),
@City VARCHAR(40),
@Zip INT,
@State VARCHAR(50)
)
AS
BEGIN TRY
UPDATE PersonContactsTable SET City = @City WHERE FirstName = @FirstName AND LastName = @LastName
UPDATE PersonContactsTable SET StateName = @State WHERE FirstName = @FirstName AND LastName = @LastName
UPDATE PersonContactsTable SET Zip = @Zip WHERE FirstName = @FirstName AND LastName = @LastName
END TRY

BEGIN CATCH
SELECT
ERROR_NUMBER() AS ErrorNumber,
ERROR_STATE() AS ErrorState,
ERROR_PROCEDURE() AS ErrorProcedure,
ERROR_LINE() AS ErrorLine,
ERROR_MESSAGE() AS ErrorMessage;
END CATCH
GO