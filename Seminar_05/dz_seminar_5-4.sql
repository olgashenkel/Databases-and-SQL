USE seminar_5;

-- Запрос на создание начальной таблицы, выполнять задания на основе этих данных

-- Создание таблицы Employees
DROP TABLE IF EXISTS Employees;

CREATE TABLE Employees (
employee_id INT PRIMARY KEY,
employee_name VARCHAR(255)
);

-- Создание таблицы Orders
DROP TABLE IF EXISTS Orders;

CREATE TABLE Orders (
order_id INT PRIMARY KEY,
employee_id INT,
customer_id INT,
order_date DATE,
total_amount DECIMAL(10, 2),
FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);

-- Создание таблицы Customers
DROP TABLE IF EXISTS Customers;

CREATE TABLE Customers (
customer_id INT PRIMARY KEY,
customer_name VARCHAR(255)
);

-- Наполнение таблиц данными
INSERT INTO Employees (employee_id, employee_name) 
VALUES
(1, 'Alice Johnson'), (2, 'Bob Brown'), (3, 'Charlie Davis'),
(4, 'David Wilson'), (5, 'Emily Clark');

INSERT INTO Customers (customer_id, customer_name) 
VALUES
(1, 'John Doe'), (2, 'Jane Smith'), (3, 'Alice Johnson'),
(4, 'Bob Brown'), (5, 'Charlie Davis'), (6, 'Emily Clark'),
(7, 'David Wilson'), (8, 'Laura Adams'), (9, 'Michael Thompson'),
(10, 'Sarah Parker');

INSERT INTO Orders (order_id, employee_id, customer_id, order_date, total_amount) 
VALUES
(1, 1, 1, '2023-01-15', 550.00),
(2, 2, 2, '2023-02-20', 600.00),
(3, 3, 3, '2023-03-10', 300.00),
(4, 4, 4, '2023-04-25', 750.00),
(5, 5, 5, '2023-05-18', 450.00),
(6, 1, 6, '2023-06-12', 500.00),
(7, 2, 7, '2023-07-21', 700.00),
(8, 3, 8, '2023-08-30', 620.00),
(9, 4, 9, '2023-09-14', 480.00),
(10, 5, 10, '2023-10-03', 510.00);


/* Задание 1:
Создайте хранимую процедуру GetEmployeeOrders, которая принимает идентификатор сотрудника 
в качестве параметра и возвращает все заказы, обработанные этим сотрудником.
*/

DELIMITER //
CREATE PROCEDURE GetEmployeeOrders (IN pr_employee_id INT)
BEGIN
	SELECT o.order_id, o.order_date, c.customer_name
		FROM orders AS o
        JOIN customers AS c ON o.customer_id = c.customer_id
        WHERE o.employee_id = pr_employee_id;
END//

CALL GetEmployeeOrders(5);


/* Задание 2:
Создайте представление EmployeeOrderSummary, 
которое покажет общую сумму заказов для каждого сотрудника.
*/

DROP VIEW IF EXISTS EmployeeOrderSummary;

CREATE VIEW EmployeeOrderSummary AS
	SELECT e.employee_name, SUM(o.total_amount) AS total_sales
    FROM orders AS o
    RIGHT JOIN Employees AS e ON o.employee_id = e.employee_id
    GROUP BY e.employee_name;

SELECT * FROM EmployeeOrderSummary;


/* Задание 3:
Ранжируйте заказы каждого сотрудника на основе суммы заказа (total_amount)
*/

SELECT e.employee_name, o.order_id, o.total_amount,
RANK() OVER (PARTITION BY e.employee_id ORDER BY o.total_amount DESC) AS order_rank
FROM Employees e
JOIN Orders o ON e.employee_id = o.employee_id;



/* Задание 4:
Используйте оконные функции для получения предыдущего и следующего заказа для каждого 
заказа на основе даты заказа
*/

SELECT order_id, order_date,
LAG(order_date) OVER (ORDER BY order_date) AS prev_order_date,
LEAD(order_date) OVER (ORDER BY order_date) AS next_order_date
FROM Orders;



/* Задание 5:
Используйте оконные функции для получения среднего, минимального и максимального значения 
суммы заказов для каждого сотрудника
*/

SELECT e.employee_name, o.order_id, o.total_amount,
	AVG(o.total_amount) OVER (PARTITION BY e.employee_id) AS avg_amount,
	MIN(o.total_amount) OVER (PARTITION BY e.employee_id) AS min_amount,
	MAX(o.total_amount) OVER (PARTITION BY e.employee_id) AS max_amount
FROM Employees e
JOIN Orders o ON e.employee_id = o.employee_id;


/* Задание 6:
Создайте представление OrderAnalysis, которое будет содержать информацию о каждом заказе, 
включая имя сотрудника, имя клиента, ранг заказа по сумме для каждого сотрудника, среднюю, 
минимальную и максимальную сумму заказов для каждого сотрудника, 
а также даты предыдущего и следующего заказов
*/

CREATE VIEW OrderAnalysis AS
SELECT e.employee_name, c.customer_name, o.order_id, o.total_amount,
RANK() OVER (PARTITION BY e.employee_id ORDER BY o.total_amount DESC) AS order_rank,
	AVG(o.total_amount) OVER (PARTITION BY e.employee_id) AS avg_amount,
	MIN(o.total_amount) OVER (PARTITION BY e.employee_id) AS min_amount,
	MAX(o.total_amount) OVER (PARTITION BY e.employee_id) AS max_amount,
	LAG(o.order_date) OVER (ORDER BY o.order_date) AS prev_order_date,
	LEAD(o.order_date) OVER (ORDER BY o.order_date) AS next_order_date
FROM Employees e
JOIN Orders o ON e.employee_id = o.employee_id
JOIN Customers c ON o.customer_id = c.customer_id;

SELECT * FROM OrderAnalysis;
