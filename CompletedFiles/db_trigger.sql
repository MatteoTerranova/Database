-- Quando employee aggiunge ore in timeslot -> consistency col project hoursspent (aggiungi ore spese al totale)
-- Hourly wage di timeslot dev'essere uguale a hourly wage di employee -> lancia errore

DROP TRIGGER IF EXISTS UpdateHours ON TimeSlot;
DROP FUNCTION IF EXISTS updateHoursSpent();
	
CREATE FUNCTION updateHoursSpent() RETURNS TRIGGER AS $$
DECLARE

	-- number of hours spent on a certain project
	
BEGIN
	
	/*SELECT p.projectid
		FROM Task AS T INNER JOIN TimeSlot AS TS
			ON T.TaskID = TS.TaskID
				INNER JOIN Compose AS C
					ON TS.TaskID = C.Child
						INNER JOIN Project AS P
							ON C.ProjectID = P.ProjectID
								WHERE C.Child = '6ef9878a-416e-4782-8e7e-7aa9dd42c140';*/
							
	UPDATE Project
		SET HoursSpent = Project.HoursSpent + NEW.Hours
		WHERE ProjectID IN (SELECT P.ProjectID AS Risotto
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
	
-- Prova:  INSERT INTO TimeSlot(TimeSlotID, TaskID, TimeStamp, Notes, HourlyWage,FiscalCode, Hours) VALUES ('de7c222e-98f0-4eae-b690-7fb37a246bee', '6ef9878a-416e-4782-8e7e-7aa9dd42c140', '2018-01-01 15:25:13', 'prova' , '4', 'RSSGVN76A15E189E', '23');