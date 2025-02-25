CREATE DATABASE LitvinenkoAutoDB
USE LitvinenkoAutoDB

CREATE TABLE Autod(
	Mark varchar(50),
	RegNr varchar(10) PRIMARY KEY,
	Aasta int,
	RegPiirk int,
);

INSERT INTO Autod(Mark, RegNr, Aasta, RegPiirk)
VALUES
	('Audi', '123 ABC', 2000, 1),
	('Ford', '777 AAA', 1988, 2),
	('Ford', 'FIN 772', 2002, 1),
	('Nissan', '111 CCC', 2006, 1),
	('Toyota', '128 HGT', 2003, 1),
	('VAZ', '544 CCH', 1960, 2);

SELECT * FROM Autod;

insert into Autod (Mark, RegNr, Aasta, RegPiirk) values ('Hummer', '#32625e', 2003, 2);
insert into Autod (Mark, RegNr, Aasta, RegPiirk) values ('Pontiac', '#138ef6', 1995, 2);
insert into Autod (Mark, RegNr, Aasta, RegPiirk) values ('Scion', '#dcbe1f', 2006, 2);
insert into Autod (Mark, RegNr, Aasta, RegPiirk) values ('Tesla', '#300c68', 2012, 2);
insert into Autod (Mark, RegNr, Aasta, RegPiirk) values ('Pontiac', '#b97cca', 2005, 2);
insert into Autod (Mark, RegNr, Aasta, RegPiirk) values ('Honda', '#91cde2', 2006, 2);
insert into Autod (Mark, RegNr, Aasta, RegPiirk) values ('Dodge', '#bc0df4', 1992, 2);
insert into Autod (Mark, RegNr, Aasta, RegPiirk) values ('Morgan', '#d41d63', 2006, 1);
insert into Autod (Mark, RegNr, Aasta, RegPiirk) values ('Cadillac', '#f6fc71', 2011, 2);
insert into Autod (Mark, RegNr, Aasta, RegPiirk) values ('Ford', '#3f5969', 1993, 2);
insert into Autod (Mark, RegNr, Aasta, RegPiirk) values ('BMW', '#b6cb2f', 2006, 1);
insert into Autod (Mark, RegNr, Aasta, RegPiirk) values ('Oldsmobile', '#1c6a92', 1997, 2);
insert into Autod (Mark, RegNr, Aasta, RegPiirk) values ('Mitsubishi', '#ee3d10', 2004, 1);
insert into Autod (Mark, RegNr, Aasta, RegPiirk) values ('Mitsubishi', '#6391b7', 2005, 1);
insert into Autod (Mark, RegNr, Aasta, RegPiirk) values ('Infiniti', '#27debe', 2003, 2);
insert into Autod (Mark, RegNr, Aasta, RegPiirk) values ('Mazda', '#44c01f', 1993, 2);
insert into Autod (Mark, RegNr, Aasta, RegPiirk) values ('Chevrolet', '#d69585', 1992, 2);
insert into Autod (Mark, RegNr, Aasta, RegPiirk) values ('Nissan', '#9b3bff', 2006, 1);
insert into Autod (Mark, RegNr, Aasta, RegPiirk) values ('GMC', '#30ed91', 2000, 1);
insert into Autod (Mark, RegNr, Aasta, RegPiirk) values ('Toyota', '#3164ad', 1997, 1);

SELECT Aasta FROM Autod ORDER BY Aasta DESC;

SELECT DISTINCT Mark FROM Autod;

SELECT Aasta FROM Autod WHERE Aasta < 1993;

SELECT Aasta, Mark FROM Autod WHERE Aasta < 1993 ORDER BY Mark;

SELECT MIN(Aasta) 'kõige varasem' FROM Autod;

UPDATE Autod SET RegNr='333 KKK' WHERE RegNr='FIN 772'; 
SELECT Mark, RegNr FROM Autod;

DELETE FROM Autod WHERE RegNr='#809afe';
SELECT * FROM Autod;

INSERT INTO Autod(Mark, RegNr, Aasta, RegPiirk)
	VALUES ('Nissan', '555 NNN', 2007, 2)

SELECT * FROM Autod;

SELECT TOP 5 Mark, Aasta FROM Autod ORDER BY Aasta DESC

SELECT Mark FROM autod WHERE Mark like 'A%';

SELECT Mark, Aasta FROM Autod WHERE (Aasta BETWEEN 1999 AND 2005) AND Mark LIKE '%a%';