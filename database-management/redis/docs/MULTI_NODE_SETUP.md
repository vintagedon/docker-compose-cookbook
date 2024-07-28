# Multi-Node Setup for Redis Docker

This document provides information on setting up Redis in a multi-node configuration using Docker.

## Table of Contents

- [Multi-Node Setup for Redis Docker](#multi-node-setup-for-redis-docker)
  - [Table of Contents](#table-of-contents)
  - [Overview](#overview)
  - [Configuration Options](#configuration-options)
    - [Master-Replica Replication](#master-replica-replication)
    - [Redis Cluster](#redis-cluster)
  - [Best Practices](#best-practices)
  - [Examples](#examples)
    - [Master-Replica Setup](#master-replica-setup)
    - [Redis Cluster Setup](#redis-cluster-setup)
  - [Troubleshooting](#troubleshooting)
  - [Additional Resources](#additional-resources)

## Overview

Redis supports various multi-node setups, including master-replica replication and Redis Cluster for horizontal scaling.

## Configuration Options

### Master-Replica Replication

- `REDIS_REPLICATION_MODE`: Set to 'master' or 'slave'
- `REDIS_MASTER_HOST`: Hostname of the master (for replicas)
- `REDIS_MASTER_PORT_NUMBER`: Port of the master (for replicas)

### Redis Cluster

- `REDIS_CLUSTER_ENABLED`: Enable cluster mode
- `REDIS_CLUSTER_SLAVE_VALIDITY_FACTOR`: Configure slave validity factor
- `REDIS_CLUSTER_MIGRATION_BARRIER`: Set migration barrier for master election

## Best Practices

1. Use odd number of nodes in Redis Cluster for better failover.
2. Configure appropriate network latency between nodes.
3. Use Redis Cluster for horizontal scaling needs.
4. Use master-replica replication for read scaling and data redundancy.

## Examples

### Master-Replica Setup

```yaml
version: "3"
services:
  redis-master:
    image: redis:6.2
    ports:
      - "6379:6379"
    volumes:
      - redis_master_data:/data

  redis-replica:
    image: redis:6.2
    command: redis-server --slaveof redis-master 6379
    depends_on:
      - redis-master

volumes:
  redis_master_data:
```

### Redis Cluster Setup

For a Redis Cluster, you typically need at least 6 nodes (3 masters and 3 replicas). Here's a basic setup:

```yaml
version: "3"
services:
  redis-cluster:
    image: grokzen/redis-cluster:latest
    environment:
      IP: 0.0.0.0
      INITIAL_PORT: 7000
    ports:
      - "7000-7005:7000-7005"
```

## Troubleshooting

- Ensure all nodes can communicate with each other on the required ports.
- Check logs for any configuration errors or connection issues.
- Verify that the cluster state is consistent across all nodes.

## Additional Resources

- [Redis Replication Documentation](https://redis.io/topics/replication)
- [Redis Cluster Tutorial](https://redis.io/topics/cluster-tutorial)
- [Redis Cluster Specification](https://redis.io/topics/cluster-spec)
