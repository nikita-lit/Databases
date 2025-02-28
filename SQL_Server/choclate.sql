CREATE DATABASE TypesOfChoclateNikita;
USE TypesOfChoclateNikita;

CREATE TABLE ChoclateTabel (
	id int PRIMARY KEY IDENTITY(1,1),
	ÐokolaadNimi varchar(50),
	KeskmineHind decimal(5,2)
)

insert into ChoclateTabel (ÐokolaadNimi, KeskmineHind) values ('verapamil hydrochloride', 20.03);
insert into ChoclateTabel (ÐokolaadNimi, KeskmineHind) values ('Pravastatin Sodium', 14.15);
insert into ChoclateTabel (ÐokolaadNimi, KeskmineHind) values ('Alcohol', 9.0);
insert into ChoclateTabel (ÐokolaadNimi, KeskmineHind) values ('Ibuprofen', 14.24);
insert into ChoclateTabel (ÐokolaadNimi, KeskmineHind) values ('labetalol hydrochloride', 11.87);
insert into ChoclateTabel (ÐokolaadNimi, KeskmineHind) values ('fexofenadine hydrochloride', 5.41);
insert into ChoclateTabel (ÐokolaadNimi, KeskmineHind) values ('Loratadine', 3.18);
insert into ChoclateTabel (ÐokolaadNimi, KeskmineHind) values ('Titanium dioxide', 8.32);
insert into ChoclateTabel (ÐokolaadNimi, KeskmineHind) values ('Menthol and Camphor (Synthetic)', 7.76);
insert into ChoclateTabel (ÐokolaadNimi, KeskmineHind) values ('Temazepam', 2.52);
insert into ChoclateTabel (ÐokolaadNimi, KeskmineHind) values ('Ciprofloxacin', 2.93);
insert into ChoclateTabel (ÐokolaadNimi, KeskmineHind) values ('OCTINOXATE and TITANIUM DIOXIDE', 14.0);
insert into ChoclateTabel (ÐokolaadNimi, KeskmineHind) values ('Fluconazole', 8.84);
insert into ChoclateTabel (ÐokolaadNimi, KeskmineHind) values ('benztropine mesylate', 3.47);
insert into ChoclateTabel (ÐokolaadNimi, KeskmineHind) values ('Avobenzone', 4.54);
insert into ChoclateTabel (ÐokolaadNimi, KeskmineHind) values ('Titanium Dioxide and Zinc Oxide', 5.44);
insert into ChoclateTabel (ÐokolaadNimi, KeskmineHind) values ('acetaminophen', 13.67);
insert into ChoclateTabel (ÐokolaadNimi, KeskmineHind) values ('Donepezil Hydrochloride', 82.42);
insert into ChoclateTabel (ÐokolaadNimi, KeskmineHind) values ('Fagopyrum esculentum', 26.96);
insert into ChoclateTabel (ÐokolaadNimi, KeskmineHind) values ('Acetaminophen', 68.3);
insert into ChoclateTabel (ÐokolaadNimi, KeskmineHind) values ('Arnica montana', 19.05);
insert into ChoclateTabel (ÐokolaadNimi, KeskmineHind) values ('dextromethorphan polistirex', 62.34);
insert into ChoclateTabel (ÐokolaadNimi, KeskmineHind) values ('Hydroxyzine hydrochloride', 14.78);
insert into ChoclateTabel (ÐokolaadNimi, KeskmineHind) values ('Hydrochlorothiazide', 54.33);
insert into ChoclateTabel (ÐokolaadNimi, KeskmineHind) values ('Tretinoin', 39.54);
insert into ChoclateTabel (ÐokolaadNimi, KeskmineHind) values ('Donepezil hydrochloride', 27.4);
insert into ChoclateTabel (ÐokolaadNimi, KeskmineHind) values ('Ritonavir', 2.87);
insert into ChoclateTabel (ÐokolaadNimi, KeskmineHind) values ('Carcinosinum', 72.31);
insert into ChoclateTabel (ÐokolaadNimi, KeskmineHind) values ('Magnesium citrate', 4.32);
insert into ChoclateTabel (ÐokolaadNimi, KeskmineHind) values ('Lidocaine Hydrochloride', 21.78);

SELECT * FROM ChoclateTabel;

GRANT SELECT ON ChoclateTabel (ÐokolaadNimi, KeskmineHind) TO NikitaChocolonely
GRANT UPDATE ON ChoclateTabel (ÐokolaadNimi, KeskmineHind) TO NikitaChocolonely

SELECT ÐokolaadNimi, KeskmineHind FROM ChoclateTabel;

SELECT id FROM ChoclateTabel

SELECT ÐokolaadNimi, KeskmineHind FROM ChoclateTabel;
UPDATE ChoclateTabel SET KeskmineHind = 500;
SELECT ÐokolaadNimi, KeskmineHind FROM ChoclateTabel;

DELETE FROM ChoclateTabel

DROP TABLE ChoclateTabel

CREATE TABLE Kasutaja (
	id int PRIMARY KEY IDENTITY(1,1),
	kasutajaNimi varchar(50)
)