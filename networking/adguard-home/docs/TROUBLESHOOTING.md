# Troubleshooting Guide for AdGuard Home Docker Setup

This document provides solutions to common issues you may encounter with your AdGuard Home Docker setup.

## Container Won't Start

1. Check container logs:
   ```
   docker logs adguardhome
   ```
2. Ensure all required ports are available
3. Verify volume mounts are correct
4. Check for sufficient disk space

## DNS Resolution Issues

1. Verify DNS port (53) is not in use by another service
2. Check firewall settings
3. Ensure correct upstream DNS servers are configured
4. Verify network interface binding

## Web Interface Inaccessible

1. Confirm the correct port mapping (default 3000)
2. Check if AdGuard Home service is running inside the container
3. Verify network connectivity to the Docker host
4. Check for any reverse proxy configuration issues

## High CPU or Memory Usage

1. Monitor resource usage:
   ```
   docker stats adguardhome
   ```
2. Review and optimize filtering rules
3. Check for any stuck queries or DNS loops
4. Consider increasing container resource limits

## Persistence Issues

1. Verify volume mounts are correctly configured
2. Check permissions on host directories
3. Ensure sufficient disk space for volumes

## Update Problems

1. Pull the latest image manually:
   ```
   docker pull adguard/adguardhome:latest
   ```
2. Check for compatibility issues with newer versions
3. Verify if there are any pending configuration changes

## Slow DNS Resolution

1. Review upstream DNS server performance
2. Check network latency to upstream servers
3. Optimize caching settings
4. Verify if there are any problematic filtering rules

## Common Error Messages

1. "port is already allocated"

   - Check for other services using the same port
   - Restart Docker daemon

2. "no space left on device"

   - Free up disk space
   - Prune unused Docker resources

3. "permission denied"
   - Check file permissions on volume mounts
   - Verify container is running with correct user/group ID

If you encounter persistent issues, consider joining the AdGuard community forums or opening an issue on the GitHub repository.
