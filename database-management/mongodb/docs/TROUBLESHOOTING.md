# MongoDB Troubleshooting Guide

This guide provides solutions to common issues you might encounter with your MongoDB Docker setup.

## 1. Connection Issues

### Problem: Can't connect to MongoDB

1. Check if the container is running:

   ```
   docker ps
   ```

2. Verify the port mapping:

   ```
   docker-compose ps
   ```

3. Ensure MongoDB is listening on the correct interface:

   ```
   docker exec -it mongodb mongosh --eval "db.runCommand({ connectionStatus: 1 })"
   ```

4. Check logs for any errors:
   ```
   docker logs mongodb
   ```

## 2. Authentication Issues

### Problem: Authentication failed

1. Verify you're using the correct credentials

2. Check if authentication is enabled:

   ```
   docker exec -it mongodb mongosh --eval "db.runCommand({ getParameter: 1, auth: 1 })"
   ```

3. If you've lost access, you can disable authentication temporarily:
   ```yaml
   command: mongod --noauth
   ```
   Then, recreate your users.

## 3. Performance Issues

### Problem: Slow queries

1. Check system resources:

   ```
   docker stats mongodb
   ```

2. Use explain to analyze query performance:

   ```javascript
   db.collection.find().explain("executionStats");
   ```

3. Check for missing indexes:

   ```javascript
   db.collection.getIndexes();
   ```

4. Monitor for slow queries:
   ```javascript
   db.setProfilingLevel(1, { slowms: 100 });
   ```

## 4. Disk Space Issues

### Problem: Running out of disk space

1. Check current disk usage:

   ```
   docker exec -it mongodb df -h
   ```

2. Compact databases:

   ```javascript
   db.runCommand({ compact: "collection_name" });
   ```

3. Remove old logs and temporary files

## 5. Replication Issues

### Problem: Replication lag

1. Check replica set status:

   ```javascript
   rs.status();
   ```

2. Verify network connectivity between members

3. Check for resource constraints on secondary members

## 6. Backup and Restore Issues

### Problem: Backup or restore failing

1. Ensure sufficient disk space for the operation

2. Check permissions on backup directory

3. For point-in-time recovery, ensure you have oplogs covering the desired period

## 7. Update and Upgrade Issues

### Problem: Errors after updating MongoDB version

1. Check compatibility of your drivers and tools with the new version

2. Review the changelog for breaking changes

3. Consider rolling back to the previous version if issues persist

## 8. Docker-specific Issues

### Problem: Container stops unexpectedly

1. Check Docker logs:

   ```
   docker logs mongodb
   ```

2. Verify resource limits in docker-compose.yml

3. Ensure the host system has sufficient resources

## 9. Data Corruption

### Problem: Unexpected data loss or corruption

1. Check MongoDB logs for any errors during write operations

2. Verify the integrity of your data files:

   ```
   docker exec -it mongodb mongod --dbpath /data/db --repair
   ```

3. Restore from a recent backup if necessary

## 10. Configuration Issues

### Problem: MongoDB not using custom configuration

1. Verify the configuration file is correctly mounted:

   ```yaml
   volumes:
     - ./mongod.conf:/etc/mongod.conf
   ```

2. Ensure the command in docker-compose.yml includes the config file:
   ```yaml
   command: mongod --config /etc/mongod.conf
   ```

Remember, for persistent or complex issues, consulting the [official MongoDB documentation](https://docs.mongodb.com/manual/troubleshooting/) or seeking support from the MongoDB community may be necessary.
