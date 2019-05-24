-- Quando employee aggiunge ore in timeslot -> consistency col project hoursspent (aggiungi ore spese al totale)
-- Hourly wage di timeslot dev'essere uguale a hourly wage di employee -> lancia errore

CREATE TRIGGER UpdateHours 
	AFTER INSERT ON TimeSlot
	FOR EACH ROW
	EXECUTE PROCEDURE updateHoursSpent();
	
CREATE FUNCTION updateHoursSpent() RETURNS TRIGGER AS $$
DECLARE
	-- ?
BEGIN
	
	SELECT ProjectID, Child, Hours, HoursSpent AS Risotto
		FROM Task AS T INNER JOIN TimeSlot AS TS
			ON T.TaskID = TS.TaskID
				INNER JOIN Compose AS C
					ON TS.TaskID = C.Child
						INNER JOIN Project AS P
							ON C.Child = P.ProjectID
							
	UPDATE Project
		SET HoursSpent = HoursSpent + Risotto.Hours
		WHERE Project.ProjectID = Risotto.ProjectID