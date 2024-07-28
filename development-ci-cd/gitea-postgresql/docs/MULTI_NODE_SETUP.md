# Multi-Node Setup for Gitea with PostgreSQL

This document provides guidance on setting up a multi-node deployment for Gitea with PostgreSQL using Docker.

## Table of Contents

- [Multi-Node Setup for Gitea with PostgreSQL](#multi-node-setup-for-gitea-with-postgresql)
  - [Table of Contents](#table-of-contents)
  - [Overview](#overview)
  - [Architecture](#architecture)
  - [Prerequisites](#prerequisites)
  - [Load Balancer Setup](#load-balancer-setup)
  - [Gitea Nodes Setup](#gitea-nodes-setup)
  - [Shared Storage](#shared-storage)
  - [PostgreSQL Replication](#postgresql-replication)
  - [Considerations](#considerations)

## Overview

A multi-node setup can provide increased availability, scalability, and performance for your Gitea instance. This setup involves running multiple Gitea nodes behind a load balancer, with a replicated PostgreSQL database.

## Architecture

The basic architecture of a multi-node Gitea setup includes:

1. Load Balancer (e.g., Nginx, HAProxy)
2. Multiple Gitea nodes
3. Shared storage for Git repositories
4. PostgreSQL primary and replica nodes

## Prerequisites

- Docker and Docker Compose installed on all nodes
- A shared network between all nodes
- Shared storage solution (e.g., NFS, GlusterFS)

## Load Balancer Setup

1. Choose a load balancer (e.g., Nginx, HAProxy)
2. Configure it to distribute traffic among Gitea nodes
3. Handle SSL termination at the load balancer level

Example Nginx configuration:

```nginx
upstream gitea {
    server gitea1:3000;
    server gitea2:3000;
    server gitea3:3000;
}

server {
    listen 80;
    server_name gitea.yourdomain.com;

    location / {
        proxy_pass http://gitea;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

## Gitea Nodes Setup

1. Modify the `docker-compose.yml` for each Gitea node:

```yaml
version: "3"

services:
  gitea:
    image: gitea/gitea:latest
    environment:
      - USER_UID=1000
      - USER_GID=1000
      - GITEA__database__DB_TYPE=postgres
      - GITEA__database__HOST=postgres-primary:5432
      - GITEA__database__NAME=gitea
      - GITEA__database__USER=gitea
      - GITEA__database__PASSWD=gitea_password
      - GITEA__server__SSH_DOMAIN=gitea.yourdomain.com
      - GITEA__server__ROOT_URL=https://gitea.yourdomain.com/
    volumes:
      - /path/to/shared/gitea:/data
      - /etc/timezone:/etc/timezone:ro
      - /etc/localtime:/etc/localtime:ro
    ports:
      - "3000:3000"
      - "22:22"
    depends_on:
      - postgres-primary

  postgres-primary:
    image: postgres:13
    environment:
      - POSTGRES_USER=gitea
      - POSTGRES_PASSWORD=gitea_password
      - POSTGRES_DB=gitea
    volumes:
      - /path/to/shared/postgres:/var/lib/postgresql/data
```

2. Ensure all Gitea nodes use the same shared storage for the `/data` directory.

## Shared Storage

1. Set up a shared storage solution (e.g., NFS, GlusterFS) for Git repositories.
2. Mount the shared storage to each Gitea node at `/path/to/shared/gitea`.

## PostgreSQL Replication

1. Set up PostgreSQL streaming replication:

Primary node (`postgres-primary`) configuration:

```yaml
services:
  postgres-primary:
    image: postgres:13
    environment:
      - POSTGRES_USER=gitea
      - POSTGRES_PASSWORD=gitea_password
      - POSTGRES_DB=gitea
    command:
      - "postgres"
      - "-c"
      - "wal_level=replica"
      - "-c"
      - "max_wal_senders=3"
      - "-c"
      - "wal_keep_segments=8"
    volumes:
      - /path/to/shared/postgres-primary:/var/lib/postgresql/data
```

Replica node (`postgres-replica`) configuration:

```yaml
services:
  postgres-replica:
    image: postgres:13
    environment:
      - POSTGRES_USER=gitea
      - POSTGRES_PASSWORD=gitea_password
      - POSTGRES_DB=gitea
    command:
      - "postgres"
      - "-c"
      - "hot_standby=on"
    volumes:
      - /path/to/shared/postgres-replica:/var/lib/postgresql/data
```

2. Initialize the replica using `pg_basebackup`.

## Considerations

1. Ensure all nodes are time-synchronized using NTP.
2. Implement proper monitoring and alerting for all components.
3. Regularly back up the shared storage and PostgreSQL data.
4. Test failover scenarios to ensure high availability.
5. Consider using Docker Swarm or Kubernetes for more advanced orchestration.

Remember that a multi-node setup increases complexity. Ensure you have the necessary expertise to manage and troubleshoot this type of deployment.
