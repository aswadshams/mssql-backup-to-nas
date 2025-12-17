
3. Paste:

```sql
/* MSSQL Backup to NAS - Template (Sanitized) */

EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 1;
RECONFIGURE;

EXEC xp_cmdshell 'DIR "\\<NAS_IP>\<ShareName>"';
EXEC xp_cmdshell 'NET USE A: "\\<NAS_IP>\<ShareName>"';

BACKUP DATABASE [<DatabaseName>]
TO DISK = 'A:\<DatabaseName>_FULL.bak'
WITH INIT, COMPRESSION, STATS = 10;

BACKUP DATABASE [<DatabaseName>]
TO DISK = 'A:\<DatabaseName>_DIFF.bak'
WITH DIFFERENTIAL, INIT, COMPRESSION, STATS = 10;

RESTORE VERIFYONLY
FROM DISK = 'A:\<DatabaseName>_FULL.bak';

EXEC xp_cmdshell 'NET USE A: /DELETE';

EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE;
