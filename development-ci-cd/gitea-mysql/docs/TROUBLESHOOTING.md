# Troubleshooting Guide for Gitea with MySQL Docker Setup

This document provides solutions to common issues you might encounter when running Gitea with MySQL using Docker.

## Table of Contents

- [Container Issues](#container-issues)
- [Gitea Issues](#gitea-issues)
- [MySQL Issues](#mysql-issues)
- [Network Issues](#network-issues)
- [Performance Issues](#performance-issues)
- [Data and Storage Issues](#data-and-storage-issues)
- [Authentication and Access Issues](#authentication-and-access-issues)
- [Upgrade Issues](#upgrade-issues)

## Container Issues

### Containers not starting

1. Check container logs:

   ```
   docker-compose logs gitea
   docker-compose logs mysql
   ```

2. Verify that ports are not already in use:

   ```
   netstat -tuln | grep '3000\|3306'
   ```

3. Ensure Docker daemon is running:
   ```
   systemctl status docker
   ```

### Container exiting immediately

1. Check if there are any permission issues with mounted volumes.
2. Verify that the Docker daemon has enough resources (CPU, memory, disk space).

## Gitea Issues

### Unable to access Gitea web interface

1. Check if Gitea container is running:

   ```
   docker-compose ps
   ```

2. Verify Gitea logs for any startup errors:

   ```
   docker-compose logs gitea
   ```

3. Ensure the correct ports are exposed in `docker-compose.yml`.

### Git operations failing

1. Check SSH key configuration.
2. Verify user permissions in Gitea.
3. Check Gitea logs for specific error messages.

## MySQL Issues

### MySQL container not starting

1. Check MySQL logs:

   ```
   docker-compose logs mysql
   ```

2. Verify MySQL data directory permissions.
3. Ensure there's enough disk space.

### Gitea unable to connect to MySQL

1. Check MySQL container status:

   ```
   docker-compose ps mysql
   ```

2. Verify MySQL environment variables in `docker-compose.yml`.
3. Check network connectivity between Gitea and MySQL containers.

## Network Issues

### Unable to access Gitea from external network

1. Check firewall settings on the host machine.
2. Verify port forwarding configuration if using a router.
3. Ensure correct `ROOT_URL` setting in Gitea configuration.

### Containers unable to communicate

1. Check Docker network configuration:

   ```
   docker network ls
   docker network inspect gitea_network
   ```

2. Verify that containers are on the same network in `docker-compose.yml`.

## Performance Issues

### Slow Gitea performance

1. Check system resources (CPU, memory, disk I/O).
2. Review Gitea logs for any warnings or errors.
3. Optimize Gitea configuration (see PERFORMANCE_TUNING.md).

### Slow MySQL queries

1. Enable and analyze MySQL slow query log.
2. Optimize MySQL configuration (see PERFORMANCE_TUNING.md).
3. Check for missing indexes on frequently used queries.

## Data and Storage Issues

### Running out of disk space

1. Check disk usage:

   ```
   df -h
   ```

2. Analyze Docker volume usage:

   ```
   docker system df -v
   ```

3. Implement log rotation and cleanup old data if necessary.

### Data corruption

1. Stop containers:

   ```
   docker-compose down
   ```

2. Check file system for errors.
3. Restore from a recent backup (see BACKUP_RESTORE.md).

## Authentication and Access Issues

### Unable to log in to Gitea

1. Verify user credentials.
2. Check Gitea logs for authentication errors.
3. Ensure MySQL is running and accessible.

### SSH key issues

1. Verify SSH key is correctly added to Gitea user profile.
2. Check SSH key permissions on the client side.
3. Verify Gitea SSH configuration.

## Upgrade Issues

### Problems after upgrading Gitea

1. Check Gitea logs for migration errors.
2. Verify compatibility between Gitea version and MySQL version.
3. Ensure all necessary environment variables are set for the new version.

### Database migration failures

1. Check Gitea logs for specific migration errors.
2. Verify MySQL user has necessary privileges for schema changes.
3. Consider manual intervention or seek support from Gitea community.

Remember to always backup your data before making significant changes or attempting to fix issues. If you encounter a problem not covered here, consult the official Gitea documentation or seek help from the Gitea community forums.
