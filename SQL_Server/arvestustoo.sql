CREATE DATABASE VoistlusAB;
USE VoistlusAB;

-- ====================================
-- 1., 2.
-- ====================================
CREATE TABLE Turniir (
	TurniirID int PRIMARY KEY IDENTITY(1,1),
	TurniirNimi varchar(50),
);

CREATE TABLE Võistlus (
	VoistlusID int PRIMARY KEY IDENTITY(1,1),
	VostlusNimi varchar(50),
	OsalejateArv int,
	TurniirID int FOREIGN KEY REFERENCES Turniir(TurniirID),
);

CREATE TABLE Osaleja (
	OsalejaID int PRIMARY KEY IDENTITY(1,1),
	OsalejaNimi varchar(50),
	VoistlusID int FOREIGN KEY REFERENCES Võistlus(VoistlusID),
);

-- ====================================
-- 3.
-- ====================================
GRANT SELECT, INSERT ON Võistlus TO opilaneNimi;
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
-- DROP TABLE Võistlus;
-- DROP TABLE Turniir;
-- DELETE FROM logi;

-- ====================================
-- 5.
-- ====================================
CREATE TRIGGER trVõistlusKustutamine
	ON Võistlus FOR DELETE
	AS
		INSERT INTO Logi(kasutaja, kuupaev, tegevus, andmed) SELECT
			SYSTEM_USER, 
			GETDATE(), 
			'DELETE Võistlus', 
			CONCAT('Kustatatud tabelist: ', deleted.VostlusNimi, ', ', deleted.OsalejateArv, ', turniir: ', turniir.TurniirNimi) 
				FROM deleted
				INNER JOIN turniir ON Turniir.TurniirID = deleted.TurniirID;

-- ====================================
-- 6.
-- ====================================
CREATE TRIGGER trVõistlusLisamine
	ON Võistlus FOR INSERT
	AS
		INSERT INTO Logi(kasutaja, kuupaev, tegevus, andmed) SELECT
			SYSTEM_USER, 
			GETDATE(), 
			'INSERT Võistlus', 
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
			CONCAT('Vanad: ', deleted.OsalejaNimi, ', võistlus: ', v1.VostlusNimi,
				   ' /// Uued: ', inserted.OsalejaNimi, ', võistlus: ', v2.VostlusNimi) 
				FROM deleted INNER JOIN inserted ON deleted.OsalejaID = inserted.OsalejaID
				INNER JOIN Võistlus v1 ON deleted.VoistlusID = v1.VoistlusID
				INNER JOIN Võistlus v2 ON inserted.VoistlusID = v2.VoistlusID;

--DROP TRIGGER trOsalejaUuendamine

-- ====================================
-- 7., 8.
-- ====================================
INSERT INTO Turniir (TurniirNimi)
	VALUES 
		('Test Turniir 2025'), 
		('Test Turniir 2024');

-- ====================================
INSERT INTO Võistlus (VostlusNimi, OsalejateArv, TurniirID)
	VALUES 
		('Võistlus 1', 120, 1), 
		('Võistlus 2', 150, 1), 
		('Võistlus 3', 80, 2);

DELETE FROM Võistlus WHERE VostlusNimi = 'Võistlus 1'

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
SELECT * FROM Võistlus;
SELECT * FROM Osaleja;

UPDATE Võistlus SET OsalejateArv = 1;
DELETE FROM Võistlus;

CREATE TABLE tabel (test int)

-- ====================================
-- 10.
-- ====================================
CREATE PROCEDURE prKuvaKõikVõistlusrühmad (@turniirnimi varchar(50))
AS 
BEGIN
	SELECT VostlusNimi, OsalejateArv FROM Võistlus 
	INNER JOIN Turniir ON Võistlus.TurniirID = Turniir.TurniirID 
	WHERE Turniir.TurniirNimi = @turniirnimi
END;

-- DROP PROCEDURE prKuvaKõikVõistlusrühmad

EXEC prKuvaKõikVõistlusrühmad 'Test Turniir 2025'

-- ====================================
-- 11., 12.
-- ====================================
BEGIN TRANSACTION;

	INSERT INTO Turniir (TurniirNimi)
		VALUES ('Test Turniir 2023');

SAVE TRANSACTION sp1;

	INSERT INTO Võistlus (VostlusNimi, OsalejateArv, TurniirID)
		VALUES 
			('Võistlus 4', 80, 1);

ROLLBACK TRANSACTION sp1;

COMMIT TRANSACTION;

SELECT * FROM Turniir;
SELECT * FROM Võistlus;

-- ====================================
-- 13. Oma andmebaasi tegevus
-- Näitab turniiri statistikat. Võistluste ja osalejate arvu.
-- ====================================
CREATE VIEW vwTurniirideStatistika AS
	SELECT 
		Turniir.TurniirNimi,
		COUNT(Võistlus.VoistlusID) AS VõistlusteArv, 
		SUM(Võistlus.OsalejateArv) AS OsalejateArv 
	FROM Võistlus
	INNER JOIN Turniir ON Võistlus.TurniirID = Turniir.TurniirID 
	GROUP BY TurniirNimi

SELECT * FROM vwTurniirideStatistika;