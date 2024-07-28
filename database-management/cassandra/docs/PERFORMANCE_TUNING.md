# Cassandra Performance Tuning Guide

This guide provides recommendations for tuning your Cassandra Docker setup for optimal performance.

## Hardware Considerations

- RAM: Cassandra is memory-intensive. Allocate at least 4GB per node, preferably 8GB or more for production.
- CPU: More cores generally mean better performance. Aim for at least 4 cores per node.
- Disk: SSDs are strongly recommended for optimal performance, especially for write-heavy workloads.
- Network: Use high-bandwidth, low-latency connections between nodes.

## JVM Tuning

Adjust the following environment variables in your `docker-compose.yml`:

```yaml
environment:
  - MAX_HEAP_SIZE=4G
  - HEAP_NEWSIZE=800M
```

Adjust these values based on your available RAM. A good rule of thumb is:

- Set `MAX_HEAP_SIZE` to 1/4 of your total RAM, but no more than 8GB.
- Set `HEAP_NEWSIZE` to 1/4 of `MAX_HEAP_SIZE`.

## Cassandra Configuration

Create a custom `cassandra.yaml` file and mount it in your Docker container. Here are some key settings to consider:

1. Concurrent Operations:

   ```yaml
   concurrent_reads: 32
   concurrent_writes: 32
   concurrent_counter_writes: 32
   ```

   Adjust these based on your CPU cores (usually 16 \* num_cores).

2. Compaction:

   ```yaml
   compaction_throughput_mb_per_sec: 16
   ```

   Increase this for faster compactions, but be aware it may impact ongoing operations.

3. Memtable Settings:

   ```yaml
   memtable_heap_space_in_mb: 2048
   memtable_offheap_space_in_mb: 2048
   ```

   Adjust these based on your write patterns and available memory.

4. Caching:
   ```yaml
   row_cache_size_in_mb: 0
   ```
   Enable row cache only if you have a read-heavy workload with a working set smaller than available memory.

## Operating System Tuning

1. Disable swap:

   ```
   sudo swapoff -a
   ```

2. Increase the number of memory map areas:

   ```
   sudo sysctl -w vm.max_map_count=1048575
   ```

3. Increase the limits on open file descriptors:
   ```
   ulimit -n 100000
   ```

Include these settings in your Docker run command or docker-compose file.

## Monitoring and Benchmarking

Use the following tools to monitor and benchmark your Cassandra cluster:

1. nodetool:

   ```
   docker exec -it cassandra nodetool status
   docker exec -it cassandra nodetool tablehistograms keyspace table
   ```

2. Cassandra Stress Tool:

   ```
   docker exec -it cassandra cassandra-stress write n=1000000 -rate threads=50
   ```

3. JConsole or VisualVM for JVM monitoring.

4. Prometheus and Grafana for long-term performance monitoring.

## Data Model Optimization

- Use appropriate partition keys to distribute data evenly across the cluster.
- Avoid large partitions (keep them under 100MB).
- Use clustering columns wisely to minimize the amount of data read for each query.
- Consider using materialized views or secondary indexes for complex query patterns.

## Network Optimization

- Use the GossipingPropertyFileSnitch for multi-datacenter deployments.
- Ensure all nodes can communicate on ports 7000, 7001, 7199, and 9042.
- Consider using a dedicated network for inter-node communication.

Remember, performance tuning is an iterative process. Monitor your cluster's performance, make incremental changes, and re-evaluate. Always test thoroughly in a staging environment before applying changes to production.

For more detailed information, refer to the official Apache Cassandra documentation on performance tuning.
