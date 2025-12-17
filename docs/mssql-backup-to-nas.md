# SQL Server Backup to NAS (FULL + DIFFERENTIAL)

## Preconditions
- SQL Server service account has access to the NAS share
- Network connectivity to NAS verified
- Adequate free space on NAS
- Backup retention policy defined
- Change approval if enabling xp_cmdshell

---

## Step 1 — Enable advanced options (if required)
```sql
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
##Step 2 — Enable xp_cmdshell (policy-dependent)
EXEC sp_configure 'xp_cmdshell', 1;
RECONFIGURE;
⚠️ Enable only if explicitly allowed by security policy.
## Step 3 — Test NAS connectivity using UNC path (recommended)
EXEC xp_cmdshell 'DIR "\\<NAS_IP>\<ShareName>"';
If this fails, do not proceed.
##Step 4 — Map NAS share to a drive letter (example)
EXEC xp_cmdshell 'NET USE A: "\\<NAS_IP>\<ShareName>"';
EXEC xp_cmdshell 'DIR A:';
##Step 5 — FULL backup to NAS
BACKUP DATABASE [<DatabaseName>]
TO DISK = 'A:\<DatabaseName>_FULL.bak'
WITH INIT, COMPRESSION, STATS = 10;
##Step 6 — DIFFERENTIAL backup to NAS
BACKUP DATABASE [<DatabaseName>]
TO DISK = 'A:\<DatabaseName>_DIFF.bak'
WITH DIFFERENTIAL, INIT, COMPRESSION, STATS = 10;
##Step 7 — Verify backup
RESTORE VERIFYONLY
FROM DISK = 'A:\<DatabaseName>_FULL.bak';
##Step 8 — Disconnect NAS mapping
EXEC xp_cmdshell 'NET USE A: /DELETE';
##Step 9 — Disable xp_cmdshell (recommended)
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE;
Notes & Best Practices

Prefer UNC paths over drive letters where possible

Never store credentials in scripts

Schedule backups via SQL Server Agent

Regularly test restore from NAS


4. Commit message:
5. Commit

---

## Step 5 — Add SQL script template
1. **Add file** → **Create new file**
2. Filename:
