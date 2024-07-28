# Performance Tuning Guide for Gogs with PostgreSQL

This document provides guidance on optimizing the performance of your Gogs instance with PostgreSQL in a Docker environment.

## Table of Contents

1. [Gogs Performance Tuning](#gogs-performance-tuning)
2. [PostgreSQL Performance Tuning](#postgresql-performance-tuning)
3. [Docker Performance Considerations](#docker-performance-considerations)
4. [Network Optimizations](#network-optimizations)
5. [Monitoring and Profiling](#monitoring-and-profiling)

## Gogs Performance Tuning

### 1. Adjust Gogs Configuration

Modify your `app.ini` file or set environment variables:

```ini
[server]
DISABLE_ROUTER_LOG = true
DISABLE_HTTP_ADDR = false

[database]
DB_TYPE = postgres
HOST = postgres:5432
NAME = gogs
USER = gogs
PASSWD = your_password
SSL_MODE = disable
MAX_OPEN_CONNS = 100
MAX_IDLE_CONNS = 50

[indexer]
ISSUE_INDEXER_TYPE = bleve

[cache]
ADAPTER = memory
INTERVAL = 60
HOST =
```

### 2. Enable Caching

Consider using Redis for caching:

```ini
[cache]
ADAPTER = redis
HOST = redis:6379
```

### 3. Optimize Git Operations

```ini
[git]
MAX_GIT_DIFF_LINES = 1000
MAX_GIT_DIFF_LINE_CHARACTERS = 5000
MAX_GIT_DIFF_FILES = 100
GC_ARGS = --aggressive --auto
```

## PostgreSQL Performance Tuning

### 1. Adjust PostgreSQL Configuration

Modify `postgresql.conf` or set environment variables:

```
max_connections = 200
shared_buffers = 512MB
effective_cache_size = 1536MB
maintenance_work_mem = 128MB
checkpoint_completion_target = 0.7
wal_buffers = 16MB
default_statistics_target = 100
random_page_cost = 1.1
effective_io_concurrency = 200
work_mem = 6553kB
min_wal_size = 1GB
max_wal_size = 4GB
```

### 2. Optimize Queries

- Ensure proper indexing on frequently queried columns
- Use `EXPLAIN ANALYZE` to identify slow queries
- Consider using materialized views for complex, frequent queries

### 3. Regular Maintenance

- Schedule regular VACUUM and ANALYZE operations
- Monitor and manage table bloat

## Docker Performance Considerations

### 1. Use Volumes for Persistent Data

```yaml
volumes:
  - gogs_data:/data
  - postgres_data:/var/lib/postgresql/data
```

### 2. Limit Container Resources

```yaml
deploy:
  resources:
    limits:
      cpus: "0.50"
      memory: 512M
    reservations:
      cpus: "0.25"
      memory: 256M
```

### 3. Use Docker Compose Version 3+

Ensures access to the latest performance features and improvements.

## Network Optimizations

### 1. Use Docker's Internal Network

Ensure Gogs and PostgreSQL communicate over Docker's internal network to reduce latency.

### 2. Consider Using a Reverse Proxy

Implement Nginx or Traefik as a reverse proxy for SSL termination and request buffering.

## Monitoring and Profiling

### 1. Implement Monitoring

Use tools like Prometheus and Grafana to monitor system resources and application metrics.

### 2. Profile Gogs

Enable pprof endpoints for Go profiling:

```ini
[server]
ENABLE_PPROF = true
```

### 3. PostgreSQL Monitoring

Use pgBadger or pg_stat_statements to analyze PostgreSQL performance.

Remember to test thoroughly in a staging environment before applying changes to production. Performance tuning is an iterative process, and what works best can vary based on your specific usage patterns and hardware.
