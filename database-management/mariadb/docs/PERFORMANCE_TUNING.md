# Performance Tuning Guide for MariaDB Docker Setup

This guide provides tips and best practices for optimizing the performance of your MariaDB Docker instance.

## Table of Contents

- [Performance Tuning Guide for MariaDB Docker Setup](#performance-tuning-guide-for-mariadb-docker-setup)
  - [Table of Contents](#table-of-contents)
  - [System Resources](#system-resources)
  - [MariaDB Configuration](#mariadb-configuration)
  - [Query Optimization](#query-optimization)
  - [Indexing](#indexing)
  - [Monitoring and Profiling](#monitoring-and-profiling)

## System Resources

1. **Allocate sufficient memory**: Ensure your Docker host has enough RAM. MariaDB performs best when it can keep its working set in memory.

2. **Use fast storage**: If possible, use SSD storage for your MariaDB data volume.

3. **CPU considerations**: While MariaDB can benefit from multiple cores, it's often more I/O bound. Ensure you have enough CPU power to handle your workload.

## MariaDB Configuration

Optimize your MariaDB configuration by adjusting these parameters in your `my.cnf` file:

1. **InnoDB Buffer Pool Size**: Set to 70-80% of your total RAM.

   ```
   innodb_buffer_pool_size = 1G
   ```

2. **InnoDB Log File Size**: Set to about 25% of the buffer pool size.

   ```
   innodb_log_file_size = 256M
   ```

3. **Max Connections**: Set based on your application needs.

   ```
   max_connections = 100
   ```

4. **Query Cache**: For read-heavy workloads, enable and size appropriately.

   ```
   query_cache_type = 1
   query_cache_size = 128M
   ```

5. **Table Open Cache**: Increase for better performance with many tables.
   ```
   table_open_cache = 2000
   ```

## Query Optimization

1. Use `EXPLAIN` to analyze your queries and identify slow ones.
2. Avoid using `SELECT *` and only select the columns you need.
3. Use appropriate JOINs and avoid subqueries where possible.
4. Utilize `LIMIT` to restrict the number of rows returned.

## Indexing

1. Create indexes on columns used in WHERE, ORDER BY, and JOIN clauses.
2. Use composite indexes for queries that filter on multiple columns.
3. Avoid over-indexing as it can slow down write operations.

## Monitoring and Profiling

1. Enable slow query log to identify problematic queries:

   ```
   slow_query_log = 1
   long_query_time = 2
   ```

2. Use tools like MariaDB's built-in performance schema or external tools like Prometheus and Grafana for monitoring.

3. Regularly analyze your table statistics:

   ```sql
   ANALYZE TABLE mytable;
   ```

4. Use `SHOW PROCESSLIST` to view currently executing queries.

Remember to test any configuration changes in a staging environment before applying them to production. Performance tuning is an iterative process and may require adjustments based on your specific workload and requirements.
