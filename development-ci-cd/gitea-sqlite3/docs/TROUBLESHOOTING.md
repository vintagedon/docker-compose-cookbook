# Troubleshooting Guide for Gitea-SQLite3 Docker Setup

This document provides solutions to common issues you might encounter with your Gitea instance using SQLite3 backend.

## Table of Contents

- [Troubleshooting Guide for Gitea-SQLite3 Docker Setup](#troubleshooting-guide-for-gitea-sqlite3-docker-setup)
  - [Table of Contents](#table-of-contents)
  - [Container Fails to Start](#container-fails-to-start)
  - [Database Connection Issues](#database-connection-issues)
  - [Web Interface Not Accessible](#web-interface-not-accessible)
  - [SSH Connection Problems](#ssh-connection-problems)
  - [Performance Issues](#performance-issues)
  - [Logging and Debugging](#logging-and-debugging)

## Container Fails to Start

1. **Check Docker logs**:

   ```bash
   docker-compose logs gitea
   ```

2. **Verify volume permissions**:
   Ensure that the `gitea_data` and `gitea_config` volumes have the correct permissions.

3. **Check resource allocation**:
   Make sure your system has enough resources (CPU, RAM, disk space) for Gitea.

## Database Connection Issues

1. **Verify SQLite3 file permissions**:
   The SQLite3 database file should be writable by the Gitea process.

2. **Check database path**:
   Ensure the `GITEA__database__PATH` in `docker-compose.yml` points to the correct location.

3. **Database corruption**:
   If you suspect database corruption, try running SQLite3 integrity check:
   ```bash
   docker-compose exec gitea sqlite3 /data/gitea/gitea.db "PRAGMA integrity_check;"
   ```

## Web Interface Not Accessible

1. **Check port mapping**:
   Verify that the ports in `docker-compose.yml` are correctly mapped.

2. **Firewall settings**:
   Ensure your firewall allows incoming connections on the Gitea port.

3. **Reverse proxy issues**:
   If using a reverse proxy, check its configuration and logs.

## SSH Connection Problems

1. **Verify SSH port**:
   Check that the SSH port in `docker-compose.yml` matches your configuration.

2. **SSH key issues**:
   Ensure that SSH keys are correctly added to Gitea and have the right permissions.

3. **Check SSH server status**:
   Verify that the Gitea SSH server is running:
   ```bash
   docker-compose exec gitea ps aux | grep ssh
   ```

## Performance Issues

1. **Check system resources**:
   Monitor CPU, RAM, and disk usage of the Gitea container.

2. **Optimize SQLite3**:
   Refer to the [PERFORMANCE_TUNING.md](PERFORMANCE_TUNING.md) guide for SQLite3 optimizations.

3. **Review Gitea configuration**:
   Check `app.ini` for any misconfigured settings that might affect performance.

## Logging and Debugging

1. **Enable debug logging**:
   In `app.ini`, set:

   ```ini
   [log]
   LEVEL = Debug
   ```

2. **Check Gitea logs**:

   ```bash
   docker-compose exec gitea cat /data/gitea/log/gitea.log
   ```

3. **Use Gitea built-in debugging**:
   Access `http://your-gitea-instance/debug/pprof/` (requires admin login) for runtime profiling data.

If you're unable to resolve an issue using this guide, please:

1. Check the [Gitea forum](https://discourse.gitea.io/) for similar issues and solutions.
2. Report the issue on the [Gitea GitHub repository](https://github.com/go-gitea/gitea/issues), providing detailed information about your setup and the problem you're experiencing.
