--//=========================================================
-- SQL SALVESTATUD PROTSEDUUR --
-- funktsioon, mis käivitab 
-- serveris mitu SQL tegevust järjest

-- Kasutame SQL Server
--//=========================================================

CREATE DATABASE protseduurLitvinenko;
USE protseduurLitvinenko;

CREATE TABLE City(
	ID int PRIMARY KEY IDENTITY(1,1),
	Name varchar(30),
	Population int
);

SELECT * FROM City;
--DROP TABLE City

INSERT INTO City(Name, Population) 
	VALUES
	('Tallinn', 300000),
	('Narva', 40000),
	('Pärnu', 60000),
	('Rakvere', 10000),
	('Tartu', 90000);

--//=========================================================
-- Protseduuri loomine
-- Protseduur, mis lisab uus linn ja kohe näitab tabelis
--//=========================================================
CREATE PROCEDURE AddCity ( @name varchar(30), @population int ) AS
BEGIN
	INSERT INTO City(Name, Population)
		VALUES (@name, @population);
	SELECT * FROM City;
END;

--DROP PROCEDURE AddCity

-- protseduuri kutse
EXEC AddCity @name = 'City 17', @population = 1000000;

-- lithsam
EXEC AddCity 'City 18', 500000;
EXEC AddCity 'City 19', 200000;
EXEC AddCity 'City 20', 180000;
EXEC AddCity 'City 21', 7000;

--//=========================================================
-- Protseduur, mis kustutab linn id järgi
--//=========================================================
CREATE PROCEDURE DeleteCityByID ( @deleteID int ) AS
BEGIN
	SELECT * FROM City;
	DELETE FROM City WHERE ID=@deleteID;
	SELECT * FROM City;
END;

-- protseduuri kustutamine
--DROP PROCEDURE DeleteCityByID

EXEC DeleteCityByID 2;

--//=========================================================
-- Protseduur, mis otsib linn esimese tähte jargi
--//=========================================================
CREATE PROCEDURE FindCityByFirstChar ( @firstChar char(1) ) AS
BEGIN
	SELECT * FROM City WHERE Name LIKE @firstChar + '%'; -- % - kõik teised tähed
END;

EXEC FindCityByFirstChar 'N';

--//=========================================================
-- tabeli uuendmine
-- rahvaarv kasvab 10% võrra
--//=========================================================
UPDATE City SET Population = Population * 1.1

UPDATE City SET Population = Population * 1.1
WHERE ID=1;

SELECT * FROM City;

--//=========================================================
-- Protseduur, mis suurendab rahvaarvu protsentides
--//=========================================================
CREATE PROCEDURE IncreasePopulationByPercentage ( @cityID int, @percentage decimal(2,1) ) AS
BEGIN
	SELECT * FROM City;
	UPDATE City SET Population = Population * @percentage
	WHERE ID=@cityID;
	SELECT * FROM City;
END;

--DROP PROCEDURE IncreasePopulationByPercentage

EXEC IncreasePopulationByPercentage 1, 1.2;

-- uue veeru lisamine
ALTER TABLE City ADD test int;

-- veeru kustutamine
ALTER TABLE City DROP COLUMN test;

--//=========================================================
-- Protseduur, mis lisab või kustutab veeru
--//=========================================================
CREATE PROCEDURE AddDeleteColumn ( @choice varchar(4), @columnName varchar(20), @columnType varchar(20) = NULL ) AS
BEGIN
	DECLARE @sqlAction as varchar(max)
	SET @sqlAction = CASE 
		WHEN @choice='add' THEN CONCAT('ALTER TABLE City ADD ', @columnName, ' ', @columnType)
		WHEN @choice='drop' THEN CONCAT('ALTER TABLE City DROP COLUMN ', @columnName)
	END;

	PRINT @sqlAction;
	BEGIN
		EXEC (@sqlAction);
	END;
END;

--DROP PROCEDURE AddDeleteColumn;

EXEC AddDeleteColumn 'add', 'test3', 'int';
EXEC AddDeleteColumn 'drop', 'test3';

--//=========================================================
-- Protseduur, mis lisab või kustutab veeru tabelis
--//=========================================================
CREATE PROCEDURE AddDeleteColumnInTable ( @choice varchar(4), @tabelName varchar(20), @columnName varchar(20), @columnType varchar(20) = NULL ) AS
BEGIN
	DECLARE @sqlAction as varchar(max)
	SET @sqlAction = CASE 
		WHEN @choice='add' THEN CONCAT('ALTER TABLE ', @tabelName, ' ADD ', @columnName, ' ', @columnType)
		WHEN @choice='drop' THEN CONCAT('ALTER TABLE ', @tabelName, ' DROP COLUMN ', @columnName)
	END;

	PRINT @sqlAction;
	BEGIN
		EXEC (@sqlAction);
	END;
END;

--DROP PROCEDURE AddDeleteColumnInTable;

EXEC AddDeleteColumnInTable 'add', 'City', 'test4', 'int';
EXEC AddDeleteColumnInTable 'drop', 'City', 'test4';

SELECT * FROM City;

--//=========================================================
-- Protseduur tingimusega
--//=========================================================
CREATE PROCEDURE PopulationRate (@limit int) AS
BEGIN
	SELECT Name, Population, IIF(Population < @limit, 'Small city', 'Big city') AS CitySize FROM City;
END;

--DROP PROCEDURE PopulationRate;

EXEC PopulationRate 100000;

--//=========================================================
-- Agregaat funktsioonid: SUM(), AVG(), MIN(), MAX(), COUNT()
--//=========================================================
CREATE PROCEDURE PopulationInfo AS
BEGIN
	SELECT 
	SUM(Population) AS 'Population Sum', 
	AVG(Population) AS 'Average Population',
	MIN(Population) AS 'Min Population',
	MAX(Population) AS 'Max Population',
	COUNT(*) AS 'Population Column Count'
	FROM City
END;

--DROP PROCEDURE PopulationInfo;

EXEC PopulationInfo;