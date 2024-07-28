# Performance Tuning for AdGuard Home Docker Setup

This guide provides tips and best practices for optimizing the performance of your AdGuard Home Docker setup.

## Hardware Recommendations

- CPU: 1+ cores
- RAM: 1GB+
- Storage: SSD recommended for faster query resolution

## Docker Configuration

1. Increase container memory limit:

   ```yaml
   services:
     adguardhome:
       deploy:
         resources:
           limits:
             memory: 2G
   ```

2. Use host networking mode for better DNS performance:
   ```yaml
   services:
     adguardhome:
       network_mode: "host"
   ```

## AdGuard Home Configuration

1. Optimize upstream DNS servers:

   - Use fast and reliable DNS providers
   - Consider using DNS-over-HTTPS or DNS-over-TLS for security

2. Enable caching:

   - Increase cache size for better performance
   - Adjust cache TTL based on your needs

3. Filtering optimization:

   - Use efficient filtering rules
   - Avoid overlapping or redundant rules
   - Regularly update and prune your filter lists

4. Enable persistent cache:

   - Helps reduce startup time and improves performance after restarts

5. Use optimized blocking mode:
   - Consider using "Null IP" blocking mode for faster response times

## System-level Tuning

1. Increase file descriptors limit:

   ```
   ulimit -n 65536
   ```

2. Optimize network stack:

   ```
   sysctl -w net.core.rmem_max=8388608
   sysctl -w net.core.wmem_max=8388608
   ```

3. Enable TCP BBR congestion control:
   ```
   sysctl -w net.core.default_qdisc=fq
   sysctl -w net.ipv4.tcp_congestion_control=bbr
   ```

## Monitoring and Profiling

1. Enable query logging for performance analysis
2. Use Docker stats to monitor resource usage:
   ```
   docker stats adguardhome
   ```
3. Consider using external monitoring tools like Prometheus and Grafana

Remember to test thoroughly after making changes and monitor the impact on your specific setup.
