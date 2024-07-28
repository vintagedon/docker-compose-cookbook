# Multi-Node Setup Guide for Ansible AWX

This document provides instructions for setting up Ansible AWX in a multi-node configuration for improved performance and high availability.

## Prerequisites

- Multiple Docker hosts
- Shared storage solution (e.g., NFS)
- Load balancer (e.g., HAProxy, Nginx)

## Architecture Overview

A multi-node AWX setup typically consists of:

1. Multiple AWX web nodes
2. Multiple AWX task nodes
3. Clustered PostgreSQL database
4. Clustered Redis cache
5. Shared storage for projects and job output
6. Load balancer for distributing traffic

## Step-by-Step Setup

### 1. Prepare Shared Storage

Set up a shared storage solution (e.g., NFS) to store AWX projects and job output. This ensures consistency across all nodes.

### 2. Set Up Database Cluster

1. Set up a PostgreSQL cluster using tools like Patroni or PostgreSQL's built-in replication.
2. Update the `postgres` service in `docker-compose.yml` to point to your clustered database.

### 3. Set Up Redis Cluster

1. Set up a Redis cluster for improved caching performance.
2. Update the `redis` service in `docker-compose.yml` to point to your Redis cluster.

### 4. Modify docker-compose.yml

Update the `docker-compose.yml` file to support multiple nodes:

```yaml
version: "3"

services:
  web:
    image: ansible/awx:${AWX_VERSION:-latest}
    depends_on:
      - redis
    environment:
      - POSTGRES_HOST=your_postgres_cluster_host
      - REDIS_HOST=your_redis_cluster_host
      - AWX_ADMIN_USER=${AWX_ADMIN_USER:-admin}
      - AWX_ADMIN_PASSWORD=${AWX_ADMIN_PASSWORD:-password}
    volumes:
      - /path/to/shared/storage:/var/lib/awx/projects
    deploy:
      replicas: 3

  task:
    image: ansible/awx:${AWX_VERSION:-latest}
    depends_on:
      - redis
      - web
    environment:
      - POSTGRES_HOST=your_postgres_cluster_host
      - REDIS_HOST=your_redis_cluster_host
      - AWX_ADMIN_USER=${AWX_ADMIN_USER:-admin}
      - AWX_ADMIN_PASSWORD=${AWX_ADMIN_PASSWORD:-password}
    volumes:
      - /path/to/shared/storage:/var/lib/awx/projects
    deploy:
      replicas: 3
```

### 5. Set Up Load Balancer

Configure a load balancer (e.g., HAProxy, Nginx) to distribute traffic across the AWX web nodes.

Example HAProxy configuration:

```
frontend awx_frontend
    bind *:80
    default_backend awx_backend

backend awx_backend
    balance roundrobin
    server awx1 awx1:8052 check
    server awx2 awx2:8052 check
    server awx3 awx3:8052 check
```

### 6. Deploy the Stack

Deploy the updated Docker Compose file across your Docker hosts:

```
docker stack deploy -c docker-compose.yml awx
```

### 7. Verify the Setup

1. Check that all services are running:
   ```
   docker service ls
   ```
2. Verify that you can access AWX through the load balancer.
3. Test failover by stopping individual nodes and ensuring the system remains operational.

## Considerations

- Ensure all nodes have consistent configurations.
- Monitor the health of all nodes and services.
- Implement proper backup and disaster recovery procedures for the clustered setup.
- Regularly update and maintain all components of the multi-node setup.

For more detailed information on scaling and managing a multi-node AWX setup, refer to the [official Ansible AWX documentation](https://docs.ansible.com/ansible-tower/).
