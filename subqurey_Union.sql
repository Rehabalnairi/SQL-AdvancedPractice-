create database Trainees
use Trainees
CREATE TABLE Trainees ( 
TraineeID INT PRIMARY KEY, 
FullName VARCHAR(100), 
Email VARCHAR(100), 
Program VARCHAR(50), 
GraduationDate DATE 
);
 --Job Applicants Table 
CREATE TABLE Applicants ( 
ApplicantID INT PRIMARY KEY, 
FullName VARCHAR(100), 
Email VARCHAR(100), 
Source VARCHAR(20), -- e.g., "Website", "Referral" 
AppliedDate DATE 
); 
--Sample Data -- Insert into Trainees 
INSERT INTO Trainees VALUES 
(1, 'Layla Al Riyami', 'layla.r@example.com', 'Full Stack .NET', '2025-04-30'), 
(2, 'Salim Al Hinai', 'salim.h@example.com', 'Outsystems', '2025-03-15'), 
(3, 'Fatma Al Amri', 'fatma.a@example.com', 'Database Admin', '2025-05-01'); -- Insert into Applicants 
INSERT INTO Applicants VALUES 
(101, 'Hassan Al Lawati', 'hassan.l@example.com', 'Website', '2025-05-02'), 
(102, 'Layla Al Riyami', 'layla.r@example.com', 'Referral', '2025-05-05'), -- same person as trainee 
(103, 'Aisha Al Farsi', 'aisha.f@example.com', 'Website', '2025-04-28');

--Part 1: UNION Practice
--1. List all unique people who either trained or applied for a job.
--Show their full names and emails. 
-- Use UNION (not UNION ALL) to avoid duplicates.
select * from Applicants
select FullName from Applicants
union
select Email from Applicants
--2. Now use UNION ALL. What changes in the result?
select * from Applicants
select FullName from Applicants
union all
select Email from Applicants
--union all show separate table

--3. Find people who are in both tables. 
select FullName from Applicants
intersect 
select FullName  from Trainees 

--Part 2: DROP, DELETE, TRUNCATE Observation
--Try DELETE FROM Trainees WHERE Program = 'Outsystems'. 
delete from Trainees where Program = 'Outsystems';

-- Try TRUNCATE TABLE Applicants.
truncate table Applicants;
--t removes all rows from the Applicants table
--6. Try DROP TABLE Applicants.
drop table Applicants

-- ( It deletes the Applicants table from the database )
-- ( All data is deleted )

--Part 3: Self-Discovery & Applied Exploration

--1. Research: 
--What is a subquery in SQL?
-- subquery in SQL is a query nested inside another query. 
--It allows you to perform operations that depend on the results of another query.
--Types of Subqueries
--Scalar Subquery: Returns a single value
--Row Subquery: Returns a single row
--Table Subquery: Returns a set of rows (like a temporary table)

SELECT *
FROM Trainees
WHERE Email IN (
SELECT Email
FROM Trainees
);

----2. Task:  Write a query to find all trainees whose emails appear in the applicants table.
SELECT Email from Applicants
-- You must use a subquery inside a WHERE clause.

SELECT *
FROM Trainees
WHERE Email IN (
SELECT Email FROM Applicants
);

--3. Extra Challenge: 
--Write a DML statement (like UPDATE or DELETE) that uses a subquery in the WHERE clause.
delete from Applicants
where Email IN (
    SELECT Email
    FROM Trainees
);

--Batch Script & Transactions
-- Research:  What is a SQL transaction? 
SQL transactions are an important aspect of database management. 
They exist to make sure your data stays accurate and reliable. 
I would actually say that they are a fundamental part of maintaining data integrity in any application.

----
--How to write transaction blocks in your database tool (BEGIN TRANSACTION, COMMIT, ROLLBACK)?
DELETE FROM Applicants WHERE ApplicantID = 2;
ROLLBACK;

--5. Task: Write a script that: 
