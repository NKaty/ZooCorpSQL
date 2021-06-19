USE [ZooCorp];

 GO

 DECLARE @ID AS int;

 DECLARE @BisonID AS int;
 DECLARE @LionID AS int;
 DECLARE @ElephantID AS int;
 DECLARE @ParrotID AS int;
 DECLARE @PenguinID AS int;
 DECLARE @SnakeID AS int;
 DECLARE @TurtleID AS int;

 DECLARE @GrassID AS int;
 DECLARE @MeatID AS int;
 DECLARE @VegetableID AS int;

-- AnimalClasses - Mammal
INSERT INTO [dbo].[AnimalClasses] VALUES ('Mammal');
SET @ID = @@IDENTITY;

-- AnimalSpecies - Mammals
INSERT INTO [dbo].[AnimalSpecies] VALUES (@ID, 'Bison', 1000);
SET @BisonID = @@IDENTITY;

INSERT INTO [dbo].[AnimalSpecies] VALUES (@ID, 'Lion', 1000);
SET @LionID = @@IDENTITY;

INSERT INTO [dbo].[AnimalSpecies] VALUES (@ID, 'Elephant', 1000);
SET @ElephantID = @@IDENTITY;

-- AnimalClasses - Bird
INSERT INTO [dbo].[AnimalClasses] VALUES ('Bird');
SET @ID = @@IDENTITY;

-- AnimalSpecies - Birds
INSERT INTO [dbo].[AnimalSpecies] VALUES (@ID, 'Parrot', 5);
SET @ParrotID = @@IDENTITY;

INSERT INTO [dbo].[AnimalSpecies] VALUES (@ID, 'Penguin', 10);
SET @PenguinID = @@IDENTITY;

-- AnimalClasses - Reptile
INSERT INTO [dbo].[AnimalClasses] VALUES ('Reptile');
SET @ID = @@IDENTITY;

-- AnimalSpecies - Reptiles
INSERT INTO [dbo].[AnimalSpecies] VALUES (@ID, 'Snake', 2);
SET @SnakeID = @@IDENTITY;

INSERT INTO [dbo].[AnimalSpecies] VALUES (@ID, 'Turtle', 5);
SET @TurtleID = @@IDENTITY;

-- Food
INSERT INTO [dbo].[Food] VALUES ('Grass');
SET @GrassID = @@IDENTITY;

INSERT INTO [dbo].[Food] VALUES ('Meat');
SET @MeatID = @@IDENTITY;

INSERT INTO [dbo].[Food] VALUES ('Vegetable');
SET @VegetableID = @@IDENTITY;

-- Medicine
INSERT INTO [dbo].[Medicine] VALUES
	('Antibiotics'),
	('AntiDepression'),
	('AntiInflammatory');

-- FavoriteFood
INSERT INTO [dbo].[FavoriteFood] VALUES
	(@BisonID, @GrassID),
	(@LionID, @MeatID),
	(@ElephantID, @GrassID),
	(@ParrotID, @VegetableID),
	(@PenguinID, @MeatID),
	(@SnakeID, @MeatID),
	(@TurtleID, @GrassID),
	(@TurtleID, @VegetableID);

-- FriendlyWith
INSERT INTO [dbo].[FriendlyWith] VALUES
	(@BisonID, @BisonID),
	(@BisonID, @ElephantID),
	(@LionID, @LionID),
	(@ElephantID, @ElephantID),
	(@ElephantID, @BisonID),
	(@ElephantID, @ParrotID),
	(@ElephantID, @TurtleID),
	(@ParrotID, @ParrotID),
	(@ParrotID, @BisonID),
	(@ParrotID, @ElephantID),
	(@ParrotID, @TurtleID),
	(@PenguinID, @PenguinID),
	(@SnakeID, @SnakeID),
	(@TurtleID, @TurtleID),
	(@TurtleID, @ParrotID),
	(@TurtleID, @BisonID),
	(@TurtleID, @ElephantID);

-- Positions
INSERT INTO [dbo].[Positions] VALUES
	('ZooKeeper'),
	('Veterinarian');