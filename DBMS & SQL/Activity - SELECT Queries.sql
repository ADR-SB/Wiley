-- Activity 1
SELECT * FROM personaltrainer.exercise;

-- Activity 2
SELECT * FROM personaltrainer.client;

-- Activity 3
SELECT * FROM personaltrainer.client 
WHERE City="Metairie";

-- Activity 4
SELECT * FROM personaltrainer.Client 
WHERE ClientId = '818u7faf-7b4b-48a2-bf12-7a26c92de20c';

-- Activity 5
SELECT COUNT(*) FROM personaltrainer.Goal;

-- Activity 6
SELECT Name, LevelId FROM personaltrainer.Workout;

-- Activity 7
SELECT Name, LevelId, Notes FROM personaltrainer.Workout 
WHERE LevelId = 2;

-- Activity 8
SELECT FirstName, LastName, City FROM personaltrainer.Client 
WHERE City IN ('Metairie', 'Kenner', 'Gretna');

-- Activity 9
SELECT FirstName, LastName, BirthDate FROM personaltrainer.Client 
WHERE BirthDate BETWEEN '1980-01-01' AND '1989-12-31';

-- Activity 10
SELECT FirstName, LastName, BirthDate FROM personaltrainer.Client 
WHERE YEAR(BirthDate) >= 1980 AND YEAR(BirthDate) <= 1989;

-- Activity 11
SELECT COUNT(*) FROM personaltrainer.Login 
WHERE EmailAddress LIKE '%.gov';

-- Activity 12
SELECT COUNT(*) FROM personaltrainer.Login 
WHERE EmailAddress NOT LIKE '%.com';

-- Activity 13
SELECT FirstName, LastName FROM personaltrainer.Client 
WHERE BirthDate IS NULL;

-- Activity 14
SELECT Name FROM personaltrainer.ExerciseCategory 
WHERE ParentCategoryId IS NOT NULL;

-- Activity 15
SELECT Name, Notes FROM personaltrainer.Workout 
WHERE LevelId = 3 AND Notes LIKE '%you%';

-- Activity 16
SELECT FirstName, LastName, City FROM personaltrainer.Client 
WHERE (LastName LIKE 'L%' OR LastName LIKE 'M%' OR LastName LIKE 'N%')
AND City = 'LaPlace';

-- Activity 17
SELECT InvoiceId, Description, Price, Quantity, (Price * Quantity) AS LineItemTotal FROM personaltrainer.InvoiceLineItem 
WHERE (Price * Quantity) BETWEEN 15 AND 25;

-- Activity 18
SELECT * FROM personaltrainer.Client 
WHERE FirstName = 'Estrella' AND LastName = 'Bazely';

SELECT * FROM personaltrainer.Login 
WHERE ClientId = (
SELECT ClientId FROM Client 
WHERE FirstName = 'Estrella' AND LastName = 'Bazely');

-- Activity 19
SELECT WorkoutId FROM personaltrainer.Workout 
WHERE Name = 'This Is Parkour';

SELECT GoalId FROM personaltrainer.WorkoutGoal 
WHERE WorkoutId = (SELECT WorkoutId FROM Workout WHERE Name = 'This Is Parkour');

SELECT Name FROM personaltrainer.Goal 
WHERE GoalId IN (
SELECT GoalId FROM WorkoutGoal 
WHERE WorkoutId = (SELECT WorkoutId FROM Workout WHERE Name = 'This Is Parkour')
);


