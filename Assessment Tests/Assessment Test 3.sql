-- Assessment Test 3

-- Create a database called "School".
-- The databse constain two tables: students and teachers

CREATE TABLE students(
	student_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	homeroom_number SMALLINT NOT NULL,
	phone VARCHAR(12) UNIQUE NOT NULL,
	email VARCHAR(50) UNIQUE,
	graduation_year SMALLINT
);

CREATE TABLE teachers(
	teacher_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	homeroom_number SMALLINT NOT NULL,
	department VARCHAR(50),
	email VARCHAR(50) UNIQUE,
	phone VARCHAR(12) UNIQUE NOT NULL
);

INSERT INTO students(first_name, last_name, phone, graduation_year, homeroom_number)
VALUES
	('Mark', 'Watney', '777-555-1234', 2035, 5

SELECT *
FROM students;

INSERT INTO teachers(first_name, last_name, homeroom_number, department, email, phone)
VALUES
	('Jonas', 'Salk', 5, 'Biology', 'jsalk@school.org', '777-555-4321');

SELECT *
FROM teachers;
