-- Quando employee aggiunge ore in timeslot -> consistency col project hoursspent (aggiungi ore spese al totale)
-- Hourly wage di timeslot dev'essere uguale a hourly wage di employee -> lancia errore
	
CREATE FUNCTION updateHoursSpent() RETURNS TRIGGER AS $$
DECLARE

	-- number of hours spent on a certain project
	HoursSpent INT;
	
BEGIN
	
	SELECT p.ProjectID, Child, Hours, p.HoursSpent AS Risotto
		FROM Task AS T INNER JOIN TimeSlot AS TS
			ON T.TaskID = TS.TaskID
				INNER JOIN Compose AS C
					ON TS.TaskID = C.Child
						INNER JOIN Project AS P
							ON C.Child = P.ProjectID;
							
	UPDATE Project
		SET HoursSpent = HoursSpent + Risotto.Hours
		WHERE Project.ProjectID = Risotto.ProjectID;
		
	RETURN Project.HoursSpent;
	
END
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER UpdateHours 
	AFTER INSERT ON TimeSlot
	FOR EACH ROW
	EXECUTE PROCEDURE updateHoursSpent();
	
-- Prova:  INSERT INTO timeslot(timeslotid, taskid, timestamp, fiscalcode, notes, hours, hourlywage) VALUES ('de7c222e-98f0-4eae-b690-7fb37a246bee', 'de7c222e-98f0-4eae-b690-7fb37a246bda', '2018-01-01 15:25:13', 'LRNBTT96C01D149A', 'prova', '4', '23');