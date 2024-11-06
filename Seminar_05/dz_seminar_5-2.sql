USE semnar_5;

-- Создание и заполнение таблицы analysis
DROP TABLE IF EXISTS analysis;
CREATE TABLE analysis
(
	an_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    an_name VARCHAR(45) NOT NULL,
    an_cost DECIMAL(10,2),
    an_price DECIMAL(10,2),
    an_group VARCHAR(10)
);

INSERT INTO analysis(an_name, an_cost, an_price, an_group)
VALUE
('analysis_001', 50, 89, 'A'),
('analysis_002', 60, 95, 'B'),
('analysis_003', 70, 105, 'C'),
('analysis_004', 80, 110, 'D'),
('analysis_005', 90, 120, 'A'),
('analysis_006', 100, 140, 'B'),
('analysis_007', 110, 150, 'C'),
('analysis_008', 120, 170, 'D'),
('analysis_009', 130, 160, 'A'),
('analysis_010', 140, 180, 'B');

SELECT * FROM analysis;


-- Создание и заполнение таблицы grups
DROP TABLE IF EXISTS grups;
CREATE TABLE grups
(
	gr_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    gr_name VARCHAR(45) NOT NULL,
    gr_temp DECIMAL(5,2)
);

INSERT INTO grups(gr_name, gr_temp)
VALUE
('group_001', 10),
('group_002', 11),
('group_003', 12),
('group_004', 13),
('group_005', 14),
('group_006', 15),
('group_007', 16),
('group_008', 17),
('group_009', 18),
('group_010', 19);

SELECT * FROM grups;


-- Создание и заполнение таблицы orders
CREATE TABLE orders
(
	ord_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    ord_datetime DATETIME,
    ord_an INT NOT NULL,
    FOREIGN KEY (ord_an) REFERENCES analysis (an_id)
);

INSERT INTO orders(ord_datetime, ord_an)
VALUE
('2020-02-04 00:00:00', 1),
('2020-02-04 00:01:00', 2),
('2020-02-04 00:02:00', 3),
('2020-02-04 12:00:00', 4),
('2020-02-05 00:00:00', 5),
('2020-02-05 00:00:00', 6),
('2020-02-05 00:00:00', 7),
('2020-02-05 00:00:00', 8),
('2020-02-06 00:00:00', 9),
('2020-02-06 00:00:00', 10),
('2020-02-06 00:00:00', 1),
('2020-02-06 00:00:00', 2),
('2020-02-07 00:00:00', 3),
('2020-02-14 00:00:00', 4),
('2020-02-24 00:00:00', 5),
('2020-02-08 00:00:00', 6),
('2020-02-08 00:00:00', 7),
('2020-02-09 00:00:00', 8),
('2020-02-14 00:00:00', 9),
('2020-02-15 00:00:00', 10);

SELECT * FROM orders;

-- Вывести название и цену всех анализов,
-- которые продавались 5 февраля 2020 и всю следующую неделю
SELECT an.an_name, an.an_price, ord.ord_datetime
FROM analysis AS an
INNER JOIN orders AS ord 
	ON an.an_id = ord.ord_an
    WHERE ord.ord_datetime >= '2020-02-05' 
		AND ord.ord_datetime < '2020-02-05' + INTERVAL 7 DAY;