# Performance Tuning Guide for Gogs with MySQL

This document provides guidance on optimizing the performance of your Gogs instance with MySQL using Docker.

## Table of Contents

- [Performance Tuning Guide for Gogs with MySQL](#performance-tuning-guide-for-gogs-with-mysql)
  - [Table of Contents](#table-of-contents)
  - [Gogs Performance Tuning](#gogs-performance-tuning)
  - [MySQL Performance Tuning](#mysql-performance-tuning)
  - [Docker Performance Tuning](#docker-performance-tuning)
  - [Network Optimization](#network-optimization)
  - [Monitoring and Profiling](#monitoring-and-profiling)

## Gogs Performance Tuning

1. Adjust Gogs configuration in `app.ini`:

   ```ini
   [server]
   DISABLE_ROUTER_LOG = true
   DISABLE_HTTP_ADDR = false

   [database]
   DB_TYPE = mysql
   HOST = mysql:3306
   NAME = gogs
   USER = gogs
   PASSWD = your_password
   SSL_MODE = disable
   ITERATE_BUFFER_SIZE = 50
   LOG_SQL = false

   [repository]
   ROOT = /data/git/repositories
   SCRIPT_TYPE = bash
   ANSI_CHARSET =
   FORCE_PRIVATE = false
   MAX_CREATION_LIMIT = -1
   PREFERRED_LICENSES = Apache License 2.0,MIT License
   DISABLE_HTTP_GIT = false

   [repository.editor]
   LINE_WRAP_EXTENSIONS = .txt,.md,.markdown,.mdown,.mkd
   PREVIEWABLE_FILE_MODES = markdown

   [repository.upload]
   ENABLED = true
   TEMP_PATH = /data/tmp/uploads
   ALLOWED_TYPES = */*
   FILE_MAX_SIZE = 3
   MAX_FILES = 5

   [repository.local]
   LOCAL_COPY_PATH = /data/tmp/local-repo

   [attachment]
   ENABLED = true
   PATH = /data/attachments
   ALLOWED_TYPES = */*
   MAX_SIZE = 4
   MAX_FILES = 5

   [time]
   FORMAT =

   [picture]
   AVATAR_UPLOAD_PATH = /data/avatars
   REPOSITORY_AVATAR_UPLOAD_PATH = /data/repo-avatars
   DISABLE_GRAVATAR = false
   ENABLE_FEDERATED_AVATAR = false

   [session]
   PROVIDER = file
   PROVIDER_CONFIG = /data/sessions
   COOKIE_SECURE = false
   COOKIE_NAME = i_like_gogs
   GC_INTERVAL_TIME = 86400
   SESSION_LIFE_TIME = 86400

   [log]
   MODE = file
   LEVEL = Info
   ```

2. Increase `ITERATE_BUFFER_SIZE` for larger repositories
3. Set `LOG_SQL = false` in production to reduce I/O
4. Adjust `MAX_CREATION_LIMIT` based on your needs
5. Configure `DISABLE_GRAVATAR` and `ENABLE_FEDERATED_AVATAR` based on your network conditions

## MySQL Performance Tuning

1. Optimize MySQL configuration in `my.cnf`:

   ```ini
   [mysqld]
   innodb_buffer_pool_size = 1G
   innodb_log_file_size = 256M
   innodb_flush_log_at_trx_commit = 2
   innodb_flush_method = O_DIRECT
   max_connections = 1000
   ```

2. Adjust `innodb_buffer_pool_size` based on available RAM (typically 70-80% of total RAM)
3. Increase `innodb_log_file_size` for write-heavy workloads
4. Set `innodb_flush_log_at_trx_commit = 2` for better performance (with slightly reduced durability)
5. Adjust `max_connections` based on expected concurrent users

## Docker Performance Tuning

1. Use Docker volumes for persistent data instead of bind mounts
2. Adjust Docker daemon settings in `/etc/docker/daemon.json`:

   ```json
   {
     "storage-driver": "overlay2",
     "log-driver": "json-file",
     "log-opts": {
       "max-size": "10m",
       "max-file": "3"
     }
   }
   ```

3. Use `--cpus` and `--memory` flags to limit resource usage if needed
4. Consider using Docker Compose version 3 for better performance and features

## Network Optimization

1. Use Docker's built-in DNS server for service discovery
2. Implement a reverse proxy (e.g., Nginx) for SSL termination and caching
3. Enable HTTP/2 in your reverse proxy for better performance
4. Use Docker's overlay network for multi-host setups

## Monitoring and Profiling

1. Implement monitoring using tools like Prometheus and Grafana
2. Use MySQL's slow query log to identify performance bottlenecks:

   ```ini
   [mysqld]
   slow_query_log = 1
   slow_query_log_file = /var/log/mysql/mysql-slow.log
   long_query_time = 2
   ```

3. Use tools like `docker stats` to monitor container resource usage
4. Implement application-level metrics in Gogs for detailed performance tracking

Remember to test thoroughly after making performance adjustments, and always make incremental changes to ensure stability.
