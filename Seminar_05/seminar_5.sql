USE seminar_5;

CREATE TABLE users (
username VARCHAR(50) PRIMARY KEY,
password VARCHAR(50) NOT NULL,
status VARCHAR(10) NOT NULL);

CREATE TABLE users_profile (
username VARCHAR(50) PRIMARY KEY,
name VARCHAR(50) NOT NULL,
address VARCHAR(50) NOT NULL,
email VARCHAR(50) NOT NULL,
FOREIGN KEY (username) REFERENCES users(username) ON DELETE CASCADE);

INSERT INTO users values
('admin' , '7856', 'Active'),
('staff' , '90802', 'Active'),
('manager' , '35462', 'Inactive');

INSERT INTO users_profile values
('admin', 'Administrator' , 'Dhanmondi', 'admin@test.com' ) ,
('staff', 'Jakir Nayek' , 'Mirpur', 'zakir@test.com' ),
('manager', 'Mehr Afroz' , 'Eskaton', 'mehr@test.com' );

/* Задание 1.
	1. Используя CTE, выведите всех пользователей из таблицы users_profil
    2. Используя CTE, посчитайте количество активных пользователей.
		Задайте псевдоним результирующему окну.
	3. С помощью CTE реализуйте таблицу квадратов чисел от 1 до 10.
*/

-- 1. Используя CTE, выведите всех пользователей из таблицы users_profil
WITH cte1 AS (
	SELECT * FROM users_profile)
SELECT * FROM cte1
WHERE username = 'admin';


-- 2. Используя CTE, посчитайте количество активных пользователей.
		-- Задайте псевдоним результирующему окну.
WITH cte_users AS (
	SELECT COUNT(*) AS total
    FROM users
    WHERE status = 'Active'
    GROUP BY status
)

SELECT total AS total_active FROM cte_users;


-- 3. С помощью CTE реализуйте таблицу квадратов чисел от 1 до 10.
WITH RECURSIVE cte2 AS
(
	SELECT 1 AS a, 1 AS res
    UNION ALL
    SELECT a + 1, pow(a + 1, 2) AS res
    FROM cte2
    WHERE a < 10
)

SELECT * FROM cte2;


/*Задание 2.
Собрать дэшборд, в котором содержится информация о максимальной
задолженности в каждом банке, а также средний размер процентной ставки  
в каждом банке в зависимости от сегмента и количество договоров 
всего всем банкам
*/

CREATE TABLE bank(
TB VARCHAR(10),
ID_CLIENT INT,
ID_DOG INT,
OSZ INT,
PROCENT_RATE INT,
RATING INT,
SEGMENT VARCHAR(20)
);
INSERT INTO bank(TB, ID_CLIENT, ID_DOG, OSZ, PROCENT_RATE, RATING, SEGMENT)
VALUES
('A', 1, 111, 100, 6, 10, 'SREDN'),
('A', 1, 222, 150, 6, 10, 'SREDN'),
('A', 2, 333, 50, 9, 15, 'MMB'),
('B', 1, 444, 200, 7, 10, 'SREDN'),
('B', 3, 555, 1000, 5, 16, 'CIB'),
('B', 4, 666, 500, 10, 20, 'CIB'),
('B', 4, 777, 10, 12, 17, 'MMB'),
('C', 5, 888, 20, 11, 21, 'MMB'),
('C', 5, 999, 200, 9, 13, 'SREDN');
SELECT * FROM bank;

SELECT TB, ID_CLIENT, ID_DOG, OSZ, PROCENT_RATE, RATING, SEGMENT,
	MAX(OSZ) OVER (PARTITION BY TB) AS 'максимальная задолженность \nв каждом банке',
    AVG(PROCENT_RATE) OVER (PARTITION BY TB, SEGMENT) AS 'средний размер \nпроцентной ставки',
    COUNT(ID_DOG) OVER () AS 'количество договоров'
FROM bank;


/*Задание 3.
Проранжировать таблицу по убыванию количества ревизий
*/

CREATE TABLE bank_2(
tb VARCHAR(10),
dep VARCHAR(20),
count_revisions INT
);

INSERT INTO bank_2(tb, dep, count_revisions)
VALUES
('D', 'Rozn', 120),
('F', 'Rozn', 111),
('A', 'Corp', 100),
('D', 'Corp', 95),
('A', 'IT', 95),
('D', 'IT', 85),
('E', 'IT', 80),
('E', 'Rozn', 72),
('E', 'Corp', 70),
('B', 'Corp', 70),
('F', 'Corp', 66),
('B', 'Rozn', 65),
('C', 'IT', 63),
('B', 'IT', 58),
('A', 'Rozn', 47),
('C', 'Corp', 42),
('C', 'Rozn', 40),
('F', 'IT', 33);

SELECT * FROM bank_2;

SELECT *,
	ROW_NUMBER() OVER(ORDER BY count_revisions DESC) AS 'row_number',
    RANK() OVER(ORDER BY count_revisions DESC) AS 'rank',
    DENSE_RANK() OVER(ORDER BY count_revisions DESC) AS 'dense_rank',
    NTILE(3) OVER(ORDER BY count_revisions DESC) AS 'ntile'
FROM bank_2;


/*Задание 4.
Найти второй отдел во всех банках по количеству ревизий
*/

WITH T_R AS
(
	SELECT *, DENSE_RANK() OVER(PARTITION BY tb
    ORDER BY count_revisions) AS ds
    FROM bank_2
)
SELECT tb, dep, count_revisions, ds
FROM T_R
WHERE ds=1;


/*Задание 5.
Оконные функции смещения
*/

DROP TABLE IF EXISTS table_task; 

CREATE TABLE table_task
(
	id_task INT,
    event VARCHAR(20),
    date_event DATE
);

INSERT INTO table_task (id_task, event, date_event)
VALUES
(1, 'Open', '2020-02-01'),
(1, 'To_1_Line', '2020-02-02'),
(1, 'To_2_Line', '2020-02-03'),
(1, 'Successful', '2020-02-04'),
(1, 'Close', '2020-02-05'),
(2, 'Open', '2020-03-01'),
(2, 'To_1_Line', '2020-03-02'),
(2, 'Denied', '2020-03-03'),
(3, 'Open', '2020-04-01'),
(3, 'To_1_Line', '2020-04-02'),
(3, 'To_2_Line', '2020-04-03');

SELECT * FROM table_task;

SELECT *,
	LEAD (event, 1, 'end') 
    OVER (PARTITION BY id_task ORDER BY date_event) AS next_event,
	LEAD (date_event, 1, '----') 
    OVER (PARTITION BY id_task ORDER BY date_event) AS next_date
FROM table_task;
