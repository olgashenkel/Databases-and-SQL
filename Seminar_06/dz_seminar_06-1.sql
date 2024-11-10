USE seminar_6;
/*
Задание 1. Создайте функцию, которая принимает кол-во сек и формат их в кол-во дней часов.
Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '
*/
DROP FUNCTION IF EXISTS fk_time;

DELIMITER //
CREATE FUNCTION fk_time(var_time INT)
	RETURNS VARCHAR(60) READS SQL DATA
BEGIN
	DECLARE fk_var VARCHAR(60);
    IF var_time < 60 AND var_time > 0
		THEN SET fk_var = CONCAT(var_time, ' секунд');
		RETURN fk_var;
	ELSEIF var_time >= 60 AND var_time < 3600
  		THEN SET fk_var = CONCAT(TRUNCATE(var_time/60, 0), ' minutes ', var_time%60, ' seconds');
		RETURN fk_var;
    ELSEIF var_time >= 3600 AND var_time < 86400
  		THEN SET fk_var = CONCAT(TRUNCATE(var_time/3600, 0), ' hours ', TRUNCATE(var_time%3600/60, 0), ' minutes ', var_time%3600%60, ' seconds');
		RETURN fk_var;        
	ELSEIF var_time >= 86400
  		THEN SET fk_var = CONCAT(TRUNCATE(var_time/86400, 0), ' days ', TRUNCATE(var_time%86400/3600, 0), ' hours ', 
				TRUNCATE(var_time%86400%3600/60, 0), ' minutes ', var_time%86400%3600%60, ' seconds');
    	RETURN fk_var;
	ELSE
		RETURN 'Некорректный ввод данных';

	END IF;
	# RETURN fk_var;
END//
DELIMITER ;

SELECT fk_time(123456) AS 'Преобразование числа \nв единицы измерения времени';