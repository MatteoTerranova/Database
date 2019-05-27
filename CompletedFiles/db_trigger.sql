-- Connect to the database ennedue
\c ennedue

-- ************************************************** HOURLY WAGE CONSISTENCY CHECK ***********************************************************
-- When an Employee reports a certain Task, the HourlyWage declared in his dedicated Timeslot must be consistent with the one assigned to him in the Employee relation.
CREATE FUNCTION checkHourlyWage() RETURNS TRIGGER AS $$
	
BEGIN
	
	-- Join the Employee table with the TimeSlot table
	-- Check if the new HourlyWage inserted in TimeSlot is different from the one related to the associated Employee
	IF NOT NEW.HourlyWage = (SELECT E.HourlyWage
								FROM Employee AS E INNER JOIN TimeSlot AS TS
								ON E.FiscalCode = TS.FiscalCode
								WHERE TS.TaskID = NEW.TaskID) THEN
		
		-- If not, the new TimeSlot data cannot be inserted.
		RAISE EXCEPTION 'Inconsistent Hourly Wage %.', NEW.HourlyWage USING HINT = 'Please check correctness';
	END IF;
		
	RETURN NEW;
	
END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER CheckWage 
	AFTER INSERT ON TimeSlot
	FOR EACH ROW
	EXECUTE PROCEDURE checkHourlyWage();
	
-- Test: INSERT INTO TimeSlot(TimeSlotID, TaskID, TimeStamp, Notes, HourlyWage,FiscalCode, Hours) VALUES ('69aed574-6572-42f0-863e-c7ba2260d752','c769d3a6-41d1-4883-9edf-e74a977446ad','2019-07-26 16:32:25+01',NULL,'7.50','LRNBTT96C01D149A','5.5');

-- ********************************************************** HOURS SPENT UPDATE ***************************************************************
	
DROP TRIGGER IF EXISTS UpdateHours ON TimeSlot;
DROP FUNCTION IF EXISTS updateHoursSpent();
	
-- When an Employee inserts new data into the TimeSlot table, the total amout of HoursSpent for the Project must be updated by adding the new ones.
CREATE FUNCTION updateHoursSpent() RETURNS TRIGGER AS $$
	
BEGIN
	
	-- Update the Project table
	UPDATE Project
	
		-- Sum the total amount of hours with the inserted ones
		SET HoursSpent = Project.HoursSpent + NEW.Hours
		
		-- Join TimeSlot, Task, Compose and Project tables and select the correct project from the Project table.
		WHERE ProjectID IN (SELECT P.ProjectID
								FROM Task AS T INNER JOIN TimeSlot AS TS
								ON T.TaskID = TS.TaskID
								INNER JOIN Compose AS C
								ON TS.TaskID = C.Child
								INNER JOIN Project AS P
								ON C.ProjectID = P.ProjectID
								WHERE C.Child = NEW.taskid);
		
	RETURN NEW;
	
END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER UpdateHours 
	AFTER INSERT ON TimeSlot
	FOR EACH ROW
	EXECUTE PROCEDURE updateHoursSpent();
	
-- Test:  INSERT INTO TimeSlot(TimeSlotID, TaskID, TimeStamp, Notes, HourlyWage,FiscalCode, Hours) VALUES ('de7c222e-98f0-4eae-b690-7fb37a246bee', '6ef9878a-416e-4782-8e7e-7aa9dd42c140', '2018-01-01 15:25:13', 'prova' , '4', 'RSSGVN76A15E189E', '23');