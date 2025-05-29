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

1. What would happen if you skipped the differential backup step? 
 the atabase will only reflect the data state at the time of the full backup.

2. What’s the difference between restoring a full vs. copy-only backup? 
thhe only difference between full and full-copy is that full-copy does not break the differential chain. Neither of them breaks the log chain as 
neither of them truncates the log file.

3. What happens if you use WITH RECOVERY in the middle of a restore chain? 
sing WITH RECOVERY too early ends the restore process and brings the database online.

 You can no longer apply additional backups (like differential or log backups) after this.

 You should only use WITH RECOVERY at the final step of the restore chain.

 Use WITH NORECOVERY until all parts are restored, then finish with WITH RECOVERY

4. Which backup types are optional and which are mandatory for full recovery?
For full data recovery, full backups are mandatory. Differential and 
incremental backups are often used in conjunction with full backups to optimize storage 
and recovery time, but they are 
not sufficient on their own for a full restoration are not sufficient on their own for a full restoration