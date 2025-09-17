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
		('M��bel'), 
		('Riided'),
		('K��giviljad'),
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

		('T-s�rk', 40, 3),
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

--2. Loo vaade, mis n�itab k�iki tooteid koos kategooria nimega.
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

--5. Loo vaade, mis arvutab toode k�ibemaksu (24%) ja iga toode hind k�ibemaksuga.
CREATE VIEW ArvutaToodeK�ibemaksu AS
	SELECT toodenimetus, 
		CAST(hind * 0.24 as decimal(5, 1)) AS 'Toode k�ibemaks', 
		CAST(hind * 1.24 as decimal(5, 1)) AS 'Toode hind k�ibemaksuga', 
		CAST(hind as decimal(5, 1)) AS 'Toode hind k�ibemaksuta' 
	FROM toode;

DROP VIEW ArvutaToodeK�ibemaksu
SELECT * FROM ArvutaToodeK�ibemaksu;

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

--3. Loo protseduur, mis kustutab toote ID j�rgi.
CREATE PROCEDURE KustutaToode ( @toodeID int ) AS
BEGIN
	SELECT * FROM toode;
	DELETE toode WHERE toodeId = @toodeID;
	SELECT * FROM toode ;
END;

EXEC KustutaToode 14;

--4. Loo protseduur, mis tagastab k�ik tooted valitud kategooriaID j�rgi.
CREATE PROCEDURE K�ikTootedKategoorias ( @kategooriaID int ) AS
BEGIN
	SELECT toodenimetus, tk.toodekategooria, hind FROM toode 
	INNER JOIN toodekategooria tk ON toode.toodekategooriaId=tk.toodekategooriaId 
	WHERE toode.toodekategooriaId = @kategooriaID;
END;

EXEC K�ikTootedKategoorias 2;
EXEC K�ikTootedKategoorias 1;

--5. Loo protseduur, mis t�stab k�igi toodete hindu kindlas kategoorias kindla protsendi v�rra.
CREATE PROCEDURE UuendaToodeteHindKategoorias ( @kategooriaID int, @protsenti decimal(5, 2) ) AS
BEGIN
	EXEC K�ikTootedKategoorias @kategooriaID;
	UPDATE toode SET hind = hind * (1 + @protsenti / 100) WHERE toodekategooriaId = @kategooriaID;
	EXEC K�ikTootedKategoorias @kategooriaID;
END;

EXEC UuendaToodeteHindKategoorias 2, 15;

--6. Loo protseduur, mis kuvab k�ige kallima toote kogu andmebaasis.
CREATE PROCEDURE K�igeKallimaToote AS
BEGIN
	SELECT TOP 1 toodenimetus, hind, tk.toodekategooria FROM toode 
	INNER JOIN toodekategooria tk ON toode.toodekategooriaId=tk.toodekategooriaId
	ORDER BY hind DESC;
END;

EXEC K�igeKallimaToote;