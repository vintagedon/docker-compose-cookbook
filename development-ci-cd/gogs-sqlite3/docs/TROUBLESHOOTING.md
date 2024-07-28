# Troubleshooting Guide for Gogs with SQLite3 Docker Setup

This document provides solutions to common issues you may encounter when running Gogs with SQLite3 in a Docker container.

## Table of Contents

- [Troubleshooting Guide for Gogs with SQLite3 Docker Setup](#troubleshooting-guide-for-gogs-with-sqlite3-docker-setup)
  - [Table of Contents](#table-of-contents)
  - [Container Startup Issues](#container-startup-issues)
    - [Problem: Container fails to start](#problem-container-fails-to-start)
    - [Problem: Container starts but Gogs is not running](#problem-container-starts-but-gogs-is-not-running)
  - [Database Connection Problems](#database-connection-problems)
    - [Problem: Gogs can't connect to SQLite3 database](#problem-gogs-cant-connect-to-sqlite3-database)
  - [Web Interface Access Issues](#web-interface-access-issues)
    - [Problem: Can't access Gogs web interface](#problem-cant-access-gogs-web-interface)
  - [Git Operation Failures](#git-operation-failures)
    - [Problem: Git push/pull operations fail](#problem-git-pushpull-operations-fail)
  - [Performance Issues](#performance-issues)
    - [Problem: Gogs is running slowly](#problem-gogs-is-running-slowly)
  - [Authentication and User Management](#authentication-and-user-management)
    - [Problem: Unable to create new users or login](#problem-unable-to-create-new-users-or-login)
  - [Backup and Restore Problems](#backup-and-restore-problems)
    - [Problem: Backup script fails](#problem-backup-script-fails)
  - [Logging and Debugging](#logging-and-debugging)
    - [Enabling debug logging](#enabling-debug-logging)

## Container Startup Issues

### Problem: Container fails to start

1. Check Docker logs:

   ```
   docker-compose logs gogs
   ```

2. Verify volume permissions:

   ```
   ls -l /path/to/gogs/data
   ```

   Ensure the directory is owned by the user running Gogs (typically UID 1000).

3. Check if required ports are available:
   ```
   netstat -tuln | grep -E ':(3000|22)'
   ```

### Problem: Container starts but Gogs is not running

1. Check if the Gogs process is running inside the container:

   ```
   docker-compose exec gogs ps aux | grep gogs
   ```

2. Verify the Gogs configuration:
   ```
   docker-compose exec gogs cat /data/gogs/conf/app.ini
   ```

## Database Connection Problems

### Problem: Gogs can't connect to SQLite3 database

1. Check if the SQLite3 database file exists:

   ```
   docker-compose exec gogs ls -l /data/gogs/gogs.db
   ```

2. Verify database permissions:

   ```
   docker-compose exec gogs ls -l /data/gogs/gogs.db
   ```

   Ensure the file is owned by the Gogs user.

3. Check Gogs logs for specific SQLite3 errors:
   ```
   docker-compose logs gogs | grep -i sqlite
   ```

## Web Interface Access Issues

### Problem: Can't access Gogs web interface

1. Verify the container is running and exposed ports:

   ```
   docker-compose ps
   ```

2. Check if Gogs is listening on the correct port:

   ```
   docker-compose exec gogs netstat -tuln
   ```

3. Verify nginx configuration if using a reverse proxy.

4. Check firewall rules to ensure the Gogs port is open.

## Git Operation Failures

### Problem: Git push/pull operations fail

1. Verify SSH key configuration:

   ```
   docker-compose exec gogs cat /data/git/.ssh/authorized_keys
   ```

2. Check Gogs logs for Git-related errors:

   ```
   docker-compose logs gogs | grep -i git
   ```

3. Verify Git hooks are executable:
   ```
   docker-compose exec gogs ls -l /data/git/gogs-repositories/user/repo.git/hooks
   ```

## Performance Issues

### Problem: Gogs is running slowly

1. Check system resources:

   ```
   docker stats gogs
   ```

2. Verify SQLite3 performance:

   ```
   docker-compose exec gogs sqlite3 /data/gogs/gogs.db 'PRAGMA integrity_check;'
   ```

3. Review Gogs configuration for performance-related settings.

4. Consider enabling caching if not already in use.

## Authentication and User Management

### Problem: Unable to create new users or login

1. Check if user registration is enabled in `app.ini`:

   ```
   docker-compose exec gogs grep -i register /data/gogs/conf/app.ini
   ```

2. Verify SMTP settings if email confirmation is required.

3. Check Gogs logs for authentication-related errors:
   ```
   docker-compose logs gogs | grep -i auth
   ```

## Backup and Restore Problems

### Problem: Backup script fails

1. Verify backup script permissions:

   ```
   ls -l /path/to/backup/script.sh
   ```

2. Check available disk space:

   ```
   df -h
   ```

3. Verify SQLite3 is not locked during backup:
   ```
   docker-compose exec gogs sqlite3 /data/gogs/gogs.db 'PRAGMA busy_timeout;'
   ```

## Logging and Debugging

### Enabling debug logging

1. Modify `app.ini` to set log level to debug:

   ```
   docker-compose exec gogs sed -i 's/LEVEL = Info/LEVEL = Debug/' /data/gogs/conf/app.ini
   ```

2. Restart the Gogs container:

   ```
   docker-compose restart gogs
   ```

3. Tail the debug logs:
   ```
   docker-compose logs -f gogs
   ```

Remember to revert the log level to `Info` after debugging to avoid excessive log growth.

If you encounter issues not covered in this guide, refer to the [official Gogs documentation](https://gogs.io/docs) or seek help from the Gogs community forums.
