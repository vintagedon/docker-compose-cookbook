# Configuration for Redis Docker Setup

This document provides detailed information on configuring your Redis instance in this Docker setup.

## Table of Contents

- [Configuration for Redis Docker Setup](#configuration-for-redis-docker-setup)
  - [Table of Contents](#table-of-contents)
  - [Overview](#overview)
  - [Configuration Options](#configuration-options)
    - [Environment Variables](#environment-variables)
    - [redis.conf Options](#redisconf-options)
  - [Best Practices](#best-practices)
  - [Examples](#examples)
    - [Basic Configuration](#basic-configuration)
    - [Advanced Configuration with redis.conf](#advanced-configuration-with-redisconf)
  - [Troubleshooting](#troubleshooting)
  - [Additional Resources](#additional-resources)

## Overview

Redis configuration in this Docker setup is primarily managed through environment variables and the `redis.conf` file.

## Configuration Options

### Environment Variables

- `REDIS_VERSION`: Redis version to use (default: latest)
- `CONTAINER_NAME`: Name of the Redis container (default: redis)
- `REDIS_PORT`: Port to expose Redis on (default: 6379)
- `REDIS_PASSWORD`: Password for Redis authentication (default: changeme)
- `REDIS_APPENDONLY`: Enable/disable AOF persistence (default: yes)
- `REDIS_MAXMEMORY`: Maximum memory Redis can use (default: 256mb)
- `REDIS_MAXMEMORY_POLICY`: Eviction policy when max memory is reached (default: allkeys-lru)

### redis.conf Options

For more advanced configurations, you can create a `redis.conf` file and mount it to the container. Some important options include:

- `bind`: Network interfaces to listen on
- `protected-mode`: Protect Redis from access from external networks
- `maxmemory-samples`: Number of keys to sample in LRU/LFU eviction
- `save`: RDB snapshot schedule

## Best Practices

1. Always set a strong password for Redis.
2. Use AOF persistence for better durability.
3. Configure maxmemory and an appropriate eviction policy.
4. In production, bind Redis to localhost and use a reverse proxy for remote access.

## Examples

### Basic Configuration

```yaml
version: "3.8"
services:
  redis:
    image: redis:6.2
    environment:
      - REDIS_PASSWORD=strongpassword
      - REDIS_MAXMEMORY=1gb
      - REDIS_MAXMEMORY_POLICY=allkeys-lru
```

### Advanced Configuration with redis.conf

1. Create a `redis.conf` file with your desired settings.
2. Update your `docker-compose.yml`:

```yaml
version: "3.8"
services:
  redis:
    image: redis:6.2
    command: redis-server /usr/local/etc/redis/redis.conf
    volumes:
      - ./redis.conf:/usr/local/etc/redis/redis.conf
```

## Troubleshooting

- If Redis doesn't start, check the logs for configuration errors.
- If you can't connect, ensure the port is correctly mapped and the password is set correctly.

## Additional Resources

- [Official Redis Configuration Documentation](https://redis.io/topics/config)
- [Redis Docker Hub Page](https://hub.docker.com/_/redis)
