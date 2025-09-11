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
