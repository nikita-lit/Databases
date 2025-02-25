CREATE DATABASE LitvinenkoDB2;
USE LitvinenkoDB2;

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

INSERT INTO Autod(Mark, RegNr, Aasta, RegPiirk)
VALUES
	('Auto', '452 MNF', 2050, 2);

CREATE TABLE test( id int )

DROP TABLE Autod

--Anname õigus kasutajale OpilaneNikita vaadata tabeli auto sisu
GRANT SELECT ON Autod TO OpilaneNikita;
GRANT UPDATE ON Autod TO OpilaneNikita;

--Keelata!
DENY DELETE ON Autod TO OpilaneNikita;

DELETE FROM Autod