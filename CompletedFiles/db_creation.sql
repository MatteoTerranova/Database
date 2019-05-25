-- Database Creation
CREATE DATABASE ennedue OWNER POSTGRES ENCODING = 'UTF8';

-- Connect to examode db to create data for its 'public' schema
\c ennedue

-- Install the extention for the uuid: uuid-ossp.
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create new domains
CREATE DOMAIN pwd AS character varying(254)
	CONSTRAINT properpassword CHECK (((VALUE)::text ~* '[A-Za-z0-9._%-]{5,}'::text));

-- Create new data types
CREATE TYPE roleType AS ENUM (
	'Employee',
	'Chief',
	'Area Manager'
);

-- Table Creation

-- FiscalCode has VARCHAR(16) because the fiscal code length is always 16
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

COMMENT ON TABLE Contact IS 'Represents a contact.';
COMMENT ON COLUMN Contact.FiscalCode IS 'The unique fiscalCode of the contact.';
COMMENT ON COLUMN Contact.Name IS 'The name of the contact.';
COMMENT ON COLUMN Contact.Surname IS 'The surname of the contact.';
COMMENT ON COLUMN Contact.BirthDate IS 'The birth date of the contact.';
COMMENT ON COLUMN Contact.Email IS 'The email of the contact.';
COMMENT ON COLUMN Contact.PhoneNumber IS 'The phone number of the contact.';
COMMENT ON COLUMN Contact.ZIP IS 'The ZIP of the contact.';
COMMENT ON COLUMN Contact.Street IS 'The street of the contact.';
COMMENT ON COLUMN Contact.Number IS 'The number of the contact.';

-- Employee
CREATE TABLE Employee(
	FiscalCode VARCHAR(16),
	Username VARCHAR NOT NULL UNIQUE,
	Password VARCHAR NOT NULL,
	IBAN VARCHAR NOT NULL,
	HourlyWage float(2) NOT NULL,
	Role roleType NOT NULL,

	PRIMARY KEY (FiscalCode),
	FOREIGN KEY (FiscalCode) REFERENCES Contact(FiscalCode)
);

COMMENT ON TABLE Employee IS 'Represents an employee.';
COMMENT ON COLUMN Employee.FiscalCode IS 'The unique fiscalCode of the employee.';
COMMENT ON COLUMN Employee.Username IS 'The username for login of the employee.';
COMMENT ON COLUMN Employee.Password IS 'The password for login of the employee.';
COMMENT ON COLUMN Employee.IBAN IS 'The IBAN of the employee.';
COMMENT ON COLUMN Employee.HourlyWage IS 'The hourly wage of the employee.';
COMMENT ON COLUMN Employee.Role IS 'The role in the studio of the employee.';

-- Customer
CREATE TABLE Customer(
	FiscalCode VARCHAR(16),
	Note VARCHAR,

	PRIMARY KEY (FiscalCode),
	FOREIGN KEY (FiscalCode) REFERENCES Contact(FiscalCode)
);

COMMENT ON TABLE Employee IS 'Represents a customer.';
COMMENT ON COLUMN Employee.FiscalCode IS 'The unique FiscalCode of the customer.';
COMMENT ON COLUMN Employee.Note IS 'Some note about the customer.';

-- Project
CREATE TABLE Project(
	ProjectID UUID,
	Title VARCHAR NOT NULL,
	StartDate DATE NOT NULL,
	EndDate DATE,
	Location VARCHAR NOT NULL,
	Quote BYTEA,
	Deadline DATE NOT NULL,
	EstimatedHours INTEGER NOT NULL,
	HoursSpent FLOAT(2),
	PRIMARY KEY (ProjectID)
);

COMMENT ON TABLE Project IS 'Represents a project.';
COMMENT ON COLUMN Project.ProjectID IS 'The unique ID of the project.';
COMMENT ON COLUMN Project.Title IS 'The title of the project.';
COMMENT ON COLUMN Project.StartDate IS 'The start date of the project';
COMMENT ON COLUMN Project.EndDate IS 'The end date of the project';
COMMENT ON COLUMN Project.Location IS 'The location of the project';
COMMENT ON COLUMN Project.Quote IS 'The quote of the project';
COMMENT ON COLUMN Project.Deadline IS 'The deadline of the project';
COMMENT ON COLUMN Project.EstimatedHours IS 'The estimated hours for the project';
COMMENT ON COLUMN Project.HoursSpent IS 'The hours spent in the project';


-- Request
CREATE TABLE Request(
	FiscalCode VARCHAR(16),
	ProjectID UUID,

	PRIMARY KEY (FiscalCode, ProjectID),
	FOREIGN KEY (FiscalCode) REFERENCES Customer(FiscalCode),
	FOREIGN KEY (ProjectID) REFERENCES Project(ProjectID)
);

COMMENT ON TABLE Request IS 'Represents the request for a project.';
COMMENT ON COLUMN Request.FiscalCode IS 'The unique fiscal code of the customer.';
COMMENT ON COLUMN Request.ProjectID IS 'The unique ID of the request project.';

-- Department
CREATE TABLE Department(
	Name VARCHAR(50),
	FiscalCode VARCHAR(16) NOT NULL,
	PRIMARY KEY (Name),
	FOREIGN KEY (FiscalCode) REFERENCES Employee(FiscalCode)
);

COMMENT ON TABLE Departement IS 'Represents a specific area of the studio.';
COMMENT ON COLUMN Department.Name IS 'The name of the department.';
COMMENT ON COLUMN Department.FiscalCode IS 'The fiscal code of the employee who managed the department.';

-- Template
CREATE TABLE Template(
	TemplateID VARCHAR,
	Description VARCHAR,
	IsRoot BOOLEAN NOT NULL,
	PRIMARY KEY (TemplateID)
);

-- Order
CREATE TABLE OrderTemplate(
	Child VARCHAR,
	Parent VARCHAR,
	PRIMARY KEY (Child, Parent),
	FOREIGN KEY (Child) REFERENCES Template(TemplateID),
	FOREIGN KEY (Parent) REFERENCES Template(TemplateID)
);

-- Task
CREATE TABLE Task(
	TaskID UUID,
	IsRoot BOOLEAN NOT NULL,
	Description VARCHAR,
	StartDate DATE NOT NULL,
	EndDate DATE,
	TemplateID VARCHAR NOT NULL,
	Name VARCHAR(50) NOT NULL,
	PRIMARY KEY (TaskID),
	FOREIGN KEY (TemplateID) REFERENCES Template(TemplateID),
	FOREIGN KEY (Name) REFERENCES Department(Name)
);

-- Compose
CREATE TABLE Compose(
	Parent UUID,
	Child UUID,
	ProjectID UUID NOT NULL,
	PRIMARY KEY (Child),
	FOREIGN KEY (Parent) REFERENCES Task(TaskID),
	FOREIGN KEY (Child) REFERENCES Task(TaskID),
	FOREIGN KEY (ProjectID) REFERENCES Project(ProjectID)
);

-- TimeSlot
CREATE TABLE TimeSlot(
	TimeSlotID UUID,
	TaskID UUID,
	TimeStamp TIMESTAMP NOT NULL,
	FiscalCode VARCHAR(16) NOT NULL,
	Notes VARCHAR,
	Hours float(2) NOT NULL,
	HourlyWage float(2) NOT NULL,
	PRIMARY KEY(TimeSlotID),
	FOREIGN KEY(TaskID) REFERENCES Task(TaskID),
	FOREIGN KEY(FiscalCode) REFERENCES Employee(FiscalCode)
);

-- Expense
CREATE TABLE Expense(
	Type VARCHAR,
	PRIMARY KEY (Type)
);

-- Has
CREATE TABLE Has(
	TimeSlotID UUID,
	Type VARCHAR,
	Cost float(2) NOT NULL,
	Description VARCHAR,
	PRIMARY KEY (TimeSlotID, Type),
	FOREIGN KEY (TimeSlotID) REFERENCES Timeslot(TimeSlotID),
	FOREIGN KEY (Type) REFERENCES Expense (Type)
);

-- Document
CREATE TABLE Document(
	DocumentID UUID,
	Title TEXT NOT NULL,
	Content BYTEA NOT NULL,
	TimeStamp TIMESTAMP NOT NULL,
	TaskID UUID NOT NULL,
	Producer VARCHAR(16),
	PRIMARY KEY (DocumentID),
	FOREIGN KEY (TaskID) REFERENCES Task(TaskID),
	FOREIGN KEY (Producer) REFERENCES Employee(FiscalCode)
);

-- Version
CREATE TABLE Version(
	Predecessor UUID,
	Successor UUID NOT NULL,
	PRIMARY KEY (Predecessor),
	FOREIGN KEY (Predecessor) REFERENCES Document(DocumentID),
	FOREIGN KEY (Successor) REFERENCES Document(DocumentID)
);

-- Validate
create TABLE ValidateDocument(
	DocumentID UUID,
	FiscalCode VARCHAR(16) NOT NULL,
	TimeStamp TIMESTAMP NOT NULL,
	PRIMARY KEY (DocumentID),
	FOREIGN KEY (FiscalCode) REFERENCES Employee(FiscalCode),
	FOREIGN KEY (DocumentID) REFERENCES Document(DocumentID)
);

-- Approve
create TABLE ApproveDocument(
	DocumentID UUID,
	FiscalCode VARCHAR(16) NOT NULL,
	TimeStamp TIMESTAMP NOT NULL,
	PRIMARY KEY (DocumentID),
	FOREIGN KEY (FiscalCode) REFERENCES Employee(FiscalCode),
	FOREIGN KEY (DocumentID) REFERENCES Document(DocumentID)
);
