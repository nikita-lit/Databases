CREATE DATABASE LitvinenkoDB;
USE LitvinenkoDB;

CREATE TABLE Kasutaja(
	kasutaja_id int PRIMARY KEY IDENTITY(1,1),
	eesnimi varchar(50) NOT NULL,
	perenimi varchar(50),
	email varchar(50) NOT NULL
);

INSERT INTO Kasutaja(eesnimi, perenimi, email)
	VALUES
		('Nikita1', 'NikitaL1', 'Nikita1@mail.com'),
		('Nikita2', 'NikitaL2', 'Nikita2@mail.com'),
		('Nikita3', 'NikitaL3', 'Nikita3@mail.com'),
		('Nikita4', 'NikitaL4', 'Nikita4@mail.com'),
		('Nikita5', 'NikitaL5', 'Nikita5@mail.com');

SELECT * FROM Kasutaja;

--//=========================================================
--
--//=========================================================
CREATE TABLE Kategooria(
	kategooria_id int PRIMARY KEY IDENTITY(1,1),
	kategooria_nimi varchar(50)
);

INSERT INTO Kategooria(kategooria_nimi)
	VALUES
		('Suppid'), ('Magusad'), ('Road'), ('Jookid'), ('Suupisted');

SELECT * FROM Kategooria;
DELETE FROM Kategooria;
DROP TABLE Kategooria;

--//=========================================================
--
--//=========================================================
CREATE TABLE Toiduaine(
	toiduaine_id int PRIMARY KEY IDENTITY(1,1),
	toiduaine_nimi varchar(100)
);

INSERT INTO Toiduaine(toiduaine_nimi)
	VALUES
		('Juust'), ('Munad'), ('Õlu'), ('Vesi'), ('Vorst');

SELECT * FROM Toiduaine;

--//=========================================================
--
--//=========================================================
CREATE TABLE Yhik(
	yhik_id int PRIMARY KEY IDENTITY(1,1),
	yhik_nimi varchar(100)
);

INSERT INTO Yhik(yhik_nimi)
	VALUES
		('ml'), ('l'), ('kg'), ('g'), ('mm');

SELECT * FROM Yhik;

--//=========================================================
--
--//=========================================================
CREATE TABLE Retsept(
	retsept_id int PRIMARY KEY IDENTITY(1,1),
	retsept_nimi varchar(100),
	kirjeldus varchar(200),
	juhend varchar(500),
	sisestatud_kp date,
	kasutaja_id int,
	FOREIGN KEY (kasutaja_id) REFERENCES Kasutaja(kasutaja_id),
	kategooria_id int,
	FOREIGN KEY (kategooria_id) REFERENCES Kategooria(kategooria_id)
);

SELECT * FROM Retsept;
--DROP TABLE Retsept;

INSERT INTO Retsept(retsept_nimi, kirjeldus, juhend, sisestatud_kp, kasutaja_id, kategooria_id)
	VALUES 
		('Pasta', 'Keeta makaroonid', 'Kasuta elektripliit', '2025-12-20', 1, 3),
		('Grill', 'Nii soola', 'Kasuta Aerogrill', '2025-05-15', 4, 3),
		('Mesi', 'Liiga magus', 'Kasuta elektripliit', '2024-11-10', 2, 2),
		('Supp', 'Köögiviljad, puljong', 'Keeda kõik koos, lisa sool ja pipar', '2025-02-14', 3, 1),
		('Kook', 'Võta jahu ja suhkur', 'Sega kõik koostisosad, küpseta ahjus', '2025-03-25', 1, 2),
		('Smuut', 'Banaan, marjad, jogurt', 'Aseta kõik segistisse ja sega ühtlaseks', '2025-01-30', 4, 4),
		('Salat', 'Tomatid, kurk, oliivid', 'Lõika koostisosad, sega kokku', '2025-02-01', 3, 5),
		('Kohv', 'Kohvipulber, vesi', 'Keeda vesi, lisa kohvipulber ja vala tassi', '2025-02-12', 5, 4);

--//=========================================================
--
--//=========================================================
CREATE TABLE Koostis(
	koostis_id int PRIMARY KEY IDENTITY(1,1),
	kogus int,
	retsept_id int,
	FOREIGN KEY (retsept_id) REFERENCES Retsept(retsept_id),
	toiduaine_id int,
	FOREIGN KEY (toiduaine_id) REFERENCES Toiduaine(toiduaine_id),
	yhik_id int,
	FOREIGN KEY (yhik_id) REFERENCES Yhik(yhik_id)
);

--DROP TABLE Koostis;
SELECT * FROM Koostis;

INSERT INTO Koostis(kogus, retsept_id, toiduaine_id, yhik_id)
	VALUES
		(3, 2, 1, 1),
		(666, 4, 2, 2),
		(21, 1, 3, 3),
		(45, 5, 4, 4),
		(1000000, 7, 5, 5);

--//=========================================================
--
--//=========================================================
CREATE TABLE Tehtud(
	tehtud_id int PRIMARY KEY IDENTITY(1,1),
	tehtud_kp date,
	retsept_id int,
	FOREIGN KEY (retsept_id) REFERENCES Retsept(retsept_id)
);

DROP TABLE Tehtud;

--//=========================================================
-- Procedures
--//=========================================================
CREATE PROCEDURE AddKasutaja ( @eesnimi varchar(50), @perenimi varchar(50), @email varchar(50) )
AS
BEGIN
	INSERT INTO Kasutaja(eesnimi, perenimi, email)
	VALUES
		(@eesnimi, @perenimi, @email);
END;

EXEC AddKasutaja 'test', 'test perenim', 'email@test.com';

CREATE PROCEDURE UpdateTable ( 
	@choice varchar(4), 
	@tabelName varchar(20), 
	@columnName varchar(20), 
	@columnType varchar(20) = NULL, 
	@value varchar(100) = NULL,
	@where varchar(100) = NULL ) AS
BEGIN
	DECLARE @sqlAction as varchar(max)
	SET @sqlAction = CASE 
		WHEN @choice='add' THEN CONCAT('ALTER TABLE ', @tabelName, ' ADD ', @columnName, ' ', @columnType)
		WHEN @choice='set' THEN CONCAT('UPDATE ', @tabelName, ' SET ', @columnName, ' = ''', @value, ''' WHERE ', @where)
		WHEN @choice='drop' THEN CONCAT('ALTER TABLE ', @tabelName, ' DROP COLUMN ', @columnName)
	END;

	PRINT @sqlAction;
	BEGIN
		EXEC (@sqlAction);
	END;
END;

DROP PROCEDURE UpdateTable;

EXEC UpdateTable 
	@choice='set', 
	@tabelName='Kasutaja', 
	@columnName='email', 
	@value='gmail@gmail.gmail',
	@where='kasutaja_id = 3';

SELECT * FROM Kasutaja;