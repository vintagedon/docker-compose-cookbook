# Performance Tuning Guide for Ansible AWX

This document provides guidelines and best practices for optimizing the performance of your Ansible AWX Docker setup.

## Hardware Recommendations

- CPU: 4+ cores
- RAM: 16GB+ (32GB+ recommended for larger environments)
- Storage: SSD for optimal database performance

## Docker Configuration

1. Increase Docker's memory limit:

   ```
   docker-compose up -d --scale web=2 --scale task=2
   ```

2. Use Docker's `--cpus` and `--memory` flags to limit resource usage:
   ```yaml
   services:
     web:
       deploy:
         resources:
           limits:
             cpus: "2"
             memory: 4G
   ```

## Database Optimization

1. Increase PostgreSQL's shared buffers:

   ```
   shared_buffers = 256MB  # Adjust based on available RAM
   ```

2. Optimize PostgreSQL for write-heavy workloads:

   ```
   synchronous_commit = off
   wal_writer_delay = 10000ms
   ```

3. Regularly vacuum and analyze the database:
   ```
   VACUUM ANALYZE;
   ```

## Redis Configuration

1. Increase Redis's maxmemory:

   ```
   maxmemory 1gb
   ```

2. Set an appropriate eviction policy:
   ```
   maxmemory-policy allkeys-lru
   ```

## AWX Configuration

1. Adjust the number of task workers:

   ```
   AWX_TASK_WORKERS=5  # Adjust based on CPU cores
   ```

2. Optimize job output collection:

   ```
   AWX_STDOUT_MAX_BYTES_DISPLAY=1048576
   ```

3. Enable job fact caching:
   ```
   AWX_FACTS_ENABLED=True
   ```

## Network Optimization

1. Use a content delivery network (CDN) for static assets.
2. Enable HTTP/2 on your reverse proxy or load balancer.
3. Implement proper caching headers for static content.

## Monitoring and Logging

1. Use Prometheus and Grafana for monitoring AWX performance.
2. Implement log rotation to prevent disk space issues.
3. Use ELK stack (Elasticsearch, Logstash, Kibana) for log analysis.

## Job Performance

1. Use fact caching to speed up playbook execution.
2. Implement and use custom credentials to reduce external API calls.
3. Use the `async` and `poll` features in Ansible for long-running tasks.

## Scaling Considerations

1. Implement a multi-node setup for increased capacity (refer to MULTI_NODE_SETUP.md).
2. Use separate nodes for web and task services.
3. Implement database replication for read-heavy workloads.

## Regular Maintenance

1. Keep AWX and its dependencies updated to the latest stable versions.
2. Regularly clean up old job data and archived files.
3. Monitor and adjust system resources based on usage patterns.

Remember to test thoroughly in a staging environment before applying any performance optimizations to your production setup. Performance tuning is an iterative process, so monitor your system closely and adjust as needed.

For more detailed information on performance tuning, refer to the [official Ansible AWX documentation](https://docs.ansible.com/ansible-tower/).
