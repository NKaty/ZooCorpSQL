CREATE DATABASE [ZooCorp];

 GO

 USE [ZooCorp];

 GO

 CREATE TABLE [dbo].[Zoos]
 (
	[ZooID] int IDENTITY(1, 1) NOT NULL,
	[Location] nvarchar(100) NOT NULL,
	CONSTRAINT [PK_Zoos_ZooID] PRIMARY KEY ([ZooID])
 );

 CREATE TABLE [dbo].[Enclosures]
 (
	[EnclosureID] int IDENTITY(1, 1) NOT NULL,
	[ZooID] int NULL,
	[Name] nvarchar(100) NOT NULL,
	[SquareFeet] float NOT NULL,
	CONSTRAINT [PK_Enclosures_EnclosureID] PRIMARY KEY ([EnclosureID]),
	CONSTRAINT [FK_Enclosures_ZooID] FOREIGN KEY ([ZooID])
		REFERENCES [dbo].[Zoos] ([ZooID]) ON DELETE SET NULL ON UPDATE CASCADE
 );

 CREATE TABLE [dbo].[AnimalClasses]
 (
	[ClassID] int IDENTITY(1, 1) NOT NULL,
	[Name] nvarchar(100) NOT NULL UNIQUE,
	CONSTRAINT [PK_AnimalClasses_ClassID] PRIMARY KEY ([ClassID])
 );

 CREATE TABLE [dbo].[AnimalSpecies]
 (
	[SpeciesID] int IDENTITY(1, 1) NOT NULL,
	[ClassID] int NULL,
	[Name] nvarchar(100) NOT NULL UNIQUE,
	[RequiredSpaceSqFt] float NOT NULL,
	CONSTRAINT [PK_AnimalSpecies_SpeciesID] PRIMARY KEY ([SpeciesID]),
	CONSTRAINT [FK_AnimalSpecies_ClassID] FOREIGN KEY ([ClassID])
		REFERENCES [dbo].[AnimalClasses] ([ClassID]) ON DELETE SET NULL ON UPDATE CASCADE
 );

 CREATE TABLE [dbo].[Food]
 (
	[FoodID] int IDENTITY(1, 1) NOT NULL,
	[Name] nvarchar(100) NOT NULL UNIQUE,
	CONSTRAINT [PK_Food_FoodID] PRIMARY KEY ([FoodID])
 );

 CREATE TABLE [dbo].[Medicine]
 (
	[MedicineID] int IDENTITY(1, 1) NOT NULL,
	[Name] nvarchar(100) NOT NULL UNIQUE,
	CONSTRAINT [PK_Medicine_MedicineID] PRIMARY KEY ([MedicineID])
 );

 CREATE TABLE [dbo].[Animals]
 (
	[AnimalID] int IDENTITY(1, 1) NOT NULL,
	[EnclosureID] int NULL,
	[SpeciesID] int NULL,
	[MedicineID] int NULL,
	[IsSick] bit NOT NULL,
	[FeedSchedule] nvarchar(100) NOT NULL,
	CONSTRAINT [PK_Animals_AnimalID] PRIMARY KEY ([AnimalID]),
	CONSTRAINT [FK_Animals_EnclosureID] FOREIGN KEY ([EnclosureID])
		REFERENCES [dbo].[Enclosures] ([EnclosureID]) ON DELETE SET NULL ON UPDATE CASCADE,
	CONSTRAINT [FK_Animals_SpeciesID] FOREIGN KEY ([SpeciesID])
		REFERENCES [dbo].[AnimalSpecies] ([SpeciesID]) ON DELETE SET NULL ON UPDATE CASCADE,
	CONSTRAINT [FK_Animals_MedicineID] FOREIGN KEY ([MedicineID])
		REFERENCES [dbo].[Medicine] ([MedicineID]) ON DELETE SET NULL ON UPDATE CASCADE,
	CONSTRAINT CK_Animals_IsSick_MedicineID CHECK
		(([MedicineID] IS NOT NULL AND [IsSick] = 1) OR (([IsSick] = 0 OR [IsSick] = 1) AND [MedicineID] IS NULL))
 );

 CREATE TABLE [dbo].[FavoriteFood]
 (
	[SpeciesID] int NOT NULL,
	[FoodID] int NOT NULL,
	CONSTRAINT [PK_FavoriteFood_SpeciesID_FoodId] PRIMARY KEY ([SpeciesID], [FoodID]),
	CONSTRAINT [FK_FavoriteFood_SpeciesID] FOREIGN KEY ([SpeciesID])
		REFERENCES [dbo].[AnimalSpecies] ([SpeciesID]) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT [FK_FavoriteFood_FoodID] FOREIGN KEY ([FoodID])
		REFERENCES [dbo].[Food] ([FoodID]) ON DELETE CASCADE ON UPDATE CASCADE
 );

 CREATE TABLE [dbo].[FriendlyWith]
 (
	[SpeciesID] int NOT NULL,
	[WithSpeciesID] int NOT NULL,
	CONSTRAINT [PK_FriendlyWith_SpeciesID_FoodId] PRIMARY KEY ([SpeciesID], [WithSpeciesID]),
	CONSTRAINT [FK_FriendlyWith_SpeciesID] FOREIGN KEY ([SpeciesID])
		REFERENCES [dbo].[AnimalSpecies] ([SpeciesID]) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT [FK_FriendlyWith_WithSpeciesID] FOREIGN KEY ([WithSpeciesID])
		REFERENCES [dbo].[AnimalSpecies] ([SpeciesID]) ON DELETE NO ACTION ON UPDATE NO ACTION
 );

 CREATE TABLE [dbo].[Positions]
 (
	[PositionID] int IDENTITY(1, 1) NOT NULL,
	[Name] nvarchar(50) NOT NULL UNIQUE,
	CONSTRAINT [PK_Positions_PositionID] PRIMARY KEY ([PositionID])
 );

CREATE TABLE [dbo].[Employees]
 (
	[EmployeeID] int IDENTITY(1, 1) NOT NULL,
	[ZooID] int NULL,
	[PositionID] int NULL,
	[FirstName] nvarchar(50) NOT NULL,
	[LastName] nvarchar(50) NOT NULL,
	CONSTRAINT [PK_Employees_EmployeeID] PRIMARY KEY ([EmployeeID]),
	CONSTRAINT [FK_Employees_ZooID] FOREIGN KEY ([ZooID])
		REFERENCES [dbo].[Zoos] ([ZooID]) ON DELETE SET NULL ON UPDATE CASCADE,
	CONSTRAINT [FK_Employees_PositionID] FOREIGN KEY ([PositionID])
		REFERENCES [dbo].[Positions] ([PositionID]) ON DELETE SET NULL ON UPDATE CASCADE
 );

 CREATE TABLE [dbo].[AnimalExperience]
 (
	[EmployeeID] int NOT NULL,
	[SpeciesID] int NOT NULL,
	CONSTRAINT [PK_AnimalExperience_EmployeeID_SpeciesID] PRIMARY KEY ([EmployeeID], [SpeciesID]),
	CONSTRAINT [FK_AnimalExperience_EmployeeID] FOREIGN KEY ([EmployeeID])
		REFERENCES [dbo].[Employees] ([EmployeeID]) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT [FK_AnimalExperience_SpeciesID] FOREIGN KEY ([SpeciesID])
		REFERENCES [dbo].[AnimalSpecies] ([SpeciesID]) ON DELETE CASCADE ON UPDATE CASCADE
 );

 CREATE TABLE [dbo].[FeedTime]
 (
	[FeedTimeID] int IDENTITY(1, 1) NOT NULL,
	[AnimalID] int NOT NULL,
	[EmployeeID] int NOT NULL,
	[FeedTime] datetime2(0) NOT NULL,
	CONSTRAINT [PK_FeedTime_FeedTimeID] PRIMARY KEY ([FeedTimeID]),
	CONSTRAINT [FK_FeedTime_AnimalID] FOREIGN KEY ([AnimalID])
		REFERENCES [dbo].[Animals] ([AnimalID]) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT [FK_FeedTime_EmployeeID] FOREIGN KEY ([EmployeeID])
		REFERENCES [dbo].[Employees] ([EmployeeID]) ON DELETE NO ACTION ON UPDATE NO ACTION
 );