# Multi-Node Setup Guide for Pi-hole Docker

This document outlines the process for setting up a high-availability Pi-hole configuration using multiple Docker nodes.

## Table of Contents

- [Multi-Node Setup Guide for Pi-hole Docker](#multi-node-setup-guide-for-pi-hole-docker)
  - [Table of Contents](#table-of-contents)
  - [Overview](#overview)
  - [Prerequisites](#prerequisites)
  - [Architecture](#architecture)
  - [Setup Process](#setup-process)
  - [Load Balancing](#load-balancing)
  - [Synchronization](#synchronization)
  - [Failover Configuration](#failover-configuration)
  - [Monitoring](#monitoring)

## Overview

A multi-node Pi-hole setup provides redundancy and load balancing, ensuring continuous ad-blocking and DNS services even if one node fails.

## Prerequisites

- Multiple Docker hosts
- Shared storage solution (e.g., NFS)
- Load balancer (e.g., HAProxy, Nginx)
- Basic understanding of networking and Docker Swarm or Kubernetes

## Architecture

```
[Client Devices]
        |
    [Load Balancer]
    /            \
[Pi-hole Node 1]  [Pi-hole Node 2]
    \            /
  [Shared Storage]
```

## Setup Process

1. **Prepare Docker Hosts**:

   - Install Docker on each host
   - Configure shared storage

2. **Create Docker Swarm or Kubernetes Cluster**:

   - Initialize the cluster on the first node
   - Join other nodes to the cluster

3. **Deploy Pi-hole Containers**:

   - Use Docker Swarm services or Kubernetes deployments
   - Example Docker Swarm service:
     ```yaml
     version: "3.8"
     services:
       pihole:
         image: pihole/pihole:latest
         deploy:
           replicas: 2
         volumes:
           - /shared/etc-pihole:/etc/pihole
           - /shared/etc-dnsmasq.d:/etc/dnsmasq.d
         environment:
           TZ: "America/New_York"
           WEBPASSWORD: "your_password"
         ports:
           - 53:53/tcp
           - 53:53/udp
           - 80:80/tcp
     ```

4. **Configure Shared Storage**:
   - Mount shared storage on each node
   - Ensure Pi-hole configurations are stored on shared storage

## Load Balancing

1. **Setup Load Balancer**:

   - Install and configure HAProxy or Nginx
   - Example HAProxy configuration:

     ```
     frontend pihole
         bind *:53
         mode tcp
         default_backend pihole_backend

     backend pihole_backend
         mode tcp
         balance roundrobin
         server pihole1 192.168.1.10:53 check
         server pihole2 192.168.1.11:53 check
     ```

2. **Configure DNS**:
   - Point clients to the load balancer IP for DNS

## Synchronization

1. **Gravity Database**:

   - Store on shared storage
   - Alternatively, use a script to sync between nodes

2. **Configuration Files**:

   - Store `setupVars.conf` and other configs on shared storage

3. **Custom Lists**:
   - Keep custom whitelist and blacklist on shared storage

## Failover Configuration

1. **Health Checks**:

   - Implement in load balancer configuration
   - Example HAProxy health check:
     ```
     option tcp-check
     tcp-check connect
     tcp-check send "GET / HTTP/1.0\r\n\r\n"
     tcp-check expect string "HTTP/1.0 200 OK"
     ```

2. **Automated Failover**:
   - Load balancer will automatically route traffic to healthy nodes

## Monitoring

1. **Node Health**:

   - Use Docker Swarm or Kubernetes built-in health checks

2. **Service Monitoring**:

   - Implement Prometheus and Grafana for advanced monitoring

3. **Alerts**:
   - Set up alerting for node failures or performance issues

Remember to thoroughly test your multi-node setup, including simulated node failures, before relying on it in production.
