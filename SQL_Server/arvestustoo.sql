CREATE DATABASE VoistlusAB;
USE VoistlusAB;

-- ====================================
-- 1., 2.
-- ====================================
CREATE TABLE Turniir (
	TurniirID int PRIMARY KEY IDENTITY(1,1),
	TurniirNimi varchar(50),
);

CREATE TABLE V�istlus (
	VoistlusID int PRIMARY KEY IDENTITY(1,1),
	VostlusNimi varchar(50),
	OsalejateArv int,
	TurniirID int FOREIGN KEY REFERENCES Turniir(TurniirID),
);

CREATE TABLE Osaleja (
	OsalejaID int PRIMARY KEY IDENTITY(1,1),
	OsalejaNimi varchar(50),
	VoistlusID int FOREIGN KEY REFERENCES V�istlus(VoistlusID),
);

-- ====================================
-- 3.
-- ====================================
GRANT SELECT, INSERT ON V�istlus TO opilaneNimi;
GRANT SELECT, INSERT ON Turniir TO opilaneNimi;
GRANT SELECT, INSERT ON Osaleja TO opilaneNimi;

-- ====================================
-- 4.
-- ====================================
CREATE TABLE logi (
	id int PRIMARY KEY IDENTITY(1,1),
	kasutaja varchar(100),
	kuupaev datetime, 
	tegevus varchar(100), 
	andmed varchar(200), 
);

-- DROP TABLE Logi;
-- DROP TABLE Osaleja;
-- DROP TABLE V�istlus;
-- DROP TABLE Turniir;
-- DELETE FROM logi;

-- ====================================
-- 5.
-- ====================================
CREATE TRIGGER trV�istlusKustutamine
	ON V�istlus FOR DELETE
	AS
		INSERT INTO Logi(kasutaja, kuupaev, tegevus, andmed) SELECT
			SYSTEM_USER, 
			GETDATE(), 
			'DELETE V�istlus', 
			CONCAT('Kustatatud tabelist: ', deleted.VostlusNimi, ', ', deleted.OsalejateArv, ', turniir: ', turniir.TurniirNimi) 
				FROM deleted
				INNER JOIN turniir ON Turniir.TurniirID = deleted.TurniirID;

-- ====================================
-- 6.
-- ====================================
CREATE TRIGGER trV�istlusLisamine
	ON V�istlus FOR INSERT
	AS
		INSERT INTO Logi(kasutaja, kuupaev, tegevus, andmed) SELECT
			SYSTEM_USER, 
			GETDATE(), 
			'INSERT V�istlus', 
			CONCAT(inserted.VostlusNimi, ', ', inserted.OsalejateArv, ', turniir: ', turniir.TurniirNimi) 
				FROM inserted
				INNER JOIN turniir ON Turniir.TurniirID = inserted.TurniirID;

-- ====================================
-- 
-- ====================================
CREATE TRIGGER trOsalejaUuendamine
	ON Osaleja FOR UPDATE
	AS
		INSERT INTO Logi(kasutaja, kuupaev, tegevus, andmed) SELECT
			SYSTEM_USER, 
			GETDATE(), 
			'UPDATE Osaleja', 
			CONCAT('Vanad: ', deleted.OsalejaNimi, ', v�istlus: ', v1.VostlusNimi,
				   ' /// Uued: ', inserted.OsalejaNimi, ', v�istlus: ', v2.VostlusNimi) 
				FROM deleted INNER JOIN inserted ON deleted.OsalejaID = inserted.OsalejaID
				INNER JOIN V�istlus v1 ON deleted.VoistlusID = v1.VoistlusID
				INNER JOIN V�istlus v2 ON inserted.VoistlusID = v2.VoistlusID;

--DROP TRIGGER trOsalejaUuendamine

-- ====================================
-- 7., 8.
-- ====================================
INSERT INTO Turniir (TurniirNimi)
	VALUES 
		('Test Turniir 2025'), 
		('Test Turniir 2024');

-- ====================================
INSERT INTO V�istlus (VostlusNimi, OsalejateArv, TurniirID)
	VALUES 
		('V�istlus 1', 120, 1), 
		('V�istlus 2', 150, 1), 
		('V�istlus 3', 80, 2);

DELETE FROM V�istlus WHERE VostlusNimi = 'V�istlus 1'

-- ====================================
INSERT INTO Osaleja (OsalejaNimi, VoistlusID)
	VALUES 
		('Nikita', 2), 
		('Ivan', 3), 
		('Vladislav', 3);

UPDATE Osaleja SET OsalejaNimi = 'Nikita 2', VoistlusID = 3 WHERE OsalejaNimi = 'Nikita'

-- ====================================
-- 9.
-- ====================================
SELECT * FROM Logi;
SELECT * FROM Turniir;
SELECT * FROM V�istlus;
SELECT * FROM Osaleja;

UPDATE V�istlus SET OsalejateArv = 1;
DELETE FROM V�istlus;

CREATE TABLE tabel (test int)

-- ====================================
-- 10.
-- ====================================
CREATE PROCEDURE prKuvaK�ikV�istlusr�hmad (@turniirnimi varchar(50))
AS 
BEGIN
	SELECT VostlusNimi, OsalejateArv FROM V�istlus 
	INNER JOIN Turniir ON V�istlus.TurniirID = Turniir.TurniirID 
	WHERE Turniir.TurniirNimi = @turniirnimi
END;

-- DROP PROCEDURE prKuvaK�ikV�istlusr�hmad

EXEC prKuvaK�ikV�istlusr�hmad 'Test Turniir 2025'

-- ====================================
-- 11., 12.
-- ====================================
BEGIN TRANSACTION;

	INSERT INTO Turniir (TurniirNimi)
		VALUES ('Test Turniir 2023');

SAVE TRANSACTION sp1;

	INSERT INTO V�istlus (VostlusNimi, OsalejateArv, TurniirID)
		VALUES 
			('V�istlus 4', 80, 1);

ROLLBACK TRANSACTION sp1;

COMMIT TRANSACTION;

SELECT * FROM Turniir;
SELECT * FROM V�istlus;

-- ====================================
-- 13. Oma andmebaasi tegevus
-- N�itab turniiri statistikat. V�istluste ja osalejate arvu.
-- ====================================
CREATE VIEW vwTurniirideStatistika AS
	SELECT 
		Turniir.TurniirNimi,
		COUNT(V�istlus.VoistlusID) AS V�istlusteArv, 
		SUM(V�istlus.OsalejateArv) AS OsalejateArv 
	FROM V�istlus
	INNER JOIN Turniir ON V�istlus.TurniirID = Turniir.TurniirID 
	GROUP BY TurniirNimi

SELECT * FROM vwTurniirideStatistika;