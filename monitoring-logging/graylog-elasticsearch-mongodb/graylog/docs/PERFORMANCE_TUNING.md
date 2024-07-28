# Performance Tuning Guide for Graylog Docker Setup

This document provides guidance on optimizing the performance of your Graylog Docker setup.

## Table of Contents

1. [System Requirements](#system-requirements)
2. [Graylog Optimization](#graylog-optimization)
3. [Elasticsearch Optimization](#elasticsearch-optimization)
4. [MongoDB Optimization](#mongodb-optimization)
5. [Docker Optimization](#docker-optimization)
6. [Monitoring and Profiling](#monitoring-and-profiling)

## System Requirements

Minimum recommended specifications for a production environment:

- CPU: 4 cores
- RAM: 8GB
- Storage: SSD with at least 100GB free space

## Graylog Optimization

### Java Heap Size

Adjust the Java heap size based on your available memory. In `docker-compose.yml`:

```yaml
environment:
  GRAYLOG_JAVA_OPTS: "-Xms2g -Xmx4g"
```

### Message Processing

Tune message processing settings in `graylog.conf`:

```
processbuffer_processors = 5
outputbuffer_processors = 3
processor_wait_strategy = blocking
ring_size = 65536
```

### Indexing

Optimize indexing settings:

```
output_batch_size = 5000
output_flush_interval = 1
output_fault_count_threshold = 5
output_fault_penalty_seconds = 30
```

## Elasticsearch Optimization

### Memory Settings

Adjust JVM heap size in `docker-compose.yml`:

```yaml
environment:
  ES_JAVA_OPTS: "-Xms2g -Xmx2g"
```

### Indexing Performance

Optimize indexing in `elasticsearch.yml`:

```yaml
index.refresh_interval: 5s
index.translog.durability: async
index.translog.sync_interval: 5s
```

### Shard Allocation

Control shard allocation:

```yaml
cluster.routing.allocation.disk.threshold_enabled: true
cluster.routing.allocation.disk.watermark.low: 85%
cluster.routing.allocation.disk.watermark.high: 90%
```

## MongoDB Optimization

### Write Concern

Adjust write concern for better performance:

```
GRAYLOG_MONGODB_URI=mongodb://mongo:27017/graylog?w=1
```

### Index Creation

Ensure proper indexes are created:

```javascript
db.messages.createIndex({ timestamp: 1, stream_id: 1 });
db.messages.createIndex({ source: 1 });
```

## Docker Optimization

### Storage Driver

Use overlay2 storage driver for better performance:

```json
{
  "storage-driver": "overlay2"
}
```

### Network

Use host network mode for better performance:

```yaml
network_mode: host
```

## Monitoring and Profiling

### Graylog Metrics

Enable Graylog's built-in metrics:

```
metrics_enabled = true
```

### Elasticsearch Monitoring

Enable Elasticsearch's monitoring features:

```yaml
xpack.monitoring.enabled: true
```

### Docker Stats

Use Docker's built-in stats command:

```bash
docker stats
```

Remember to test thoroughly after making any performance optimizations. Monitor your system closely to ensure changes have the desired effect without introducing instability.
