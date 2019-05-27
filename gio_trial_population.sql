--Insert Operations


--Contact
INSERT INTO Contact(FiscalCode, Name, Surname, BirthDate, Email,PhoneNumber, ZIP, Street, Number) VALUES
('MNGSLV89H60Z100C','Silvia','Mengotti','1989-08-20','silviamengotti@gmail.com','3498975114','35017','Via Piave',27),
('LRNBTT96C01D149A','Lorenzo','Bottiglia','1996-03-01','lorenzo01@gmail.com','3458975211','36061','Via San Giuseppe ',1),
('RSSNRD85D05A044I','Andrea','Rossi','1985-04-05',NULL,'3281515616','30012','Via II Febbraio',12),
('RSSGVN76A15E189E','Giovanni','Rossi','1976-01-15','giogio@libero.it','3494949122','36061','Via Santuario',16),
('BRNGNN64G46H005D','Gianna','Bruni','1964-07-06',NULL,'3271231112','34815','Via Roma',37),
('VLNLIA88A01A007M','Elia','Valencia','1988-01-01','elia88@hotmail.com','3251516878','36116','Via Verci',22),
('BRDSRA77C43M401T','Sara','Bardi','1977-03-03','sara0303@hotmail.com','3411579852','36061','Via Marinali',14),
('RSSMRA70A01L726S','Mario','Rossi','1970-01-01','sigrossi@hotmail.com','3271818523','35082','Via Costa',11),
('PVNTHM56M14A001M','Thomas','Pavan','1956-10-14',NULL,'3448972123','34014','Via Adriatico',46);


--Employee
INSERT INTO Employee(FiscalCode, Username, Password, IBAN, HourlyWage, Role ) VALUES
('LRNBTT96C01D149A','bottiglialore','1996lorenzo','IT96Z9645879900115684001800',6.50,'Employee'),
('RSSGVN76A15E189E','rossigio76','giovanni1976','IT46A0258760055890317000011',7.80,'Employee'),
('BRNGNN64G46H005D','brunigianna46','missbruni46','IT01M0700001145620000002315',12.50,'Chief'),
('MNGSLV89H60Z100C','mengottisilvia100','silvia1234.','IT47A0789560000002516182022',9.30,'Area Manager');


--Customer
INSERT INTO Customer(FiscalCode,Note) VALUES
('RSSMRA70A01L726S','OKkkK'),
('PVNTHM56M14A001M','Good Customer'),
('RSSNRD85D05A044I','Problematic payment issues'),
('BRDSRA77C43M401T','Very polite and punctual');

--Project
INSERT INTO Project(ProjectID, Title, StartDate, EndDate, Location, Quote, Deadline, EstimatedHours, HoursSpent) VALUES
('de7c222e-98f0-4eae-b690-7fb37a246bdd','The New House','2018-03-01',NULL,'Padova','532','2019-12-25',112, 300),
('757ca527-b338-42f5-bbe2-1075d63b492c','New Project','2019-08-15','2020-09-05','Roma','213','2020-09-05',80, 400),
('866adc89-5a04-463b-82a3-3bf0ad77491b','Company Building','2018-04-26','2021-04-01','Venezia','643','2021-06-06',1600, 450);

--Department
INSERT INTO Department(Name, FiscalCode) VALUES
('PlanificationDepartment', 'RSSGVN76A15E189E'),
('VeficationDepartment', 'LRNBTT96C01D149A'),
('ProjectingDepartment', 'MNGSLV89H60Z100C');

--Template
INSERT INTO Template(TemplateID, Description, IsRoot) VALUES
('bf44a0cb-3aad-4aa4-8282-17bae578e1d2','asdas','1'), --consider this as a site-inspection
('4dc57b44-1734-415f-935b-6dac0f812d7d','sas','0'), --consider this as the planimetry done after the site inspection
('f45d74ee-2e30-4f09-a4ae-37df7102f65a','ses','0'), --consider this as the technical report done after site-inspection and planimetry
('02cc96bb-5276-42d7-82e4-ff262aa60efd','sus','0'); --consider this as the drawing done after the above three ones

--Task
--For the first operation insert, I have considered a template and I have specified that the specified task need to be done for that template
INSERT INTO Task(TaskID, IsRoot, Description, EndDate,StartDate, TemplateID, Name) VALUES
('c769d3a6-41d1-4883-9edf-e74a977446ad','0',NULL,'2019-08-25','2019-07-25','bf44a0cb-3aad-4aa4-8282-17bae578e1d2','PlanificationDepartment'),
('7ba08242-0397-4137-9275-e18d8be8ef8e','0','This task needs to be completed 1 week before deadline','2019-10-10','2019-08-10','4dc57b44-1734-415f-935b-6dac0f812d7d','VeficationDepartment'),
('102bcee0-501b-4c63-a5c0-31a82a14a8a5','0',NULL,'2019-04-26','2019-02-15','02cc96bb-5276-42d7-82e4-ff262aa60efd','ProjectingDepartment'),
('6ef9878a-416e-4782-8e7e-7aa9dd42c140','0','Task to be completed carefully','2019-12-01','2019-09-01','02cc96bb-5276-42d7-82e4-ff262aa60efd','VeficationDepartment'),
('103bcee0-501b-4c63-a5c0-31a82a14a8a5',TRUE,NULL,'2019-04-26','2019-02-15','02cc96bb-5276-42d7-82e4-ff262aa60efd','ProjectingDepartment'),
('7ef9878a-416e-4782-8e7e-7aa9dd42c140',FALSE,'Task to be completed carefully','2019-12-01','2019-09-01','02cc96bb-5276-42d7-82e4-ff262aa60efd','VeficationDepartment'),
('104bcee0-501b-4c63-a5c0-31a82a14a8a5',FALSE,NULL,'2019-04-26','2019-02-15','02cc96bb-5276-42d7-82e4-ff262aa60efd','ProjectingDepartment'),
('8ef9878a-416e-4782-8e7e-7aa9dd42c140',FALSE,'Task to be completed carefully','2019-12-01','2019-09-01','02cc96bb-5276-42d7-82e4-ff262aa60efd','VeficationDepartment'),
('9ef9878a-416e-4782-8e7e-7aa9dd42c140',FALSE,'Task to be completed carefully','2019-12-01','2019-09-01','02cc96bb-5276-42d7-82e4-ff262aa60efd','VeficationDepartment'),
('9ef9878a-516e-4782-8e7e-7aa9dd42c140',FALSE,'Task to be completed carefully','2019-12-01','2019-09-01','02cc96bb-5276-42d7-82e4-ff262aa60efd','VeficationDepartment'),

('c869d3a6-41d1-4883-9edf-e74a977446ad','0',NULL,'2019-08-25','2019-07-25','bf44a0cb-3aad-4aa4-8282-17bae578e1d2','PlanificationDepartment'),
('c969d3a6-41d1-4883-9edf-e74a977446ad','0',NULL,'2019-08-25','2019-07-25','bf44a0cb-3aad-4aa4-8282-17bae578e1d2','PlanificationDepartment'),
('c999d3a6-41d1-4883-9edf-e74a977446ad','0',NULL,'2019-08-25','2019-07-25','bf44a0cb-3aad-4aa4-8282-17bae578e1d2','PlanificationDepartment');

--Compose
--In the first operation, the parent is take over and the child is computations of the project The new house
--In the second operation Design is the parent, instead design 2D is the child for the project New project
INSERT INTO Compose(Parent, Child, ProjectID) VALUES
('c769d3a6-41d1-4883-9edf-e74a977446ad','7ba08242-0397-4137-9275-e18d8be8ef8e','de7c222e-98f0-4eae-b690-7fb37a246bdd'),
('102bcee0-501b-4c63-a5c0-31a82a14a8a5','6ef9878a-416e-4782-8e7e-7aa9dd42c140','757ca527-b338-42f5-bbe2-1075d63b492c'),
('103bcee0-501b-4c63-a5c0-31a82a14a8a5','7ef9878a-416e-4782-8e7e-7aa9dd42c140','866adc89-5a04-463b-82a3-3bf0ad77491b'),
('103bcee0-501b-4c63-a5c0-31a82a14a8a5','104bcee0-501b-4c63-a5c0-31a82a14a8a5','866adc89-5a04-463b-82a3-3bf0ad77491b'),
('103bcee0-501b-4c63-a5c0-31a82a14a8a5','8ef9878a-416e-4782-8e7e-7aa9dd42c140','866adc89-5a04-463b-82a3-3bf0ad77491b'),
('8ef9878a-416e-4782-8e7e-7aa9dd42c140','9ef9878a-516e-4782-8e7e-7aa9dd42c140','866adc89-5a04-463b-82a3-3bf0ad77491b'),
('8ef9878a-416e-4782-8e7e-7aa9dd42c140','c869d3a6-41d1-4883-9edf-e74a977446ad','866adc89-5a04-463b-82a3-3bf0ad77491b'),
('9ef9878a-516e-4782-8e7e-7aa9dd42c140','c969d3a6-41d1-4883-9edf-e74a977446ad','866adc89-5a04-463b-82a3-3bf0ad77491b'),
('c869d3a6-41d1-4883-9edf-e74a977446ad','c999d3a6-41d1-4883-9edf-e74a977446ad','866adc89-5a04-463b-82a3-3bf0ad77491b');

--TimeSlot
INSERT INTO TimeSlot(TimeSlotID, TaskID, TimeStamp, Notes, HourlyWage,FiscalCode, Hours) VALUES
('69aed574-6572-42f0-863e-c7ba2260d752','c769d3a6-41d1-4883-9edf-e74a977446ad','2019-07-26 16:32:25+01',NULL,'6.50','LRNBTT96C01D149A','5.5'),
('3e636e45-034a-4269-b868-a0a8958086d4','102bcee0-501b-4c63-a5c0-31a82a14a8a5','2019-03-15 10:05:25+01','Finished the last part the projection','7.80','RSSGVN76A15E189E','3.25'),
('fe2ef85c-752b-4af5-ae67-dfc1f247f979','6ef9878a-416e-4782-8e7e-7aa9dd42c140','2019-10-05 12:14:25+01',NULL,'9.30','MNGSLV89H60Z100C','4.0');

--Request
INSERT INTO Request(FiscalCode, ProjectID) VALUES
('PVNTHM56M14A001M','757ca527-b338-42f5-bbe2-1075d63b492c'),
('BRDSRA77C43M401T','866adc89-5a04-463b-82a3-3bf0ad77491b'),
('RSSMRA70A01L726S','de7c222e-98f0-4eae-b690-7fb37a246bdd');

--OrderTemplate

INSERT INTO OrderTemplate(Child, Parent) VALUES
('4dc57b44-1734-415f-935b-6dac0f812d7d','bf44a0cb-3aad-4aa4-8282-17bae578e1d2'),
('f45d74ee-2e30-4f09-a4ae-37df7102f65a','4dc57b44-1734-415f-935b-6dac0f812d7d'),
('02cc96bb-5276-42d7-82e4-ff262aa60efd','f45d74ee-2e30-4f09-a4ae-37df7102f65a');

--Expense
INSERT INTO Expense(Type) VALUES
('TripExpenses'),
('FuelExpenses'),
('DesignMaterials');

--Has
INSERT INTO Has(TimeSlotID, Type, Cost, Description, HourlyWage) VALUES
('3e636e45-034a-4269-b868-a0a8958086d4','DesignMaterials','250.80','Paper and some other materials needed for the design','4.50'),
('69aed574-6572-42f0-863e-c7ba2260d752','TripExpenses','540.12',NULL,'9.30'),
('fe2ef85c-752b-4af5-ae67-dfc1f247f979','FuelExpenses','320.00','Fuel for 150 km','5.50');

--Document
INSERT INTO Document(DocumentID, Title, Content, TimeStamp, TaskID, Producer) VALUES
('ef88126a-5133-4ce4-aea8-45a5781e54ca', 'After Inspection',?????,'2019-06-25 09:29:25+01','c769d3a6-41d1-4883-9edf-e74a977446ad','LRNBTT96C01D149A'),
('c7ba2260d752-4af5-034a-a0a8958086d4','Planimetry Computations',????????,'2019-04-25 10:08:25+01','7ba08242-0397-4137-9275-e18d8be8ef8e','RSSGVN76A15E189E'),
('ccdfba04-6725-49cb-8814-c214c35fe3ea', '2D final design',?????,'2019-05-26 13:15:25+01','6ef9878a-416e-4782-8e7e-7aa9dd42c140','RSSGVN76A15E189E'),
('04cfbbab-14ea-4af5-ae67-dfc1f247f979', '2D final design updated',?????,'2019-05-26 14:25:25+01','6ef9878a-416e-4782-8e7e-7aa9dd42c140','LRNBTT96C01D149A');

--Version
INSERT INTO Version( Predecessor, Successor) VALUES
('ccdfba04-6725-49cb-8814-c214c35fe3ea','04cfbbab-14ea-4af5-ae67-dfc1f247f979');

--Validate
INSERT INTO ValidateDocument(DocumentID, FiscalCode, TimeStamp) VALUES
('ef88126a-5133-4ce4-aea8-45a5781e54ca','BRNGNN64G46H005D','2019-06-25 11:29:25+01'),

--Approve
--Shown two cases where one document is validated by the chief and another by the Area Manager
INSERT INTO ApproveDocument(DocumentID, FiscalCode, TimeStamp) VALUES
('04cfbbab-14ea-4af5-ae67-dfc1f247f979','MNGSLV89H60Z100C','2019-05-27 12:25:25+01'),
('c7ba2260d752-4af5-034a-a0a8958086d4','BRNGNN64G46H005D','2019-04-25 30:08:25+01');
