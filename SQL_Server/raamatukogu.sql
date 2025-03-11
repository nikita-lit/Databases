CREATE DATABASE LibraryDB;
USE LibraryDB;

CREATE TABLE Students(
	studentID int PRIMARY KEY IDENTITY(1,1),
	name varchar(30),
	surname varchar(30),
	birthdate date,
	gender varchar(6),
	class varchar(10),
	point int
);

CREATE TABLE Authors(
	authorID int PRIMARY KEY IDENTITY(1,1),
	name varchar(30),
	surname varchar(30),
);

CREATE TABLE Types(
	typeID int PRIMARY KEY IDENTITY(1,1),
	name varchar(30),
);

CREATE TABLE Publishers(
	publisherID int PRIMARY KEY IDENTITY(1,1),
	name varchar(30),
	aadress varchar(30),
);

CREATE TABLE Books(
	bookID int PRIMARY KEY IDENTITY(1,1),
	name varchar(30),
	pagecount int,
	point int,
	authorID int
	FOREIGN KEY (authorID) REFERENCES Authors(authorID),
	typeID int,
	FOREIGN KEY (typeID) REFERENCES Types(typeID),
	publisherID int,
	FOREIGN KEY (publisherID) REFERENCES Publishers(publisherID)
);

--DROP TABLE Books

CREATE TABLE Borrows(
	borrowID int PRIMARY KEY IDENTITY(1,1),
	studentID int,
	FOREIGN KEY (studentID) REFERENCES Students(studentID),
	bookID int,
	FOREIGN KEY (bookID) REFERENCES Books(bookID),
	takenDate date,
	broughtDate date
);

--DROP TABLE Borrows

INSERT INTO Authors(name, surname) 
	VALUES 
	('Walter', 'White'),
	('Cat', 'Cat2'),
	('Paul', 'Paul2'),
	('Shrek', 'Shrek2'),
	('Tomas', 'Tomas2');

SELECT * FROM Authors

INSERT INTO Types(name)
	VALUES
	('Science'),
	('Guide'),
	('Cooking'),
	('Romance'),
	('Horror');

INSERT INTO Publishers(name, aadress)
	VALUES
	('Shrek University', 'New York'),
	('Random Publisher', 'Random City'),
	('Books And Books Group', 'Berlin'),
	('Water Press', 'Atlantic Ocean'),
	('Cat House', 'Paris');

INSERT INTO Books(name, pagecount, point, authorID, typeID, publisherID)
	VALUES
	('Water', 45, 5, 2, 1, 5),
	('MS Access kasutamine', 666, 2, 5, 5, 2),
	('Cooking with W.W.', 44, 3, 1, 3, 3),
	('Python programming', 100, 9, 3, 2, 4),
	('Fell in love with Shrek', 45, 5, 3, 4, 1);

INSERT INTO Students (name, surname, birthdate, gender, class, point) 
	VALUES
	('Nikita', 'Nikita2', '2005-03-07', 'male', 10, 5),
	('Shrek', 'Shrek2', '2015-03-01', 'male', 2, 3),
	('Trump', 'Trump2', '2005-03-12', 'male', 6, 2),
	('Petrov', 'Petrov2', '2002-02-24', 'female', 8, 2),
	('Genrih', 'Genrih2', '2001-02-03', 'male', 6, 4),
	('Female', 'Female2', '1969-03-09', 'female', 9, 5);

INSERT INTO Borrows(studentID, bookID, takenDate, broughtDate)
	VALUES
	(2, 1, '2025-03-10', '2025-03-19'),
	(1, 2, '2025-03-5', '2025-03-8'),
	(4, 3, '2025-03-10', '2025-03-15'),
	(5, 4, '2025-03-10', '2025-03-12'),
	(6, 5, '2025-03-5', '2025-03-7'),
	(3, 2, '2025-03-10', '2025-03-11');

SELECT * FROM Borrows

--//=========================================================
SELECT books.name, books.authorID
FROM books INNER JOIN authors ON books.authorID = authors.authorID
WHERE authors.name = AuthorName;
--//=========================================================
SELECT [name]&" "&[surname] AS student_name, gender
FROM students
WHERE gender = StudentsGender;
--//=========================================================
SELECT [students.name]&" "&[students.surname] AS student_name, borrows.bookID
FROM students INNER JOIN borrows ON students.studentID = borrows.studentID
WHERE students.name = StudentName;
--//=========================================================
SELECT AVG(pagecount) AS avg_page_count
FROM books;
--//=========================================================
SELECT books.name, borrows.takenDate, borrows.broughtDate
FROM books INNER JOIN borrows ON borrows.bookID = books.bookID
WHERE borrows.broughtDate > Date();
--//=========================================================
SELECT [name]&" "&[surname] AS student_name, birthdate, Year(Date())-Year(birthdate) AS age
FROM students;

