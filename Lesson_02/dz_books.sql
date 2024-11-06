USE seminar_1;

/*
INSERT dz_books (title, author, year, price) 
VALUES 
('Убить пересмешника', 'Харпер Ли', '1960', '300'),
('1984', 'Джордж Оруэлл', '1949', '250'),
('Великий Гэтсби', 'Ф. Скотт Фицджеральд', '1925', '200'),
('Над пропастью во ржи', 'Дж. Д. Сэлинджер', '1951', '280'),
('Моби Дик', 'Герман Мелвилл', '1851', '400'),
('Скотный двор', 'Джордж Оруэлл', '1945', '220'),
('Почти на Каталонии', 'Джордж Оруэлл', '1938', '180');
*/
/*
SELECT title, author, price FROM dz_books
	WHERE year > 1950
    ORDER BY price;
*/
/*
SELECT * FROM dz_books
	WHERE author = 'Джордж Оруэлл' AND year > 1940;
*/

# SELECT count(*) as count_books FROM dz_books;

# SELECT AVG(price) as average_price FROM dz_books;

/*
SELECT author FROM dz_books
	WHERE price = (SELECT MAX(price) FROM dz_books);
*/

# SELECT author, count(author) as count_books FROM dz_books GROUP BY author HAVING count(author) > 1;

SELECT title, author FROM dz_books
	WHERE year < 1950
    ORDER BY author;
