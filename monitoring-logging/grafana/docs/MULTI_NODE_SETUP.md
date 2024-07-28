# Multi-Node Setup for Grafana

This document provides guidance on setting up Grafana in a multi-node environment for high availability and scalability.

## Table of Contents

- [Multi-Node Setup for Grafana](#multi-node-setup-for-grafana)
  - [Table of Contents](#table-of-contents)
  - [Architecture Overview](#architecture-overview)
  - [Load Balancer Configuration](#load-balancer-configuration)
  - [Grafana Instance Configuration](#grafana-instance-configuration)
  - [Database Configuration](#database-configuration)
  - [File Storage](#file-storage)
  - [Caching](#caching)
  - [Session Management](#session-management)

## Architecture Overview

A typical multi-node Grafana setup consists of:

1. Multiple Grafana instances
2. A load balancer
3. A shared database (e.g., PostgreSQL)
4. Shared file storage (e.g., NFS)
5. A caching layer (e.g., Redis)

```
       ┌─────────────┐
       │Load Balancer│
       └─────────────┘
             │
     ┌───────┼───────┐
     │       │       │
┌─────────┐ ┌─────────┐ ┌─────────┐
│ Grafana │ │ Grafana │ │ Grafana │
│ Node 1  │ │ Node 2  │ │ Node 3  │
└─────────┘ └─────────┘ └─────────┘
     │           │           │
     └───────────┼───────────┘
                 │
         ┌───────┴───────┐
         │   Shared DB   │
         └───────────────┘
```

## Load Balancer Configuration

1. Set up a load balancer (e.g., Nginx, HAProxy) in front of your Grafana instances.
2. Configure health checks to ensure traffic is only sent to healthy instances.
3. Enable sticky sessions if you're not using a shared cache for user sessions.

Example Nginx configuration:

```nginx
upstream grafana {
    server grafana1:3000;
    server grafana2:3000;
    server grafana3:3000;
}

server {
    listen 80;
    server_name grafana.example.com;

    location / {
        proxy_pass http://grafana;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

## Grafana Instance Configuration

1. Use the same configuration for all Grafana instances.
2. Set a unique `instance_name` for each instance:

```ini
[server]
instance_name = grafana-01
```

3. Configure database and file storage to use shared resources.

## Database Configuration

1. Set up a PostgreSQL database cluster for high availability.
2. Configure all Grafana instances to use this shared database:

```ini
[database]
type = postgres
host = postgres.example.com:5432
name = grafana
user = grafana
password = <password>
```

## File Storage

1. Set up shared file storage (e.g., NFS) for storing images, plugins, and other files.
2. Mount the shared storage to each Grafana instance.
3. Configure Grafana to use the shared storage:

```ini
[paths]
data = /var/lib/grafana
plugins = /var/lib/grafana/plugins
provisioning = /etc/grafana/provisioning
```

## Caching

1. Set up a Redis cluster for caching.
2. Configure all Grafana instances to use this shared cache:

```ini
[caching]
enabled = true
type = redis
connstr = addr=redis.example.com:6379,pool_size=100,db=0,ssl=false
```

## Session Management

1. For stateless operation, configure Grafana to use the shared Redis for session storage:

```ini
[session]
provider = redis
provider_config = addr=redis.example.com:6379,pool_size=100,db=0,ssl=false
```

Remember to secure all communications between components, preferably using SSL/TLS encryption.

For more detailed information on multi-node setups, please refer to the [official Grafana documentation on high availability](https://grafana.com/docs/grafana/latest/setup-grafana/set-up-for-high-availability/).
