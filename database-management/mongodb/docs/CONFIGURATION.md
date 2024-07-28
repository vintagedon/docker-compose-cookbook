# MongoDB Configuration Guide

This document provides detailed information on configuring your MongoDB Docker setup.

## Basic Configuration

The basic configuration options are set in the `.env` file. Here are the key variables:

- `MONGO_VERSION`: The version of MongoDB to use (e.g., "5.0.9")
- `MONGO_PORT`: The port on which MongoDB will be accessible (default: 27017)
- `MONGO_ROOT_USERNAME`: The username for the root user
- `MONGO_ROOT_PASSWORD`: The password for the root user
- `MONGO_INITDB_DATABASE`: The name of the initial database to create

## Advanced Configuration

### Authentication

MongoDB authentication is enabled by default. To disable it (not recommended for production), you can add the following to your `docker-compose.yml` file under the `command` key:

```yaml
command: mongod --auth
```

### Replica Set Configuration

To set up a replica set, add the following to your `.env` file:

```
MONGO_REPLICA_SET_NAME=rs0
```

Then, modify your `docker-compose.yml` to include the replica set option:

```yaml
command: mongod --replSet ${MONGO_REPLICA_SET_NAME}
```

### Sharding

For sharding configuration, refer to the [MULTI_NODE_SETUP.md](MULTI_NODE_SETUP.md) file.

## Performance Tuning

For performance tuning options, see the [PERFORMANCE_TUNING.md](PERFORMANCE_TUNING.md) file. Key options include:

- `MONGO_CACHE_SIZE_GB`: WiredTiger cache size in GB
- `MONGO_MAX_CONNECTIONS`: Maximum number of simultaneous connections

## Networking

By default, MongoDB is accessible on the host machine at `localhost:27017`. To change this, modify the `MONGO_PORT` in your `.env` file.

## Data Persistence

Data is persisted in a Docker volume. To use a named volume instead of a local volume, set `USE_NAMED_VOLUMES=true` in your `.env` file.

## Logging

To adjust logging levels, you can add the following to your `docker-compose.yml` under the `command` key:

```yaml
command: mongod --logpath /var/log/mongodb/mongod.log --logappend
```

## Additional Options

For any additional MongoDB options not covered here, you can add them to the `MONGO_EXTRA_FLAGS` variable in your `.env` file. For example:

```
MONGO_EXTRA_FLAGS=--wiredTigerCacheSizeGB 2 --maxConns 200
```

Then, in your `docker-compose.yml`, add:

```yaml
command: mongod ${MONGO_EXTRA_FLAGS}
```

Remember to restart your MongoDB container after making configuration changes:

```
docker-compose down
docker-compose up -d
```

For more detailed configuration options, always refer to the [official MongoDB documentation](https://docs.mongodb.com/manual/reference/configuration-options/).
