USE seminar_1;
/*
SELECT ProductName, Manufacturer, Price FROM dz_phone
	WHERE ProductCount > 2;
    */
/*
SELECT * FROM dz_phone
	WHERE Manufacturer LIKE 'Samsung';
*/
/*
SELECT * FROM dz_phone
	WHERE ProductName LIKE '%iphone%';
*/
/*
SELECT * FROM dz_phone
	WHERE Manufacturer LIKE '%samsung%';
*/
/*
SELECT * FROM dz_phone
	# WHERE ProductName RLIKE '[0-9]';
# или:
    WHERE ProductName REGEXP '[0-9]';
*/
SELECT * FROM dz_phone
    WHERE ProductName REGEXP '[8]';