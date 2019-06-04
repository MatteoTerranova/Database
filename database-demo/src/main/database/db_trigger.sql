-- Connect to the database ennedue
\c ennedue

-- When an Employee reports a certain Task, the HourlyWage declared in his dedicated Timeslot must be consistent with the one assigned to him in the Employee relation.
CREATE FUNCTION checkHourlyWage() RETURNS TRIGGER AS $$
	
BEGIN
	
	-- Join the Employee table with the TimeSlot table
	-- Check if the new HourlyWage inserted in TimeSlot is different from the one related to the associated Employee
	IF NOT NEW.HourlyWage IN (SELECT E.HourlyWage
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
	AFTER INSERT OR UPDATE ON TimeSlot
	FOR EACH ROW
	EXECUTE PROCEDURE updateHoursSpent();