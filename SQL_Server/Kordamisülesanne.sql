create database triger2tabelid;
use triger2tabelid;
 
--tabel toode ja toodekategooria on seotud oma vahel
create table toodekategooria(
	toodekategooriaId int not null primary key identity (1,1),
	toodekategooria varchar(100) unique,
	kirjeldus text
);
 
create table toode(
	toodeId int not null primary key identity (1,1),
	toodenimetus varchar(100) unique,
	hind decimal(5, 2),
	toodekategooriaId int,
	foreign key (toodekategooriaId) references toodekategooria(toodekategooriaId)
);

-- tabeli struktuuri muutmine, uue veergu lisamine
ALTER TABLE toode ADD aktiivne bit;

UPDATE toode SET aktiivne = 1;
UPDATE toode SET aktiivne = 0 WHERE toodekategooriaId = 1;

SELECT * FROM toodekategooria;
SELECT * FROM toode;

INSERT INTO toodekategooria(toodekategooria) 
	VALUES 
		('Elektroonika'), 
		('Mööbel'), 
		('Riided'),
		('Köögiviljad'),
		('Liha');

INSERT INTO toodekategooria(toodekategooria) 
	VALUES 
		('Joogid');

INSERT INTO toode(toodenimetus, hind, toodekategooriaId)
	VALUES     
		('Telefon', 600, 1),
		('Tahvelarvuti', 800, 1),
		('Arvuti', 900, 1),

		('Diivan', 300, 2),
		('Tool', 100, 2),

		('T-särk', 40, 3),
		('Jope', 90, 3),

		('Tomat', 2, 4),
		('Porgand', 1.2, 4),

		('Kana', 12.5, 5),
		('Sealiha', 15, 5);

SELECT toodenimetus, hind, tk.toodekategooria FROM toode
	INNER JOIN toodekategooria tk ON toode.toodekategooriaId=tk.toodekategooriaId;

SELECT toodekategooria, MAX(t.hind) AS 'Max Hind' FROM toodekategooria 
	INNER JOIN toode t ON t.toodekategooriaId=toodekategooria.toodekategooriaId GROUP BY toodekategooria.toodekategooria;

SELECT toodekategooria, COUNT(*) AS 'Toodete Arv' FROM toodekategooria 
	INNER JOIN toode t ON t.toodekategooriaId=toodekategooria.toodekategooriaId GROUP BY toodekategooria.toodekategooria;

SELECT toodekategooria, CAST(AVG(t.hind) as decimal(5, 1)) AS 'Keskmine Hind' FROM toodekategooria 
	INNER JOIN toode t ON t.toodekategooriaId=toodekategooria.toodekategooriaId GROUP BY toodekategooria.toodekategooria;

SELECT toodekategooria FROM toodekategooria
	LEFT JOIN toode t ON t.toodekategooriaId=toodekategooria.toodekategooriaId WHERE t.toodekategooriaId IS NULL;

SELECT toodenimetus, hind FROM toode 
	WHERE hind > (SELECT AVG(hind) FROM toode);

--1. Loo vaade, mis kuvab ainult toodete nime ja hinna.
CREATE VIEW KuvaToodete AS
	SELECT toodenimetus, hind FROM toode;

SELECT * FROM KuvaToodete;

--2. Loo vaade, mis näitab kõiki tooteid koos kategooria nimega.
CREATE VIEW KuvaToodeteKategooriaga AS
	SELECT toodenimetus, hind, tk.toodekategooria FROM toode
		INNER JOIN toodekategooria tk ON toode.toodekategooriaId=tk.toodekategooriaId;

SELECT * FROM KuvaToodeteKategooriaga;

--3. Loo vaade, mis kuvab ainult aktiivseid (nt saadaval olevaid) tooteid.
CREATE VIEW KuvaAinultAktiivseidTooteid AS
	SELECT * FROM toode WHERE toode.aktiivne = 1;

SELECT * FROM KuvaAinultAktiivseidTooteid;





--4. Loo vaade, mis koondab info: kategooria nimi, toodete arv, minimaalne ja maksimaalne hind.
CREATE VIEW KategooriadInfo AS
	SELECT toodekategooria, 
		COUNT(*) AS 'Toodete Arv', 
		CAST(MIN(t.hind) as decimal(5, 1)) AS 'Min Hind', 
		CAST(MAX(t.hind) as decimal(5, 1)) AS 'Max Hind' 
		FROM toodekategooria tk
		INNER JOIN toode t ON t.toodekategooriaId=tk.toodekategooriaId GROUP BY tk.toodekategooria;

DROP VIEW KategooriadInfo;

SELECT * FROM KategooriadInfo;

--5. Loo vaade, mis arvutab toode käibemaksu (24%) ja iga toode hind käibemaksuga.
CREATE VIEW ArvutaToodeKäibemaksu AS
	SELECT toodenimetus, 
		CAST(hind * 0.24 as decimal(5, 1)) AS 'Toode käibemaks', 
		CAST(hind * 1.24 as decimal(5, 1)) AS 'Toode hind käibemaksuga', 
		CAST(hind as decimal(5, 1)) AS 'Toode hind käibemaksuta' 
	FROM toode;

DROP VIEW ArvutaToodeKäibemaksu
SELECT * FROM ArvutaToodeKäibemaksu;

--//=========================================
-- Protseduurid 
--//=========================================

--1. Loo protseduur, mis lisab uue toote (sisendparameetrid: tootenimi, hind, kategooriaID).
CREATE PROCEDURE LisaToode ( @tootenimi varchar(100), @hind decimal(5, 2), @kategooriaID int, @aktiivne bit ) AS
BEGIN
	INSERT INTO toode(toodenimetus, hind, toodekategooriaId, aktiivne)
		VALUES (@tootenimi, @hind, @kategooriaID, @aktiivne);

	SELECT * FROM toode;
END;

EXEC LisaToode 'Sibul2', 1.5, 4, 1;

--2. Loo protseduur, mis uuendab toote hinda vastavalt tooteID-le.
CREATE PROCEDURE UuendaToodeHind ( @toodeID int, @uusHind decimal(5, 2) ) AS
BEGIN
	SELECT * FROM toode WHERE toodeId = @toodeId;
	UPDATE toode SET hind = @uusHind WHERE toodeId = @toodeId;
	SELECT * FROM toode WHERE toodeId = @toodeId;
END;

EXEC UuendaToodeHind 14, 1;

--3. Loo protseduur, mis kustutab toote ID järgi.
CREATE PROCEDURE KustutaToode ( @toodeID int ) AS
BEGIN
	SELECT * FROM toode;
	DELETE toode WHERE toodeId = @toodeID;
	SELECT * FROM toode ;
END;

EXEC KustutaToode 14;

--4. Loo protseduur, mis tagastab kõik tooted valitud kategooriaID järgi.
CREATE PROCEDURE KõikTootedKategoorias ( @kategooriaID int ) AS
BEGIN
	SELECT toodenimetus, tk.toodekategooria, hind FROM toode 
	INNER JOIN toodekategooria tk ON toode.toodekategooriaId=tk.toodekategooriaId 
	WHERE toode.toodekategooriaId = @kategooriaID;
END;

EXEC KõikTootedKategoorias 2;
EXEC KõikTootedKategoorias 1;

--5. Loo protseduur, mis tõstab kõigi toodete hindu kindlas kategoorias kindla protsendi võrra.
CREATE PROCEDURE UuendaToodeteHindKategoorias ( @kategooriaID int, @protsenti decimal(5, 2) ) AS
BEGIN
	EXEC KõikTootedKategoorias @kategooriaID;
	UPDATE toode SET hind = hind * (1 + @protsenti / 100) WHERE toodekategooriaId = @kategooriaID;
	EXEC KõikTootedKategoorias @kategooriaID;
END;

EXEC UuendaToodeteHindKategoorias 2, 5;

--6. Loo protseduur, mis kuvab kõige kallima toote kogu andmebaasis.
CREATE PROCEDURE KõigeKallimaToote AS
BEGIN
	SELECT TOP 1 toodenimetus, hind, tk.toodekategooria FROM toode 
	INNER JOIN toodekategooria tk ON toode.toodekategooriaId=tk.toodekategooriaId
	ORDER BY hind DESC;
END;

EXEC KõigeKallimaToote;


GRANT INSERT, UPDATE, DELETE ON toode TO tootehaldur;
GRANT INSERT, UPDATE, SELECT ON toodekategooria TO kataloogihaldur;

GRANT SELECT ON toode TO vaataja;
GRANT SELECT ON toodekategooria TO vaataja;


SELECT 
	CONCAT(table_schema, '.', table_name) AS scope,
	grantee,
	privilege_type
FROM INFORMATION_SCHEMA.TABLE_PRIVILEGES




BEGIN TRANSACTION;

INSERT INTO toodekategooria (toodekategooria)
VALUES ('Meelelahutus');

INSERT INTO toode (toodenimetus, hind, toodekategooriaId)
VALUES ('Nutitelefon', 500, 1);

SELECT * FROM toodekategooria;
SELECT * FROM toode;

ROLLBACK;

SELECT * FROM toodekategooria;
SELECT * FROM toode;




BEGIN TRANSACTION;

SAVE TRANSACTION sp1;

BEGIN TRY
    INSERT INTO toode (toodenimetus, hind, toodekategooriaId)
		VALUES ('Telefon', 150, 1);
END TRY

BEGIN CATCH
	PRINT 'Viga'
    ROLLBACK TRANSACTION sp1;
END CATCH

INSERT INTO toode (toodenimetus, hind, toodekategooriaId)
	VALUES ('Müts', 150, 3);

COMMIT;

SELECT * FROM toode;
