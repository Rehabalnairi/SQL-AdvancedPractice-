CREATE DATABASE TrainingDB; 
GO 
USE TrainingDB; 
GO 
CREATE TABLE Students ( 
StudentID INT PRIMARY KEY, 
FullName NVARCHAR(100), 
EnrollmentDate DATE 
); 
INSERT INTO Students VALUES  
(1, 'Sara Ali', '2023-09-01'), 
(2, 'Mohammed Nasser', '2023-10-15');

--------------

----
--Full Backup 
BACKUP DATABASE TrainingDB
TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\TrainingDB_Full.bak';

--
select * from Students
INSERT INTO Students VALUES (3, 'Fatma Said', '2024-01-10');
--2. Insert New Record (simulate data change)
INSERT INTO Students VALUES (3, 'Fatma Said', '2024-01-10');
--3. Differential Backup
BACKUP DATABASE TrainingDB 
TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\TrainingDB_Diff.bak'
WITH DIFFERENTIAL;

--4. Transaction Log Backup 
-- First make sure Recovery Model is FULL 

BACKUP LOG TrainingDB 
TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\TrainingDB_Log.trn';

--5. Copy-Only Backup
BACKUP DATABASE TrainingDB TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\TrainingDB_CopyOnly.bak' WITH 
COPY_ONLY;

----
ALTER DATABASE TrainingDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

-- Drop the database
DROP DATABASE TrainingDB;

--Step 2: Restore from Your Backups
RESTORE DATABASE TrainingDB  
FROM DISK = 'C:\Backups\TrainingDB_Full.bak'  
WITH NORECOVERY;
RESTORE DATABASE TrainingDB  
FROM DISK = 'C:\Backups\TrainingDB_Diff.bak'  

WITH NORECOVERY;
RESTORE DATABASE TrainingDB WITH RECOVERY;

--Step 3: Verify the Restored Data
USE TrainingDB; 
SELECT * FROM Students; 
