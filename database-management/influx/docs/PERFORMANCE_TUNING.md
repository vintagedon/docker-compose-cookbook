# InfluxDB Performance Tuning Guide

This guide provides recommendations for optimizing the performance of your InfluxDB Docker setup. Always test these settings in a non-production environment before applying them to your production system.

## Hardware Recommendations

- CPU: 2-4+ cores for small/medium installations, 8-16+ cores for large installations
- Memory: 2-4GB for small installations, 8-16GB+ for medium/large installations
- Storage: SSD or high-performance HDD, with enough space for your data and future growth

## Docker Resource Allocation

Ensure your Docker container has access to sufficient resources:

1. Update your `docker-compose.yml` file to include resource limits:

```yaml
services:
  influxdb:
    # ... other configurations ...
    deploy:
      resources:
        limits:
          cpus: "4"
          memory: 8G
        reservations:
          cpus: "2"
          memory: 4G
```

2. Adjust these values based on your available resources and requirements.

## InfluxDB Configuration Tuning

Add the following environment variables to your `.env` file to tune InfluxDB performance:

```
# Cache Configuration
INFLUXDB_CACHE_MAX_MEMORY_SIZE=1073741824  # 1GB
INFLUXDB_CACHE_SNAPSHOT_MEMORY_SIZE=26214400  # 25MB
INFLUXDB_CACHE_SNAPSHOT_WRITE_COLD_DURATION=10m

# Compaction Configuration
INFLUXDB_COMPACT_FULL_WRITE_COLD_DURATION=4h
INFLUXDB_COMPACT_THROUGHPUT=48_000_000  # 48MB/s
INFLUXDB_COMPACT_THROUGHPUT_BURST=48_000_000  # 48MB/s

# Query Configuration
INFLUXDB_QUERY_CONCURRENCY=10
INFLUXDB_QUERY_QUEUE_SIZE=100000
```

Adjust these values based on your specific use case and available resources.

## Write Performance Optimization

1. Use batch writes instead of single-point writes when possible.
2. Consider using the line protocol for data ingestion, as it's more efficient than other formats.
3. Use appropriate timestamp precision to reduce unnecessary storage.

## Query Performance Optimization

1. Use time ranges in your queries to limit the amount of data scanned.
2. Create and use appropriate indexes for frequently queried tags.
3. Use `GROUP BY time()` with an appropriate interval to reduce the number of points processed.

## Monitoring and Profiling

1. Enable InfluxDB's built-in monitoring:

Add the following to your `docker-compose.yml` file:

```yaml
services:
  influxdb:
    # ... other configurations ...
    environment:
      - INFLUXDB_MONITOR_STORE_ENABLED=true
```

2. Use the InfluxDB UI or API to monitor key metrics like write throughput, query performance, and memory usage.

3. For more detailed profiling, consider using tools like `pprof` or `perf` inside the Docker container.

## Regular Maintenance

1. Implement a data retention policy to automatically delete old data.
2. Regularly run compactions to optimize data storage.
3. Monitor and manage shard groups to ensure optimal query performance.

## Networking Considerations

1. If InfluxDB is running on a separate host, ensure network latency is minimized.
2. Consider using a dedicated network for InfluxDB traffic in multi-container setups.

Remember to always test performance optimizations in a staging environment before applying them to production. Monitor your system closely after making changes to ensure they have the desired effect.

For more detailed information on InfluxDB performance tuning, please refer to the [official InfluxDB documentation](https://docs.influxdata.com/influxdb/v2.7/write-data/best-practices/optimize-writes/).
