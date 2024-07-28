# Configuration for MySQL Docker Setup

This document provides detailed information on configuring your MySQL Docker setup.

## Table of Contents

- [Configuration for MySQL Docker Setup](#configuration-for-mysql-docker-setup)
  - [Table of Contents](#table-of-contents)
  - [Basic Configuration](#basic-configuration)
  - [Advanced Configuration](#advanced-configuration)
  - [Custom MySQL Configuration](#custom-mysql-configuration)
  - [Environment Variables](#environment-variables)
  - [Persistence Configuration](#persistence-configuration)

## Basic Configuration

Basic configuration is done through environment variables in the `.env` file. Key variables include:

- `MYSQL_ROOT_PASSWORD`: Set the root password for MySQL
- `MYSQL_DATABASE`: Create a database on startup
- `MYSQL_USER` and `MYSQL_PASSWORD`: Create a user with superuser permissions for the database specified by `MYSQL_DATABASE`

## Advanced Configuration

For advanced configuration, you can modify the `my.cnf` file. Place your custom `my.cnf` in the `./config` directory, which is mounted to `/etc/mysql/conf.d` in the container.

Example `my.cnf`:

```ini
[mysqld]
max_connections=250
query_cache_size=0
innodb_buffer_pool_size=1G
```

## Custom MySQL Configuration

To add custom configuration:

1. Create a file with a `.cnf` extension in the `./config` directory
2. Add your custom MySQL configurations to this file
3. Restart the MySQL container

Example `custom.cnf`:

```ini
[mysqld]
slow_query_log=1
long_query_time=2
```

## Environment Variables

Here's a list of all environment variables you can set in the `.env` file:

- `CONTAINER_NAME`: Name of the MySQL container (default: mysql)
- `PORT`: Port to expose MySQL on (default: 3306)
- `MYSQL_ROOT_PASSWORD`: Root password for MySQL
- `MYSQL_DATABASE`: Name of a database to create
- `MYSQL_USER`: Name of a new user to create
- `MYSQL_PASSWORD`: Password for the new user
- `USE_NAMED_VOLUMES`: Whether to use named volumes (true/false)

## Persistence Configuration

Data persistence is managed through Docker volumes. By default, a volume named `mysql_data` is used. If `USE_NAMED_VOLUMES` is set to `true`, a named volume `mysql_named_data` is used instead.

To backup your data:

```bash
docker run --rm --volumes-from mysql -v $(pwd):/backup mysql:latest tar cvf /backup/backup.tar /var/lib/mysql
```

To restore from a backup:

```bash
docker run --rm --volumes-from mysql -v $(pwd):/backup mysql:latest bash -c "cd /var/lib/mysql && tar xvf /backup/backup.tar --strip 1"
```

Remember to stop the MySQL container before restoring data.
