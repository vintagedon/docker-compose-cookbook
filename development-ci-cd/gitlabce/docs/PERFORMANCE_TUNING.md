# Performance Tuning for GitLab CE Docker Setup

This document provides guidelines and best practices for optimizing the performance of your GitLab CE Docker installation.

## Table of Contents

- [Performance Tuning for GitLab CE Docker Setup](#performance-tuning-for-gitlab-ce-docker-setup)
  - [Table of Contents](#table-of-contents)
  - [System Requirements](#system-requirements)
  - [Docker Resource Allocation](#docker-resource-allocation)
  - [GitLab Configuration Optimization](#gitlab-configuration-optimization)
  - [Database Optimization](#database-optimization)
  - [Redis Optimization](#redis-optimization)
  - [Nginx Configuration](#nginx-configuration)
  - [Sidekiq Optimization](#sidekiq-optimization)
  - [Monitoring and Profiling](#monitoring-and-profiling)

## System Requirements

Ensure your host system meets or exceeds these recommended specifications:

- CPU: At least 4 cores
- RAM: Minimum 8GB, recommended 16GB or more
- Storage: SSD with at least 50GB free space

## Docker Resource Allocation

Properly allocate resources to your GitLab container:

1. CPU: Allocate at least 2 CPUs to the GitLab container.

   ```yaml
   services:
     gitlab:
       cpus: 2
   ```

2. Memory: Allocate at least 8GB of RAM.

   ```yaml
   services:
     gitlab:
       mem_limit: 8g
   ```

3. Swap: Disable swap for the container to prevent unpredictable performance.
   ```yaml
   services:
     gitlab:
       mem_swappiness: 0
   ```

## GitLab Configuration Optimization

Optimize GitLab's configuration in the `GITLAB_OMNIBUS_CONFIG`:

1. Adjust the number of worker processes:

   ```ruby
   unicorn['worker_processes'] = 3
   ```

2. Increase the number of database connections:

   ```ruby
   postgresql['max_connections'] = 200
   ```

3. Optimize Unicorn settings:
   ```ruby
   unicorn['worker_timeout'] = 60
   unicorn['sidekiq_cluster_worker_timeout'] = 60
   ```

## Database Optimization

1. Increase shared buffers:

   ```ruby
   postgresql['shared_buffers'] = "256MB"
   ```

2. Adjust work memory:

   ```ruby
   postgresql['work_mem'] = "16MB"
   ```

3. Optimize autovacuum:
   ```ruby
   postgresql['autovacuum_max_workers'] = 4
   postgresql['autovacuum_naptime'] = '15s'
   ```

## Redis Optimization

1. Increase max memory:

   ```ruby
   redis['maxmemory'] = '1gb'
   ```

2. Set maxmemory policy:
   ```ruby
   redis['maxmemory_policy'] = 'allkeys-lru'
   ```

## Nginx Configuration

1. Increase worker connections:

   ```ruby
   nginx['worker_connections'] = 2048
   ```

2. Enable gzip compression:
   ```ruby
   nginx['gzip_enabled'] = true
   ```

## Sidekiq Optimization

1. Adjust concurrency:

   ```ruby
   sidekiq['concurrency'] = 25
   ```

2. Split queues for better performance:
   ```ruby
   sidekiq['queue_groups'] = [
     "elastic_indexer,mailers,repository_check",
     "*"
   ]
   ```

## Monitoring and Profiling

1. Enable Prometheus monitoring:

   ```ruby
   prometheus['enable'] = true
   grafana['enable'] = true
   ```

2. Use GitLab's Performance Bar for admins:

   ```ruby
   gitlab_rails['monitoring_whitelist'] = ['127.0.0.1', '::1', '192.168.0.0/24']
   ```

3. Enable request profiling:
   ```ruby
   gitlab_rails['rack_attack_git_basic_auth'] = {
     'enabled' => true,
     'ip_whitelist' => ["127.0.0.1"]
   }
   ```

Remember to monitor your GitLab instance after making these changes and adjust as necessary. Performance tuning is an iterative process and may require fine-tuning based on your specific usage patterns and workload.

For more detailed information on performance tuning, refer to the [official GitLab documentation](https://docs.gitlab.com/ee/administration/high_availability/performance_tuning.html).
