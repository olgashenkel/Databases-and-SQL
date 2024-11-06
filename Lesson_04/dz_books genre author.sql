USE seminar_2;

/*
DROP TABLE IF EXISTS books;

CREATE TABLE books (
id INT AUTO_INCREMENT PRIMARY KEY,
title VARCHAR(255) NOT NULL,
author VARCHAR(255) NOT NULL,
year INT NOT NULL,
price DECIMAL(10, 2) NOT NULL
);

INSERT INTO books (title, author, year, price) 
VALUES
('Убить пересмешника', 'Харпер Ли', 1960, 300.00),
('1984', 'Джордж Оруэлл', 1949, 250.00),
('Великий Гэтсби', 'Ф. Скотт Фицджеральд', 1925, 200.00),
('Над пропастью во ржи', 'Дж. Д. Сэлинджер', 1951, 280.00),
('Моби Дик', 'Герман Мелвилл', 1851, 400.00),
('Скотный двор', 'Джордж Оруэлл', 1945, 220.00),
('Почти на Каталонии', 'Джордж Оруэлл', 1938, 180.00),
('Собака Баскервилей', 'Артур Конан Дойл', 1902, 350.00),
('Дневник Анны Франк', 'Анна Франк', 1947, 300.00),
('Краткая история времени', 'Стивен Хокинг', 1988, 320.00);
*/
/*
DROP TABLE IF EXISTS genres;

CREATE TABLE genres
(
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL
);

INSERT INTO genres (name)
VALUES
('Художественная литература'),
('Нехудожественная литература'),
('Детектив'),
('Биография'),
('Наука');
*/
/*
DROP TABLE IF EXISTS authors;

CREATE TABLE authors
(
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL
    
);

INSERT INTO authors(name)
	SELECT DISTINCT author FROM books;
*/
/*
ALTER TABLE books
	ADD genre_id INT NOT NULL,
    ADD author_id INT NOT NULL;
*/
/*
UPDATE books 
	SET genre_id = (SELECT id FROM genres WHERE name = 'Художественная литература')
		WHERE title IN ('Убить пересмешника', '1984', 'Великий Гэтсби', 'Над пропастью во ржи', 'Моби Дик');

UPDATE books
	SET genre_id = (SELECT id FROM genres WHERE name = 'Нехудожественная литература')
		WHERE title IN ('Скотный двор', 'Почти на Каталонии');
        
UPDATE books
	SET genre_id = (SELECT id FROM genres WHERE name = 'Детектив')
		WHERE title = 'Собака Баскервилей';
UPDATE books
	SET genre_id = (SELECT id FROM genres WHERE name = 'Биография')
		WHERE title = 'Дневник Анны Франк';

UPDATE books
	SET genre_id = (SELECT id FROM genres WHERE name = 'Наука')
		WHERE title = 'Краткая история времени';        
*/
/*
UPDATE books
	SET author_id = (SELECT id FROM authors WHERE name = 'Харпер Ли')
		WHERE title = 'Убить пересмешника';
        
UPDATE books
	SET author_id = (SELECT id FROM authors WHERE name = 'Джордж Оруэлл')
		WHERE title IN ('1984', 'Скотный двор', 'Почти на Каталонии');
        
UPDATE books
	SET author_id = (SELECT id FROM authors WHERE name = 'Ф. Скотт Фицджеральд')
		WHERE title = 'Великий Гэтсби';
        
UPDATE books
	SET author_id = (SELECT id FROM authors WHERE name = 'Дж. Д. Сэлинджер')
		WHERE title = 'Над пропастью во ржи';
        
UPDATE books
	SET author_id = (SELECT id FROM authors WHERE name = 'Герман Мелвилл')
		WHERE title = 'Моби Дик';
        
UPDATE books
	SET author_id = (SELECT id FROM authors WHERE name = 'Артур Конан Дойл')
		WHERE title = 'Собака Баскервилей';
        
UPDATE books
	SET author_id = (SELECT id FROM authors WHERE name = 'Анна Франк')
		WHERE title = 'Дневник Анны Франк';
        
UPDATE books
	SET author_id = (SELECT id FROM authors WHERE name = 'Стивен Хокинг')
		WHERE title = 'Краткая история времени';
*/
/*
SELECT books.title AS title, genres.name AS name, authors.name AS name
	FROM books
		INNER JOIN genres ON books.genre_id = genres.id
		INNER JOIN authors ON books.author_id = authors.id;
*/
/*
UPDATE books
	SET price = price + (price * 0.1)
		WHERE year < 2000;
        
SELECT * FROM books;
*/

SELECT genres.name AS name, AVG(books.price) AS price
FROM books
	INNER JOIN genres ON books.genre_id = genres.id
GROUP BY genres.name
HAVING AVG(books.price) > 300;