# Troubleshooting Guide for MariaDB Docker Setup

This guide addresses common issues you might encounter when using the MariaDB Docker setup and provides solutions.

## Table of Contents

1. [Container Fails to Start](#container-fails-to-start)
2. [Connection Issues](#connection-issues)
3. [Performance Problems](#performance-problems)
4. [Data Persistence Issues](#data-persistence-issues)
5. [Logging and Debugging](#logging-and-debugging)

## Container Fails to Start

### Issue: Container exits immediately after starting

1. Check the Docker logs:

   ```
   docker logs mariadb
   ```

2. Common reasons and solutions:
   - **Port conflict**: Ensure the specified port is not in use by another service.
   - **Insufficient permissions**: Check that the data directory has correct ownership and permissions.
   - **Misconfiguration**: Verify your `docker-compose.yml` and `.env` files for any misconfigurations.

### Issue: Container starts but MariaDB service is not running

1. Exec into the container:

   ```
   docker exec -it mariadb bash
   ```

2. Check the MariaDB status:

   ```
   mysqladmin -u root -p status
   ```

3. Review MariaDB error logs:
   ```
   cat /var/log/mysql/error.log
   ```

## Connection Issues

### Issue: Cannot connect to MariaDB from host machine

1. Verify the port mapping in `docker-compose.yml`:

   ```yaml
   ports:
     - "3306:3306"
   ```

2. Check if MariaDB is listening on all interfaces:

   ```
   docker exec mariadb netstat -tln
   ```

3. Ensure the firewall is not blocking the connection.

### Issue: Application cannot connect to MariaDB

1. Verify the connection string or configuration in your application.
2. Ensure the application is using the correct network (if using Docker network).
3. Check that the MariaDB user has the necessary permissions.

## Performance Problems

### Issue: Slow queries

1. Enable slow query log:

   ```sql
   SET GLOBAL slow_query_log = 'ON';
   SET GLOBAL long_query_time = 2;
   ```

2. Analyze slow queries:

   ```
   docker exec mariadb mysqldumpslow /var/log/mysql/mysql-slow.log
   ```

3. Use `EXPLAIN` to analyze query execution plans.

### Issue: High CPU or memory usage

1. Check system resource usage:

   ```
   docker stats mariadb
   ```

2. Review and adjust MariaDB configuration parameters in `my.cnf`.
3. Optimize queries and index usage.

## Data Persistence Issues

### Issue: Data loss after container restart

1. Verify volume configuration in `docker-compose.yml`:

   ```yaml
   volumes:
     - mariadb_data:/var/lib/mysql
   ```

2. Check if the volume exists:

   ```
   docker volume ls
   ```

3. Inspect the volume:
   ```
   docker volume inspect mariadb_data
   ```

## Logging and Debugging

### Accessing logs

1. View container logs:

   ```
   docker logs mariadb
   ```

2. Access MariaDB error log:
   ```
   docker exec mariadb cat /var/log/mysql/error.log
   ```

### Debugging

1. Enable general query log (use cautiously in production):

   ```sql
   SET GLOBAL general_log = 'ON';
   SET GLOBAL general_log_file = '/var/log/mysql/mysql.log';
   ```

2. Use MariaDB's built-in debugging tools:
   ```sql
   SHOW PROCESSLIST;
   SHOW ENGINE INNODB STATUS;
   ```

Remember, if you encounter issues not covered in this guide, consult the [official MariaDB documentation](https://mariadb.com/kb/en/documentation/) or seek help from the MariaDB community forums.
