-- Быстрый тест базы данных
-- Выполните этот скрипт для проверки готовности системы

PRINT '=== ПРОВЕРКА БАЗЫ ДАННЫХ ===';

-- 1. Проверяем таблицы
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Department')
    PRINT '✅ Таблица Department существует'
ELSE
    PRINT '❌ Таблица Department НЕ существует';

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Course')
    PRINT '✅ Таблица Course существует'
ELSE
    PRINT '❌ Таблица Course НЕ существует';

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Person')
    PRINT '✅ Таблица Person существует'
ELSE
    PRINT '❌ Таблица Person НЕ существует';

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'StudentGrade')
    PRINT '✅ Таблица StudentGrade существует'
ELSE
    PRINT '❌ Таблица StudentGrade НЕ существует';

-- 2. Проверяем данные
PRINT '';
PRINT '=== ПРОВЕРКА ДАННЫХ ===';

DECLARE @deptCount INT = (SELECT COUNT(*) FROM Department);
DECLARE @courseCount INT = (SELECT COUNT(*) FROM Course);
DECLARE @personCount INT = (SELECT COUNT(*) FROM Person);
DECLARE @gradeCount INT = (SELECT COUNT(*) FROM StudentGrade);

PRINT 'Кафедр: ' + CAST(@deptCount AS VARCHAR(10));
PRINT 'Курсов: ' + CAST(@courseCount AS VARCHAR(10));
PRINT 'Студентов: ' + CAST(@personCount AS VARCHAR(10));
PRINT 'Оценок: ' + CAST(@gradeCount AS VARCHAR(10));

-- 3. Проверяем каскадное удаление
PRINT '';
PRINT '=== ПРОВЕРКА КАСКАДНОГО УДАЛЕНИЯ ===';

DECLARE @cascadeCount INT = (
    SELECT COUNT(*) 
    FROM sys.foreign_keys 
    WHERE delete_referential_action = 1
);

IF @cascadeCount > 0
    PRINT '✅ Каскадное удаление настроено (' + CAST(@cascadeCount AS VARCHAR(10)) + ' ограничений)'
ELSE
    PRINT '❌ Каскадное удаление НЕ настроено';

-- 4. Показываем примеры данных
PRINT '';
PRINT '=== ПРИМЕРЫ ДАННЫХ ===';

SELECT TOP 3 'Кафедры:' AS Info, Name FROM Department;
SELECT TOP 3 'Курсы:' AS Info, Title FROM Course;
SELECT TOP 3 'Студенты:' AS Info, LastName + ', ' + FirstMidName AS Name FROM Person;

PRINT '';
PRINT '=== ТЕСТ ЗАВЕРШЕН ===';
PRINT 'Если все пункты отмечены ✅ - база данных готова к тестированию!';
