# CouchDB Docker Setup Configuration Guide

This document provides detailed information on configuring your CouchDB Docker setup.

## Basic Configuration

Basic configuration is done through environment variables in the `.env` file. Here are the key variables:

- `CONTAINER_NAME`: Name of the Docker container (default: couchdb)
- `PORT`: The port on which CouchDB will be accessible (default: 5984)
- `COUCHDB_VERSION`: The version of CouchDB to use (default: latest)
- `COUCHDB_USER`: Admin username for CouchDB
- `COUCHDB_PASSWORD`: Admin password for CouchDB
- `COUCHDB_SECRET`: A secret string used for cookie generation
- `COUCHDB_ERLANG_COOKIE`: The Erlang cookie for distributed Erlang (important for clustering)

## Advanced Configuration

For more advanced configuration, you can modify the `docker-compose.yml` file or add environment variables. Here are some advanced options:

### Memory and Concurrency

- `MAX_DOCUMENT_SIZE`: Maximum size of a document in bytes (default: 4294967296, i.e., 4GB)
- `MAX_HTTP_CONNECTIONS`: Maximum number of HTTP connections (default: 2048)

Example:

```yaml
environment:
  - MAX_DOCUMENT_SIZE=8589934592
  - MAX_HTTP_CONNECTIONS=4096
```

### Logging

- `COUCHDB_LOG_LEVEL`: Set the log level (debug, info, notice, warning, error, critical, alert, emergency)

Example:

```yaml
environment:
  - COUCHDB_LOG_LEVEL=debug
```

### Network Binding

- `COUCHDB_BIND_ADDRESS`: The IP address CouchDB binds to (default: 0.0.0.0)

Example:

```yaml
environment:
  - COUCHDB_BIND_ADDRESS=127.0.0.1
```

## Persistent Data

By default, CouchDB data is stored in a Docker volume. You can use a named volume by setting `USE_NAMED_VOLUMES=true` in your `.env` file.

For even more control, you can mount a local directory:

```yaml
volumes:
  - ./couchdb_data:/opt/couchdb/data
```

## Custom Configuration File

For extensive customization, you can provide your own `local.ini` file:

1. Create a `local.ini` file with your desired settings.
2. Add a volume mount in `docker-compose.yml`:

```yaml
volumes:
  - ./local.ini:/opt/couchdb/etc/local.d/local.ini
```

Remember to restart your container after making configuration changes:

```
docker-compose down
docker-compose up -d
```

For more detailed information on CouchDB configuration options, refer to the [official CouchDB documentation](https://docs.couchdb.org/en/stable/config/index.html).
