# Performance Tuning Guide for Gitea-SQLite3 Docker Setup

This document provides guidelines and best practices for optimizing the performance of your Gitea instance with SQLite3 backend.

## Table of Contents

- [Performance Tuning Guide for Gitea-SQLite3 Docker Setup](#performance-tuning-guide-for-gitea-sqlite3-docker-setup)
  - [Table of Contents](#table-of-contents)
  - [Hardware Considerations](#hardware-considerations)
  - [Docker Resource Allocation](#docker-resource-allocation)
  - [SQLite3 Optimizations](#sqlite3-optimizations)
  - [Gitea Configuration](#gitea-configuration)
  - [Caching](#caching)
  - [Monitoring and Profiling](#monitoring-and-profiling)

## Hardware Considerations

- Use SSDs for storage, especially for the SQLite3 database file.
- Ensure sufficient RAM for caching and operations.
- Consider using a multi-core CPU for better concurrency handling.

## Docker Resource Allocation

Adjust Docker resource limits in your `docker-compose.yml`:

```yaml
services:
  gitea:
    # ... other configurations ...
    deploy:
      resources:
        limits:
          cpus: "2"
          memory: 2G
        reservations:
          cpus: "1"
          memory: 1G
```

## SQLite3 Optimizations

1. Enable Write-Ahead Logging (WAL) mode:

   Add to your custom `app.ini`:

   ```ini
   [database]
   SQLITE_JOURNAL_MODE = wal
   ```

2. Increase the cache size:

   ```ini
   [database]
   SQLITE_CACHE_SIZE = 50000
   ```

3. Set a larger busy timeout:

   ```ini
   [database]
   SQLITE_BUSY_TIMEOUT = 5000
   ```

## Gitea Configuration

1. Adjust maximum number of concurrent processes:

   ```ini
   [server]
   MAX_CONCURRENT_PROCESSES = 4
   ```

2. Enable GZIP compression:

   ```ini
   [server]
   ENABLE_GZIP = true
   ```

3. Set appropriate repository indexer settings:

   ```ini
   [indexer]
   REPO_INDEXER_ENABLED = true
   UPDATE_BUFFER_LEN = 20
   MAX_FILE_SIZE = 1048576
   ```

## Caching

1. Enable caching for repositories:

   ```ini
   [cache]
   ENABLED = true
   ADAPTER = memory
   INTERVAL = 60
   HOST =
   ```

2. If dealing with many repositories, consider using Redis for caching instead of memory.

## Monitoring and Profiling

1. Enable Prometheus metrics:

   ```ini
   [metrics]
   ENABLED = true
   ```

2. Use Docker's built-in monitoring:

   ```bash
   docker stats gitea
   ```

3. Consider using external monitoring tools like Grafana for visualizing performance metrics.

Remember to test thoroughly after making any changes, as performance optimizations can sometimes lead to unexpected behavior. Always benchmark before and after changes to measure the impact.
