# SQL Server Backups to NAS (FULL + DIFFERENTIAL)

A sanitized, production-oriented tutorial demonstrating how SQL Server
FULL and DIFFERENTIAL backups can be written to a NAS / DR share.

This repository focuses on **connectivity validation, controlled use of
xp_cmdshell, and backup verification**, with clear security warnings.

## Why this matters
NAS-backed backups are common in enterprise environments, but incorrect
permissions, unsafe scripting, or poor cleanup can silently break recovery
plans. This guide documents a safe, auditable approach.

## Contents
- Preconditions & security warnings
- NAS connectivity validation
- FULL backup to NAS
- DIFFERENTIAL backup to NAS
- Verification & cleanup

➡️ Full guide: [Backup to NAS – Step by Step](docs/mssql-backup-to-nas.md)

See `DISCLAIMER.md` before applying in production.
