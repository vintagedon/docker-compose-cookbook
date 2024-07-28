# Performance Tuning Guide for Gogs with SQLite3 Docker Setup

This document provides tips and best practices for optimizing the performance of your Gogs instance with SQLite3 backend.

## Table of Contents

- [Performance Tuning Guide for Gogs with SQLite3 Docker Setup](#performance-tuning-guide-for-gogs-with-sqlite3-docker-setup)
  - [Table of Contents](#table-of-contents)
  - [Hardware Considerations](#hardware-considerations)
  - [Docker Configuration](#docker-configuration)
  - [Gogs Configuration](#gogs-configuration)
  - [SQLite3 Optimization](#sqlite3-optimization)
  - [Caching](#caching)
  - [Monitoring and Profiling](#monitoring-and-profiling)
  - [Additional Tips](#additional-tips)

## Hardware Considerations

1. **CPU**: Ensure your system has enough CPU cores to handle concurrent requests.
2. **Memory**: Provide sufficient RAM for Gogs and SQLite3 to operate efficiently.
3. **Storage**: Use fast SSD storage for better I/O performance, especially for the SQLite3 database file.

## Docker Configuration

1. **Resource Limits**: Set appropriate CPU and memory limits for the Gogs container to prevent resource starvation.
2. **Volume Mounts**: Use volume mounts for persistent data to improve I/O performance.
3. **Network Mode**: Consider using host network mode for better network performance if security allows.

Example `docker-compose.yml` resource limits:

```yaml
services:
  gogs:
    # ...
    deploy:
      resources:
        limits:
          cpus: "2"
          memory: 2G
        reservations:
          cpus: "1"
          memory: 1G
```

## Gogs Configuration

Optimize the `app.ini` file for better performance:

1. **Repository Indexer**:

   ```ini
   [indexer]
   ISSUE_INDEXER_PATH = /data/gogs/indexers/issues.bleve
   ```

2. **Session Settings**:

   ```ini
   [session]
   PROVIDER = file
   PROVIDER_CONFIG = /data/gogs/sessions
   ```

3. **Git Process Settings**:

   ```ini
   [git]
   MAX_GIT_DIFF_LINES = 1000
   MAX_GIT_DIFF_LINE_CHARACTERS = 5000
   MAX_GIT_DIFF_FILES = 100
   GC_ARGS = --aggressive --auto
   ```

4. **Gogs Server Settings**:
   ```ini
   [server]
   DISABLE_ROUTER_LOG = true
   ```

## SQLite3 Optimization

1. **Journal Mode**: Use WAL (Write-Ahead Logging) mode for better concurrency:

   ```sql
   PRAGMA journal_mode=WAL;
   ```

2. **Synchronous Setting**: Adjust the synchronous setting for better performance (may slightly reduce durability):

   ```sql
   PRAGMA synchronous=NORMAL;
   ```

3. **Cache Size**: Increase the cache size for better performance:

   ```sql
   PRAGMA cache_size=-64000; -- 64MB cache
   ```

4. **Regular Maintenance**: Perform regular VACUUM operations to optimize the database file size and structure.

## Caching

1. **Enable Memcached**: Consider using Memcached for caching to reduce database load:

   ```ini
   [cache]
   ADAPTER = memcache
   HOST = memcached:11211
   ```

2. **Repository Archive Caching**: Enable caching for repository archives:
   ```ini
   [repository.upload]
   TEMP_PATH = /data/gogs/tmp/uploads
   ```

## Monitoring and Profiling

1. **Prometheus Metrics**: Enable Prometheus metrics for monitoring:

   ```ini
   [prometheus]
   ENABLED = true
   ```

2. **pprof Profiling**: Enable pprof for Go runtime profiling:

   ```ini
   [server]
   ENABLE_PPROF = true
   ```

3. **Logging**: Adjust log levels for optimal performance while maintaining necessary information:
   ```ini
   [log]
   MODE = file
   LEVEL = Info
   ```

## Additional Tips

1. **Regular Updates**: Keep Gogs updated to benefit from performance improvements in newer versions.
2. **Repository Size**: Monitor repository sizes and consider using Git LFS for large files.
3. **Webhooks**: Optimize webhook configurations to prevent performance impact during high-activity periods.
4. **Backup Scheduling**: Schedule backups during low-activity periods to minimize performance impact.

Remember to test any changes in a staging environment before applying them to production. Performance tuning is an iterative process, and the optimal configuration may vary based on your specific usage patterns and hardware capabilities.
