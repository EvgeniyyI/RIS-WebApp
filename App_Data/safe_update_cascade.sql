-- Безопасный скрипт для добавления каскадного удаления
-- Этот скрипт проверяет существование ограничений перед их изменением

-- Функция для безопасного удаления ограничения
DECLARE @sql NVARCHAR(MAX);

-- 1. Удаляем ограничение Course -> Department (если существует)
IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK__Course__Departme__276EDEB3')
BEGIN
    SET @sql = 'ALTER TABLE Course DROP CONSTRAINT FK__Course__Departme__276EDEB3';
    EXEC sp_executesql @sql;
    PRINT 'Удалено ограничение FK__Course__Departme__276EDEB3';
END

-- 2. Удаляем ограничение StudentGrade -> Course (если существует)
IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK__StudentGr__Cours__2C3393D0')
BEGIN
    SET @sql = 'ALTER TABLE StudentGrade DROP CONSTRAINT FK__StudentGr__Cours__2C3393D0';
    EXEC sp_executesql @sql;
    PRINT 'Удалено ограничение FK__StudentGr__Cours__2C3393D0';
END

-- 3. Удаляем ограничение StudentGrade -> Person (если существует)
IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK__StudentGr__Stude__2D27B809')
BEGIN
    SET @sql = 'ALTER TABLE StudentGrade DROP CONSTRAINT FK__StudentGr__Stude__2D27B809';
    EXEC sp_executesql @sql;
    PRINT 'Удалено ограничение FK__StudentGr__Stude__2D27B809';
END

-- 4. Создаем новые ограничения с каскадным удалением
-- Course -> Department
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_Course_Department_Cascade')
BEGIN
    ALTER TABLE Course 
    ADD CONSTRAINT FK_Course_Department_Cascade 
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID) ON DELETE CASCADE;
    PRINT 'Создано ограничение FK_Course_Department_Cascade с каскадным удалением';
END

-- StudentGrade -> Course
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_StudentGrade_Course_Cascade')
BEGIN
    ALTER TABLE StudentGrade 
    ADD CONSTRAINT FK_StudentGrade_Course_Cascade 
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID) ON DELETE CASCADE;
    PRINT 'Создано ограничение FK_StudentGrade_Course_Cascade с каскадным удалением';
END

-- StudentGrade -> Person
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_StudentGrade_Person_Cascade')
BEGIN
    ALTER TABLE StudentGrade 
    ADD CONSTRAINT FK_StudentGrade_Person_Cascade 
    FOREIGN KEY (StudentID) REFERENCES Person(PersonID) ON DELETE CASCADE;
    PRINT 'Создано ограничение FK_StudentGrade_Person_Cascade с каскадным удалением';
END

-- 5. Показываем результат
SELECT 
    'Текущие ограничения:' AS Info,
    fk.name AS ForeignKeyName,
    tp.name AS ParentTable,
    tr.name AS ReferencedTable,
    fk.delete_referential_action_desc AS DeleteAction
FROM sys.foreign_keys fk
INNER JOIN sys.tables tp ON fk.parent_object_id = tp.object_id
INNER JOIN sys.tables tr ON fk.referenced_object_id = tr.object_id
WHERE tp.name IN ('Course', 'StudentGrade')
ORDER BY tp.name, fk.name;

PRINT 'Обновление завершено успешно!';

