# Troubleshooting Guide for Gitea with PostgreSQL Docker Setup

This document provides solutions to common issues you might encounter when running Gitea with PostgreSQL in Docker.

## Table of Contents

- [Container Issues](#container-issues)
- [Database Connection Issues](#database-connection-issues)
- [Gitea Web Interface Issues](#gitea-web-interface-issues)
- [Git Operation Issues](#git-operation-issues)
- [Performance Issues](#performance-issues)
- [Logging and Debugging](#logging-and-debugging)

## Container Issues

### Containers not starting

1. Check if the containers are running:

   ```
   docker-compose ps
   ```

2. If containers are not running, check the logs:

   ```
   docker-compose logs
   ```

3. Ensure that the required ports are not already in use on your host system.

4. Verify that your `docker-compose.yml` file is correctly formatted.

### Container exits immediately

1. Check the container logs:

   ```
   docker-compose logs gitea
   ```

2. Ensure that the environment variables in your `docker-compose.yml` file are correctly set.

3. Verify that the volumes are correctly mounted and have the proper permissions.

## Database Connection Issues

### Gitea can't connect to PostgreSQL

1. Verify that the PostgreSQL container is running:

   ```
   docker-compose ps postgres
   ```

2. Check the PostgreSQL logs:

   ```
   docker-compose logs postgres
   ```

3. Ensure that the database connection settings in your `docker-compose.yml` file are correct:

   ```yaml
   environment:
     - GITEA__database__DB_TYPE=postgres
     - GITEA__database__HOST=postgres:5432
     - GITEA__database__NAME=gitea
     - GITEA__database__USER=gitea
     - GITEA__database__PASSWD=gitea_password
   ```

4. Try to connect to the database from the Gitea container:
   ```
   docker-compose exec gitea psql -h postgres -U gitea -d gitea
   ```

## Gitea Web Interface Issues

### Can't access Gitea web interface

1. Verify that the Gitea container is running:

   ```
   docker-compose ps gitea
   ```

2. Check if the correct ports are exposed in your `docker-compose.yml` file:

   ```yaml
   ports:
     - "3000:3000"
   ```

3. Ensure that your firewall is not blocking the Gitea port.

4. Check the Gitea logs for any errors:
   ```
   docker-compose logs gitea
   ```

### Internal Server Error

1. Check the Gitea logs for detailed error messages:

   ```
   docker-compose logs gitea
   ```

2. Verify that Gitea has write permissions to its data directory.

3. Ensure that all required environment variables are set correctly.

## Git Operation Issues

### Push/Pull operations fail

1. Verify that SSH keys are correctly set up in Gitea.

2. Check if the correct SSH port is exposed in your `docker-compose.yml` file:

   ```yaml
   ports:
     - "22:22"
   ```

3. Ensure that your firewall is not blocking the SSH port.

4. Check the Gitea logs for any SSH-related errors:
   ```
   docker-compose logs gitea | grep ssh
   ```

## Performance Issues

### Slow response times

1. Check the system resources (CPU, Memory, Disk I/O) of your Docker host.

2. Verify that PostgreSQL is properly tuned (refer to PERFORMANCE_TUNING.md).

3. Consider enabling caching in Gitea's configuration.

4. Check for any long-running queries in PostgreSQL:
   ```
   docker-compose exec postgres psql -U gitea -c "SELECT pid, now() - pg_stat_activity.query_start AS duration, query FROM pg_stat_activity WHERE state = 'active';"
   ```

## Logging and Debugging

### Enabling debug logging

1. Set the log level to debug in your `docker-compose.yml` file:

   ```yaml
   environment:
     - GITEA__log__LEVEL=debug
   ```

2. Restart the Gitea container:

   ```
   docker-compose restart gitea
   ```

3. Check the logs for more detailed information:
   ```
   docker-compose logs gitea
   ```

### Accessing logs

1. Gitea logs:

   ```
   docker-compose logs gitea
   ```

2. PostgreSQL logs:

   ```
   docker-compose logs postgres
   ```

3. To follow logs in real-time:
   ```
   docker-compose logs -f gitea
   ```

If you're still experiencing issues after trying these troubleshooting steps, consider seeking help on the [Gitea forum](https://discourse.gitea.io/) or [GitHub issue tracker](https://github.com/go-gitea/gitea/issues).
