# Cassandra Configuration Guide

This document provides detailed information on configuring your Cassandra Docker setup.

## Environment Variables

The following environment variables can be set in the `.env` file or passed directly to `docker-compose`:

- `CONTAINER_NAME`: Name of the Cassandra container (default: cassandra)
- `CASSANDRA_PORT`: Port to expose for CQL connections (default: 9042)
- `CASSANDRA_VERSION`: Cassandra version to use (default: latest)
- `CASSANDRA_CLUSTER_NAME`: Name of the Cassandra cluster (default: MyCluster)
- `CASSANDRA_ENDPOINT_SNITCH`: Endpoint snitch to use (default: SimpleSnitch)
- `CASSANDRA_DC`: Datacenter name (default: dc1)
- `MAX_HEAP_SIZE`: Maximum heap size for Cassandra JVM (default: 4G)
- `HEAP_NEWSIZE`: New generation heap size for Cassandra JVM (default: 800M)

## Advanced Configuration

For more advanced configurations, you can modify the `cassandra.yaml` file. To do this:

1. Create a custom `cassandra.yaml` file:

   ```
   docker run --rm cassandra:${CASSANDRA_VERSION:-latest} cat /etc/cassandra/cassandra.yaml > custom-cassandra.yaml
   ```

2. Modify the `custom-cassandra.yaml` file as needed.

3. Update the `docker-compose.yml` file to mount this custom configuration:
   ```yaml
   services:
     cassandra:
       # ... other configurations ...
       volumes:
         - ./custom-cassandra.yaml:/etc/cassandra/cassandra.yaml
         - cassandra_data:/var/lib/cassandra
   ```

## Common Configuration Options

### Changing the Authenticator

To enable password authentication, set the following in your custom `cassandra.yaml`:

```yaml
authenticator: PasswordAuthenticator
```

Then, create a superuser after starting Cassandra:

```
docker exec -it cassandra cqlsh -u cassandra -p cassandra
```

```sql
CREATE USER admin WITH PASSWORD 'adminpassword' SUPERUSER;
```

### Enabling SSL

To enable SSL, you need to:

1. Generate SSL certificates
2. Update the `cassandra.yaml` configuration
3. Mount the SSL certificates in the Docker container

Refer to the official Cassandra documentation for detailed steps on SSL configuration.

## Persistence Configuration

By default, Cassandra data is persisted in a Docker volume. You can change this behavior by modifying the `volumes` section in `docker-compose.yml`.

To use a named volume:

```yaml
volumes:
  - cassandra_named_data:/var/lib/cassandra
```

To use a bind mount:

```yaml
volumes:
  - ./cassandra_data:/var/lib/cassandra
```

## Network Configuration

By default, the Cassandra container is attached to a custom network named `cassandra_network`. You can modify this in the `docker-compose.yml` file if needed.

To expose additional ports, add them to the `ports` section in `docker-compose.yml`:

```yaml
ports:
  - "9042:9042"
  - "7000:7000"
  - "7001:7001"
  - "7199:7199"
```

Remember to adjust your firewall settings accordingly when exposing additional ports.

## Additional Resources

For more detailed configuration options, refer to the official Apache Cassandra documentation:
[Cassandra Configuration](https://cassandra.apache.org/doc/latest/configuration/cassandra_config_file.html)
