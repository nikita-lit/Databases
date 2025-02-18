CREATE TABLE Kasutaja(
	kasutaja_id int PRIMARY KEY AUTO_INCREMENT,
	eesnimi varchar(50) NOT NULL,
	perenimi varchar(50),
	email varchar(50) NOT NULL
);

INSERT INTO Kasutaja(eesnimi, perenimi, email)
	VALUES
		('Nikita1', 'NikitaL1', 'Nikita1@mail.com'),
		('Nikita2', 'NikitaL2', 'Nikita2@mail.com'),
		('Nikita3', 'NikitaL3', 'Nikita3@mail.com'),
		('Nikita4', 'NikitaL4', 'Nikita4@mail.com'),
		('Nikita5', 'NikitaL5', 'Nikita5@mail.com');

SELECT * FROM Kasutaja;

--//=========================================================
--
--//=========================================================
CREATE TABLE Kategooria(
	kategooria_id int PRIMARY KEY AUTO_INCREMENT,
	kategooria_nimi varchar(50)
);

INSERT INTO Kategooria(kategooria_nimi)
	VALUES
		('Suppid'), ('Magusad'), ('Road'), ('Jookid'), ('Suupisted');

SELECT * FROM Kategooria;

--//=========================================================
--
--//=========================================================
CREATE TABLE Toiduaine(
	toiduaine_id int PRIMARY KEY AUTO_INCREMENT,
	toiduaine_nimi varchar(100)
);

INSERT INTO Toiduaine(toiduaine_nimi)
	VALUES
		('Juust'), ('Munad'), ('Õlu'), ('Vesi'), ('Vorst');

SELECT * FROM Toiduaine;

--//=========================================================
--
--//=========================================================
CREATE TABLE Yhik(
	yhik_id int PRIMARY KEY AUTO_INCREMENT,
	yhik_nimi varchar(100)
);

INSERT INTO Yhik(yhik_nimi)
	VALUES
		('ml'), ('l'), ('kg'), ('g'), ('mm');

SELECT * FROM Yhik;

--//=========================================================
--
--//=========================================================
CREATE TABLE Retsept(
	retsept_id int PRIMARY KEY IDENTITY(1,1),
	retsept_nimi varchar(100),
	kirjeldus varchar(200),
	juhend varchar(500),
	sisestatud_kp date,
	kasutaja_id int,
	FOREIGN KEY (kasutaja_id) REFERENCES Kasutaja(kasutaja_id),
	kategooria_id int,
	FOREIGN KEY (kategooria_id) REFERENCES Kategooria(kategooria_id)
);

SELECT * FROM Retsept;

INSERT INTO Retsept(retsept_nimi, kirjeldus, juhend, sisestatud_kp, kasutaja_id, kategooria_id)
	VALUES 
		('Pasta', 'Keeta makaroonid', 'Kasuta elektripliit', '2025-12-20', 1, 3),
		('Grill', 'Nii soola', 'Kasuta Aerogrill', '2025-05-15', 4, 3),
		('Mesi', 'Liiga magus', 'Kasuta elektripliit', '2024-11-10', 2, 2),
		('Supp', 'Köögiviljad, puljong', 'Keeda kõik koos, lisa sool ja pipar', '2025-02-14', 3, 1),
		('Kook', 'Võta jahu ja suhkur', 'Sega kõik koostisosad, küpseta ahjus', '2025-03-25', 1, 2),
		('Smuut', 'Banaan, marjad, jogurt', 'Aseta kõik segistisse ja sega ühtlaseks', '2025-01-30', 4, 4),
		('Salat', 'Tomatid, kurk, oliivid', 'Lõika koostisosad, sega kokku', '2025-02-01', 3, 5),
		('Kohv', 'Kohvipulber, vesi', 'Keeda vesi, lisa kohvipulber ja vala tassi', '2025-02-12', 5, 4);


--//=========================================================
--
--//=========================================================
CREATE TABLE Koostis(
	koostis_id int PRIMARY KEY AUTO_INCREMENT,
	kogus int,
	retsept_id int,
	FOREIGN KEY (retsept_id) REFERENCES Retsept(retsept_id),
	toiduaine_id int,
	FOREIGN KEY (toiduaine_id) REFERENCES Toiduaine(toiduaine_id),
	yhik_id int,
	FOREIGN KEY (yhik_id) REFERENCES Yhik(yhik_id)
);

SELECT * FROM Koostis;

INSERT INTO Koostis(kogus, retsept_id, toiduaine_id, yhik_id)
	VALUES
		(3, 2, 1, 1),
		(666, 4, 2, 2),
		(21, 1, 3, 3),
		(45, 5, 4, 4),
		(1000000, 7, 5, 5);

--//=========================================================
--
--//=========================================================
CREATE TABLE Tehtud(
	tehtud_id int PRIMARY KEY AUTO_INCREMENT,
	tehtud_kp date,
	retsept_id int,
	FOREIGN KEY (retsept_id) REFERENCES Retsept(retsept_id)
);

INSERT INTO Tehtud(tehtud_kp, retsept_id)
	VALUES
		('2025-01-01', 1),
		('2025-02-10', 3),
		('2025-01-15', 2),
		('2025-02-18', 5),
		('2025-03-01', 7);