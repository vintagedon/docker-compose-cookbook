# Multi-Node Setup Guide for Gogs with MySQL

This document provides guidance on setting up a multi-node configuration for Gogs with MySQL using Docker.

## Table of Contents

- [Multi-Node Setup Guide for Gogs with MySQL](#multi-node-setup-guide-for-gogs-with-mysql)
  - [Table of Contents](#table-of-contents)
  - [Overview](#overview)
  - [Architecture](#architecture)
  - [Prerequisites](#prerequisites)
  - [Load Balancer Setup](#load-balancer-setup)
  - [Gogs Nodes Setup](#gogs-nodes-setup)
  - [MySQL Replication](#mysql-replication)
  - [Shared Storage](#shared-storage)
  - [Considerations](#considerations)

## Overview

A multi-node setup can improve performance, reliability, and scalability of your Gogs instance. This setup involves multiple Gogs nodes, a load balancer, and MySQL replication.

## Architecture

The multi-node architecture typically consists of:

1. Load Balancer (e.g., Nginx, HAProxy)
2. Multiple Gogs nodes
3. MySQL Primary-Replica setup
4. Shared storage for Git repositories

## Prerequisites

- Docker and Docker Compose on all nodes
- A shared network or Docker Swarm setup
- Shared storage solution (e.g., NFS, GlusterFS)

## Load Balancer Setup

1. Choose a load balancer (e.g., Nginx)
2. Configure it to distribute traffic among Gogs nodes
3. Example Nginx configuration:

   ```nginx
   upstream gogs_nodes {
       server gogs1:3000;
       server gogs2:3000;
       # Add more Gogs nodes as needed
   }

   server {
       listen 80;
       server_name gogs.example.com;

       location / {
           proxy_pass http://gogs_nodes;
           proxy_set_header Host $host;
           proxy_set_header X-Real-IP $remote_addr;
       }
   }
   ```

## Gogs Nodes Setup

1. Modify the `docker-compose.yml` to define multiple Gogs services:

   ```yaml
   version: "3"
   services:
     gogs1:
       image: gogs/gogs
       volumes:
         - /path/to/shared/repos:/data/git/repositories
       # ... other configurations

     gogs2:
       image: gogs/gogs
       volumes:
         - /path/to/shared/repos:/data/git/repositories
       # ... other configurations
   ```

2. Ensure all Gogs nodes use the same database configuration

## MySQL Replication

1. Set up a MySQL Primary-Replica configuration
2. Configure Gogs to use the MySQL Primary for writes and Replicas for reads
3. Example MySQL Primary configuration:

   ```yaml
   mysql_primary:
     image: mysql:8.0
     command: --server-id=1 --log-bin=/var/log/mysql/mysql-bin.log
     # ... other configurations
   ```

4. Example MySQL Replica configuration:

   ```yaml
   mysql_replica:
     image: mysql:8.0
     command: --server-id=2
     # ... other configurations
   ```

## Shared Storage

1. Set up a shared storage solution (e.g., NFS) for Git repositories
2. Mount the shared storage on all Gogs nodes
3. Configure Gogs to use the shared storage for repositories

## Considerations

- Ensure session persistence or use a distributed session store
- Implement proper backup and disaster recovery procedures
- Monitor the health and performance of all nodes
- Regularly test failover scenarios
- Consider using Docker Swarm or Kubernetes for easier orchestration

Remember to thoroughly test your multi-node setup before deploying to production.
