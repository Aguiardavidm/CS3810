-- David Aguiar HW2

-- 2 Create a table named Countries using the following statement:
CREATE TABLE Countries (
	name VARCHAR(20),
	latitude INT,
	longitude INT,
	area INT,
	population INT,
	gdp INT,
	gdpYear INT,
-- 3 Set the primary key 
	PRIMARY KEY (name)
);

-- 4a Create another table, Borders
CREATE TABLE Borders (
	name_a VARCHAR(20),
	name_b VARCHAR(20),
	PRIMARY KEY (name_a, name_b),
	FOREIGN KEY (name_a) REFERENCES Countries (name),
	FOREIGN KEY (name_b) REFERENCES Countries (name)
);

-- 4b Populate Countries
INSERT INTO Countries (name, latitude, longitude, area, population, gdp, gdpYear) VALUES
('Germany', 5100, 900, 357022, 80594017, 3979, 2016),
('Netherlands', 5230, 545, 41543, 17084719, 870, 2016),
('Belgium', 5050, 400, 30528, 11491346, 508, 2016),
('Luxemburg', 4945, 610, 2586, 594130, 58, 2016),
('Poland', 5200, 2000, 312685, 38476269, 1052, 2016),
('Czechia', 4945, 1530, 78867, 10674723, 350, 2016),
('Austria', 4720, 1320, 83871, 8754413, 41660, 2016),
('France', 4600, 200, 643801, 67106161, 2699, 2016),
('Switzerland', 4700, 800, 41277,  8236303, 4963, 2016);

-- 4b Populate borders
INSERT INTO Borders (name_a, name_b) VALUES
('Germany','Netherlands'),
('Germany','Belgium'),
('Germany','Luxemburg'),
('Germany','Poland'),
('Germany','Czechia'),
('Germany','Austria'),
('Germany','France'),
('Germany','Switzerland'),
('Netherlands','Germany'),
('Netherlands','Belgium'),
('Belgium','Germany'),
('Belgium','Netherlands'),
('Belgium','Luxemburg'),
('Belgium','France'),
('Luxemburg','Germany'),
('Luxemburg','Belgium'),
('Luxemburg','France'),
('Poland','Germany'),
('Poland','Czechia'),
('Czechia','Germany'),
('Czechia','Poland'),
('Czechia','Austria'),
('Austria','Germany'),
('Austria','Czechia'),
('Austria','Switzerland'),
('France','Germany'),
('France','Belgium'),
('France','Luxemburg'),
('France','Switzerland'),
('Switzerland','Germany'),
('Switzerland','Austria'),
('Switzerland','France');

-- 4c Use query to display  all countries that border Germany
Select name_b FROM Borders WHERE name_a = 'Germany';

-- 4d Use query to display all countries that have a population greater then 35 million
SELECT * FROM Countries WHERE population > 35000000;

-- 4e Use query to display all countries that border Germany and that have a population greater then 35 million
SELECT name_b FROM Borders
INNER JOIN Countries C ON C.name = name_b
WHERE name_a = 'Germany' AND C.population > 35000000;
