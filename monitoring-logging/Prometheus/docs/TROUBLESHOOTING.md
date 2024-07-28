# Troubleshooting Guide for Prometheus Docker Setup

This document provides solutions for common issues you might encounter when running Prometheus in a Docker container.

## Table of Contents

- [Troubleshooting Guide for Prometheus Docker Setup](#troubleshooting-guide-for-prometheus-docker-setup)
  - [Table of Contents](#table-of-contents)
  - [Container Won't Start](#container-wont-start)
  - [Can't Access Prometheus Web UI](#cant-access-prometheus-web-ui)
  - [Prometheus Not Scraping Targets](#prometheus-not-scraping-targets)
  - [High Memory Usage](#high-memory-usage)
  - [Slow Query Performance](#slow-query-performance)
  - [Data Retention Issues](#data-retention-issues)

## Container Won't Start

If the Prometheus container fails to start:

1. Check Docker logs:

   ```
   docker logs prometheus
   ```

2. Verify the Prometheus configuration:

   ```
   docker run --rm -v /path/to/prometheus.yml:/etc/prometheus/prometheus.yml prom/prometheus:v2.30.3 promtool check config /etc/prometheus/prometheus.yml
   ```

3. Ensure all required ports are available and not used by other services.

## Can't Access Prometheus Web UI

If you can't access the Prometheus web interface:

1. Check if the container is running:

   ```
   docker ps | grep prometheus
   ```

2. Verify the port mapping in your `docker-compose.yml`:

   ```yaml
   ports:
     - "9090:9090"
   ```

3. Check your firewall settings to ensure the Prometheus port is open.

## Prometheus Not Scraping Targets

If Prometheus isn't scraping targets:

1. Check the Prometheus UI's "Targets" page for errors.

2. Verify your `prometheus.yml` configuration, especially the `scrape_configs` section.

3. Ensure target services are reachable from the Prometheus container. You may need to adjust your Docker network settings.

## High Memory Usage

If Prometheus is using too much memory:

1. Check the number of time series:

   ```
   curl http://localhost:9090/api/v1/status/tsdb
   ```

2. Reduce the number of metrics or decrease the retention period:

   ```yaml
   --storage.tsdb.retention.time=15d
   ```

3. Increase the available memory in your `docker-compose.yml`:
   ```yaml
   deploy:
     resources:
       limits:
         memory: 2G
   ```

## Slow Query Performance

For slow query performance:

1. Use the query log to identify slow queries:

   ```yaml
   --query.log-queries-longer-than=10s
   ```

2. Optimize your PromQL queries, avoiding high-cardinality labels.

3. Use recording rules for complex, frequently-used queries.

## Data Retention Issues

If you're experiencing data retention issues:

1. Check your retention settings:

   ```yaml
   --storage.tsdb.retention.time=30d
   --storage.tsdb.retention.size=512GB
   ```

2. Verify available disk space:

   ```
   docker exec prometheus df -h /prometheus
   ```

3. Consider using remote storage for long-term data retention.

Remember to restart your Prometheus container after making configuration changes:

```
docker-compose down
docker-compose up -d
```

If issues persist, check the [official Prometheus documentation](https://prometheus.io/docs/prometheus/latest/troubleshooting/) or seek help from the community.
