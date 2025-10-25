-- Скрипт для тестирования базы данных
-- Выполните этот скрипт для проверки данных

-- 1. Проверяем существование таблиц
SELECT 'Проверка таблиц:' AS Info;
SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' ORDER BY TABLE_NAME;

-- 2. Проверяем данные в таблицах
SELECT 'Данные в таблицах:' AS Info;

SELECT 'Department' AS TableName, COUNT(*) AS RecordCount FROM Department
UNION ALL
SELECT 'Course' AS TableName, COUNT(*) AS RecordCount FROM Course
UNION ALL
SELECT 'Person' AS TableName, COUNT(*) AS RecordCount FROM Person
UNION ALL
SELECT 'StudentGrade' AS TableName, COUNT(*) AS RecordCount FROM StudentGrade;

-- 3. Показываем содержимое таблиц
SELECT 'Содержимое Department:' AS Info;
SELECT * FROM Department;

SELECT 'Содержимое Course:' AS Info;
SELECT * FROM Course;

SELECT 'Содержимое Person:' AS Info;
SELECT * FROM Person;

SELECT 'Содержимое StudentGrade:' AS Info;
SELECT * FROM StudentGrade;

-- 4. Проверяем связи
SELECT 'Связи между таблицами:' AS Info;
SELECT 
    fk.name AS ForeignKeyName,
    tp.name AS ParentTable,
    tr.name AS ReferencedTable,
    fk.delete_referential_action_desc AS DeleteAction
FROM sys.foreign_keys fk
INNER JOIN sys.tables tp ON fk.parent_object_id = tp.object_id
INNER JOIN sys.tables tr ON fk.referenced_object_id = tr.object_id
WHERE tp.name IN ('Course', 'StudentGrade')
ORDER BY tp.name, fk.name;
