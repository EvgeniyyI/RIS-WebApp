-- Скрипт для проверки текущего состояния базы данных
-- Показывает все таблицы, ограничения и связи

-- 1. Показываем все таблицы
SELECT 
    'Таблицы в базе данных:' AS Info;
    
SELECT 
    TABLE_NAME AS TableName,
    TABLE_TYPE AS TableType
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_SCHEMA = 'dbo'
ORDER BY TABLE_NAME;

-- 2. Показываем все внешние ключи
SELECT 
    'Внешние ключи:' AS Info;
    
SELECT 
    fk.name AS ForeignKeyName,
    tp.name AS ParentTable,
    cp.name AS ParentColumn,
    tr.name AS ReferencedTable,
    cr.name AS ReferencedColumn,
    fk.delete_referential_action_desc AS DeleteAction,
    fk.update_referential_action_desc AS UpdateAction
FROM sys.foreign_keys fk
INNER JOIN sys.tables tp ON fk.parent_object_id = tp.object_id
INNER JOIN sys.tables tr ON fk.referenced_object_id = tr.object_id
INNER JOIN sys.foreign_key_columns fkc ON fk.object_id = fkc.constraint_object_id
INNER JOIN sys.columns cp ON fkc.parent_object_id = cp.object_id AND fkc.parent_column_id = cp.column_id
INNER JOIN sys.columns cr ON fkc.referenced_object_id = cr.object_id AND fkc.referenced_column_id = cr.column_id
ORDER BY tp.name, fk.name;

-- 3. Показываем количество записей в каждой таблице
SELECT 
    'Количество записей в таблицах:' AS Info;
    
SELECT 
    'Department' AS TableName,
    COUNT(*) AS RecordCount
FROM Department
UNION ALL
SELECT 
    'Course' AS TableName,
    COUNT(*) AS RecordCount
FROM Course
UNION ALL
SELECT 
    'Person' AS TableName,
    COUNT(*) AS RecordCount
FROM Person
UNION ALL
SELECT 
    'StudentGrade' AS TableName,
    COUNT(*) AS RecordCount
FROM StudentGrade;

-- 4. Проверяем, есть ли каскадное удаление
SELECT 
    'Проверка каскадного удаления:' AS Info;
    
SELECT 
    CASE 
        WHEN EXISTS (
            SELECT 1 FROM sys.foreign_keys 
            WHERE delete_referential_action = 1 
            AND parent_object_id IN (
                SELECT object_id FROM sys.tables WHERE name IN ('Course', 'StudentGrade')
            )
        ) 
        THEN 'Каскадное удаление НАСТРОЕНО' 
        ELSE 'Каскадное удаление НЕ НАСТРОЕНО' 
    END AS CascadeDeleteStatus;

