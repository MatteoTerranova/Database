-- connect to ennedue db

\c ennedue

--Retrieve customer's names, surnames and the names of the projects assigned by them
SELECT name, surname, title
	FROM Customer AS Cu INNER JOIN Contact AS Co
		ON Cu.FiscalCode = Co.FiscalCode
	INNER JOIN Request AS R
		ON Cu.FiscalCode = R.FiscalCode
	INNER JOIN Project as P 
		ON R.ProjectID = P.ProjectID;

--Retrieve names and surnames of the customers
SELECT name, surname 
	FROM Customer AS Cu INNER JOIN Contact AS Co ON Cu.FiscalCode = Co.FiscalCode;

--Retrieve the title of the project and the total effective amount of hours spent on it
SELECT title, hoursSpent 
	FROM Project;

--Retrieve project titles and their respective phases
SELECT title, description
	FROM Project AS P INNER JOIN Compose AS C 
		ON P.ProjectID = C.ProjectID
	INNER JOIN Task AS T 
		ON C.taskid_child = T.taskID; 



--DA SISTEMARE

--Count how many employees are working on each project
--Subquery to obtain 
WITH RECURSIVE proj_subpart(projectID, taskID_parent, taskID_child) AS (
	SELECT projectID, taskID_parent, taskID_child 
	FROM project AS P INNER JOIN Compose AS C 
		ON P.projectID = C.projectID
	INNER JOIN Task AS T 
		ON C.taskID_child = T.taskID
	UNION
	SELECT projectID, taskidID_parent, taskID_child
	FROM proj_subpart AS pr INNER JOIN C 
		ON C.taskidID_parent = pr.taskid_child
)

SELECT title, COUNT(*) AS workers_number
	FROM Project AS p INNER JOIN proj_subpart AS pr
		ON p.ProjectID = pr.ProjectID
	INNER JOIN Task AS t 
		ON pr.taskID_child = t.taskID
	INNER JOIN TimeSlot AS ts 
		ON t.taskID = ts.taskID
	INNER JOIN Employee AS e 
		ON ts.FiscalCode = e.FiscalCode
	GROUP BY title;