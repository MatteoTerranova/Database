-- Connect to ennedue db
\c ennedue

-- Stored procedure to select all the timeslots of an employee in a certain period
-- Replace to modify an existing version of this function
CREATE OR REPLACE FUNCTION viewEmployeeHours(targetEmployeeFiscalCode VARCHAR(16), fromDate DATE, toDate DATE) 
RETURNS TABLE(
    TimeSlotId UUID,
    Hours FLOAT(2)
)

LANGUAGE plpgsql
AS $$

DECLARE 
	-- The fiscal code of the employee
    fiscalCodeEmployee VARCHAR(16);

BEGIN
    -- Check whether the employee fiscal code exists
    SELECT targetEmployeeFiscalCode INTO fiscalCodeEmployee 
		FROM Employee WHERE FiscalCode = targetEmployeeFiscalCode;

    IF NOT FOUND THEN

        RAISE EXCEPTION 'employee fiscal code % does not exist', fiscalCodeEmployee;

    ELSE
        -- Return all the timeslots of the employee
        RETURN QUERY 
			SELECT TimeSlot.TimeSlotID, TimeSlot.Hours 
			FROM Employee 
				INNER JOIN TimeSlot ON Employee.FiscalCode = TimeSlot.FiscalCode
				INNER JOIN Task ON TimeSlot.TimeSlotID = Task.TaskID
			WHERE TimeSlot.CurTime::DATE >= fromDate
				AND TimeSlot.CurTime::DATE < toDate
				AND Employee.FiscalCode = targetEmployeeFiscalCode;

    END IF;
END;
$$;