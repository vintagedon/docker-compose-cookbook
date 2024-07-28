# Performance Tuning Guide for Neo4j Docker Setup

This guide provides recommendations for optimizing the performance of your Neo4j Docker instance.

## Table of Contents

- [Performance Tuning Guide for Neo4j Docker Setup](#performance-tuning-guide-for-neo4j-docker-setup)
  - [Table of Contents](#table-of-contents)
  - [Memory Configuration](#memory-configuration)
  - [Cache Tuning](#cache-tuning)
  - [Query Optimization](#query-optimization)
  - [Index Usage](#index-usage)
  - [Hardware Considerations](#hardware-considerations)
  - [Docker-Specific Optimizations](#docker-specific-optimizations)
  - [Monitoring and Profiling](#monitoring-and-profiling)

## Memory Configuration

Proper memory allocation is crucial for Neo4j performance:

- Heap Memory: Set initial and max heap sizes based on your data size and query complexity.

  ```
  NEO4J_dbms_memory_heap_initial__size=1G
  NEO4J_dbms_memory_heap_max__size=4G
  ```

- Page Cache: Allocate enough memory to keep your entire graph in memory if possible.
  ```
  NEO4J_dbms_memory_pagecache_size=4G
  ```

## Cache Tuning

- Adjust cache sizes based on your workload:
  ```
  NEO4J_dbms_query_cache_size=64m
  NEO4J_dbms_memory_off_heap_max__size=2G
  ```

## Query Optimization

- Use EXPLAIN and PROFILE to analyze query performance.
- Optimize complex queries by breaking them down or using more efficient patterns.
- Utilize Cypher query hints for better performance.

## Index Usage

- Create indexes on properties used frequently in WHERE clauses:
  ```
  CREATE INDEX ON :Label(property)
  ```
- Use composite indexes for multi-property queries:
  ```
  CREATE INDEX ON :Label(property1, property2)
  ```

## Hardware Considerations

- Use SSDs for better I/O performance.
- Ensure sufficient CPU cores for concurrent operations.
- Consider using a dedicated server for production deployments.

## Docker-Specific Optimizations

- Use volume mounts for data persistence to avoid storage driver overhead.
- Allocate sufficient CPU shares and memory limits:
  ```yaml
  services:
    neo4j:
      deploy:
        resources:
          limits:
            cpus: "4"
            memory: 8G
  ```

## Monitoring and Profiling

- Enable Neo4j metrics:
  ```
  NEO4J_metrics_enabled=true
  NEO4J_metrics_jmx_enabled=true
  ```
- Use tools like `neo4j-admin memrec` to get memory configuration recommendations.
- Monitor query logs to identify slow-running queries:
  ```
  NEO4J_dbms_logs_query_enabled=true
  NEO4J_dbms_logs_query_threshold=5s
  ```

Remember, performance tuning is an iterative process. Monitor your system's performance regularly and adjust settings as your data and usage patterns evolve.

For more detailed performance tuning options, refer to the [official Neo4j performance tuning documentation](https://neo4j.com/docs/operations-manual/current/performance/).
