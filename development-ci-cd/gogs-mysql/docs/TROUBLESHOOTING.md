# Troubleshooting Guide for Gogs with MySQL Docker Setup

This document provides solutions to common issues you may encounter when running Gogs with MySQL in Docker.

## Table of Contents

- [Troubleshooting Guide for Gogs with MySQL Docker Setup](#troubleshooting-guide-for-gogs-with-mysql-docker-setup)
  - [Table of Contents](#table-of-contents)
  - [Container Issues](#container-issues)
  - [Database Connection Issues](#database-connection-issues)
  - [Git Operation Issues](#git-operation-issues)
  - [Web Interface Issues](#web-interface-issues)
  - [Performance Issues](#performance-issues)
  - [Logging and Debugging](#logging-and-debugging)

## Container Issues

1. **Containers not starting:**

   - Check Docker logs: `docker-compose logs`
   - Ensure all required environment variables are set in `.env`
   - Verify Docker and Docker Compose versions are up to date

2. **Container exits immediately:**
   - Check if volumes are properly mounted
   - Ensure correct permissions on mounted volumes

## Database Connection Issues

1. **Gogs can't connect to MySQL:**

   - Verify MySQL container is running: `docker-compose ps`
   - Check MySQL logs: `docker-compose logs mysql`
   - Ensure database credentials in Gogs config match those in `.env`
   - Try connecting to MySQL from Gogs container:
     ```
     docker-compose exec gogs /bin/sh
     mysql -h mysql -u $MYSQL_USER -p
     ```

2. **"Access denied" errors:**
   - Verify MySQL user has necessary permissions
   - Check if MySQL user can connect from Gogs container IP

## Git Operation Issues

1. **Push/pull operations fail:**

   - Verify SSH key is properly added to Gogs
   - Check Gogs logs for specific error messages
   - Ensure correct Git configuration on client side

2. **"Repository not found" errors:**
   - Verify repository exists and user has access
   - Check file permissions in Gogs data volume

## Web Interface Issues

1. **Can't access Gogs web interface:**

   - Verify Gogs container is running and ports are correctly mapped
   - Check if a reverse proxy (if used) is correctly configured
   - Ensure no firewall is blocking access

2. **Slow or unresponsive web interface:**
   - Check system resources (CPU, memory, disk I/O)
   - Review Gogs and MySQL logs for any errors or warnings
   - Consider performance tuning (see PERFORMANCE_TUNING.md)

## Performance Issues

1. **Slow Git operations:**

   - Check disk I/O performance
   - Verify network latency between client and server
   - Consider increasing Gogs worker pool size in config

2. **High CPU or memory usage:**
   - Monitor resource usage: `docker stats`
   - Review and optimize MySQL queries
   - Consider scaling horizontally (see MULTI_NODE_SETUP.md)

## Logging and Debugging

1. **Enabling debug logs in Gogs:**

   - Edit `app.ini` and set:
     ```ini
     [log]
     LEVEL = Debug
     ```
   - Restart Gogs container: `docker-compose restart gogs`

2. **Accessing logs:**

   - Gogs logs: `docker-compose logs gogs`
   - MySQL logs: `docker-compose logs mysql`
   - For more detailed logs, consider mounting log directories to host

3. **Common log locations inside containers:**
   - Gogs: `/app/gogs/log/`
   - MySQL: `/var/log/mysql/`

Remember to check the official Gogs documentation and GitHub issues for more specific troubleshooting tips. If problems persist, consider reaching out to the Gogs community for support.
