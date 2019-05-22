-- Connect to ennedue db
\c ennedue

-- Insert Operations

-- Contact
INSERT INTO Contact(FiscalCode, Name, Surname, BirthDate, Email,PhoneNumber, ZIP, Street, Number) VALUES
('MNGSLV89H60Z100C','Silvia','Mengotti','1989-08-20','silviamengotti@gmail.com','3498975114','35017','Via Piave','27'),
('LRNBTT96C01D149A','Lorenzo','Bottiglia','1996-03-01','lorenzo01@gmail.com','3458975211','36061','Via San Giuseppe ','1'),
('RSSNRD85D05A044I','Andrea','Rossi','1985-04-05',NULL,'3281515616','30012','Via II Febbraio','12'),
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
INSERT INTO Customer(FiscalCode,Note) VALUES
('RSSMRA70A01L726S',NULL),
('PVNTHM56M14A001M','Good Customer'),
('RSSNRD85D05A044I','Problematic payment issues'),
('BRDSRA77C43M401T','Very polite and punctual');


--Project
INSERT INTO Project(ProjectID, Title, StartDate, EndDate, Location, Quote, Deadline, EstimatedHours, HoursSpent) VALUES
('de7c222e-98f0-4eae-b690-7fb37a246bdd','The New House','2018-03-01',NULL,'Padova',??,'2019-02-25','112','15'),
('757ca527-b338-42f5-bbe2-1075d63b492c','New Project','2019-08-15','2020-09-05','Roma',??,'2020-09-05','80','2'),
('866adc89-5a04-463b-82a3-3bf0ad77491b','Company Building','2018-04-26','2021-04-01','Venezia',??,'2021-06-06','1600','202');

--Request
INSERT INTO Request(FiscalCode, ProjectID) VALUES
('PVNTHM56M14A001M','757ca527-b338-42f5-bbe2-1075d63b492c'),
('BRDSRA77C43M401T','866adc89-5a04-463b-82a3-3bf0ad77491b'),
('RSSMRA70A01L726S','de7c222e-98f0-4eae-b690-7fb37a246bdd');

--Department
INSERT INTO Department(Name, FiscalCode) VALUES
('Design', 'RSSGVN76A15E189E'),
('Design 2D', 'LRNBTT96C01D149A'),
('Design 3D', 'MNGSLV89H60Z100C');

--Template
INSERT INTO Template(TemplateID, Description, IsRoot) VALUES
('bf44a0cb-3aad-4aa4-8282-17bae578e1d2',??,'1'),
('4dc57b44-1734-415f-935b-6dac0f812d7d',??,'0'),
('f45d74ee-2e30-4f09-a4ae-37df7102f65a',??,'1'),
('02cc96bb-5276-42d7-82e4-ff262aa60efd',??,'1'),
('102bcee0-501b-4c63-a5c0-31a82a14a8a5',??,'0');


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
