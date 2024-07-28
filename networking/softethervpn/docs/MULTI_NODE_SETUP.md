# Multi-Node Setup for SoftEther VPN

This document provides guidance on setting up a multi-node SoftEther VPN environment using Docker.

## Overview

A multi-node setup can provide increased reliability, load balancing, and geographic distribution for your VPN service. SoftEther VPN supports cascading connections, which allows for creating a network of VPN servers.

## Architecture

In this setup, we'll have:

1. A primary VPN server
2. One or more secondary VPN servers
3. A load balancer (optional)

## Setup Instructions

### 1. Primary Node Setup

Set up your primary node as described in the main README. This will be the central hub of your VPN network.

### 2. Secondary Node Setup

For each secondary node:

1. Clone the repository to the new host.
2. Modify the `docker-compose.yml`:

   ```yaml
   version: "3.8"

   services:
     softethervpn:
       # ... (keep other settings the same)
       environment:
         - SPW=${SERVER_PASSWORD:-ChangeThisPassword}
         - HPW=${HUB_PASSWORD:-ChangeThisHubPassword}
         - USERS=${VPN_USERS:-user1:password1,user2:password2}
         - CASCADE_SERVER=${PRIMARY_SERVER_IP}
         - CASCADE_PORT=${PRIMARY_SERVER_PORT}
         - CASCADE_HUB=DEFAULT
         - CASCADE_USERNAME=${CASCADE_USERNAME}
         - CASCADE_PASSWORD=${CASCADE_PASSWORD}
   ```

3. Update the `.env` file with the cascading connection details:

   ```
   PRIMARY_SERVER_IP=x.x.x.x
   PRIMARY_SERVER_PORT=5555
   CASCADE_USERNAME=cascade_user
   CASCADE_PASSWORD=secure_password
   ```

4. Modify the `init.sh` script to set up the cascading connection:

   ```bash
   #!/bin/bash

   # ... (keep existing initialization code)

   # Set up cascading connection
   vpncmd localhost:5555 /SERVER /CMD CascadeCreate ${CASCADE_SERVER} /PORT:${CASCADE_PORT} /HUB:${CASCADE_HUB} /USERNAME:${CASCADE_USERNAME} /PASSWORD:${CASCADE_PASSWORD}
   vpncmd localhost:5555 /SERVER /CMD CascadeOnline ${CASCADE_SERVER}

   echo "SoftEther VPN server initialization and cascading setup complete."
   ```

5. Start the secondary node:

   ```bash
   docker-compose up -d
   ```

### 3. Load Balancer Setup (Optional)

If you want to distribute traffic across multiple nodes, you can set up a load balancer. Here's a simple example using HAProxy:

1. Create a `haproxy.cfg` file:

   ```
   global
       log /dev/log local0
       log /dev/log local1 notice
       chroot /var/lib/haproxy
       stats socket /run/haproxy/admin.sock mode 660 level admin expose-fd listeners
       stats timeout 30s
       user haproxy
       group haproxy
       daemon

   defaults
       log global
       mode tcp
       option tcplog
       option dontlognull
       timeout connect 5000
       timeout client  50000
       timeout server  50000

   frontend vpn_frontend
       bind *:5555
       default_backend vpn_backend

   backend vpn_backend
       balance roundrobin
       server vpn1 vpn1_ip:5555 check
       server vpn2 vpn2_ip:5555 check
       # Add more servers as needed
   ```

2. Create a Docker Compose file for HAProxy:

   ```yaml
   version: "3.8"

   services:
     haproxy:
       image: haproxy:latest
       ports:
         - "5555:5555"
       volumes:
         - ./haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg:ro
   ```

3. Start the HAProxy container:

   ```bash
   docker-compose up -d
   ```

## Maintenance and Monitoring

1. Regularly check the status of all nodes:

   ```bash
   docker exec softethervpn vpncmd localhost:5555 /SERVER /CMD ServerStatusGet
   ```

2. Monitor the cascading connections:

   ```bash
   docker exec softethervpn vpncmd localhost:5555 /SERVER /CMD CascadeList
   ```

3. Update all nodes when upgrading:
   - Follow the upgrade process described in UPGRADING.md for each node.
   - Upgrade secondary nodes before the primary node to ensure compatibility.

Remember to adjust firewall rules and network configurations to allow communication between your VPN nodes. Always prioritize security in your multi-node setup.
