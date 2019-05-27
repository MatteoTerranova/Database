-- connect to ennedue db

\c ennedue

-- Stored procedure
-- Positive case
SELECT * FROM viewEmployeeHours('LRNBTT96C01D149A','2018-07-20','2018-08-10');
-- Negative case (generates an error)
SELECT * FROM viewEmployeeHours('LRNBTT96C01D149F','2019-07-01','2019-07-31');

-- Retrieve customer's names, surnames and the names of the projects assigned by them
SELECT surname, name, title
	FROM Contact AS Co INNER JOIN Customer AS Cu ON Co.FiscalCode = Cu.FiscalCode
	INNER JOIN Request AS R ON Cu.FiscalCode = R.FiscalCode
	INNER JOIN Project as P ON R.ProjectID = P.ProjectID
ORDER BY surname, name, title ASC;

-- Retrieve the title of the project and the total effective amount of hours spent on it
SELECT title, hoursSpent 
	FROM Project
ORDER BY title ASC;

-- Retrieve the names of the departments and the number of tasks to which they are assigned
SELECT d.Name, COUNT(TaskID) as number_of_tasks
FROM Department as d LEFT OUTER JOIN TASK AS t ON d.Name = t.Name
GROUP BY d.Name
ORDER BY d.Name ASC;

-- Return how many hours the employees have spent on the projects
SELECT Title, Surname, Name, SUM(employeeHours.Hours) AS Total_Hours
FROM (
	SELECT Contact.Surname, Contact.Name, Task.TaskID, TimeSlot.Hours 
	FROM Employee INNER JOIN TimeSlot ON Employee.FiscalCode = TimeSlot.FiscalCode
	INNER JOIN Task ON TimeSlot.TimeSlotID = Task.TaskID
	INNER JOIN Contact ON TimeSlot.FiscalCode = Contact.FiscalCode
	) AS employeeHours INNER JOIN Compose ON employeeHours.TaskID = Compose.Child OR employeeHours.TaskID = Compose.Parent
	INNER JOIN Project ON Compose.ProjectID = Project.ProjectID
GROUP BY Title, Surname, Name
ORDER BY Title, Surname, Name ASC;

--Display the structure of the projects along with their descriptions
WITH RECURSIVE proj_subpart AS (
	SELECT Parent, Child, ProjectID, 1 AS Depth
	FROM Task as t INNER JOIN Compose AS C 
		ON t.taskID = C.Child
	WHERE isRoot = TRUE
	UNION ALL
	SELECT C.Parent, C.Child, C.ProjectID, Depth + 1
	FROM proj_subpart AS pr INNER JOIN Compose AS C ON C.Parent = pr.Child
)

SELECT p.Title AS Project_Name, tmt.TemplateID AS Task_Description, Depth, tmt.Description AS General_task_description
	FROM Project AS p INNER JOIN proj_subpart AS ps ON p.ProjectID = ps.ProjectID
	INNER JOIN Task AS t ON ps.Child = t.taskID
	INNER JOIN Template AS tmt ON t.TemplateID = tmt.TemplateID
ORDER BY p.Title, Depth ASC;

