# Cassandra Troubleshooting Guide

This guide covers common issues you might encounter with your Cassandra Docker setup and how to resolve them.

## Connection Issues

### Cannot connect to Cassandra

1. Check if the container is running:

   ```
   docker ps
   ```

2. Verify the exposed ports:

   ```
   docker port cassandra
   ```

3. Check Cassandra logs:

   ```
   docker logs cassandra
   ```

4. Ensure your client is connecting to the correct IP and port.

### Node is not joining the cluster

1. Check if the seeds are correctly configured in `cassandra.yaml`.
2. Verify that the cluster name is consistent across all nodes.
3. Ensure that the Gossip port (7000) is open between nodes.

## Performance Issues

### Slow queries

1. Use `nodetool tablestats` to check table statistics.
2. Analyze your data model for potential anti-patterns.
3. Check if you need to add or update indexes.

### High CPU usage

1. Use `nodetool tpstats` to check thread pool statistics.
2. Consider increasing the number of cores allocated to the container.
3. Optimize your queries and data model.

### High memory usage

1. Check JVM heap usage with `nodetool info`.
2. Adjust `MAX_HEAP_SIZE` and `HEAP_NEWSIZE` in your Docker environment.
3. Consider adding more RAM to your host or using a larger instance.

## Data Issues

### Data inconsistency

1. Run `nodetool repair` to fix inconsistencies.
2. Check your consistency level settings.
3. Ensure all nodes are up and communicating correctly.

### Disk space running out

1. Check disk usage with `nodetool status`.
2. Run `nodetool clearsnapshot` to remove old snapshots.
3. Consider adding more storage or cleaning up unnecessary data.

## Startup Issues

### Container exits immediately

1. Check Docker logs:
   ```
   docker logs cassandra
   ```
2. Ensure you have enough system resources (CPU, RAM, Disk).
3. Verify your `cassandra.yaml` configuration.

### Cassandra process not starting

1. Check Cassandra logs in `/var/log/cassandra/system.log` inside the container.
2. Verify JVM settings and system resource limits.

## Upgrade Issues

### Data loss after upgrade

1. Ensure you followed the correct upgrade path.
2. Check if you need to run `nodetool upgradesstables`.
3. Restore from a backup if necessary.

### Incompatible schema

1. Check for any schema changes required for the new version.
2. Use `cqlsh` to manually update the schema if needed.

## Common Docker-specific Issues

### Volume permissions

If you're using bind mounts and encounter permission issues:

1. Ensure the host directory has the correct permissions.
2. Consider using named volumes instead of bind mounts.

### Network conflicts

If you're having issues with Docker networking:

1. Check for conflicts in your Docker network configuration.
2. Try creating a new Docker network for your Cassandra cluster.

## Diagnostic Commands

Here are some useful diagnostic commands:

```bash
# Check cluster status
docker exec -it cassandra nodetool status

# Check system log
docker exec -it cassandra cat /var/log/cassandra/system.log

# Run cqlsh
docker exec -it cassandra cqlsh

# Check table statistics
docker exec -it cassandra nodetool tablestats keyspace_name table_name

# Check thread pool statistics
docker exec -it cassandra nodetool tpstats

# Run a repair
docker exec -it cassandra nodetool repair

# Flush memtables to SSTables
docker exec -it cassandra nodetool flush

# Compact SSTables
docker exec -it cassandra nodetool compact
```

If you're still encountering issues after trying these solutions, consider seeking help from the Cassandra community forums or consulting the official Apache Cassandra documentation.
