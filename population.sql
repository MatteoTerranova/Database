-- Connect to ennedue db
\c ennedue

-- Insert Operations

-- Contact
INSERT INTO Contact(FiscalCode, Name, Surname, BirthDate, Email,PhoneNumber, ZIP, Street, Number) VALUES
('MNGSLV89H60Z100C','Silvia','Mengotti','1989-08-20','silviamengotti@gmail.com','3498975114','35017','Via Piave','27'),
('LRNBTT96C01D149A','Lorenzo','Bottiglia','1996-03-01','lorenzo01@gmail.com','3458975211','36061','Via San Giuseppe ','1'),
('RSSNRD85D05A044I','Andrea','Rossi','1985-04-05',NULL,'3281515616','30012','Via II Febbraio',12),
('RSSGVN76A15E189E','Giovanni','Rossi','1976-01-15','giogio@libero.it','3494949122','36061','Via Santuario','16'),
('BRNGNN64G46H005D','Gianna','Bruni','1964-07-06',NULL,'3271231112','34815','Via Roma','37/A'),
('VLNLIA88A01A007M','Iia','Valencia','1988-01-01','ilia88@hotmail.com','3251516878','36116','Via Verci','22'),
('BRDSRA77C43M401T','Sara','Bardi','1977-03-03','sara0303@hotmail.com','3411579852','36061','Via Marinali','14');
('RSSMRA70A01L726S','Mario','Rossi','1970-01-01','sigrossi@hotmail.com','3271818523','35082','Via Costa','11/C');
('PVNTHM56M14A001M','Thomas','Pavam','1956-10-14',NULL,'3448972123','34014','Via Adriatico','46');


-- Employee
INSERT INTO Employee(FiscalCode, Username, Password, IBAN, HourlyWage, Role ) VALUES
('LRNBTT96C01D149A','bottiglialore','1996lorenzo','IT96Z9645879900115684001800','6.50','Employee'),
('RSSGVN76A15E189E','rossigio76','giovanni1976','IT46A0258760055890317000011','6.50','Employee'),
('BRNGNN64G46H005D','brunigianna46','missbruni46','IT01M0700001145620000002315','12.50','Chief'),
('MNGSLV89H60Z100C','mengottisilvia100','silvia1234.','IT47A0789560000002516182022','9.30','Area Manager');


-- Customer
INSERT INTO Cutomer(FiscalCode,Note) VALUES
('RSSMRA70A01L726S',NULL),
('PVNTHM56M14A001M','Very Polite'),
('RSSNRD85D05A044I','Good customer'),
('BRDSRA77C43M401T',NULL);

-- Project
INSERT INTO Project(ProjectID, Title, StartDate, EndDate, Location, Quote, Deadline, EstimeateHours, HoursSpent) VALUES
('de7c222e-98f0-4eae-b690-7fb37a246bdd','The New House','2018-03-01',NULL,'Padova',

a-gennaio
b-febbraio
c-marzo
d-aprile
e-maggio
f-giugno
g-luglio
h-agosto
i-settembre
m-ottobre
n-novembre
o-dicembre