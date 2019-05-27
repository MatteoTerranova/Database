-- connect to ennedue db
\c ennedue

-- Stored procedure
-- Positive case
SELECT * FROM viewEmployeeHours('LRNBTT96C01D149A','2018-07-20','2018-08-10');
-- Negative case
SELECT * FROM viewEmployeeHours('LRNBTT96C01D149F','2018-07-25','2018-08-10');

-- Retrieve customer's names, surnames and the names of the projects assigned by them
SELECT name, surname, title
	FROM Contact AS Co INNER JOIN Customer AS Cu
		ON Co.FiscalCode = Cu.FiscalCode
	INNER JOIN Request AS R
		ON Cu.FiscalCode = R.FiscalCode
	INNER JOIN Project as P 
		ON R.ProjectID = P.ProjectID;

-- Retrieve alle the information regarding each customer
SELECT *
	FROM Customer AS Cu INNER JOIN Request AS R
		ON Cu.FiscalCode = R.FiscalCode;

-- Retrieve names and surnames of the customers
SELECT name, surname 
	FROM Customer AS Cu INNER JOIN Contact AS Co ON Cu.FiscalCode = Co.FiscalCode;

-- Retrieve the title of the project and the total effective amount of hours spent on it
SELECT title, hoursSpent 
	FROM Project;

-- Retrieve project titles and their respective phases
SELECT title, description
	FROM Project AS P INNER JOIN Compose AS C 
		ON P.ProjectID = C.ProjectID
	INNER JOIN Task AS T 
		ON C.Child = T.taskID; 



--DA SISTEMARE

--Count how many employees are working on each project
--Subquery to obtain 
WITH RECURSIVE proj_subpart AS (
	SELECT Parent, Child, ProjectID, 1 AS Depth
	FROM Task as t INNER JOIN Compose AS C 
		ON t.taskID = C.Parent
	WHERE isRoot = TRUE
	UNION
	SELECT C.Parent, C.Child, C.ProjectID, Depth + 1
	FROM proj_subpart AS pr INNER JOIN Compose AS C 
		ON C.Parent = pr.Child
)
/*
SELECT *
FROM proj_subpart;
*/
/*
WITH proj_lastpart AS (
	SELECT Parent, Child, projectID
	FROM proj_subpart AS ps
	WHERE ps.Child IS NULL
)*/

SELECT p.Title, COUNT(*) AS workers_number

	FROM Project AS p INNER JOIN proj_subpart AS ps
		ON p.ProjectID = ps.ProjectID
	INNER JOIN Task AS t 
		ON ps.Child = t.taskID
	INNER JOIN TimeSlot AS ts 
		ON t.taskID = ts.taskID
	INNER JOIN Employee AS e 
		ON ts.FiscalCode = e.FiscalCode
	WHERE Depth = (SELECT MAX(Depth) 
		FROM proj_subpart)
GROUP BY title, FiscalCode;
	

	
/*
SELECT title, COUNT(*) AS workers_number


	FROM Project AS p INNER JOIN (
		SELECT Child, ProjectID
		FROM proj_subpart AS pr
		WHERE pr.Depth = (
			SELECT 
				MAX(Depth) 
			FROM proj_subpart )
		GROUP BY pr.ProjectID
		) AS pl
		ON p.ProjectID = pl.ProjectID

	INNER JOIN Task AS t 
		ON pl.taskID_child = t.taskID
	INNER JOIN TimeSlot AS ts 
		ON t.taskID = ts.taskID
	INNER JOIN Employee AS e 
		ON ts.FiscalCode = e.FiscalCode
	GROUP BY title;
*/