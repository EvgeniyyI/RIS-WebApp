-- Minimal Contoso-like schema for School (simplified for demo)
CREATE TABLE Department(
    DepartmentID INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(50) NOT NULL
);
CREATE TABLE Course(
    CourseID INT IDENTITY PRIMARY KEY,
    Title NVARCHAR(100) NOT NULL,
    Credits INT NOT NULL DEFAULT 3,
    DepartmentID INT NOT NULL FOREIGN KEY REFERENCES Department(DepartmentID) ON DELETE CASCADE
);
CREATE TABLE Person(
    PersonID INT IDENTITY PRIMARY KEY,
    LastName NVARCHAR(50) NOT NULL,
    FirstMidName NVARCHAR(50) NOT NULL,
    EnrollmentDate DATE NULL
);
CREATE TABLE StudentGrade(
    EnrollmentID INT IDENTITY PRIMARY KEY,
    CourseID INT NOT NULL FOREIGN KEY REFERENCES Course(CourseID) ON DELETE CASCADE,
    StudentID INT NOT NULL FOREIGN KEY REFERENCES Person(PersonID) ON DELETE CASCADE,
    Grade DECIMAL(3,2) NULL
);

-- Seed
INSERT Department(Name) VALUES (N'CS'),(N'Math'),(N'History');
INSERT Course(Title,Credits,DepartmentID) VALUES
 (N'Algorithms',4,1),(N'Data Structures',3,1),
 (N'Calculus',5,2),(N'Linear Algebra',4,2),
 (N'World History',3,3);

INSERT Person(LastName, FirstMidName, EnrollmentDate) VALUES
 (N'Adams', N'Alice', '2023-09-01'),
 (N'Brown', N'Bob', '2022-09-01'),
 (N'Clark', N'Caroline', '2024-02-15');
