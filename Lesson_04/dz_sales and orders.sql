use seminar_2;

/*
CREATE TABLE sales
(
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    order_date DATE NOT NULL,
    count_product INT NOT NULL
);
*/
/*
INSERT INTO sales(order_date, count_product)
VALUES
('2022-01-01', 156),
('2022-01-02', 180),
('2022-01-03', 21),
('2022-01-04', 124),
('2022-01-05', 341);
*/
/*
SELECT id AS 'id_заказа',
CASE
	WHEN count_product < 100 THEN 'Маленький заказ'
    WHEN count_product > 100 AND count_product < 300 THEN 'Средний заказ'
    WHEN count_product > 300 THEN 'Большой заказ'
END AS 'Тип заказа'
FROM sales;
*/
/*
CREATE TABLE orders
(
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    employee_id VARCHAR(20) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    order_status VARCHAR(45) NOT NULL
);
*/
/*
INSERT INTO orders(employee_id, amount, order_status)
VALUES
('e03', 15, 'OPEN'),
('e01', 25.50, 'OPEN'),
('e05', 100.70, 'CLOSED'),
('e02', 22.18, 'OPEN'),
('e04', 9.50, 'CANCELLED');
*/

SELECT *,
CASE
	WHEN order_status = 'OPEN'
		THEN 'ORDER IS IN OPEN STATE'
	WHEN order_status = 'CLOSED'
		THEN 'ORDER IS CLOSED'
	WHEN order_status = 'CANCELLED'
		THEN 'ORDER IS CANCELLED'
END AS 'full_order_status'
FROM orders;