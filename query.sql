-- connect to ennedue db

\c ennedue

-- Retrieve customer's names, surnames and the names of the projects assigned by them
SELECT name, surname, title
	FROM Contact AS Co INNER JOIN Customer AS Cu
		ON Co.FiscalCode = Cu.FiscalCode
	INNER JOIN Request AS R
		ON Cu.FiscalCode = R.FiscalCode
	INNER JOIN Project as P 
		ON R.ProjectID = P.ProjectID;

-- test
SELECT * --CU.FiscalCode
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
WITH RECURSIVE proj_subpart(Parent, Child, projectID) AS (
	SELECT Parent, Child, ProjectID
	FROM Task as t INNER JOIN Compose AS C 
		ON t.taskID = C.Parent
	WHERE t.isRoot = true
	UNION
	SELECT C.Parent, C.Child, C.ProjectID
	FROM proj_subpart AS pr INNER JOIN Compose AS C 
		ON C.Parent = pr.Child
)

WITH proj_lastpart(Parent, Child, projectID) AS(
	SELECT Parent, Child, projectID
	FROM proj_subpart AS ps
	WHERE ps.Child IS NULL
)
	
SELECT title, COUNT(*) AS workers_number
	FROM Project AS p INNER JOIN proj_lastpart AS pr
		ON p.ProjectID = pr.ProjectID
	INNER JOIN Task AS t 
		ON pr.taskID_child = t.taskID
	INNER JOIN TimeSlot AS ts 
		ON t.taskID = ts.taskID
	INNER JOIN Employee AS e 
		ON ts.FiscalCode = e.FiscalCode
	GROUP BY title;