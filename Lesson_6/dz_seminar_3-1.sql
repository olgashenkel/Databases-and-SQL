/*
DROP DATABASE IF EXISTS seminar_3;
CREATE DATABASE IF NOT EXISTS seminar_3;
*/
USE seminar_3;
/*
DROP TABLE IF EXISTS salespeople;
CREATE TABLE salespeople
(
	snum INT,
    sname VARCHAR(45),
    city VARCHAR(45),
    comm INT
);

DROP TABLE IF EXISTS customers;
CREATE TABLE customers
(
	cnum INT,
    cname VARCHAR(45),
    city VARCHAR(45),
    rating INT,
    snum INT
);


DROP TABLE IF EXISTS orders;
CREATE TABLE orders
(
	onum INT,
    amt DECIMAL(10,2),
    odate DATE,
    cnum INT,
    snum INT
);
*/
/*
INSERT salespeople (snum, sname, city, comm)
	VALUES
    (1001, 'Peel', 'London', 12),
    (1002, 'Serres', 'San Jose', 13),
    (1004, 'Motika', 'London', 11),
    (1007, 'Rifkin', 'Barcelona', 15),
    (1003, 'Axelrod', 'New York', 10);
    
INSERT customers (cnum, cname, city, rating, snum)
	VALUES
    (2001, 'Hoffman', 'London', 100, 1001),
    (2002, 'Giovanni', 'Rome', 200, 1003),
    (2003, 'Liu', 'SanJose', 200, 1002),
    (2004, 'Grass', 'Berlin', 300, 1002),
    (2006, 'Clemens', 'London', 100, 1001),
    (2008, 'Cisneros', 'SanJose', 300, 1007),
    (2007, 'Pereira', 'Rome', 100, 1004);

INSERT orders (onum, amt, odate, cnum, snum)
	VALUES
    (3001, 18.69, '1990-03-10', 2008, 1007),
    (3003, 767.19, '1990-03-10', 2001, 1001),
    (3002, 1900.10, '1990-03-10', 2007, 1004),
    (3005, 5160.45, '1990-03-10', 2003, 1002),
    (3006, 1098.16, '1990-03-10', 2008, 1007),
    (3009, 1713.23, '1990-04-10', 2002, 1003),
    (3007, 75.75, '1990-04-10', 2004, 1002),
    (3008, 4723.00, '1990-05-10', 2006, 1001),
    (3010, 1309.95, '1990-06-10', 2004, 1002),
    (3011, 9891.88, '1990-04-10', 2006, 1001);

    SELECT * FROM customers;
    SELECT * FROM orders;
    SELECT * FROM salespeople;
    */
SELECT city, sname, snum, comm 
	FROM salespeople;

SELECT rating, cname
	FROM customers
		WHERE city = 'SanJose';

SELECT DISTINCT snum FROM orders;

SELECT * FROM customers
	WHERE cname LIKE 'G%';
    
SELECT * FROM orders
	WHERE amt > 1000;

SELECT MIN(amt) AS 'Наименьшая сумма заказа' FROM orders;

SELECT * FROM customers
	WHERE rating > 100 AND city <> 'Rome';
