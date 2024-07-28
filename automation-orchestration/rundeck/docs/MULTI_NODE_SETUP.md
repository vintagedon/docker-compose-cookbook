# Multi-Node Setup Guide for Rundeck

This guide provides instructions for setting up a multi-node Rundeck environment using Docker.

## Architecture Overview

A multi-node Rundeck setup typically consists of:

1. Multiple Rundeck application servers
2. A load balancer
3. A shared database
4. A shared file system for project definitions and logs

## Prerequisites

- Docker and Docker Compose installed on all nodes
- A shared network accessible by all nodes
- A load balancer (e.g., Nginx, HAProxy)

## Step-by-Step Setup

### 1. Shared Database

Use an external database that can be accessed by all Rundeck nodes. Update the `docker-compose.yml` file on each node:

```yaml
services:
  rundeck:
    environment:
      - RUNDECK_DATABASE_URL=jdbc:mariadb://your-external-db-host:3306/rundeck?autoReconnect=true&useSSL=false
```

### 2. Shared File System

Set up a shared file system (e.g., NFS) for project definitions and logs. Update the `docker-compose.yml` file:

```yaml
services:
  rundeck:
    volumes:
      - /path/to/shared/projects:/home/rundeck/server/projects
      - /path/to/shared/logs:/home/rundeck/server/logs
```

### 3. Rundeck Configuration

Update the `rundeck-config.properties` file on each node:

```properties
rundeck.clusterMode.enabled=true
rundeck.execution.logs.fileStoragePlugin=db
```

### 4. Load Balancer Configuration

Set up a load balancer to distribute traffic among your Rundeck nodes. Here's an example Nginx configuration:

```nginx
upstream rundeck {
    server rundeck1:4440;
    server rundeck2:4440;
    # Add more servers as needed
}

server {
    listen 80;
    server_name rundeck.yourdomain.com;

    location / {
        proxy_pass http://rundeck;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

### 5. Starting the Cluster

1. Start the Rundeck containers on each node:

   ```
   docker-compose up -d
   ```

2. Start your load balancer.

3. Access Rundeck through the load balancer URL.

## Considerations

- Ensure all nodes have the same Rundeck version and plugins installed.
- Monitor the health of all nodes and set up automatic failover if possible.
- Regularly backup the shared database and file system.

For more detailed information on Rundeck clustering, refer to the [official Rundeck documentation](https://docs.rundeck.com/docs/administration/clustering/).
