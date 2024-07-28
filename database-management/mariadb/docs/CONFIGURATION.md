# MariaDB Docker Configuration Guide

This document provides detailed information on configuring your MariaDB Docker instance.

## Table of Contents

- [MariaDB Docker Configuration Guide](#mariadb-docker-configuration-guide)
  - [Table of Contents](#table-of-contents)
  - [Environment Variables](#environment-variables)
  - [Custom Configuration File](#custom-configuration-file)
  - [Persistent Storage](#persistent-storage)
  - [Networking](#networking)
  - [Security Settings](#security-settings)

## Environment Variables

The following environment variables can be set in the `.env` file:

- `CONTAINER_NAME`: The name of the Docker container (default: mariadb)
- `PORT`: The port to expose MariaDB on (default: 3306)
- `MARIADB_VERSION`: The version of MariaDB to use (default: 10.6)
- `MYSQL_ROOT_PASSWORD`: The root password for MariaDB (required)
- `MYSQL_DATABASE`: The name of the default database to create
- `MYSQL_USER`: The name of a new user to create
- `MYSQL_PASSWORD`: The password for the new user

Example:

```
CONTAINER_NAME=mymariadb
PORT=3307
MARIADB_VERSION=10.6
MYSQL_ROOT_PASSWORD=mysecretpassword
MYSQL_DATABASE=myapp
MYSQL_USER=myappuser
MYSQL_PASSWORD=myapppassword
```

## Custom Configuration File

To use a custom MariaDB configuration file:

1. Create a `my.cnf` file in the project directory.
2. Add your custom configurations to this file.
3. Update the `docker-compose.yml` file to mount this configuration:

```yaml
services:
  mariadb:
    ...
    volumes:
      - ./my.cnf:/etc/mysql/my.cnf
    ...
```

## Persistent Storage

By default, MariaDB data is stored in a Docker volume. You can change this to a bind mount for easier access:

1. Create a directory on your host system: `mkdir -p /path/to/mariadb/data`
2. Update the `docker-compose.yml` file:

```yaml
services:
  mariadb:
    ...
    volumes:
      - /path/to/mariadb/data:/var/lib/mysql
    ...
```

## Networking

To connect your MariaDB instance to other Docker networks:

1. Create a new network: `docker network create mynetwork`
2. Update the `docker-compose.yml` file:

```yaml
services:
  mariadb:
    ...
    networks:
      - default
      - mynetwork

networks:
  default:
    name: mariadb_network
  mynetwork:
    external: true
```

## Security Settings

For enhanced security:

1. Use strong passwords for both root and regular users.
2. Limit network access by binding to localhost:

```yaml
services:
  mariadb:
    ...
    ports:
      - "127.0.0.1:3306:3306"
    ...
```

3. Use SSL for encrypted connections. Add the following to your `my.cnf`:

```
[mysqld]
ssl-cert=/path/to/server-cert.pem
ssl-key=/path/to/server-key.pem
```

Remember to mount these SSL files in your `docker-compose.yml`.

For more advanced security configurations, refer to the [SECURITY.md](SECURITY.md) file.
