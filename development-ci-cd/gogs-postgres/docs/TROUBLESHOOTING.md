# Troubleshooting Guide for Gogs with PostgreSQL

This document provides solutions to common issues you might encounter when running Gogs with PostgreSQL in a Docker environment.

## Table of Contents

1. [Container Startup Issues](#container-startup-issues)
2. [Database Connection Problems](#database-connection-problems)
3. [Git Operation Failures](#git-operation-failures)
4. [Authentication Issues](#authentication-issues)
5. [Performance Problems](#performance-problems)
6. [Backup and Restore Issues](#backup-and-restore-issues)
7. [Network-related Problems](#network-related-problems)

## Container Startup Issues

### Problem: Gogs container fails to start

1. Check container logs:

   ```
   docker logs gogs
   ```

2. Verify environment variables in `docker-compose.yml`

3. Ensure volumes are correctly mounted

### Problem: PostgreSQL container fails to start

1. Check container logs:

   ```
   docker logs gogs-postgres
   ```

2. Verify PostgreSQL data directory permissions

3. Check for conflicting ports

## Database Connection Problems

### Problem: Gogs can't connect to PostgreSQL

1. Verify database credentials in Gogs configuration

2. Check network connectivity between containers

3. Ensure PostgreSQL is accepting connections:
   ```
   docker exec -it gogs-postgres psql -U gogs -c "SELECT 1;"
   ```

## Git Operation Failures

### Problem: Git push/pull operations fail

1. Check Gogs logs for specific error messages

2. Verify SSH key configuration (for SSH operations)

3. Check file permissions in Git repositories

4. Ensure sufficient disk space

## Authentication Issues

### Problem: Unable to log in to Gogs

1. Verify user credentials in the database

2. Check for any LDAP or OAuth configuration issues

3. Review Gogs logs for authentication errors

### Problem: Email notifications not working

1. Verify SMTP settings in Gogs configuration

2. Check for any email delivery issues

## Performance Problems

### Problem: Slow Gogs performance

1. Monitor system resources (CPU, memory, disk I/O)

2. Check PostgreSQL query performance:

   ```
   docker exec -it gogs-postgres psql -U gogs -c "SELECT * FROM pg_stat_activity;"
   ```

3. Review Gogs configuration for optimal settings

4. Consider scaling resources or implementing caching

## Backup and Restore Issues

### Problem: Unable to create backups

1. Check for sufficient disk space

2. Verify backup script permissions

3. Ensure PostgreSQL dump command is working:
   ```
   docker exec gogs-postgres pg_dump -U gogs gogs > test_backup.sql
   ```

### Problem: Restore process fails

1. Verify backup file integrity

2. Check for version compatibility between backup and current setup

3. Ensure sufficient disk space for restore operation

## Network-related Problems

### Problem: Unable to access Gogs web interface

1. Verify port mappings in `docker-compose.yml`

2. Check host firewall settings

3. Ensure reverse proxy (if used) is correctly configured

### Problem: SSH operations fail

1. Verify SSH port mapping

2. Check SSH key configuration in Gogs

3. Ensure SSH service is running in the Gogs container:
   ```
   docker exec gogs ps aux | grep ssh
   ```

## General Troubleshooting Steps

1. Always check container logs for error messages:

   ```
   docker logs gogs
   docker logs gogs-postgres
   ```

2. Verify configuration files for any syntax errors or misconfigurations

3. Ensure all containers are up and running:

   ```
   docker-compose ps
   ```

4. Check system resources on the host machine:

   ```
   top
   df -h
   ```

5. Review recent changes or updates that might have caused the issue

6. Consider restarting the containers if all else fails:
   ```
   docker-compose down
   docker-compose up -d
   ```

If you encounter an issue not covered in this guide, please check the [Gogs official documentation](https://gogs.io/docs) or seek help from the Gogs community forums.
