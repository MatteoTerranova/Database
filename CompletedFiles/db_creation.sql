-- Database Creation
CREATE DATABASE ennedue OWNER POSTGRES ENCODING = 'UTF8';

-- Connect to examode db to create data for its 'public' schema
\c ennedue

-- Install the extention for the uuid: uuid-ossp.
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create new domains
CREATE DOMAIN pwd AS character varying(254)
	CONSTRAINT properpassword CHECK (((VALUE)::text ~* '[A-Za-z0-9._%-]{5,}'::text));
	
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

-- Employee
CREATE TABLE Employee(
	FiscalCode VARCHAR(16),
	Username VARCHAR NOT NULL UNIQUE,
	Password VARCHAR NOT NULL,
	IBAN VARCHAR NOT NULL,
	HourlyWage float(2) NOT NULL,
	Role VARCHAR NOT NULL,

	PRIMARY KEY (FiscalCode),
	FOREIGN KEY (FiscalCode) REFERENCES Contact(FiscalCode)
);

-- Customer
CREATE TABLE Customer(
	FiscalCode VARCHAR(16),
	Note VARCHAR NOT NULL,

	PRIMARY KEY (FiscalCode),
	FOREIGN KEY (FiscalCode) REFERENCES Contact(FiscalCode)
);

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
	PRIMARY KEY (ProjectID) 
);

-- Request
CREATE TABLE Request(
	FiscalCode VARCHAR(16),
	ProjectID UUID,

	PRIMARY KEY (FiscalCode, ProjectID),
	FOREIGN KEY (FiscalCode) REFERENCES Customer(FiscalCode),
	FOREIGN KEY (ProjectID) REFERENCES Project(ProjectID)
);

-- Department
CREATE TABLE Department(
	Name VARCHAR(50),
	FiscalCode VARCHAR(16) NOT NULL,
	PRIMARY KEY (Name),
	FOREIGN KEY (FiscalCode) REFERENCES Employee(FiscalCode)
);

-- Template
CREATE TABLE Template(
	TemplateID UUID,
	Description VARCHAR,
	IsRoot BOOLEAN NOT NULL,	
	PRIMARY KEY (TemplateID)
);

-- Order
CREATE TABLE OrderTemplate(
	Child UUID,
	Parent UUID,
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
	TemplateID UUID NOT NULL,
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
	HourlyWage float(2) NOT NULL,
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
	PRIMARY KEY (DocumentID)
);

-- Version
CREATE TABLE Version(
	Predecessor UUID,
	Successor UUID NOT NULL,
	PRIMARY KEY (Predecessor),
	FOREIGN KEY (Predecessor) REFERENCES Document(DocumentID)
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

	
