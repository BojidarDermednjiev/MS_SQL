--01. Find Names of All Employees by First Name

USE [SoftUni]

SELECT [FirstName], [LastName] FROM [Employees]
 WHERE LEFT([FirstName], 2) = 'SA'

--02. Find Names of All Employees by Last Name

SELECT [FirstName], [LastName] FROM [Employees]
 WHERE [LastName] LIKE '%ei%'

--03. Find First Names of All Employees

SELECT [FirstName] FROM [Employees]
 WHERE
       [DepartmentId] IN (3, 10) AND
        DATEPART(YEAR, [HireDate]) BETWEEN 1995 and 2005

--04. Find All Employees Except Engineers

SELECT [FirstName], [LastName] FROM [Employees]
 WHERE [JobTitle] NOT LIKE '%engineer%'

--05. Find Towns with Name Length

  SELECT [Name] FROM [Towns]
   WHERE
        LEN([Name]) = 5 OR
        LEN([Name]) = 6
ORDER BY [Name] ASC

--06. Find Towns Starting With

  SELECT * FROM [Towns]
   WHERE LEFT([Name], 1) IN ('M', 'K', 'B', 'E')
ORDER BY [Name] ASC

--07. Find Towns Not Starting With

  SELECT * FROM [Towns]
   WHERE LEFT([Name], 1) NOT IN ('R', 'B', 'D')
ORDER BY [Name] ASC

--08. Create View Employees Hired After 2000 Year

CREATE VIEW [V_EmployeesHiredAfter2000] AS
SELECT [FirstName], [LastName]
  FROM [Employees]
 WHERE YEAR([HireDate]) > 2000

--09. Length of Last Name

SELECT [FirstName], [LastName]
  FROM [Employees]
 WHERE LEN([LastName]) = 5

--10. Rank Employees by Salary

SELECT [EmployeeID], [FirstName], [LastName], [Salary],
DENSE_RANK() OVER
(PARTITION  BY [Salary] ORDER BY [EmployeeID])
AS [Rank]
FROM [Employees]
WHERE [Salary] BETWEEN 10000 and 50000
ORDER BY [Salary] DESC

--11. Find All Employees with Rank 2

SELECT * FROM
(
  SELECT [EmployeeID], [FirstName], [LastName], [Salary],
  DENSE_RANK() OVER
  (PARTITION  BY [Salary] ORDER BY [EmployeeID])
  AS [RANK]
  FROM [Employees]
)
AS [RankedSelection]
WHERE [Salary] BETWEEN 10000 AND 50000 AND [RANK] = 2 
ORDER BY [Salary] DESC


--12. Countries Holding 'A' 3 or More Times

USE [Geography]

SELECT [CountryName], [IsoCode] FROM [Countries]
WHERE [CountryName] LIKE '%A%A%A'
ORDER BY [IsoCode]

--13. Mix of Peak and River Names

SELECT 
	[PeakName], 
	[RiverName],
	LOWER(CONCAT(SUBSTRING(PeakName, 1, LEN([PeakName]) - 1), [RiverName])) AS [Mix]
FROM [Peaks], [Rivers]
WHERE RIGHT(PeakName, 1) = LEFT(RiverName, 1)
ORDER BY [Mix]

--14. Games From 2011 and 2012 Year

USE Diablo

SELECT TOP(50) 
	[Name], 	
	FORMAT([Start], 'yyyy-MM-dd') AS [Start]
FROM [Games]
WHERE YEAR([Start]) IN (2011, 2012)
ORDER BY [Start], [Name]

--15. User Email Providers

SELECT 
	[Username], 
	SUBSTRING([Email], CHARINDEX('@', [Email]) + 1, LEN([Email]) - CHARINDEX('@', [Email])) AS [Email Provider]
FROM [Users]
ORDER BY [Email Provider], [Username]

--16. Get Users with IP Address Like Pattern

SELECT [Username], [IpAddress] 
FROM [Users]
WHERE [IpAddress] LIKE '___.1%.%.___'
ORDER BY [Username]

--17. Show All Games with Duration & Part of the Day

SELECT 
	[Name] AS [Game],
	CASE
		WHEN DATEPART(HOUR, [Start]) BETWEEN 0 AND 11 THEN 'Morning'
		WHEN DATEPART(HOUR, [Start]) BETWEEN 12 AND 17 THEN 'Afternoon'
		WHEN DATEPART(HOUR, [Start]) BETWEEN 18 AND 24 THEN 'Evening'
	END AS [Part of the day],
	CASE
		WHEN [Duration] <= 3 THEN 'Extra Short'
		WHEN [Duration] BETWEEN 4 AND 6 THEN 'Short'
		WHEN [Duration] > 6 THEN 'Long'
		WHEN [Duration] IS NULL THEN 'Extra Long'
	END AS [Duration]
FROM [Games]
ORDER BY [Game], [Duration], [Part of the day]

--18. Orders Table


CREATE TABLE [People]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(50) NOT NULL,
	[Birthdate] DATE NOT NULL
)

INSERT INTO [People]([Id], [Name], [Birthdate])
 VALUES
	('Victor', '2000-12-07'),
	('Steven','1992-09-10'),
	('Stephen','1910-09-19'),
	('John','2010-01-06')

SELECT
	[Name],
	DATEDIFF(YEAR, [Birthdate], GETDATE()) AS [Age in Years],
	DATEDIFF(MONTH, [Birthdate], GETDATE()) AS [Age in Months],
	DATEDIFF(DAY, [Birthdate], GETDATE()) AS [Age in Days],
	DATEDIFF(MINUTE, [Birthdate], GETDATE()) AS [Age in Minutes]
FROM [People]