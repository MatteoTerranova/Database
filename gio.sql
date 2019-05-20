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

CREATE TABLE Template	(
	TemplateID UUID,
	Description VARCHAR,
	IsRoot BOOLEAN NOT NULL,	
	PRIMARY KEY (TemplateID)
);

CREATE TABLE Order	(
	Child UUID NOT NULL,
	Parent UUID NOT NULL
	PRIMARY KEY (Child, Parent)
	FOREIGN KEY (Child) REFERENCES Template(TemplateID),
	FOREIGN KEY (Parent) REFERENCES Template(TemplateID)
);