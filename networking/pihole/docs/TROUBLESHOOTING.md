# Troubleshooting Guide for Pi-hole Docker Setup

This document provides solutions to common issues you might encounter with your Pi-hole Docker installation.

## Table of Contents

- [Troubleshooting Guide for Pi-hole Docker Setup](#troubleshooting-guide-for-pi-hole-docker-setup)
  - [Table of Contents](#table-of-contents)
  - [Container Won't Start](#container-wont-start)
  - [DNS Not Working](#dns-not-working)
  - [Web Interface Not Accessible](#web-interface-not-accessible)
  - [High CPU or Memory Usage](#high-cpu-or-memory-usage)
  - [Ads Not Being Blocked](#ads-not-being-blocked)
  - [DHCP Issues](#dhcp-issues)
  - [Custom DNS Not Resolving](#custom-dns-not-resolving)
  - [Logs and Debugging](#logs-and-debugging)

## Container Won't Start

1. **Check Docker logs**:

   ```
   docker-compose logs pihole
   ```

2. **Verify port availability**:
   Ensure ports 53, 80, and 67 (if using DHCP) are not in use by other services.

3. **Check Docker daemon**:

   ```
   sudo systemctl status docker
   ```

4. **Verify Docker-Compose file**:
   Ensure all paths and environment variables in `docker-compose.yml` are correct.

## DNS Not Working

1. **Check Pi-hole container status**:

   ```
   docker-compose ps
   ```

2. **Verify DNS port is open**:

   ```
   sudo lsof -i :53
   ```

3. **Test DNS resolution**:

   ```
   dig @<pi-hole-ip> example.com
   ```

4. **Check upstream DNS servers**:
   Verify upstream DNS servers in Pi-hole web interface under Settings > DNS.

## Web Interface Not Accessible

1. **Verify container is running**:

   ```
   docker-compose ps
   ```

2. **Check web port binding**:

   ```
   docker-compose port pihole 80
   ```

3. **Verify lighttpd is running inside the container**:

   ```
   docker exec pihole service lighttpd status
   ```

4. **Check firewall rules**:
   Ensure port 80 is open on your host firewall.

## High CPU or Memory Usage

1. **Check container resource usage**:

   ```
   docker stats pihole
   ```

2. **Verify host resource availability**:

   ```
   top
   ```

3. **Check for large query volume**:
   Review query logs in Pi-hole web interface.

4. **Optimize blocklists**:
   Remove unnecessary or overlapping blocklists.

## Ads Not Being Blocked

1. **Update gravity database**:

   ```
   docker exec pihole pihole -g
   ```

2. **Check client DNS settings**:
   Ensure clients are using Pi-hole for DNS.

3. **Verify blocklists**:
   Check active blocklists in Pi-hole web interface under Group Management > Adlists.

4. **Test with a known ad domain**:
   ```
   dig @<pi-hole-ip> doubleclick.net
   ```

## DHCP Issues

1. **Verify DHCP is enabled**:
   Check DHCP settings in Pi-hole web interface under Settings > DHCP.

2. **Check DHCP port**:
   Ensure port 67 is exposed in `docker-compose.yml`.

3. **Verify no other DHCP server is running**:
   Disable DHCP on your router if using Pi-hole for DHCP.

4. **Check DHCP lease file**:
   ```
   docker exec pihole cat /etc/pihole/dhcp.leases
   ```

## Custom DNS Not Resolving

1. **Check custom DNS entries**:
   Verify entries in `/etc/pihole/custom.list`.

2. **Restart DNS service**:

   ```
   docker exec pihole pihole restartdns
   ```

3. **Flush DNS cache on client**:
   On Windows: `ipconfig /flushdns`
   On macOS/Linux: `sudo killall -HUP mDNSResponder`

## Logs and Debugging

1. **View Pi-hole logs**:

   ```
   docker exec pihole pihole -t
   ```

2. **Generate debug log**:

   ```
   docker exec pihole pihole debug
   ```

3. **Check Docker logs**:

   ```
   docker-compose logs pihole
   ```

4. **Enable query logging** (if disabled):
   ```
   docker exec pihole pihole logging on
   ```

If you're still experiencing issues after trying these solutions, consider posting on the [Pi-hole Discourse](https://discourse.pi-hole.net/) or [GitHub issues](https://github.com/pi-hole/docker-pi-hole/issues) for further assistance.
