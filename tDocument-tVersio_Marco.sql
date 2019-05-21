

CREATE TABLE Document(
	DocumentID UUID,
	Title TEXT NOT NULL,
	Content BLOB NOT NULL,
	TimeStamp TIMESTAMPTZ NOT NULL,
	PRIMARY KEY (DocumentID)
);

CREATE TABLE Version(
	DocumentID_Predecessor UUID,
	DocumentID_Successor UUID,
	PRIMARY KEY (DocumentID_Predecessor),
	FOREIGN KEY (DocumentID_Predecessor) REFERENCES Document(DocumentID)
);