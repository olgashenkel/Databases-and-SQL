USE seminar_1;

SELECT * FROM table_1

# 1. Выбрать всех сотрудников, у которых зарплата больше 6000
# WHERE salary > 6000;

# 2. Выбрать сотрудников, которые принадлежат отделу IT 
# WHERE dept LIKE 'IT';
# или:
WHERE dept = 'IT';

SELECT name, dept FROM table_1

# 3. Выбрать сотрудников, которые НЕ принадлежат отделу IT 
#WHERE dept NOT LIKE 'IT';
# или:
WHERE dept != 'IT';
