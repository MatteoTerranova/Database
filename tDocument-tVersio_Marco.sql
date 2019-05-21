

CREATE TABLE Document(
	DocumentID UUID,
	Title TEXT NOT NULL,
	Content BLOB NOT NULL,
	TimeStamp TIMESTAMPTZ NOT NULL,
	PRIMARY KEY (DocumentID)
);

CREATE TABLE Version(
	Predecessor UUID,
	Successor UUID NOT NULL,
	PRIMARY KEY (Predecessor),
	FOREIGN KEY (Predecessor) REFERENCES Document(DocumentID)
);