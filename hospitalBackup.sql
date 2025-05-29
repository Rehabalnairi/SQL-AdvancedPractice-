
CREATE DATABASE Hospital;

USE Hospital;
CREATE TABLE Doctor (
    DoctorID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Specialty NVARCHAR(100),
    PhoneNumber NVARCHAR(15),
    Email NVARCHAR(100),
    HireDate DATE
);


INSERT INTO Doctor (FirstName, LastName, Specialty, PhoneNumber, Email, HireDate)
VALUES 
('John', 'Doe', 'Cardiology', '123-456-7890', 'johndoe@example.com', '2020-05-15'),
('Jane', 'Smith', 'Neurology', '234-567-8901', 'janesmith@example.com', '2019-08-22'),
('Emily', 'Clark', 'Pediatrics', '345-678-9012', 'emilyclark@example.com', '2021-01-10'),
('Michael', 'Brown', 'Orthopedics', '456-789-0123', 'michaelbrown@example.com', '2018-11-30');

ALTER DATABASE Hospital SET RECOVERY FULL;
select * from Doctor
--- Backup frequency

-- Full Backup 

BACKUP DATABASE [Hospital]
TO DISK = 'C:\HospitalBackups\HospitalDB_Full.bak'
WITH FORMAT, INIT, NAME = 'Full Backup of HospitalDB';

-- Replace YYYYMMDD with actual date using SQL Agent job or dynamic SQL
-- Differential Backup - Scheduled Monday to Saturday at 2:00 AM

BACKUP DATABASE Hospital
TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\HospitalBackup_Diff_20240528.bak'
WITH DIFFERENTIAL, INIT, NAME = 'Nightly Differential Backup';


-- Replace YYYYMMDD with actual date
-- Transaction Log Backup - Scheduled every hour
BACKUP LOG HospitalDB
TO DISK = 'C:\HospitalBackups\HospitalDB_Log_YYYYMMDD_HH00.trn'
WITH INIT, NAME = 'Transaction Log Backup of HospitalDB';
-- Replace YYYYMMDD_HH with actual date and hour
-- Transaction Log Backup - every hour
BACKUP LOG Hospital
TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\HospitalBackup_Log_20240528_1300.trn'
WITH INIT, NAME = 'Hourly Transaction Log Backup';

