--//=========================================================
-- Milline tabel tuleks luua?  - Puu
-- Millised väljad tuleks luua? -id, ja veel 3-5 veergu, PuuNimetus, Kõrgus, Hind 
-- Millised protseduurid on vaja teha (vähemalt kolm protseduuri tabeliga töötamise jaoks).

-- Protseduur, mis otsib keskmine hind ja summarne  hind
-- Protseduur, mis liisab ueed andmed  tabelisse 
-- Protseduur, mis otsib puu suurem kui sisestatud hind 
--//=========================================================

CREATE DATABASE PuuAB;
USE PuuAB;

CREATE TABLE Puu(
	ID int PRIMARY KEY IDENTITY(1, 1),
	PuuNimetus varchar(30),
	Korgus decimal(5, 1),
	Hind decimal(5, 2)
);

DELETE FROM Puu;
SELECT * FROM Puu;
--DROP TABLE Puu;

--//=========================================================
-- Protseduur, mis otsib keskmine hind ja summarne hind
--//=========================================================
CREATE PROCEDURE KeskmineJaSummarneHind AS
BEGIN
SELECT 
	AVG(Hind) AS 'Keskmine Hind', 
	SUM(Hind) AS 'Summarne Hind'
	FROM Puu;
END;

--DROP PROCEDURE KeskmineJaSummarneHind;
EXEC KeskmineJaSummarneHind;

--//=========================================================
-- Protseduur, mis liisab ueed andmed tabelisse
--//=========================================================
CREATE PROCEDURE LisaPuu (@nimi varchar(30), @korgus decimal(5, 1), @hind decimal(5, 2)) AS
BEGIN
    INSERT INTO Puu (PuuNimetus, korgus, hind)
		VALUES (@nimi, @korgus, @hind);
END;

EXEC LisaPuu @nimi='Puu1', @korgus=45, @hind=100.5;
EXEC LisaPuu @nimi='Puu12', @korgus=12.5, @hind=90.2;
EXEC LisaPuu @nimi='Puu4', @korgus=6, @hind=666;
EXEC LisaPuu @nimi='Puu16', @korgus=75.5, @hind=100;
EXEC LisaPuu @nimi='Puu7', @korgus=55, @hind=15.8;

SELECT * FROM Puu;

--DROP PROCEDURE LisaPuu;

--//=========================================================
-- Protseduur, mis otsib puu suurem kui sisestatud hind 
--//=========================================================
CREATE PROCEDURE PuuHinnang ( @piir decimal(5, 2) ) AS
BEGIN
    SELECT PuuNimetus, Hind FROM Puu WHERE Hind > @piir;
END;

--DROP PROCEDURE PuuHinnang;

EXEC PuuHinnang 0;

--//=========================================================
-- Täiendav protseduur
-- Protseduur, mis kustutab puu id järgi
--//=========================================================
CREATE PROCEDURE KustutaPuu ( @puuID int ) AS
BEGIN
	SELECT * FROM Puu;
	DELETE FROM Puu WHERE ID=@puuID;
	SELECT * FROM Puu;
END;

EXEC KustutaPuu 2;