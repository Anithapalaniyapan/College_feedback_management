create database College_Feedback_Management;
use College_Feedback_Management;

CREATE TABLE Authentication (
    user_id INT PRIMARY KEY ,
    username VARCHAR(100) ,
    password_hash VARCHAR(255) NOT NUll,
    role ENUM('student', 'staff', 'academic_director') NOT NULL
);

INSERT INTO Authentication (user_id, username, password_hash, role)
VALUES
(1, 'student1', 'hashed_password_1', 'student'),
(2, 'staff1', 'hashed_password_2', 'staff'),
(3, 'director1', 'hashed_password_3', 'academic_director');

select*from authentication;

CREATE TABLE Department (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL
);

INSERT INTO Department (department_id,department_name)
 VALUES
(1, 'Computer Science and Engineering'),
(2, 'Information Technology'),          
(3, 'Artificial Intelligence & Data Science'),
(4, 'Cyber Security'),                    
(5, 'Mechanical Engineering'),          
(6, 'Electronics and Communication Engineering'),  
(7, 'Agricultural Engineering'),        
(8, 'Biomedical Engineering');


select*from department ;          


CREATE TABLE Academic_Year (
    year_id INT PRIMARY KEY ,
    year_name VARCHAR(50)  NOT NULL  
);


INSERT INTO Academic_Year (year_id,year_name)
VALUES('1','First Year'),
('4','Second Year'),
('5','Third Year'),
('6','Fourth Year');


select*from Academic_Year ;


CREATE TABLE Semester (
    semester_id INT PRIMARY KEY,
    semester_name VARCHAR(50)NOT NULL
);

INSERT INTO Semester (semester_id,semester_name) 
VALUES(77, 'Semester 1'),
(7, 'Semester 2'),
(8, 'Semester 3'),
(9, 'Semester 4'),
(12, 'Semester 5'),
(34, 'Semester 6'),
(35, 'Semester 7'),
(88, 'Semester 8');


select*from Semester ;


CREATE TABLE Student (
    student_id INT PRIMARY KEY ,
    fullname VARCHAR(100),
    dob DATE,
    phone_no VARCHAR(15),
    email VARCHAR(100) UNIQUE,
    gender ENUM('Male', 'Female'),
    age INT,
    department_id INT,
    year_id INT,
    semester_id INT,
    FOREIGN KEY (department_id) REFERENCES Department(department_id),
    FOREIGN KEY (year_id) REFERENCES Academic_Year(year_id),
    FOREIGN KEY (semester_id) REFERENCES Semester(semester_id)
);


INSERT INTO Student (student_id, fullname, dob, phone_no, email, gender, age, department_id, year_id, semester_id)
VALUES(9, 'Nila Prabakaran', '2004-09-15', '8765432190', 'nila@shanmugha.edu.in', 'Female', 20, 2, 1, 7),
(10, 'Ishwariya Paramesh', '2005-10-10', '9876543215', 'ishwariya@shanmugha.edu.in', 'Female', 19, 3, 1, 9),
(11, 'Lavanya Kannan', '2004-05-30', '6543217890', 'lavanya@shanmugha.edu.in', 'Female', 20, 4, 1, 8),
(12, 'Haritha Elango', '2005-11-25', '7654321098', 'haritha@shanmugha.edu.in', 'Female', 19, 2, 1, 35),
(13, 'Niranjana Rajkumar', '2004-12-18', '8765432109', 'niranjana@shanmugha.edu.in', 'Female', 20, 1, 1, 77),
(14, 'Sathvika Sivakumar', '2005-03-27', '9876543201', 'sathvika@shanmugha.edu.in', 'Female', 19, 4, 1, 9),
(15, ' Arvindkumar', '2004-07-08', '7890123456', 'arvind@shanmugha.edu.in', 'Female', 20, 3, 1, 8),
(16, 'Mahima Thirumalai', '2005-01-19', '8901234567', 'mahima@shanmugha.edu.in', 'Female', 19, 5, 1, 35);

select*from student ;


CREATE TABLE Staff (
    staff_id INT PRIMARY KEY ,
    user_id INT,
    name VARCHAR(100),
    email VARCHAR(100),
    phone_number VARCHAR(15),
    department_id INT,
    FOREIGN KEY (user_id) REFERENCES Authentication(user_id),
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);


INSERT INTO Staff (staff_id, user_id, name, email, phone_number, department_id)
VALUES
(1, 1, 'Mr. A. Kumar', 'kumar@shanmugha.edu.in', '1234567890', 1),
(2, 2, 'Mr. M. Venkatesh', 'venkatesh@shanmugha.edu.in', '2345678901', 2),
(3, 3, 'Ms. P. Sharma', 'sharma@shanmugha.edu.in', '3456789012', 1),
(4, 2, 'Ms. S. Deepa', 'deepa@shanmugha.edu.in', '4567890123', 1),
(5, 1, 'Ms. P. Dhanush', 'dhanush@shanmugha.edu.in', '5678901234', 1),
(6, 3, 'Mr. N. Madhavan', 'madhavan@shanmugha.edu.in', '6789012345', 2);


select*from staff;

CREATE TABLE Feedback_Category (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100)
);

INSERT INTO Feedback_Category (category_id,category_name)
 VALUES(444,'Course Quality'),
(555,'Instructor Quality'),
(666,'Facilities'),
(777,'Overall Experience');


select*from Feedback_Category;


CREATE TABLE Question (
    question_id INT PRIMARY KEY ,
    question_text TEXT ,
    role ENUM('student', 'staff') NOT NULL,
    category_id INT,
    created_at time,
    FOREIGN KEY (category_id) REFERENCES Feedback_Category(category_id)
);


INSERT INTO Question (category_id,question_id, question_text,created_at,role)
VALUES(444,12, 'How would you rate the quality of the course materials?','12:00','student'),
(444, 13,'How relevant is the course content to your field of study?','11:55','staff'),
(555, 14,'How effective is the instructor in delivering the content?','7:00','staff'),
(666, 15,'How approachable is the instructor?','8:00','student'),
(444, 16,'How would you rate the campus facilities?','7:55','staff'),
(666, 17,'How satisfied are you with your overall experience at the college?','8:09','student');


select*from question;

CREATE TABLE Student_Feedback (
    feedback_id INT PRIMARY KEY ,
    student_id INT,
    question_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    semester_id INT,
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (question_id) REFERENCES Question(question_id),
    FOREIGN KEY (semester_id) REFERENCES Semester(semester_id)
);


INSERT INTO Student_Feedback (feedback_id,student_id, question_id, rating, semester_id)
VALUES(121, 9, 12, 5, 77),
(221, 10, 13, 4, 8),
(123, 12, 14, 3, 9),
(124, 16, 15, 4, 12),
(125, 11, 17, 5, 8);


select*from Student_Feedback ;

CREATE TABLE Staff_Feedback (
    feedback_id INT PRIMARY KEY ,
    staff_id INT,
    question_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 10),
    FOREIGN KEY (staff_id) REFERENCES Staff(staff_id),
    FOREIGN KEY (question_id) REFERENCES Question(question_id)
);


INSERT INTO Staff_Feedback (feedback_id,staff_id, question_id, rating)
VALUES(221,1, 13, 5),  
(121, 2,14, 4),  
(123,3, 15, 3),  
(124,4, 16, 4),  
(125, 5 ,17, 5);

select*from Staff_Feedback  ;


CREATE TABLE Feedback_Summary (
    summary_id INT PRIMARY KEy,
    role ENUM('student', 'staff'),
    overall_score DECIMAL,
    category_id INT,
    department_id INT,
    semester_id INT,          
    generated_at TIME,
    FOREIGN KEY (category_id) REFERENCES Feedback_Category(category_id),
    FOREIGN KEY (department_id) REFERENCES Department(department_id),
    FOREIGN KEY (semester_id) REFERENCES Semester(semester_id)
);

INSERT INTO Feedback_Summary (summary_id,role, overall_score, category_id, department_id, semester_id,generated_at)
VALUES
(1, 'student', 4.5, 444, 2, 77, '10:30:00'),
(2, 'staff', 3.8, 555, 1, 8, '11:15:00'),
(3, 'student', 4.2, 666, 3, 9, '14:00:00'),
(4, 'staff', 4.9, 777, 2, 12, '09:45:00');


select*from  Feedback_Summary  ;

SELECT 
    Student_Feedback.feedback_id,
    Student.fullname,
    Question.question_text,
    Student_Feedback.rating,
    Semester.semester_name
FROM Student_Feedback
INNER JOIN Student ON Student_Feedback.student_id = Student.student_id
INNER JOIN Question ON Student_Feedback.question_id = Question.question_id
INNER JOIN Semester ON Student_Feedback.semester_id = Semester.semester_id;
