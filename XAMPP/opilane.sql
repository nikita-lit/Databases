CREATE TABLE opilane(
	opilaneID int PRIMARY KEY AUTO_INCREMENT,
	eesnimi varchar(25) NOT NULL,
	perenimi varchar(25) NOT NULL,
	synniaeg date,
	stip bit,
	aadress text,
	keskmine_hinne decimal(2, 1)
);

--//=========================================================

INSERT INTO opilane(eesnimi, perenimi, synniaeg, stip, keskmine_hinne) 
VALUES 
    ('Nikita1', 'Nik1', '2001-12-12', 1, 5),
    ('Nikita2', 'Nik2', '2002-12-12', 0, 3.5), 
    ('Nikita3', 'Nik3', '2003-12-12', 0, 4), 
    ('Nikita4', 'Nik4', '2004-12-12', 1, 2),
    ('Nikita5', 'Nik5', '2005-12-12', 1, 3),

--//=========================================================

DELETE FROM opilane WHERE opilaneID=2;
UPDATE opilane SET aadress='Tartu' WHERE opilaneID=3;

--//=========================================================

CREATE TABLE Language(
	ID int NOT NULL PRIMARY KEY,
	code char(3) NOT NULL,
	Language varchar(50) NOT NULL,
	IsOfficial bit,
	Percentage smallint
);

INSERT INTO Language(ID, Code, Language) 
VALUES
	(1, 'EST', 'eesti'), 
	(2, 'RUS', 'vene'), 
	(3, 'ENG', 'inglise'),
	(4, 'DE', 'saksa');

--//=========================================================

CREATE TABLE KeeleValik(
	keeleValikID int PRIMARY KEY AUTO_INCREMENT,
	valikuNimetus varchar(10) NOT NULL,
	opilaneID int,
	FOREIGN KEY (opilaneID) REFERENCES opilane(opilaneID),
	languageID int,
	FOREIGN KEY (languageID) REFERENCES Language(ID)
);

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
	oppimineID int PRIMARY KEY AUTO_INCREMENT,
	aine varchar(50),
	aasta varchar(4),
	opetaja varchar(50),
	opilaneID int,
	FOREIGN KEY (opilaneID) REFERENCES opilane(opilaneID),
	hinne int
);

INSERT INTO oppimine(aine, aasta, opetaja, opilaneID, hinne)
VALUES 
	('Kunst', '2025', 'Nikita', 1, 5);