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

-- Subquery for retriving the total number of hours spent by each employeeHours
SELECT Contact.Surname, Contact.Name, Task.TaskID, TimeSlot.Hours 
	FROM Employee 
		INNER JOIN TimeSlot ON Employee.FiscalCode = TimeSlot.FiscalCode
		INNER JOIN Task ON TimeSlot.TaskID = Task.TaskID
		INNER JOIN Contact ON TimeSlot.FiscalCode = Contact.FiscalCode
		
-- Return the eployee that has the highest salary in a certain period
SELECT MAX(DaylySalary) AS Dayly_Salary
FROM(SELECT Employee.FiscalCode, SUM(TimeSlot.Hours * TimeSlot.hourlyWage) AS DaylySalary 
 FROM Employee
 INNER JOIN TimeSlot ON Employee.FiscalCode = TimeSlot.FiscalCode
 INNER JOIN Task ON TimeSlot.TaskID = Task.TaskID
WHERE TimeSlot.CurTime >= '2018-07-01 00:00:00+01'::DATE AND TimeSlot.CurTime < '2018-07-30 23:59:59+01'::DATE
GROUP BY Employee.FiscalCode) AS Count;

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

