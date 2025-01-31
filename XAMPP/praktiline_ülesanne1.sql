--//=========================================================
-- XAMPP / Praktiline ülesanne/ CREATE TABLE, ALTER TABLE laused.
-- https://moodle.edu.ee/mod/assign/view.php?id=1424988
--//=========================================================

CREATE DATABASE epoodlitvinenko;
USE epoodlitvinenko;

--//=========================================================
--	CATEGORY
--//=========================================================

CREATE TABLE Category(
	ID int PRIMARY KEY AUTO_INCREMENT,
	Name varchar(25) UNIQUE NOT NULL
);

SELECT * FROM Category;

INSERT INTO Category(Name) 
VALUES 
	('jook'),
	('söök'),
	('tööriist'),
	('elektroonika'),
	('riie');

--DROP TABLE Category

--//=========================================================

--Tabeli struktuuri muutmine --> uue veergu(столбец) lisanmine
ALTER TABLE Category ADD test int;

--Tabeli struktuuri muutmine --> veergu kustataimne
ALTER TABLE Category DROP COLUMN test;

--//=========================================================
--	PRODUCT
--//=========================================================

CREATE TABLE Product(
	ID int PRIMARY KEY AUTO_INCREMENT,
	Name varchar(25) UNIQUE NOT NULL,
	CategoryID int,
	FOREIGN KEY (CategoryID) REFERENCES Category(ID),
	Price decimal(5, 2)
);

SELECT * FROM Product;

INSERT INTO Product(Name, CategoryID, Price) 
VALUES 
	('mahl', 1, 1.89),
	('haamer', 3, 2),
	('telefon', 3, 666.666),
	('t-särk', 4, 666.666),
	('leib', 2, 1.5),
	('vorst', 1, 999.989999999);

--DELETE FROM Product WHERE Name='vorst';
--DROP TABLE Product;

--//=========================================================
--	CUSTOMER
--//=========================================================

CREATE TABLE Customer(
	ID int PRIMARY KEY AUTO_INCREMENT,
	Name varchar(25) NOT NULL,
	Contact varchar(25)
);

SELECT * FROM Customer;

INSERT INTO Customer(Name, Contact) 
VALUES 
	('Nikita1', 'email'),
	('Nikita2', 'tel'),
	('Nikita3', 'email'),
	('Nikita4', 'email'),
	('Nikita5', 'tel');

--//=========================================================
--	SALE
--//=========================================================

CREATE TABLE Sale(
	ID int PRIMARY KEY AUTO_INCREMENT,
	ProductID int NOT NULL,
	FOREIGN KEY (ProductID) REFERENCES Product(ID),
	CustomerID int,
	FOREIGN KEY (CustomerID) REFERENCES Customer(ID),
	Count int NOT NULL,
	DateOfSale date
);

DROP TABLE Sale;
SELECT * FROM Sale;

INSERT INTO Sale(ProductID, CustomerID, Count, DateOfSale) 
VALUES 
	(1, 1, 5, '2000-12-12'),
	(2, 2, 21, '2001-12-13'),
	(3, 3, 1, '2000-12-14'),
	(4, 4, 3, '2020-12-15'),
	(5, 5, 12, '2077-12-16'),
	(3, 5, 15, '2077-12-16');

--//=========================================================

SELECT * FROM Category, Product, Customer, Sale;
DROP TABLE Sale, Customer, Product, Category;