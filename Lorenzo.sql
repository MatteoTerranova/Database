create TABLE Approve (
  DocumentID UUID NOT NULL,
	FiscalCode VARCHAR(16) NOT NULL,
	TimeStamp TIMESTAMP NOT NULL,
	PRIMARY KEY (DocumentID)
  FOREIGN KEY (FiscalCode) REFERENCES Employee(FiscalCode),
  FOREIGN KEY (DocumentID) REFERENCES Document(DocumentID)
);

create TABLE Validate (
  DocumentID UUID NOT NULL,
	FiscalCode VARCHAR(16) NOT NULL,
	TimeStamp TIMESTAMP NOT NULL,
	PRIMARY KEY (DocumentID)
  FOREIGN KEY (FiscalCode) REFERENCES Employee(FiscalCode),
  FOREIGN KEY (DocumentID) REFERENCES Document(DocumentID)
);
