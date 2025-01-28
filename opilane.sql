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
	ID int NOT NULL PRIMARY KEY,
	code char(3) NOT NULL,
	name varchar(50) NOT NULL,
	IsOfficial bit,
	Percentage smallint,
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
	Foreign key (languageID) references Language(ID),
);

--DROP TABLE KeeleValik;

SELECT * FROM KeeleValik;
SELECT * FROM Language;
SELECT * FROM opilane;

INSERT INTO KeeleValik(valikuNimetus, opilaneID, languageID)
VALUES 
	--('valik A', 1, 1),
	--('valik B', 1, 2),
	--('valik C', 1, 3),
	('valik A', 2, 3);