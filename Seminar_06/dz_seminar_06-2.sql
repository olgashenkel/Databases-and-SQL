USE seminar_6;

/*
Задание 2. Выведите только чётные числа от 1 до 10.
			Пример: 2,4,6,8,10
*/

DROP FUNCTION IF EXISTS fk_numbers;

DELIMITER //
CREATE FUNCTION fk_numbers(var_numbers INT)
RETURNS VARCHAR(256) READS SQL DATA
BEGIN
	DECLARE i INT DEFAULT 4;
    DECLARE result VARCHAR(256);

	IF var_numbers >= 2 AND var_numbers < 4 
		THEN SET result = '2';
		RETURN result;
	ELSEIF var_numbers >= 4 THEN
		SET result = '2';
		WHILE i <= var_numbers DO
				SET result = CONCAT(result, ', ', i);
				SET i = i + 2;
			END WHILE;
		RETURN result;
    ELSE 
        RETURN 'Нет значений для вывода результата';
	END IF;
    
END//
DELIMITER ;

SELECT fk_numbers(10) AS 'Чётные числа';