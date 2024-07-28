# Performance Tuning Guide for Pi-hole Docker Setup

This document provides tips and best practices for optimizing the performance of your Pi-hole installation running in Docker.

## Table of Contents

- [Performance Tuning Guide for Pi-hole Docker Setup](#performance-tuning-guide-for-pi-hole-docker-setup)
  - [Table of Contents](#table-of-contents)
  - [Hardware Considerations](#hardware-considerations)
  - [Docker Configuration](#docker-configuration)
  - [Pi-hole Specific Optimizations](#pi-hole-specific-optimizations)
  - [Network Optimizations](#network-optimizations)
  - [Monitoring and Benchmarking](#monitoring-and-benchmarking)

## Hardware Considerations

1. **CPU**:

   - Pi-hole is generally not CPU-intensive, but a multi-core processor can help with concurrent requests.
   - Recommended: 2+ cores for smooth operation.

2. **RAM**:

   - Minimum: 512MB
   - Recommended: 1GB or more for larger networks or when using extensive blocklists.

3. **Storage**:
   - Type: SSD preferred for faster read/write operations.
   - Capacity: 4GB minimum, 16GB+ recommended for long-term logging.

## Docker Configuration

1. **Resource Limits**:

   - Set appropriate CPU and memory limits in `docker-compose.yml`:
     ```yaml
     services:
       pihole:
         ...
         deploy:
           resources:
             limits:
               cpus: '0.5'
               memory: 512M
     ```

2. **Storage Driver**:

   - Use overlay2 storage driver for better performance:
     ```
     $ docker info | grep "Storage Driver"
     Storage Driver: overlay2
     ```

3. **Network Mode**:
   - Use host network mode for better DNS performance:
     ```yaml
     services:
       pihole:
         ...
         network_mode: host
     ```

## Pi-hole Specific Optimizations

1. **Blocklist Optimization**:

   - Use fewer, well-maintained blocklists instead of many small lists.
   - Regularly update blocklists (`pihole -g`).

2. **Database Optimization**:

   - Periodically vacuum the Pi-hole database:
     ```
     $ docker exec pihole pihole -f
     ```

3. **DNS Cache**:

   - Increase DNS cache size in `/etc/dnsmasq.d/01-pihole.conf`:
     ```
     cache-size=10000
     ```

4. **Query Logging**:
   - Disable query logging if not needed for improved performance:
     ```
     $ docker exec pihole pihole logging off
     ```

## Network Optimizations

1. **Use a Static IP**:

   - Ensure Pi-hole has a static IP to avoid DNS resolution delays.

2. **Upstream DNS Servers**:

   - Use fast, reliable upstream DNS servers.
   - Consider using DNS-over-HTTPS for improved security and potentially better performance.

3. **Network Interface**:
   - If possible, use a wired Ethernet connection for more stable performance.

## Monitoring and Benchmarking

1. **Resource Monitoring**:

   - Use tools like `docker stats` or Prometheus with Grafana for monitoring resource usage.

2. **DNS Benchmarking**:

   - Use tools like `dig` or `dnsbench` to measure DNS query times:
     ```
     $ dig @pi.hole example.com
     ```

3. **Performance Testing**:
   - Periodically run performance tests to ensure optimal operation:
     ```
     $ for i in {1..100}; do dig @pi.hole example.com > /dev/null; done
     ```

Remember to test thoroughly after making any changes and to monitor performance over time to ensure your optimizations are effective.
