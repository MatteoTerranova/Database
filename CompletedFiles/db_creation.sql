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
COMMENT ON COLUMN Contact.ZIP IS 'The Zone Improvement Plan of the contact.';
COMMENT ON COLUMN Contact.Street IS 'The street of the contact.';
COMMENT ON COLUMN Contact.Number IS 'The address number of the contact.';

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
COMMENT ON COLUMN Employee.Username IS 'The username for the login of the employee.';
COMMENT ON COLUMN Employee.Password IS 'The password for the login of the employee.';
COMMENT ON COLUMN Employee.IBAN IS 'The IBAN of the employee.';
COMMENT ON COLUMN Employee.HourlyWage IS 'The hourly wage of the employee.';
COMMENT ON COLUMN Employee.Role IS 'The role in the studio of the employee.';

-- Customer
CREATE TABLE Customer(
	FiscalCode VARCHAR(16),
	Note TEXT,

	PRIMARY KEY (FiscalCode),
	FOREIGN KEY (FiscalCode) REFERENCES Contact(FiscalCode)
);

COMMENT ON TABLE Customer IS 'Represents a customer.';
COMMENT ON COLUMN Customer.FiscalCode IS 'The unique FiscalCode of the customer.';
COMMENT ON COLUMN Customer.Note IS 'Some annotations about the customer.';

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
	HoursSpent FLOAT(2) DEFAULT 0.00,
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
COMMENT ON COLUMN Project.HoursSpent IS 'The hours spent for the project';


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
COMMENT ON COLUMN Request.ProjectID IS 'The unique ID of the requested project.';

-- Department
CREATE TABLE Department(
	Name VARCHAR(50),
	FiscalCode VARCHAR(16) NOT NULL,
	PRIMARY KEY (Name),
	FOREIGN KEY (FiscalCode) REFERENCES Employee(FiscalCode)
);

COMMENT ON TABLE Department IS 'Represents a specific area of the studio.';
COMMENT ON COLUMN Department.Name IS 'The name of the department.';
COMMENT ON COLUMN Department.FiscalCode IS 'The fiscal code of the employee who leads the department.';

-- Template
CREATE TABLE Template(
	TemplateID VARCHAR,
	Description TEXT,
	IsRoot BOOLEAN NOT NULL,
	PRIMARY KEY (TemplateID)
);

COMMENT ON TABLE Template IS 'Represents a set of predefined templates.';
COMMENT ON COLUMN Template.TemplateID IS 'The name of the template.';
COMMENT ON COLUMN Template.Description IS 'The description of the template.';
COMMENT ON COLUMN Template.IsRoot IS 'Determines if the template is the root of the tree.';

-- Order
CREATE TABLE OrderTemplate(
	Child VARCHAR,
	Parent VARCHAR,
	PRIMARY KEY (Child, Parent),
	FOREIGN KEY (Child) REFERENCES Template(TemplateID),
	FOREIGN KEY (Parent) REFERENCES Template(TemplateID)
);

COMMENT ON TABLE OrderTemplate IS 'Handles the order of the template.';
COMMENT ON COLUMN OrderTemplate.Child IS 'The identifier of the child node.';
COMMENT ON COLUMN OrderTemplate.Parent IS 'The identifier of the parent node.';

-- Task
CREATE TABLE Task(
	TaskID UUID,
	IsRoot BOOLEAN NOT NULL,
	Description TEXT,
	StartDate DATE NOT NULL,
	EndDate DATE,
	TemplateID VARCHAR NOT NULL,
	Name VARCHAR(50) NOT NULL,
	PRIMARY KEY (TaskID),
	FOREIGN KEY (TemplateID) REFERENCES Template(TemplateID),
	FOREIGN KEY (Name) REFERENCES Department(Name)
);

COMMENT ON TABLE Task IS 'Represents an activity of the studio.';
COMMENT ON COLUMN Task.TaskID IS 'The unique ID of the task.';
COMMENT ON COLUMN Task.IsRoot IS 'Determines if the task is the root of the tree.';
COMMENT ON COLUMN Task.Description IS 'The description of the task.';
COMMENT ON COLUMN Task.StartDate IS 'The start date of the task.';
COMMENT ON COLUMN Task.EndDate IS 'The end date of the task.';
COMMENT ON COLUMN Task.TemplateID IS 'The name of the template.';
COMMENT ON COLUMN Task.Name IS 'The name of the department associated to the task.';

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

COMMENT ON TABLE Compose IS 'Represents which tasks compose a project.';
COMMENT ON COLUMN Compose.Parent IS 'The identifier of the parent task.';
COMMENT ON COLUMN Compose.Child IS 'The identifier of the child task.';
COMMENT ON COLUMN Compose.ProjectID IS 'The unique identifier of the associated project.';


-- TimeSlot
CREATE TABLE TimeSlot(
	TimeSlotID UUID,
	TaskID UUID,
	CurTime TIMESTAMPTZ NOT NULL,
	FiscalCode VARCHAR(16) NOT NULL,
	Notes TEXT,
	Hours float(2) NOT NULL,
	HourlyWage float(2) NOT NULL,
	PRIMARY KEY(TimeSlotID),
	FOREIGN KEY(TaskID) REFERENCES Task(TaskID),
	FOREIGN KEY(FiscalCode) REFERENCES Employee(FiscalCode)
);

COMMENT ON TABLE TimeSlot IS 'Represents the contribute of each employee in different fractions of time.';
COMMENT ON COLUMN TimeSlot.TimeSlotID IS 'The unique identifier of a specific time slot.';
COMMENT ON COLUMN TimeSlot.TaskID IS 'The unique identifier of the task.';
COMMENT ON COLUMN TimeSlot.CurTime IS 'The date and time when a time slot has been reported.';
COMMENT ON COLUMN TimeSlot.FiscalCode IS 'The unique fiscal code of the employee.';
COMMENT ON COLUMN TimeSlot.Notes IS 'Notes about the time slot.';
COMMENT ON COLUMN TimeSlot.Hours IS 'The number of hours spent in the time slot.';
COMMENT ON COLUMN TimeSlot.HourlyWage IS 'The employee’s wage per hour.';

-- Expense
CREATE TABLE Expense(
	Type VARCHAR,
	PRIMARY KEY (Type)
);

COMMENT ON TABLE Expense IS 'Represents the expense incurred by an employee that has to be reimbursed.';
COMMENT ON COLUMN Expense.Type IS 'The type of expense.';

-- Has
CREATE TABLE Has(
	TimeSlotID UUID,
	Type VARCHAR,
	Cost float(2) NOT NULL,
	Description TEXT,
	PRIMARY KEY (TimeSlotID, Type),
	FOREIGN KEY (TimeSlotID) REFERENCES Timeslot(TimeSlotID),
	FOREIGN KEY (Type) REFERENCES Expense (Type)
);

COMMENT ON TABLE Has IS 'Represents the featurse of an expense.';
COMMENT ON COLUMN Has.TimeSlotID IS 'The unique identifier of a specific time slot.';
COMMENT ON COLUMN Has.Type IS 'The type of expense.';
COMMENT ON COLUMN Has.Cost IS 'The amount of the expense.';
COMMENT ON COLUMN Has.Description IS 'The description of the time slot.';

-- Document
CREATE TABLE Document(
	DocumentID UUID,
	Title VARCHAR NOT NULL,
	Content BYTEA NOT NULL,
	CurTime TIMESTAMPTZ NOT NULL,
	TaskID UUID NOT NULL,
	Producer VARCHAR(16),
	PRIMARY KEY (DocumentID),
	FOREIGN KEY (TaskID) REFERENCES Task(TaskID),
	FOREIGN KEY (Producer) REFERENCES Employee(FiscalCode)
);

COMMENT ON TABLE Document IS 'Represents the document generated by the studio.';
COMMENT ON COLUMN Document.DocumentID IS 'The unique identifier of the document.';
COMMENT ON COLUMN Document.Title IS 'The title of the document.';
COMMENT ON COLUMN Document.Content IS 'The content of the document.';
COMMENT ON COLUMN Document.CurTime IS 'The date when a document has been received.';
COMMENT ON COLUMN Document.TaskID IS 'The unique identifier of the task.';
COMMENT ON COLUMN Document.Producer IS 'The producer of the document.';

-- Version
CREATE TABLE Version(
	Predecessor UUID,
	Successor UUID NOT NULL,
	PRIMARY KEY (Predecessor),
	FOREIGN KEY (Predecessor) REFERENCES Document(DocumentID),
	FOREIGN KEY (Successor) REFERENCES Document(DocumentID)
);

COMMENT ON TABLE Version IS 'Represents the version of the document.';
COMMENT ON COLUMN Version.Predecessor IS 'The unique identifier of the previous version of the document.';
COMMENT ON COLUMN Version.Successor IS 'The unique identifier of the updated version of the document.';

-- Validate
create TABLE ValidateDocument(
	DocumentID UUID,
	FiscalCode VARCHAR(16) NOT NULL,
	CurTime TIMESTAMPTZ NOT NULL,
	PRIMARY KEY (DocumentID),
	FOREIGN KEY (FiscalCode) REFERENCES Employee(FiscalCode),
	FOREIGN KEY (DocumentID) REFERENCES Document(DocumentID)
);

COMMENT ON TABLE ValidateDocument IS 'Represents the validation of a document.';
COMMENT ON COLUMN ValidateDocument.DocumentID IS 'The unique identifier of the document.';
COMMENT ON COLUMN ValidateDocument.FiscalCode IS 'The unique fiscal code of the employee.';
COMMENT ON COLUMN ValidateDocument.CurTime IS 'The date when a document has been validated.';

-- Approve
create TABLE ApproveDocument(
	DocumentID UUID,
	FiscalCode VARCHAR(16) NOT NULL,
	CurTime TIMESTAMPTZ NOT NULL,
	PRIMARY KEY (DocumentID),
	FOREIGN KEY (FiscalCode) REFERENCES Employee(FiscalCode),
	FOREIGN KEY (DocumentID) REFERENCES Document(DocumentID)
);

COMMENT ON TABLE ApproveDocument IS 'Represents the approvation of a document.';
COMMENT ON COLUMN ApproveDocument.DocumentID IS 'The unique identifier of the document.';
COMMENT ON COLUMN ApproveDocument.FiscalCode IS 'The unique fiscal code of the employee.';
COMMENT ON COLUMN ApproveDocument.CurTime IS 'The date when a document has been approved.';
