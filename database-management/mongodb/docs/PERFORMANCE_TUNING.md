## Sharding

For very large datasets or high-throughput applications, consider implementing sharding:

1. Plan your shard key carefully based on your data distribution and access patterns
2. Use hashed shard keys for more even data distribution
3. Implement zone sharding for data locality

Refer to the [MULTI_NODE_SETUP.md](MULTI_NODE_SETUP.md) file for instructions on setting up a sharded cluster.

## Read/Write Concerns

Adjust read and write concerns based on your application's needs:

- For higher throughput: Use `w: 1` (acknowledge writes when received by the primary)
- For higher data safety: Use `w: "majority"` (acknowledge writes when received by a majority of replica set members)

Example in your application code:

```javascript
db.collection.insertOne(
  { data: "example" },
  { writeConcern: { w: "majority" } }
);
```

## Aggregation Pipeline Optimization

1. Use `$match` and `$limit` stages early in the pipeline to reduce the amount of data processed
2. Use indexes to support your aggregation pipeline stages
3. Use `allowDiskUse: true` for large datasets that exceed the 100MB memory limit

Example:

```javascript
db.collection.aggregate(
  [
    { $match: { status: "active" } },
    { $group: { _id: "$category", count: { $sum: 1 } } },
  ],
  { allowDiskUse: true }
);
```

## Compression

Enable compression to reduce storage requirements and I/O operations:

```yaml
command: mongod --wiredTigerCollectionBlockCompressor zlib
```

## Network Optimization

1. Use connection pooling in your application
2. Enable TCP keepalive:

```yaml
command: mongod --tcpKeepAliveTime 300
```

## Regular Maintenance

1. Compact your database regularly:

```javascript
db.runCommand({ compact: "collection_name" });
```

2. Repair the database if necessary (requires downtime):

```bash
mongod --repair
```

3. Update indexes periodically:

```javascript
db.collection.reIndex();
```

## Monitoring Tools

Utilize monitoring tools to track performance metrics:

1. MongoDB Compass: GUI tool for query optimization and performance monitoring
2. MongoDB Cloud Manager: Comprehensive monitoring and automation platform
3. Prometheus with MongoDB exporter: For custom metrics collection

## Docker-specific Optimizations

1. Use Docker volumes for data persistence instead of bind mounts
2. Disable Docker's default logging mechanism if not needed:

```yaml
logging:
  driver: "none"
```

3. Use Docker's `host` network mode for better performance (note: this reduces container isolation):

```yaml
network_mode: "host"
```

## Benchmarking

Regularly benchmark your MongoDB performance:

1. Use `mongoperf` for I/O performance testing
2. Implement custom benchmarks that simulate your workload

Example `mongoperf` command:

```bash
echo '{nThreads:16,fileSizeMB:1000,r:true,w:true}' | mongoperf
```

Remember, performance tuning is an iterative process. Always measure the impact of your changes and adjust accordingly. For more detailed performance tuning options, refer to the [official MongoDB performance tuning documentation](https://docs.mongodb.com/manual/administration/analyzing-mongodb-performance/).
