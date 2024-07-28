# Performance Tuning for Prometheus

This document provides guidance on optimizing Prometheus performance, including storage tuning, query optimization, and resource allocation.

## Table of Contents

- [Performance Tuning for Prometheus](#performance-tuning-for-prometheus)
  - [Table of Contents](#table-of-contents)
  - [Storage Optimization](#storage-optimization)
  - [Query Optimization](#query-optimization)
  - [Resource Allocation](#resource-allocation)
  - [Cardinality](#cardinality)
  - [Scrape Interval and Retention](#scrape-interval-and-retention)
  - [Remote Storage](#remote-storage)

## Storage Optimization

Prometheus uses a time-series database (TSDB) for storage. To optimize storage:

1. Use `--storage.tsdb.retention.time` to set the retention period. For example:

   ```
   --storage.tsdb.retention.time=15d
   ```

2. Use `--storage.tsdb.retention.size` to limit the total size of storage. For example:

   ```
   --storage.tsdb.retention.size=512GB
   ```

3. Consider using compression. Prometheus uses Snappy compression by default.

## Query Optimization

To optimize queries:

1. Use specific selectors instead of broad ones.
2. Avoid using regular expressions in queries when possible.
3. Use `rate()` instead of `irate()` for most cases.
4. Use recording rules for frequently used or complex queries.

Example of a recording rule:

```yaml
groups:
  - name: example
    rules:
      - record: job:http_inprogress_requests:sum
        expr: sum(http_inprogress_requests) by (job)
```

## Resource Allocation

Prometheus can be resource-intensive. Consider the following:

1. CPU: Prometheus is multi-threaded. Allocate multiple CPU cores for better performance.
2. Memory: Prometheus keeps a lot of data in memory. Allocate enough RAM based on your data volume.
3. Disk I/O: Use SSDs for better performance, especially for write-ahead logs and the TSDB.

## Cardinality

High cardinality can severely impact Prometheus performance. To manage cardinality:

1. Avoid using high-cardinality labels like email addresses or user IDs.
2. Use label values with low cardinality (e.g., environment, datacenter).
3. Use recording rules to aggregate high-cardinality data.

## Scrape Interval and Retention

Balance between data granularity and resource usage:

1. Set appropriate scrape intervals. Default is 15s, but you might not need such frequent updates for all metrics.
2. Adjust retention period based on your needs and available resources.

## Remote Storage

For long-term storage or to handle large volumes of data, consider using remote storage:

1. Use `remote_write` to send data to long-term storage systems.
2. Use `remote_read` to query data from these systems.

Example configuration:

```yaml
remote_write:
  - url: "http://remote-storage-host:port/api/v1/write"

remote_read:
  - url: "http://remote-storage-host:port/api/v1/read"
```

Remember to monitor Prometheus itself and adjust these settings based on your specific use case and requirements.
