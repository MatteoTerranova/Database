-- Task
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

-- Template
CREATE TABLE Template	(
	TemplateID UUID,
	Description VARCHAR,
	IsRoot BOOLEAN NOT NULL,	
	PRIMARY KEY (TemplateID)
);

-- Order
CREATE TABLE Order	(
	Child UUID,
	Parent UUID,
	PRIMARY KEY (Child, Parent),
	FOREIGN KEY (Child) REFERENCES Template(TemplateID),
	FOREIGN KEY (Parent) REFERENCES Template(TemplateID)
);

-- FiscalCode has VARCHAR(16) because the fiscal code length is always 16
-- Department
CREATE TABLE Department	{
	Name VARCHAR(50),
	FiscalCode VARCHAR(16) NOT NULL,
	PRIMARY KEY (Name),
	FOREIGN KEY (FiscalCode) REFERENCES Employee(FiscalCode)
};