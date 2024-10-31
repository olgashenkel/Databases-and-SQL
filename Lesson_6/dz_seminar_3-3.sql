USE seminar_3;
/*
 -- Создание таблицы Customers
DROP TABLE IF EXISTS Customers;

CREATE TABLE Customers (
customer_id INT PRIMARY KEY,
customer_name VARCHAR(255)
);

-- Создание таблицы Orders
DROP TABLE IF EXISTS Orders;

CREATE TABLE Orders (
order_id INT PRIMARY KEY,
customer_id INT,
order_date DATE,
total_amount DECIMAL(10, 2),
shipper_id INT,
FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

 -- Создание таблицы Shippers
DROP TABLE IF EXISTS Shippers;

CREATE TABLE Shippers (
shipper_id INT PRIMARY KEY,
shipper_name VARCHAR(255)
);

-- Создание таблицы Products
DROP TABLE IF EXISTS Products;

CREATE TABLE Products (
product_id INT PRIMARY KEY,
product_name VARCHAR(255),
category_id INT,
author VARCHAR(255),
price DECIMAL(10, 2)
);

-- Создание таблицы OrderDetails
DROP TABLE IF EXISTS OrderDetails;

CREATE TABLE OrderDetails (
order_detail_id INT PRIMARY KEY,
order_id INT,
product_id INT,
quantity INT,
FOREIGN KEY (order_id) REFERENCES Orders(order_id),
FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Создание таблицы Categories
DROP TABLE IF EXISTS Categories;

CREATE TABLE Categories (
category_id INT PRIMARY KEY,
category_name VARCHAR(255)
);


-- Наполнение таблиц данными
INSERT INTO Customers (customer_id, customer_name) 
VALUES
(1, 'Иван Иванов'), (2, 'Мария Смирнова'), (3, 'Алексей Попов'), (4,
'Наталья Кузнецова'), (5, 'Дмитрий Васильев'),
(6, 'Ольга Петрова'), (7, 'Андрей Сидоров'), (8, 'Елена Алексеева'),
(9, 'Сергей Морозов'), (10, 'Ирина Фёдорова'),
(11, 'Андрей Иванов'), (12, 'Екатерина Мартынова');

INSERT INTO Shippers (shipper_id, shipper_name) 
VALUES
(1, 'СДЕК'), (2, 'Почта России'), (3, 'ПЭК');

INSERT INTO Categories (category_id, category_name) 
VALUES
(1, 'Художественная литература'), (2, 'Наука'), (3, 'Мистика');

INSERT INTO Products (product_id, product_name, category_id, author, price) 
VALUES
(1, '1984', 1, 'Джордж Оруэлл', 250),
(2, 'Убить пересмешника', 1, 'Харпер Ли', 300),
(3, 'Великий Гэтсби', 1, 'Фрэнсис Скотт Фицджеральд', 200),
(4, 'Краткая история времени', 2, 'Стивен Хокинг', 320),
(5, 'Собака Баскервилей', 3, 'Артур Конан Дойл', 350),
(6, 'Моби Дик', 1, 'Герман Мелвилл', 400),
(7, 'Скотный двор', 1, 'Джордж Оруэлл', 220),
(8, 'Похвала Каталонии', 1, 'Джордж Оруэлл', 180),
(9, 'Дневник Анны Франк', 1, 'Анна Франк', 300),
(10, 'Краткая история времени', 2, 'Стивен Хокинг', 320);

-- Добавление заказов и деталей заказов с реалистичным распределением
INSERT INTO Orders (order_id, customer_id, order_date, total_amount, shipper_id) 
VALUES
(1, 1, '2023-01-10', 750, 1),
(2, 3, '2023-01-12', 820, 2),
(3, 2, '2023-01-15', 600, 3),
(4, 4, '2023-02-01', 670, 1),
(5, 6, '2023-02-05', 550, 2),
(6, 3, '2023-02-10', 400, 3),
(7, 7, '2023-03-01', 320, 1),
(8, 8, '2023-03-05', 500, 2),
(9, 1, '2023-03-10', 270, 3),
(10, 5, '2023-03-15', 350, 1),
(11, 4, '2023-03-20', 420, 2),
(12, 9, '2023-04-01', 300, 3),
(13, 5, '2023-04-05', 220, 1),
(14, 6, '2023-04-10', 500, 2),
(15, 8, '2023-04-15', 450, 3),
(16, 10, '2023-05-01', 350, 1),
(17, 4, '2023-05-05', 250, 2),
(18, 9, '2023-05-10', 300, 3),
(19, 7, '2023-05-15', 400, 1);

INSERT INTO OrderDetails (order_detail_id, order_id, product_id, quantity) 
VALUES
(1, 1, 1, 1), (2, 1, 2, 1), (3, 1, 4, 1),
(4, 2, 3, 1), (5, 2, 5, 1), (6, 2, 7, 1),
(7, 3, 6, 1), (8, 3, 9, 1),
(9, 4, 1, 1), (10, 4, 8, 1),
(11, 5, 2, 1), (12, 5, 5, 1),
(13, 6, 3, 1),
(14, 7, 4, 1), (15, 7, 9, 1),
(16, 8, 10, 1),
(17, 9, 5, 1), (18, 9, 6, 1),
(19, 10, 7, 1);
*/

SELECT ROUND(AVG(total_amount), 2) AS 'average_receipt'
	FROM orders;
    
SELECT 
	Shippers.shipper_name,
	EXTRACT(MONTH FROM Orders.order_date) AS month,
	EXTRACT(YEAR FROM Orders.order_date) AS year,
	COUNT(DISTINCT Orders.order_id) AS unique_orders_count
FROM Orders
JOIN Shippers ON Orders.shipper_id = Shippers.shipper_id
GROUP BY
	Shippers.shipper_name,
	EXTRACT(YEAR FROM Orders.order_date),
	EXTRACT(MONTH FROM Orders.order_date);	
    
SELECT product_name, price FROM Products
	WHERE price > 100
ORDER BY price DESC
LIMIT 5;

SELECT Categories.category_name, COUNT(DISTINCT Orders.order_id) AS order_count
	FROM OrderDetails
JOIN Products ON OrderDetails.product_id = Products.product_id
JOIN Categories ON Products.category_id = Categories.category_id
JOIN Orders ON OrderDetails.order_id = Orders.order_id
GROUP BY Categories.category_name
HAVING COUNT(DISTINCT Orders.order_id) > 1;

SELECT
	Customers.customer_id,
	Customers.customer_name,
	SUM(Orders.total_amount) AS total_amount,
	COUNT(Orders.order_id) AS order_count
FROM Orders
JOIN Customers ON Orders.customer_id = Customers.customer_id
GROUP BY Customers.customer_id, Customers.customer_name
ORDER BY Customers.customer_id;