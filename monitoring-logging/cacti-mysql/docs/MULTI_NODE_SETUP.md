# Multi-Node Setup for Cacti with MySQL

This guide provides information on setting up Cacti in a multi-node environment for distributed monitoring and logging.

## Table of Contents

- [Multi-Node Setup for Cacti with MySQL](#multi-node-setup-for-cacti-with-mysql)
  - [Table of Contents](#table-of-contents)
  - [Overview](#overview)
  - [Architecture](#architecture)
  - [Prerequisites](#prerequisites)
  - [Setup Steps](#setup-steps)
  - [Configuration](#configuration)
  - [Load Balancing](#load-balancing)
  - [Troubleshooting](#troubleshooting)

## Overview

A multi-node setup for Cacti allows you to distribute the monitoring and logging workload across multiple servers, improving performance and scalability.

## Architecture

In a multi-node Cacti setup:

- The main Cacti instance (primary node) handles the web interface and coordination.
- Additional Cacti instances (remote data collectors) perform data collection and send results to the primary node.
- A centralized MySQL database stores all configuration and collected data.

## Prerequisites

- Multiple servers or VMs for Cacti nodes
- Shared storage for RRD files (e.g., NFS)
- Load balancer (optional, for web interface)

## Setup Steps

1. Set up the primary Cacti node:

   - Follow the standard setup process in the main README.md
   - Ensure the MySQL database is accessible from other nodes

2. Set up remote data collectors:

   - Install Cacti on each remote node
   - Configure each node to use the central MySQL database
   - Set up shared storage for RRD files

3. Configure the primary node:

   - In Cacti UI: Console > Configuration > Settings > Poller
   - Enable "Boost RRD Updates"
   - Set up remote data collectors

4. Configure each remote data collector:
   - In Cacti UI: Console > Configuration > Settings > Poller
   - Set "Poller Type" to "Remote Poller"
   - Assign devices to the remote poller

## Configuration

Update the `docker-compose.yml` for each node:

```yaml
version: "3.8"

services:
  cacti:
    # ... (other settings remain the same)
    environment:
      - REMOTE_POLLER=1 # Set to 1 for remote data collectors
      - CENTRAL_DB_HOST=<primary_node_ip>
      - CENTRAL_DB_PORT=3306
      - CENTRAL_DB_NAME=cacti
      - CENTRAL_DB_USER=cactiuser
      - CENTRAL_DB_PASS=cactipassword
    volumes:
      - /shared/rra:/var/www/html/rra # Path to shared RRD storage
```

## Load Balancing

If using multiple web interfaces, set up a load balancer (e.g., NGINX, HAProxy) to distribute traffic among Cacti nodes.

## Troubleshooting

- Ensure all nodes can access the central MySQL database
- Check NFS/shared storage permissions
- Verify network connectivity between all nodes
- Review Cacti logs on all nodes for any errors

For more detailed information, refer to the official Cacti documentation on distributed environments.
