# Troubleshooting MySQL Docker Setup

This document provides solutions to common issues you might encounter with your MySQL Docker setup.

## Table of Contents

- [Troubleshooting MySQL Docker Setup](#troubleshooting-mysql-docker-setup)
  - [Table of Contents](#table-of-contents)
  - [Container Won't Start](#container-wont-start)
  - [Connection Issues](#connection-issues)
  - [Performance Problems](#performance-problems)
  - [Data Persistence Issues](#data-persistence-issues)
  - [Replication Problems](#replication-problems)

## Container Won't Start

1. **Check Docker logs**:

   ```
   docker logs mysql
   ```

   Look for error messages that might indicate the problem.

2. **Verify environment variables**:
   Ensure all required environment variables are set correctly in your `.env` file.

3. **Check port conflicts**:
   Make sure the port specified for MySQL (default 3306) is not already in use.

4. **Inspect volume permissions**:
   Ensure the MySQL user has proper permissions on the data volume.

## Connection Issues

1. **Verify network settings**:
   Check that your application and MySQL container are on the same Docker network.

2. **Check credentials**:
   Ensure you're using the correct username and password.

3. **Inspect firewall rules**:
   Make sure your firewall isn't blocking the MySQL port.

4. **SSL issues**:
   If using SSL, verify that SSL certificates are correctly configured.

## Performance Problems

1. **Monitor resource usage**:
   Use `docker stats` to check CPU, memory, and I/O usage of your MySQL container.

2. **Analyze slow queries**:
   Enable and review the slow query log:

   ```sql
   SET GLOBAL slow_query_log = 'ON';
   SET GLOBAL long_query_time = 2;
   ```

3. **Check indexing**:
   Ensure your tables are properly indexed. Use `EXPLAIN` to analyze query execution plans.

4. **Optimize configuration**:
   Review and adjust MySQL configuration parameters in `my.cnf` based on your workload.

## Data Persistence Issues

1. **Verify volume configuration**:
   Check that volumes are correctly defined in your `docker-compose.yml` file.

2. **Inspect volume contents**:
   Use `docker volume inspect` to check the actual location of volume data on the host.

3. **Check permissions**:
   Ensure the MySQL user has read/write permissions on the data volume.

## Replication Problems

1. **Check replication status**:
   On the slave, run:

   ```sql
   SHOW SLAVE STATUS\G
   ```

   Look for errors in the output.

2. **Verify master settings**:
   Ensure the master's binary logging is enabled and the replication user has correct permissions.

3. **Network issues**:
   Check that the slave can connect to the master's replication port.

4. **Data inconsistencies**:
   If data becomes inconsistent, you may need to re-initialize the slave from a fresh master snapshot.

For any persistent issues, consider the following general troubleshooting steps:

1. Review Docker and MySQL log files for error messages.
2. Verify that you're using compatible versions of MySQL and Docker.
3. Try recreating the container with a clean data volume to rule out data corruption issues.
4. Check the official MySQL documentation and Docker Hub page for known issues and their solutions.

If problems persist, consider seeking help from the MySQL or Docker community forums, or consult with a database administrator.
