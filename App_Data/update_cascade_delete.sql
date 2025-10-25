-- Скрипт для добавления каскадного удаления к существующим внешним ключам
-- Выполните этот скрипт, если база данных уже создана и содержит данные

-- 1. Удаляем существующие внешние ключи
IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK__Course__Departme__276EDEB3')
    ALTER TABLE Course DROP CONSTRAINT FK__Course__Departme__276EDEB3;

IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK__StudentGr__Cours__2C3393D0')
    ALTER TABLE StudentGrade DROP CONSTRAINT FK__StudentGr__Cours__2C3393D0;

IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK__StudentGr__Stude__2D27B809')
    ALTER TABLE StudentGrade DROP CONSTRAINT FK__StudentGr__Stude__2D27B809;

-- 2. Создаем новые внешние ключи с каскадным удалением
ALTER TABLE Course 
ADD CONSTRAINT FK_Course_Department_Cascade 
FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID) ON DELETE CASCADE;

ALTER TABLE StudentGrade 
ADD CONSTRAINT FK_StudentGrade_Course_Cascade 
FOREIGN KEY (CourseID) REFERENCES Course(CourseID) ON DELETE CASCADE;

ALTER TABLE StudentGrade 
ADD CONSTRAINT FK_StudentGrade_Person_Cascade 
FOREIGN KEY (StudentID) REFERENCES Person(PersonID) ON DELETE CASCADE;

-- Проверяем, что ограничения созданы
SELECT 
    fk.name AS ForeignKeyName,
    tp.name AS ParentTable,
    cp.name AS ParentColumn,
    tr.name AS ReferencedTable,
    cr.name AS ReferencedColumn,
    fk.delete_referential_action_desc AS DeleteAction
FROM sys.foreign_keys fk
INNER JOIN sys.tables tp ON fk.parent_object_id = tp.object_id
INNER JOIN sys.tables tr ON fk.referenced_object_id = tr.object_id
INNER JOIN sys.foreign_key_columns fkc ON fk.object_id = fkc.constraint_object_id
INNER JOIN sys.columns cp ON fkc.parent_object_id = cp.object_id AND fkc.parent_column_id = cp.column_id
INNER JOIN sys.columns cr ON fkc.referenced_object_id = cr.object_id AND fkc.referenced_column_id = cr.column_id
WHERE tp.name IN ('Course', 'StudentGrade')
ORDER BY tp.name, fk.name;

PRINT 'Каскадное удаление успешно добавлено!';
