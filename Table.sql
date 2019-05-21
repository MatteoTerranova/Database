--TimeSlot
CREATE TABLE TimeSlot(
TimeSlotID UUID,
TaskID UUID,
TimeStamp TIMESTAMP NOT NULL,
FiscalCode TEXT NOT NULL,
Notes TEXT,
Hours FLOAT NOT NULL,
HourlyWage FLOAT NOT NULL,
PRIMARY KEY(TimeSlot ID),
FOREIGN KEY(TaskID) REFERENCES Task(TaskID),
FOREIGN KEY(FiscalCode) REFERENCES Employee(FiscalCode)
);

--Has
CREATE TABLE Has(
TimeSlot ID UUID NOT NULL,
Type TEXT NOT NULL,
Cost FLOAT NOT NULL,
Description TEXT,
HourlyWage FLOAT NOT NULL,
PRIMARY KEY (TimeSlotID, Type),
FOREIGN KEY (TimeSlotID) REFERENCES Timeslot(TimeSlotID),
FOREIGN KEY (Type) REFERENCES Expense (Type)
);

--Expense
CREATE TABLE Expense(
Type TEXT,
PRIMARY KEY (Type)
);