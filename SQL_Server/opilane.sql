--AB loomine

CREATE DATABASE LitvinenkoBase;
USE LitvinenkoBase;

CREATE TABLE opilane(
	opilaneID int primary key identity(1, 1),
	eesnimi varchar(25) NOT NULL,
	perenimi varchar(25) NOT NULL,
	synniaeg date,
	stip bit,
	aadress text,
	keskmine_hinne decimal(2, 1)
);

--andmete lisamine tabelisse
INSERT INTO opilane(eesnimi,  perenimi,  synniaeg,  stip, keskmine_hinne) 
VALUES(
	'Nikita', 
	'Nikita', 
	'2000-12-12', 
	1,
	4.5
);

INSERT INTO opilane(eesnimi,  perenimi,  synniaeg,  stip, keskmine_hinne) 
VALUES(
	'Nikita2', 
	'Nikita2', 
	'2000-12-12', 
	1,
	4.5
);

SELECT * FROM opilane;

--tabeli kustutamine
--DROP TABLE opilane;

DELETE FROM opilane;

--rida kustutamine, kus on opilandID = 2
DELETE FROM opilane WHERE opilaneID=2;

--andmete uuendamine
UPDATE opilane SET aadress='Tartu' WHERE opilaneID=3;

--//=========================================================

CREATE TABLE Language(
	ID int NOT NULL primary key,
	code char(3) NOT NULL,
	Language varchar(50) NOT NULL,
	IsOfficial bit,
	Percentage smallint
);

--DROP TABLE Language;
SELECT * FROM Language;

INSERT INTO Language(ID, Code, Language) 
VALUES
	(1, 'EST', 'eesti'), 
	(2, 'RUS', 'vene'), 
	(3, 'ENG', 'inglise'),
	(4, 'DE', 'saksa');

--//=========================================================

CREATE TABLE KeeleValik(
	keeleValikID int primary key identity(1,1),
	valikuNimetus varchar(10) NOT NULL,
	opilaneID int,
	Foreign key (opilaneID) references opilane(opilaneID),
	languageID int,
	Foreign key (languageID) references Language(ID)
);

--DROP TABLE KeeleValik;

SELECT * FROM KeeleValik;
SELECT * FROM Language;
SELECT * FROM opilane;

INSERT INTO KeeleValik(valikuNimetus, opilaneID, languageID)
VALUES 
	('valik A', 1, 1),
	('valik B', 1, 2),
	('valik C', 1, 3),
	('valik A', 2, 3);

SELECT opilane.opilaneID, opilane.eesnimi, Language.Language
FROM opilane, Language, KeeleValik 
	WHERE opilane.opilaneID=KeeleValik.opilaneID AND
	Language.ID=KeeleValik.languageID;

SELECT *
FROM opilane, Language, KeeleValik 
	WHERE opilane.opilaneID=KeeleValik.opilaneID AND
	Language.ID=KeeleValik.languageID;

--//=========================================================
--	Ülesanne
--//=========================================================

CREATE TABLE oppimine(
	oppimineID int primary key identity(1, 1),
	aine varchar(50),
	aasta varchar(4),
	opetaja varchar(50),
	opilaneID int,
	Foreign key (opilaneID) references opilane(opilaneID),
	hinne int
);

INSERT INTO oppimine(aine, aasta, opetaja, opilaneID, hinne)
VALUES 
	('Kunst', 
	'2025', 
	'Nikita', 
	10,
	5);

SELECT * FROM oppimine

--//=========================================================
--	Ülesanne 2
--//=========================================================

--//=========================================================
-- Protseduur, mis lisab uus opilane ja kohe näitab tabelis
--//=========================================================
CREATE PROCEDURE AddOpilane ( 
	@eesnimi varchar(25),  
	@perenimi varchar(25),  
	@synniaeg date,  
	@stip bit, 
	@keskmine_hinne decimal(2, 1) ) AS
BEGIN
	SELECT * FROM opilane;
	INSERT INTO opilane(eesnimi,  perenimi,  synniaeg,  stip, keskmine_hinne) 
	VALUES(
		@eesnimi, 
		@perenimi, 
		@synniaeg, 
		@stip,
		@keskmine_hinne
	);
	SELECT * FROM opilane;
END;

EXEC AddOpilane 'Nikita', 'LNikita', '2000-12-12', 1, 4.5;
EXEC AddOpilane 'Nikita1', 'LNikita1', '2001-12-12', 0, 2.5;
EXEC AddOpilane 'Nikita2', 'LNikita2', '2002-12-12', 0, 3.5;
EXEC AddOpilane 'Nikita3', 'LNikita3', '2003-12-12', 1, 4;
EXEC AddOpilane 'Nikita4', 'LNikita4', '2004-12-12', 0, 2;
EXEC AddOpilane 'GNikita5', 'LNikita5', '2005-12-12', 1, 5;
EXEC AddOpilane 'GNikita6', 'ZNikita6', '2002-12-12', 1, 5;

--//=========================================================
-- Protseduur, mis kustutab opilane id järgi
--//=========================================================
CREATE PROCEDURE DeleteOpilaneByID ( @opilaneID int ) AS
BEGIN
	SELECT * FROM opilane;
	DELETE FROM opilane WHERE opilaneID=@opilaneID;
	SELECT * FROM opilane;
END;

EXEC DeleteOpilaneByID 2;

--//=========================================================
-- Protseduur, mis otsib opilane esimese tähte jargi
--//=========================================================
CREATE PROCEDURE FindOpilaneByFirstChar_InFirstName ( @firstChar char(1) ) AS
BEGIN
	SELECT * FROM opilane WHERE eesnimi LIKE @firstChar + '%'; -- % - kõik teised tähed
END;

CREATE PROCEDURE FindOpilaneByFirstChar_InLastName ( @firstChar char(1) ) AS
BEGIN
	SELECT * FROM opilane WHERE perenimi LIKE @firstChar + '%'; -- % - kõik teised tähed
END;

EXEC FindOpilaneByFirstChar_InFirstName 'N';
EXEC FindOpilaneByFirstChar_InFirstName 'G';
EXEC FindOpilaneByFirstChar_InLastName 'Z';

--//=========================================================
-- Protseduur, mis otsib opilane esimese tähte jargi
--//=========================================================
CREATE PROCEDURE SetOpilaneStip ( @opilaneID int, @stip bit ) AS
BEGIN
	SELECT * FROM opilane WHERE opilaneID = @opilaneID; 
	UPDATE opilane SET stip = @stip WHERE opilaneID = @opilaneID; 
	SELECT * FROM opilane WHERE opilaneID = @opilaneID; 
END;

EXEC SetOpilaneStip 5, 1;