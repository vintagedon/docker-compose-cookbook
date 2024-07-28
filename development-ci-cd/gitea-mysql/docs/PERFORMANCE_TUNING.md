# Performance Tuning Guide for Gitea with MySQL Docker Setup

This document provides guidance on optimizing the performance of your Gitea instance with MySQL using Docker.

## Table of Contents

- [Performance Tuning Guide for Gitea with MySQL Docker Setup](#performance-tuning-guide-for-gitea-with-mysql-docker-setup)
  - [Table of Contents](#table-of-contents)
  - [Gitea Performance Tuning](#gitea-performance-tuning)
  - [MySQL Performance Tuning](#mysql-performance-tuning)
  - [Docker Performance Tuning](#docker-performance-tuning)
  - [System-level Optimizations](#system-level-optimizations)
  - [Monitoring and Profiling](#monitoring-and-profiling)

## Gitea Performance Tuning

1. **Indexer Configuration**: Adjust the indexer settings in `app.ini`:

   ```ini
   [indexer]
   ISSUE_INDEXER_TYPE = bleve
   REPO_INDEXER_ENABLED = true
   UPDATE_BUFFER_LEN = 20
   MAX_FILE_SIZE = 1048576
   ```

2. **Caching**: Enable and configure caching:

   ```ini
   [cache]
   ADAPTER = memory
   INTERVAL = 60
   HOST =
   ```

3. **Repository Archives**: Adjust settings for creating repository archives:

   ```ini
   [repository.upload]
   FILE_MAX_SIZE = 50
   MAX_FILES = 5
   ```

4. **Git Configuration**: Optimize Git settings:
   ```ini
   [git]
   DISABLE_DIFF_HIGHLIGHT = true
   MAX_GIT_DIFF_LINES = 1000
   MAX_GIT_DIFF_LINE_CHARACTERS = 5000
   MAX_GIT_DIFF_FILES = 100
   GC_ARGS = --aggressive --auto
   ```

## MySQL Performance Tuning

1. **InnoDB Buffer Pool**: Set the InnoDB buffer pool size to 50-80% of available RAM:

   ```cnf
   [mysqld]
   innodb_buffer_pool_size = 1G
   ```

2. **Query Cache**: Disable the query cache for better performance with Gitea:

   ```cnf
   query_cache_type = 0
   query_cache_size = 0
   ```

3. **Connection Pool**: Adjust max connections based on your needs:

   ```cnf
   max_connections = 500
   ```

4. **Temporary Tables**: Increase temporary table size:
   ```cnf
   tmp_table_size = 64M
   max_heap_table_size = 64M
   ```

## Docker Performance Tuning

1. **Resource Limits**: Set appropriate CPU and memory limits in `docker-compose.yml`:

   ```yaml
   services:
     gitea:
       ...
       deploy:
         resources:
           limits:
             cpus: '2'
             memory: 2G
   ```

2. **Storage Driver**: Use overlay2 storage driver for better performance:

   ```json
   {
     "storage-driver": "overlay2"
   }
   ```

3. **Logging**: Use json-file logging driver with size limits:
   ```yaml
   logging:
     driver: "json-file"
     options:
       max-size: "10m"
       max-file: "3"
   ```

## System-level Optimizations

1. **File System**: Use ext4 or XFS file system for better performance.

2. **Swappiness**: Reduce swappiness to minimize swap usage:

   ```
   sysctl -w vm.swappiness=10
   ```

3. **I/O Scheduler**: Use the deadline I/O scheduler for SSDs:
   ```
   echo deadline > /sys/block/sda/queue/scheduler
   ```

## Monitoring and Profiling

1. **Prometheus and Grafana**: Set up Prometheus and Grafana for monitoring Gitea and MySQL metrics.

2. **MySQL Slow Query Log**: Enable and analyze the slow query log:

   ```cnf
   slow_query_log = 1
   slow_query_log_file = /var/log/mysql/mysql-slow.log
   long_query_time = 2
   ```

3. **Gitea Built-in Profiling**: Enable Gitea's built-in profiling:
   ```ini
   [profiler]
   ENABLED = true
   ```

Remember to test these optimizations in a staging environment before applying them to production. Performance tuning is an iterative process, so monitor the effects of each change carefully.
