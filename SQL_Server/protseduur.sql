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