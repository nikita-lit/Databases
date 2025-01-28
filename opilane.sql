--AB loomine

Create database LitvinenkoBase;

use LitvinenkoBase;
CREATE TABLE opilane(
	opilaneID int primary key identity(1, 1),
	eesnimi varchar(25) not null,
	perenimi varchar(25) not null,
	synniaeg date,
	stip bit,
	aadress text,
	keskmine_hinne decimal(2, 1)
)

--andmete lisamine tabelisse
INSERT INTO opilane(
	eesnimi, 
	perenimi, 
	synniaeg, 
	stip,  
	keskmine_hinne) 
VALUES(
	'Nikita', 
	'Nikita', 
	'2000-12-12', 
	1,
	4.5)

INSERT INTO opilane(
	eesnimi, 
	perenimi, 
	synniaeg, 
	stip,  
	keskmine_hinne) 
VALUES(
	'Nikita2', 
	'Nikita2', 
	'2000-12-12', 
	1,
	4.5);

select * from opilane;

--tabeli kustutamine
--drop table opilane;

DELETE FROM opilane;

--rida kustutamine, kus on opilandID = 2
DELETE FROM opilane WHERE opilaneID=2;

--andmete uuendamine
UPDATE opilane SET aadress='Tartu' 
WHERE opilaneID=3