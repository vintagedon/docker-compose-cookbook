# Multi-Node Setup Guide for Graylog Docker

This document provides instructions on setting up a multi-node Graylog cluster using Docker.

## Table of Contents

- [Multi-Node Setup Guide for Graylog Docker](#multi-node-setup-guide-for-graylog-docker)
  - [Table of Contents](#table-of-contents)
  - [Overview](#overview)
  - [Prerequisites](#prerequisites)
  - [Architecture](#architecture)
  - [Configuration](#configuration)
    - [Graylog Nodes](#graylog-nodes)
    - [Elasticsearch](#elasticsearch)
    - [MongoDB](#mongodb)
  - [Deployment](#deployment)
  - [Load Balancing](#load-balancing)
  - [Monitoring](#monitoring)
  - [Troubleshooting](#troubleshooting)

## Overview

A multi-node Graylog setup improves performance, scalability, and fault tolerance. This guide covers the basics of setting up such a cluster.

## Prerequisites

- Docker and Docker Compose on all nodes
- A shared filesystem or object storage for content packs and message journal
- A load balancer (e.g., Nginx, HAProxy)

## Architecture

A typical multi-node Graylog setup consists of:

- Multiple Graylog nodes
- Elasticsearch cluster
- MongoDB replica set
- Load balancer

```
[Client] --> [Load Balancer] --> [Graylog Node 1]
                             --> [Graylog Node 2]
                             --> [Graylog Node 3]
                                      |
                                      v
                             [Elasticsearch Cluster]
                                      |
                                      v
                               [MongoDB Replica Set]
```

## Configuration

### Graylog Nodes

1. Modify the `docker-compose.yml` to include multiple Graylog services:

   ```yaml
   graylog-1:
     image: graylog/graylog:${GRAYLOG_VERSION:-4.2}
     # ... other configurations ...

   graylog-2:
     image: graylog/graylog:${GRAYLOG_VERSION:-4.2}
     # ... other configurations ...
   ```

2. Ensure each Graylog node has a unique `node_id` in its environment variables:

   ```yaml
   environment:
     GRAYLOG_NODE_ID: "graylog-1"
   ```

### Elasticsearch

1. Set up an Elasticsearch cluster with at least 3 nodes for production use.
2. Ensure all Graylog nodes point to the Elasticsearch cluster.

### MongoDB

1. Set up a MongoDB replica set with at least 3 nodes for production use.
2. Update the `GRAYLOG_MONGODB_URI` to point to the replica set.

## Deployment

1. Start the MongoDB replica set
2. Start the Elasticsearch cluster
3. Start the Graylog nodes
4. Configure the load balancer

## Load Balancing

Configure your load balancer to distribute traffic among the Graylog nodes. Example Nginx configuration:

```nginx
upstream graylog {
    server graylog-1:9000;
    server graylog-2:9000;
}

server {
    listen 80;
    server_name graylog.example.com;

    location / {
        proxy_pass http://graylog;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

## Monitoring

Monitor your Graylog cluster using:

- Graylog's built-in monitoring features
- Prometheus and Grafana
- Docker's monitoring tools

## Troubleshooting

Common issues in a multi-node setup:

1. **Node communication**: Ensure all nodes can communicate with each other.
2. **Elasticsearch cluster health**: Check Elasticsearch cluster status regularly.
3. **MongoDB replica set**: Verify MongoDB replica set is functioning correctly.
4. **Load balancer issues**: Check load balancer logs and configuration.

For more detailed information, refer to the [official Graylog documentation on clustering](https://docs.graylog.org/en/latest/pages/configuration/multinode_setup.html).
