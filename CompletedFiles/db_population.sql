-- Connect to the database ennedue
\c ennedue

--Insert Operations

--Contact
INSERT INTO Contact(FiscalCode, Name, Surname, BirthDate, Email, PhoneNumber, ZIP, Street, Number) VALUES
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
INSERT INTO Employee(FiscalCode, Username, Password, IBAN, HourlyWage, Role) VALUES
('LRNBTT96C01D149A','bottiglialore','1996lorenzo','IT96Z9645879900115684001800',6.50,'Employee'),
('RSSGVN76A15E189E','rossigio76','giovanni1976','IT46A0258760055890317000011',7.80,'Employee'),
('BRNGNN64G46H005D','brunigianna46','missbruni46','IT01M0700001145620000002315',12.50,'Chief'),
('MNGSLV89H60Z100C','mengottisilvia100','silvia1234.','IT47A0789560000002516182022',9.30,'Area Manager');


--Customer
INSERT INTO Customer(FiscalCode,Note) VALUES
('RSSMRA70A01L726S',NULL),
('PVNTHM56M14A001M','Good Customer'),
('RSSNRD85D05A044I','Problematic payment issues'),
('BRDSRA77C43M401T','Very polite and punctual');

--Project
INSERT INTO Project(ProjectID, Title, StartDate, EndDate, Location, Quote, Deadline, EstimatedHours, HoursSpent) VALUES	-- BETA TEST VALUES FOR EstimatedHours (NEED UPDATE)
('de7c222e-98f0-4eae-b690-7fb37a246bdd','The New House','2018-07-25','2018-08-25','Padova','300','2018-08-30',112,94.00),
('757ca527-b338-42f5-bbe2-1075d63b492c','Bathroom','2018-08-10','2018-10-17','Roma','160','2018-10-20',80,45.00),
('866adc89-5a04-463b-82a3-3bf0ad77491b','Company Building','2019-05-10',NULL,'Venezia','230','2020-01-12',1600,1000.00);

--Request
INSERT INTO Request(FiscalCode, ProjectID) VALUES
('PVNTHM56M14A001M','757ca527-b338-42f5-bbe2-1075d63b492c'),
('BRDSRA77C43M401T','866adc89-5a04-463b-82a3-3bf0ad77491b'),
('RSSMRA70A01L726S','de7c222e-98f0-4eae-b690-7fb37a246bdd');

--Department
INSERT INTO Department(Name, FiscalCode) VALUES
('PlanificationDepartment', 'RSSGVN76A15E189E'),
('VeficationDepartment', 'LRNBTT96C01D149A'),
('ProjectingDepartment', 'MNGSLV89H60Z100C');

--Template
INSERT INTO Template(TemplateID, Description, IsRoot) VALUES	-- TEST VALUES FOR Description (NEED UPDATE)
('concept', 'd1', '1'),
('sketches','d2', '0'),
('architectural model', 'd3', '0'),
('realization', 'd4', '0'),
('architectural executive', 'd5', '1'),
('task assignment', 'd6', '0'),
('details analysis', 'd7', '0'),
('draft', 'd8', '0'),
('drawing', 'd9', '0'),
('computations', 'd10', '0'),
('modelling', 'd11', '0'),
('take-over', 'd12', '0');

--OrderTemplate

INSERT INTO OrderTemplate(Child, Parent) VALUES
('sketches','concept'),
('architectural model','concept'),
('realization','concept'),
('task assignment', 'architectural executive'),
('details analysis','architectural executive'),
('draft','architectural executive'),
('drawing','sketches'),
('computations','sketches'),
('modelling','sketches'),
('take-over','sketches'),
('drawing','architectural model'),
('computations','architectural model'),
('modelling','architectural model'),
('take-over','architectural model'),
('drawing','realization'),
('computations','realization'),
('modelling','realization'),
('take-over','realization'),
('drawing','task assignment'),
('computations','task assignment'),
('modelling','task assignment'),
('take-over','task assignment'),
('drawing','details analysis'),
('computations','details analysis'),
('modelling','details analysis'),
('take-over','details analysis'),
('drawing','draft'),
('computations','draft'),
('modelling','draft'),
('take-over','draft');

--Task
--For the first operation insert, I have considered a template and I have specified that the specified task need to be done for that template
INSERT INTO Task(TaskID, IsRoot, Description, EndDate, StartDate, TemplateID, Name) VALUES
--Project 1
('c769d3a6-41d1-4883-9edf-e74a977446ad','1','The living room must have a large open space.','2018-08-25','2018-07-25','concept','PlanificationDepartment'),
('f77d1e8b-3b5f-491c-987c-8d5d77baba3a','0',NULL,'2018-08-03','2018-07-25','sketches','PlanificationDepartment'),
('e527d149-b101-4bbb-b86f-29ca2ccf6b99','0',NULL,'2018-08-03','2018-07-25','drawing','PlanificationDepartment'),
('353bf9d0-183e-469d-978a-9484f6c25b15','0',NULL,'2018-08-03','2018-07-25','modelling','PlanificationDepartment'),
('fc63b2ab-4aa3-45e7-a5a0-85f1436f81b2','0',NULL,'2018-08-25','2018-08-03','architectural model','PlanificationDepartment'),
('7632306e-63eb-4a48-a630-8891a06580a8','0',NULL,'2018-08-25','2018-08-03','modelling','PlanificationDepartment'),

--Project 2
('bb6a4192-90d6-4f97-ab66-6518d29a3537','1','This task needs to be completed 1 week before deadline.','2018-10-17','2018-08-10','architectural executive','ProjectingDepartment'),
('f23af6d9-6f21-42fd-b35b-e8f9bbc8a753','0',NULL,'2018-10-03','2018-08-10','task assignment','ProjectingDepartment'),
('fe081609-5c64-465c-b96e-e3c7668d72bc','0',NULL,'2018-10-03','2018-08-10','computations','ProjectingDepartment'),
('056d76ff-01c6-4248-9749-8a36a26a1144','0',NULL,'2018-10-03','2018-08-10','take-over','ProjectingDepartment'),
('197dd0f2-56f3-449b-9241-92491a773e5e','0',NULL,'2018-10-10','2018-10-03','draft','ProjectingDepartment'),
('735dcc1b-2843-41de-a74c-c040d6f8155b','0',NULL,'2018-10-10','2018-10-03','drawing','ProjectingDepartment'),
('d17c7007-fa6a-4cbb-bc72-9d51fd6c1796','0',NULL,'2018-10-10','2018-10-03','computations','ProjectingDepartment'),

--Project 3
('e6f40259-69f5-402c-9616-dc58fbd1fb4b','1','Task to be completed carefully.',NULL,'2019-05-10','concept','VeficationDepartment'),
('84a0ee99-4702-41de-8aff-185d257c9dc1','0',NULL,NULL,'2019-05-10','realization','VeficationDepartment'),
('165b25b4-8b44-46eb-b8ca-4becc7e6ca7c','0',NULL,NULL,'2019-05-10','drawing','VeficationDepartment'),
('35e0ef16-edee-4a30-9f46-80b0b959610c','0',NULL,NULL,'2019-05-10','computations','VeficationDepartment'),
('644932c2-c6c5-4872-b6a8-114634c6a472','0',NULL,NULL,'2019-05-10','modelling','VeficationDepartment'),
('850216a6-3c23-4aca-ad7d-ee0b1916bc7b','0',NULL,'2019-05-25','2019-05-10','take-over','VeficationDepartment');

--Compose
INSERT INTO Compose(Parent, Child, ProjectID) VALUES
--Project 1
(NULL,'c769d3a6-41d1-4883-9edf-e74a977446ad','de7c222e-98f0-4eae-b690-7fb37a246bdd'),
('c769d3a6-41d1-4883-9edf-e74a977446ad','f77d1e8b-3b5f-491c-987c-8d5d77baba3a','de7c222e-98f0-4eae-b690-7fb37a246bdd'),
('f77d1e8b-3b5f-491c-987c-8d5d77baba3a','e527d149-b101-4bbb-b86f-29ca2ccf6b99','de7c222e-98f0-4eae-b690-7fb37a246bdd'),
('f77d1e8b-3b5f-491c-987c-8d5d77baba3a','353bf9d0-183e-469d-978a-9484f6c25b15','de7c222e-98f0-4eae-b690-7fb37a246bdd'),
('c769d3a6-41d1-4883-9edf-e74a977446ad','fc63b2ab-4aa3-45e7-a5a0-85f1436f81b2','de7c222e-98f0-4eae-b690-7fb37a246bdd'),
('fc63b2ab-4aa3-45e7-a5a0-85f1436f81b2','7632306e-63eb-4a48-a630-8891a06580a8','de7c222e-98f0-4eae-b690-7fb37a246bdd'),

--Project 2
(NULL,'bb6a4192-90d6-4f97-ab66-6518d29a3537','757ca527-b338-42f5-bbe2-1075d63b492c'),
('bb6a4192-90d6-4f97-ab66-6518d29a3537','f23af6d9-6f21-42fd-b35b-e8f9bbc8a753','757ca527-b338-42f5-bbe2-1075d63b492c'),
('f23af6d9-6f21-42fd-b35b-e8f9bbc8a753','fe081609-5c64-465c-b96e-e3c7668d72bc','757ca527-b338-42f5-bbe2-1075d63b492c'),
('f23af6d9-6f21-42fd-b35b-e8f9bbc8a753','056d76ff-01c6-4248-9749-8a36a26a1144','757ca527-b338-42f5-bbe2-1075d63b492c'),
('bb6a4192-90d6-4f97-ab66-6518d29a3537','197dd0f2-56f3-449b-9241-92491a773e5e','757ca527-b338-42f5-bbe2-1075d63b492c'),
('197dd0f2-56f3-449b-9241-92491a773e5e','735dcc1b-2843-41de-a74c-c040d6f8155b','757ca527-b338-42f5-bbe2-1075d63b492c'),
('197dd0f2-56f3-449b-9241-92491a773e5e','d17c7007-fa6a-4cbb-bc72-9d51fd6c1796','757ca527-b338-42f5-bbe2-1075d63b492c'),

--Project 3
(NULL,'e6f40259-69f5-402c-9616-dc58fbd1fb4b','866adc89-5a04-463b-82a3-3bf0ad77491b'),
('e6f40259-69f5-402c-9616-dc58fbd1fb4b','84a0ee99-4702-41de-8aff-185d257c9dc1','866adc89-5a04-463b-82a3-3bf0ad77491b'),
('84a0ee99-4702-41de-8aff-185d257c9dc1','165b25b4-8b44-46eb-b8ca-4becc7e6ca7c','866adc89-5a04-463b-82a3-3bf0ad77491b'),
('84a0ee99-4702-41de-8aff-185d257c9dc1','35e0ef16-edee-4a30-9f46-80b0b959610c','866adc89-5a04-463b-82a3-3bf0ad77491b'),
('84a0ee99-4702-41de-8aff-185d257c9dc1','644932c2-c6c5-4872-b6a8-114634c6a472','866adc89-5a04-463b-82a3-3bf0ad77491b'),
('84a0ee99-4702-41de-8aff-185d257c9dc1','850216a6-3c23-4aca-ad7d-ee0b1916bc7b','866adc89-5a04-463b-82a3-3bf0ad77491b');

--TimeSlot
--The hours specified in this insertions are added to the total amount of hours dedicated to the project by means of the UpdateHours trigger
INSERT INTO TimeSlot(TimeSlotID, TaskID, CurTime, Notes, HourlyWage, FiscalCode, Hours) VALUES
--Project 1
('69aed574-6572-42f0-863e-c7ba2260d752','353bf9d0-183e-469d-978a-9484f6c25b15','2018-07-25 16:32:25+01',NULL,'6.50','LRNBTT96C01D149A','5.5'),
('e5b6ca51-14e6-4959-b0c4-e9d882a2fcde','353bf9d0-183e-469d-978a-9484f6c25b15','2018-07-28 13:32:25+01',NULL,'6.50','LRNBTT96C01D149A','6.0'),
('6f4fc82d-0e6c-4395-85ab-e6f919620f93','353bf9d0-183e-469d-978a-9484f6c25b15','2018-07-30 18:32:25+01',NULL,'6.50','LRNBTT96C01D149A','18.5'),
('b0426e09-1097-44db-9a55-113c9330ab1e','e527d149-b101-4bbb-b86f-29ca2ccf6b99','2018-08-01 11:32:25+01',NULL,'9.30','MNGSLV89H60Z100C','9.0'),
('ee6b4167-1c71-4b16-9f9d-9ddbeda67c1c','7632306e-63eb-4a48-a630-8891a06580a8','2018-08-24 10:32:25+01',NULL,'9.30','MNGSLV89H60Z100C','4.0'),

--Project 2
('12476d9b-058c-4a71-b33b-bdca507e53c6','fe081609-5c64-465c-b96e-e3c7668d72bc','2018-08-11 16:32:25+01',NULL,'7.80','RSSGVN76A15E189E','2.5'),
('8563d0ef-a842-42c6-b613-b9bf824977bc','056d76ff-01c6-4248-9749-8a36a26a1144','2018-09-03 12:32:25+01',NULL,'7.80','RSSGVN76A15E189E','2.5'),
('976af0cc-ceee-4477-b81e-cf0199bb07bf','735dcc1b-2843-41de-a74c-c040d6f8155b','2018-10-03 14:32:25+01',NULL,'7.80','RSSGVN76A15E189E','6.0'),
('a1001926-a9cf-4b4e-98fa-96ee0d546187','d17c7007-fa6a-4cbb-bc72-9d51fd6c1796','2018-10-09 22:32:25+01',NULL,'7.80','RSSGVN76A15E189E','7.0'),

--Project 3
('31f1de04-e117-4463-8eef-ba0598502e66', '165b25b4-8b44-46eb-b8ca-4becc7e6ca7c','2018-05-10 10:32:25+01',NULL,'12.50','BRNGNN64G46H005D','3.5'),
('1a14cdb1-6d78-4266-b9ea-7e76d8822701', '35e0ef16-edee-4a30-9f46-80b0b959610c','2018-05-14 12:32:25+01',NULL,'12.50','BRNGNN64G46H005D','10.5'),
('2cae32d3-7bf1-435f-b851-9220fb8c2ca1', '644932c2-c6c5-4872-b6a8-114634c6a472','2018-05-17 18:32:25+01',NULL,'12.50','BRNGNN64G46H005D','9.0'),
('7134af62-a1e2-43df-a150-1ec98e44c8fb', '850216a6-3c23-4aca-ad7d-ee0b1916bc7b','2018-05-21 15:32:25+01',NULL,'12.50','BRNGNN64G46H005D','7.5');

--This insertion attempt fails since the specified hourly wage is different from the one declared in the employee table (see trigger CheckWage)
INSERT INTO TimeSlot(TimeSlotID, TaskID, CurTime, Notes, HourlyWage, FiscalCode, Hours) VALUES
('b4614a62-215a-4cbe-a080-4ac35032aeef','353bf9d0-183e-469d-978a-9484f6c25b15','2018-08-02 04:32:25+01',NULL,'6.55','LRNBTT96C01D149A','2.0');

--Expense
INSERT INTO Expense(Type) VALUES
('TripExpenses'),
('FuelExpenses'),
('DesignMaterials');

--Has
INSERT INTO Has(TimeSlotID, Type, Cost, Description) VALUES
('69aed574-6572-42f0-863e-c7ba2260d752','DesignMaterials','250.80','Paper and some other materials needed for the design'),
('12476d9b-058c-4a71-b33b-bdca507e53c6','TripExpenses','540.12',NULL),
('31f1de04-e117-4463-8eef-ba0598502e66','FuelExpenses','320.00','Fuel for 150 km');

--Document
/*INSERT INTO Document(DocumentID, Title, Content, CurTime, TaskID, Producer) VALUES
('ef88126a-5133-4ce4-aea8-45a5781e54ca', 'After Inspection',?????,'2019-06-25 09:29:25+01','c769d3a6-41d1-4883-9edf-e74a977446ad','LRNBTT96C01D149A'),
('c7ba2260d752-4af5-034a-a0a8958086d4','Planimetry Computations',????????,'2019-04-25 10:08:25+01','7ba08242-0397-4137-9275-e18d8be8ef8e','RSSGVN76A15E189E'),
('ccdfba04-6725-49cb-8814-c214c35fe3ea', '2D final design',?????,'2019-05-26 13:15:25+01','6ef9878a-416e-4782-8e7e-7aa9dd42c140','RSSGVN76A15E189E'),
('04cfbbab-14ea-4af5-ae67-dfc1f247f979', '2D final design updated',?????,'2019-05-26 14:25:25+01','6ef9878a-416e-4782-8e7e-7aa9dd42c140','LRNBTT96C01D149A');

--Version
INSERT INTO Version(Predecessor, Successor) VALUES
('ccdfba04-6725-49cb-8814-c214c35fe3ea','04cfbbab-14ea-4af5-ae67-dfc1f247f979');

--Validate
INSERT INTO ValidateDocument(DocumentID, FiscalCode, CurTime) VALUES
('ef88126a-5133-4ce4-aea8-45a5781e54ca','BRNGNN64G46H005D','2019-06-25 11:29:25+01'),

--Approve
--Shown two cases where one document is validated by the chief and another by the Area Manager
INSERT INTO ApproveDocument(DocumentID, FiscalCode, CurTime) VALUES
('04cfbbab-14ea-4af5-ae67-dfc1f247f979','MNGSLV89H60Z100C','2019-05-27 12:25:25+01'),
('c7ba2260d752-4af5-034a-a0a8958086d4','BRNGNN64G46H005D','2019-04-25 30:08:25+01');*/