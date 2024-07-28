# Performance Tuning for MySQL Docker Setup

This document provides guidance on optimizing the performance of your MySQL Docker setup, including the use of MySQLTuner-perl for automated performance analysis.

## Table of Contents

- [Performance Tuning for MySQL Docker Setup](#performance-tuning-for-mysql-docker-setup)
  - [Table of Contents](#table-of-contents)
  - [System Resources](#system-resources)
  - [MySQL Configuration](#mysql-configuration)
  - [Query Optimization](#query-optimization)
  - [Indexing](#indexing)
  - [Monitoring and Profiling](#monitoring-and-profiling)
  - [Using MySQLTuner-perl](#using-mysqltuner-perl)
    - [Installation](#installation)
    - [Basic Usage](#basic-usage)
    - [Docker-specific Usage](#docker-specific-usage)
    - [Interpreting Results](#interpreting-results)

## System Resources

1. **Allocate sufficient memory**: Ensure your Docker host has enough memory. MySQL's performance is heavily dependent on memory.

2. **CPU considerations**: For write-heavy workloads, consider allocating more CPU cores to your MySQL container.

3. **Storage**: Use SSD for better I/O performance. In Docker, consider using volume mounts instead of bind mounts for better performance.

## MySQL Configuration

Optimize your MySQL configuration by adjusting these parameters in your `my.cnf`:

1. **InnoDB Buffer Pool**:

   ```ini
   innodb_buffer_pool_size = 70-80% of available memory
   ```

2. **Query Cache** (for MySQL 5.7 and earlier):

   ```ini
   query_cache_type = 0
   query_cache_size = 0
   ```

3. **Connection Handling**:

   ```ini
   max_connections = 1000
   thread_cache_size = 32
   ```

4. **Temporary Tables**:

   ```ini
   tmp_table_size = 64M
   max_heap_table_size = 64M
   ```

5. **Binary Logging** (if not needed):
   ```ini
   skip-log-bin
   ```

## Query Optimization

1. Use `EXPLAIN` to analyze query execution plans.
2. Optimize `SELECT` queries:
   - Only select needed columns
   - Use `LIMIT` for large result sets
3. Use prepared statements to reduce query parsing overhead.
4. Avoid using `SELECT *`.

## Indexing

1. Create indexes on columns used in `WHERE`, `JOIN`, and `ORDER BY` clauses.
2. Use composite indexes for queries with multiple conditions.
3. Avoid over-indexing, as it can slow down write operations.

## Monitoring and Profiling

1. Enable slow query log:

   ```ini
   slow_query_log = 1
   long_query_time = 2
   ```

2. Use MySQL's built-in performance schema.

3. Consider using monitoring tools like Prometheus with mysqld_exporter for real-time performance monitoring.

4. For Docker-specific monitoring, use `docker stats` or consider tools like cAdvisor.

## Using MySQLTuner-perl

[MySQLTuner-perl](https://github.com/major/MySQLTuner-perl) is a powerful script that can help you analyze your MySQL performance and provide recommendations for improvements.

### Installation

1. Clone the MySQLTuner-perl repository:

   ```bash
   git clone https://github.com/major/MySQLTuner-perl.git
   ```

2. Make the script executable:
   ```bash
   chmod +x mysqltuner.pl
   ```

### Basic Usage

To run MySQLTuner-perl against your MySQL Docker container:

1. Ensure your MySQL container is running.

2. Run MySQLTuner-perl:

   ```bash
   ./mysqltuner.pl --host 127.0.0.1 --user root --pass your_root_password
   ```

   Replace `your_root_password` with your actual MySQL root password.

3. Review the output, which includes:
   - Current MySQL configuration
   - Status and performance metrics
   - Recommendations for improvement

### Docker-specific Usage

You can also run MySQLTuner-perl directly inside your MySQL Docker container:

1. Copy the script into your container:

   ```bash
   docker cp mysqltuner.pl mysql:/tmp/
   ```

2. Run the script inside the container:
   ```bash
   docker exec -it mysql perl /tmp/mysqltuner.pl --user root --pass your_root_password
   ```

### Interpreting Results

MySQLTuner-perl provides a wealth of information and recommendations. Key areas to focus on include:

- Memory usage and allocation
- Query cache efficiency (for MySQL 5.7 and earlier)
- InnoDB buffer pool size
- Slow queries and their frequency
- Table indexing recommendations

Remember to test any configuration changes thoroughly in a staging environment before applying them to production. MySQLTuner-perl is a powerful tool, but its recommendations should be considered in the context of your specific workload and requirements.
