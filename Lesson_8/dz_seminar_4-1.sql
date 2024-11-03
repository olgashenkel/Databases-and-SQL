USE seminar_4;

-- Задание 1. Создание и заполнение таблицы AUTO
DROP TABLE IF EXISTS AUTO;
CREATE TABLE  AUTO 
(       
	REGNUM VARCHAR(10) PRIMARY KEY, 
	MARK VARCHAR(10), 
	COLOR VARCHAR(15),
	RELEASEDT DATE, 
	PHONENUM VARCHAR(15)
);

INSERT INTO AUTO (REGNUM, MARK,	COLOR, RELEASEDT, PHONENUM )
VALUES
(111114,'LADA', 'КРАСНЫЙ', date'2008-01-01', '9152222221'),
(111116,'BMW', 'СИНИЙ', date'2015-01-01', '9173333334'),
(111121,'AUDI', 'СИНИЙ', date'2009-01-01', '9173333332'),
(111122,'AUDI', 'СИНИЙ', date'2011-01-01', '9213333336'),
(111113,'BMW', 'ЗЕЛЕНЫЙ', date'2007-01-01', '9214444444'),
(111126,'LADA', 'ЗЕЛЕНЫЙ', date'2005-01-01', null),
(111117,'BMW', 'СИНИЙ', date'2005-01-01', null),
(111119,'LADA', 'СИНИЙ', date'2017-01-01', 9213333331);


-- Вывести на экран сколько машин каждого цвета для марок BMW и LADA
SELECT MARK, COLOR, COUNT(COLOR) AS COUNT FROM auto
	WHERE MARK IN ('BMW', 'LADA')
GROUP BY MARK, COLOR
ORDER BY MARK;


/* Задание 2. 
Вывести на экран марку авто (количество) и количество авто не этой марки.
Например: 	100 машин, из них 20 – BMW и 80 машин другой марки; 
			AUDI – 30 и 70 машин другой марки, 
            LADA – 15 и 85 авто другой марки
*/

SELECT DISTINCT MARK, 
	(SELECT COUNT(MARK) FROM auto AS auto_all WHERE auto_all.MARK = auto.MARK) AS 'Quantity of this model', 
	(SELECT COUNT(MARK) FROM auto AS auto_all WHERE auto_all.MARK != auto.MARK) AS 'Quantity of other models'
	FROM auto AS auto;


/* Задание 1. Даны 2 таблицы.
Напишите запрос, который вернет строки из таблицы test_a, 
id которых нет в таблице test_b, НЕ используя ключевого слова NOT
*/

-- Создание таблиц test_a и test_b
CREATE TABLE test_a 
	(id INT, test VARCHAR(10));

CREATE TABLE test_b
	(id INT);

-- Заполнение таблиц test_a и test_b
INSERT INTO test_a (id, test)
VALUES
(10, 'A'),
(20, 'A'),
(30, 'F'),
(40, 'D'),
(50, 'C');

INSERT INTO test_b (id)
VALUES
(10),
(30),
(50);

-- Создание запроса
SELECT * FROM test_a
	NATURAL LEFT JOIN test_b
    WHERE test_b.id IS NULL;