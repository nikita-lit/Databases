--//=========================================================
-- XAMPP / Praktiline ülesanne/ CREATE TABLE, ALTER TABLE laused.
-- https://moodle.edu.ee/mod/assign/view.php?id=1424988
--//=========================================================

CREATE DATABASE epoodlitvinenko;
USE epoodlitvinenko;

--//=========================================================

CREATE TABLE Category(
	ID int PRIMARY KEY IDENTITY(1, 1),
	Name varchar(25) UNIQUE NOT NULL
);

SELECT * FROM Category;

INSERT INTO Category(Name) 
VALUES 
	('jook'),
	('söök');

--//=========================================================

--Tabeli struktuuri muutmine --> uue veergu(столбец) lisanmine
ALTER TABLE Category ADD test int;

--Tabeli struktuuri muutmine --> veergu kustataimne
ALTER TABLE Category DROP COLUMN test;

--//=========================================================

CREATE TABLE Product(
	ID int PRIMARY KEY IDENTITY(1,1),
	Name varchar(25) UNIQUE NOT NULL,
	CategoryID int,
	FOREIGN KEY (CategoryID) REFERENCES Category(ID),
	Price decimal(5, 2)
);

SELECT * FROM Product;

INSERT INTO Product(Name, CategoryID, Price) 
VALUES 
	('mahl', 1, 1.89),
	('leib', 2, 1.5);

INSERT INTO Product(Name, CategoryID, Price) 
VALUES 
	('vorst', 1, 999.989999999);

DELETE FROM Product WHERE Name='vorst';

--//=========================================================

CREATE TABLE Customer(
	ID int PRIMARY KEY IDENTITY(1, 1),
	Name varchar(25) NOT NULL,
	Contact varchar(25)
);

SELECT * FROM Customer;

INSERT INTO Customer(Name, Contact) 
VALUES 
	('Nikita', 'email'),
	('Nikita2', 'tel');

--//=========================================================

CREATE TABLE Sale(
	ID int PRIMARY KEY IDENTITY(1, 1),
	ProductID int NOT NULL,
	FOREIGN KEY (ProductID) REFERENCES Product(ID),
	CustomerID int,
	FOREIGN KEY (CustomerID) REFERENCES Customer(ID),
	Count int NOT NULL,
	DateOfSale date
);

SELECT * FROM Sale;

INSERT INTO Sale(ProductID, CustomerID, Count, DateOfSale) 
VALUES 
	(1, 1, 1, '2000-12-12'),
	(2, 1, 1, '2000-12-13');