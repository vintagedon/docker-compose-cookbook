# Multi-Node Setup for Fluentd Docker

This guide provides instructions for setting up Fluentd in a distributed environment, allowing you to scale your logging infrastructure across multiple nodes.

## Table of Contents

- [Multi-Node Setup for Fluentd Docker](#multi-node-setup-for-fluentd-docker)
  - [Table of Contents](#table-of-contents)
  - [Overview](#overview)
  - [Architecture](#architecture)
  - [Prerequisites](#prerequisites)
  - [Setup Instructions](#setup-instructions)
    - [Sample Forwarder Configuration](#sample-forwarder-configuration)
    - [Sample Aggregator Configuration](#sample-aggregator-configuration)
  - [Configuration](#configuration)
  - [Load Balancing](#load-balancing)
  - [Monitoring](#monitoring)
  - [Troubleshooting](#troubleshooting)

## Overview

In a multi-node setup, Fluentd instances are distributed across multiple servers or containers. This setup improves scalability, reliability, and allows for more efficient log processing.

## Architecture

A typical multi-node Fluentd setup consists of:

1. **Forwarder Nodes**: These are Fluentd instances that collect logs from various sources and forward them to Aggregator Nodes.
2. **Aggregator Nodes**: These Fluentd instances receive logs from Forwarder Nodes and process them further or send them to final destinations.

## Prerequisites

- Docker and Docker Compose installed on all nodes
- Network connectivity between all nodes
- Sufficient resources (CPU, RAM, storage) on each node

## Setup Instructions

1. **Forwarder Nodes**:

   - Use the existing `docker-compose.yml` file on each forwarder node.
   - Modify the Fluentd configuration to forward logs to Aggregator Nodes.

2. **Aggregator Nodes**:
   - Create a new `docker-compose.yml` file for aggregator nodes.
   - Set up a new Fluentd configuration for aggregation.

### Sample Forwarder Configuration

```xml
<source>
  @type forward
  port 24224
  bind 0.0.0.0
</source>

<match **>
  @type forward
  <server>
    host aggregator1.example.com
    port 24224
  </server>
  <server>
    host aggregator2.example.com
    port 24224
  </server>
</match>
```

### Sample Aggregator Configuration

```xml
<source>
  @type forward
  port 24224
  bind 0.0.0.0
</source>

<match **>
  @type elasticsearch
  host elasticsearch.example.com
  port 9200
  logstash_format true
</match>
```

## Configuration

1. Ensure each node has a unique `CONTAINER_NAME` in its `.env` file.
2. Adjust the `FLUENTD_PORT` if needed to avoid conflicts.
3. Configure appropriate tags and matches to route logs correctly.

## Load Balancing

For high-volume environments, consider using a load balancer in front of your Aggregator Nodes. Popular options include:

- HAProxy
- Nginx
- AWS Elastic Load Balancer (if running in AWS)

## Monitoring

Monitor your Fluentd nodes using:

1. Fluentd's built-in monitoring agent
2. Prometheus and Grafana for visualizations
3. Docker's health check feature (already configured in `docker-compose.yml`)

## Troubleshooting

1. Check individual node logs: `docker logs <container_name>`
2. Ensure all nodes can communicate with each other
3. Verify that aggregator nodes can reach the final log destination (e.g., Elasticsearch)
4. Check for any network issues or firewall rules blocking communication

For more detailed troubleshooting, refer to the [TROUBLESHOOTING.md](TROUBLESHOOTING.md) file.
