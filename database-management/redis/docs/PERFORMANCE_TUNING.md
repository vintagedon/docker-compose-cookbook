# Performance Tuning for Redis Docker Setup

This document provides guidance on optimizing the performance of your Redis instance in this Docker setup.

## Table of Contents

- [Performance Tuning for Redis Docker Setup](#performance-tuning-for-redis-docker-setup)
  - [Table of Contents](#table-of-contents)
  - [Overview](#overview)
  - [Configuration Options](#configuration-options)
  - [Best Practices](#best-practices)
  - [Examples](#examples)
    - [Optimized for Cache Use Case](#optimized-for-cache-use-case)
    - [Optimized for Persistence](#optimized-for-persistence)
  - [Troubleshooting](#troubleshooting)
  - [Additional Resources](#additional-resources)

## Overview

Performance tuning in Redis involves optimizing memory usage, adjusting persistence settings, and configuring client connections.

## Configuration Options

- `maxmemory`: Set the maximum amount of memory Redis can use
- `maxmemory-policy`: Define how Redis should behave when maxmemory is reached
- `appendonly`: Enable/disable AOF persistence
- `appendfsync`: Configure AOF fsync policy
- `save`: Configure RDB persistence
- `tcp-keepalive`: Enable TCP keepalive on client connections

## Best Practices

1. Set an appropriate `maxmemory` limit to prevent swapping.
2. Choose the right `maxmemory-policy` for your use case (e.g., allkeys-lru for cache).
3. Use AOF persistence with `appendfsync everysec` for a balance of performance and durability.
4. Avoid expensive commands like KEYS in production environments.
5. Use pipelining and connection pooling in your Redis clients.

## Examples

### Optimized for Cache Use Case

```yaml
version: "3"
services:
  redis:
    image: redis:6.2
    command: redis-server --maxmemory 2gb --maxmemory-policy allkeys-lru
    environment:
      - REDIS_APPENDONLY=no
```

### Optimized for Persistence

```yaml
version: "3"
services:
  redis:
    image: redis:6.2
    command: redis-server --appendonly yes --appendfsync everysec
    environment:
      - REDIS_SAVE="900 1 300 10 60 10000"
```

## Troubleshooting

- Monitor Redis INFO commands for performance metrics.
- Use the SLOWLOG command to identify slow queries.
- Check for high CPU usage or memory swapping.

## Additional Resources

- [Redis Administration](https://redis.io/topics/admin)
- [Redis Latency Monitoring Framework](https://redis.io/topics/latency-monitor)
- [Redis Benchmarks](https://redis.io/topics/benchmarks)
