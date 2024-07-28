# Performance Tuning Guide for Rundeck

This guide provides recommendations for optimizing the performance of your Rundeck Docker setup.

## JVM Tuning

Adjust JVM settings in the `docker-compose.yml` file:

```yaml
services:
  rundeck:
    environment:
      - RUNDECK_JVM_OPTS=-Xmx4096m -Xms2048m -XX:MaxMetaspaceSize=512m
```

Adjust these values based on your available resources and workload.

## Database Optimization

1. Increase the connection pool size:

   ```properties
   dataSource.properties.maxActive=50
   dataSource.properties.minIdle=2
   dataSource.properties.maxIdle=10
   ```

2. Enable prepared statement caching:

   ```properties
   dataSource.properties.poolPreparedStatements=true
   dataSource.properties.maxOpenPreparedStatements=100
   ```

3. Optimize MariaDB settings in `docker-compose.yml`:
   ```yaml
   services:
     db:
       command:
         - --innodb-buffer-pool-size=1G
         - --query-cache-size=32M
         - --query-cache-limit=2M
   ```

## Rundeck Configuration

1. Increase the number of quartz threads:

   ```properties
   quartz.threadPool.threadCount=20
   ```

2. Adjust logging levels:

   ```properties
   rundeck.logging.strategy.logger.org.rundeck.level=INFO
   ```

3. Enable job threading:
   ```properties
   rundeck.feature.jobThreadsEnabled=true
   rundeck.jobs.threads=10
   ```

## Caching

Enable Rundeck's built-in caching:

```properties
rundeck.config.storage.converter.1.type=jasypt-encryption
rundeck.config.storage.converter.1.config.encryptorType=custom
rundeck.config.storage.converter.1.config.password=sekrit
rundeck.config.storage.converter.1.config.algorithm=PBEWITHSHA256AND128BITAES-CBC-BC
rundeck.config.storage.converter.1.config.provider=BC
```

## Execution History Clean-up

Set up regular clean-up of old execution history:

```properties
rundeck.execution.history.cleanup.batch=500
rundeck.execution.history.cleanup.retention.days=60
rundeck.execution.history.cleanup.enabled=true
```

## Monitoring

Use tools like Prometheus and Grafana to monitor Rundeck's performance:

1. Enable Rundeck's built-in Prometheus support:

   ```properties
   rundeck.metrics.enabled=true
   rundeck.metrics.prometheus.enabled=true
   ```

2. Set up Prometheus to scrape Rundeck's metrics endpoint.

3. Create Grafana dashboards to visualize Rundeck's performance metrics.

## Hardware Considerations

- Use SSDs for the database and Rundeck's file storage.
- Ensure sufficient CPU and RAM for your workload.
- Consider using a CDN for serving static assets in production environments.

Remember to test thoroughly after making any performance tuning changes, and adjust based on your specific use case and workload.
