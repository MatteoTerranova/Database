-- ZIP has VARCHAR(5) because postal code length is always 5 (in Italy)
-- Contact
CREATE TABLE Contact(
	FiscalCode VARCHAR(16),
	Name VARCHAR NOT NULL,
	Surname VARCHAR NOT NULL,
	BirthDate DATE,
	Email VARCHAR,
	PhoneNumber VARCHAR NOT NULL,
	ZIP VARCHAR(5) NOT NULL,
	Street VARCHAR,
	Number SMALLINT,
	CONSTRAINT Address CHECK ((Street is NULL AND Number is NULL) OR (Street is NOT  NULL AND Number is NOT NULL)),
	PRIMARY KEY (FiscalCode)
);

-- Employee
CREATE TABLE Employee(
	FiscalCode VARCHAR(16),
	Username VARCHAR NOT NULL,
	Password VARCHAR NOT NULL,
	IBAN VARCHAR NOT NULL,
	HourlyWage float(2) NOT NULL,
	Role VARCHAR NOT NULL,

	PRIMARY KEY (FiscalCode),
	FOREIGN KEY (FiscalCode) REFERENCES Contact(FiscalCode)
);

--Customer
CREATE TABLE Customer(
	FiscalCode VARCHAR(16),
	Note VARCHAR NOT NULL,

	PRIMARY KEY (FiscalCode),
	FOREIGN KEY (FiscalCode) REFERENCES Contact(FiscalCode)
);

--Project

--Request
CREATE TABLE Request(
	FiscalCode VARCHAR(16),
	ProjectID UUID,

	PRIMARY KEY (FiscalCode, ProjectID),
	FOREIGN KEY (FiscalCode) REFERENCES Customer(FiscalCode),
	FOREIGN KEY (FiscalCode) REFERENCES ProjectID(FiscalCode)
);

--Department

--Template
CREATE TABLE Template	(
	TemplateID UUID,
	Description VARCHAR,
	IsRoot BOOLEAN NOT NULL,	
	PRIMARY KEY (TemplateID)
);

--Order
CREATE TABLE Order	(
	Child UUID,
	Parent UUID,
	PRIMARY KEY (Child, Parent),
	FOREIGN KEY (Child) REFERENCES Template(TemplateID),
	FOREIGN KEY (Parent) REFERENCES Template(TemplateID)
);

--Task
CREATE TABLE Task	(
	TaskID UUID,
	IsRoot BOOLEAN NOT NULL,
	Description VARCHAR,
	StartDate DATE NOT NULL,
	EndDate DATE,
	TemplateID UUID NOT NULL,
	Name VARCHAR(50) NOT NULL,	
	PRIMARY KEY (TaskID),
	FOREIGN KEY (TemplateID) REFERENCES Template(TemplateID),
	FOREIGN KEY (Name) REFERENCES Department(Name)
);

--Compose

--TimeSlot
CREATE TABLE TimeSlot(
	TimeSlotID UUID,
	TaskID UUID,
	TimeStamp TIMESTAMP NOT NULL,
	FiscalCode VARCHAR(16) NOT NULL,
	Notes VARCHAR,
	Hours FLOAT NOT NULL,
	HourlyWage FLOAT NOT NULL,
	PRIMARY KEY(TimeSlotID),
	FOREIGN KEY(TaskID) REFERENCES Task(TaskID),
	FOREIGN KEY(FiscalCode) REFERENCES Employee(FiscalCode)
);

--Expense
CREATE TABLE Expense(
	Type VARCHAR,
	PRIMARY KEY (Type)
);

--Has
CREATE TABLE Has(
TimeSlotID UUID,
Type VARCHAR,
Cost FLOAT NOT NULL,
Description VARCHAR,
HourlyWage FLOAT NOT NULL,
PRIMARY KEY (TimeSlotID, Type),
FOREIGN KEY (TimeSlotID) REFERENCES Timeslot(TimeSlotID),
FOREIGN KEY (Type) REFERENCES Expense (Type)
);

--Document
CREATE TABLE Document(
	DocumentID UUID,
	Title TEXT NOT NULL,
	Content BYTEA NOT NULL,
	TimeStamp TIMESTAMP NOT NULL,
	PRIMARY KEY (DocumentID)
);

--Version
CREATE TABLE Version(
	Predecessor UUID,
	Successor UUID NOT NULL,
	PRIMARY KEY (Predecessor),
	FOREIGN KEY (Predecessor) REFERENCES Document(DocumentID)
);

--Validate 
create TABLE Validate (
	DocumentID UUID,
	FiscalCode VARCHAR(16) NOT NULL,
	TimeStamp TIMESTAMP NOT NULL,
	PRIMARY KEY (DocumentID)
	FOREIGN KEY (FiscalCode) REFERENCES Employee(FiscalCode),
	FOREIGN KEY (DocumentID) REFERENCES Document(DocumentID)
);

--Approve
create TABLE Approve (
	DocumentID UUID,
	FiscalCode VARCHAR(16) NOT NULL,
	TimeStamp TIMESTAMP NOT NULL,
	PRIMARY KEY (DocumentID)
	FOREIGN KEY (FiscalCode) REFERENCES Employee(FiscalCode),
	FOREIGN KEY (DocumentID) REFERENCES Document(DocumentID)
);
