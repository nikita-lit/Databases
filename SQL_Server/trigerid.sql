CREATE DATABASE LitvinenkoTriggers;
USE LitvinenkoTriggers;

CREATE TABLE Linnad(
	linnID int PRIMARY KEY IDENTITY(1, 1),
	linnanimi varchar(15),
	rahvaarv int
);

--tabel logi näitab adminile kuidas table linnad kasutatakse, 
--tabel logi täidab triger
CREATE TABLE Logi(
	id int PRIMARY KEY IDENTITY(1, 1),
	aeg DATETIME,
	toiming  varchar(100),
	andmed varchar(200),
	kasutaja varchar(100),
);

--INSERT TRIGER, mis jälgib tabeli linnad täitmine
CREATE TRIGGER LinnaLisamine
ON Linnad FOR INSERT
AS
	INSERT INTO Logi (aeg, kasutaja, toiming, andmed) 
		SELECT GETDATE(), SYSTEM_USER, 'Linn on lisatud', inserted.linnanimi FROM inserted;

--trigeri tegevuse kontroll
INSERT INTO Linnad(linnanimi, rahvaarv) 
	VALUES ('Tallinn', 650000);

SELECT * FROM Linnad;
SELECT * FROM Logi;

--DELETE TRIGGER, jälgib linna kustatamine tabelis linnad
CREATE TRIGGER LinnaKustutamine
ON Linnad FOR DELETE
AS
	INSERT INTO Logi (aeg, kasutaja, toiming, andmed) 
		SELECT GETDATE(), SYSTEM_USER, 'Linn on kustutatud', deleted.linnanimi FROM deleted;

--kontroll
DELETE FROM Linnad WHERE linnID = 1;

--UPDATE TRIGGER
CREATE TRIGGER LinnaUuendamine
ON Linnad FOR UPDATE
AS
	INSERT INTO Logi (aeg, kasutaja, toiming, andmed) SELECT 
		GETDATE(), 
		SYSTEM_USER, 
		'Linn on uuendatud', 
		CONCAT('vanad andmed: ', deleted.linnanimi, ', rahvaarv: ', deleted.rahvaarv, ' - uued andmed: ', inserted.linnanimi, ', rahvaarv: ', inserted.rahvaarv) 
	FROM deleted 
		INNER JOIN inserted ON 
			deleted.linnID = inserted.linnID;

--kontroll
UPDATE Linnad SET rahvaarv = 650001 WHERE linnID = 2;
