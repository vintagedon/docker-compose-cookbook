# Configuration Guide for Gogs with MySQL Docker Setup

This document provides detailed information on configuring your Gogs instance with MySQL using Docker.

## Table of Contents

- [Configuration Guide for Gogs with MySQL Docker Setup](#configuration-guide-for-gogs-with-mysql-docker-setup)
  - [Table of Contents](#table-of-contents)
  - [Environment Variables](#environment-variables)
  - [Gogs Configuration](#gogs-configuration)
  - [MySQL Configuration](#mysql-configuration)
  - [Networking](#networking)
  - [Volumes](#volumes)

## Environment Variables

The `.env` file contains important configuration options. Here's an explanation of each variable:

- `GOGS_VERSION`: The version of Gogs to use (default: latest)
- `GOGS_CONTAINER_NAME`: The name of the Gogs container (default: gogs)
- `GOGS_HTTP_PORT`: The HTTP port for Gogs web interface (default: 3000)
- `GOGS_SSH_PORT`: The SSH port for Git operations (default: 22)
- `MYSQL_VERSION`: The version of MySQL to use (default: 8.0)
- `MYSQL_CONTAINER_NAME`: The name of the MySQL container (default: gogs-mysql)
- `MYSQL_ROOT_PASSWORD`: The root password for MySQL (required)
- `MYSQL_DATABASE`: The name of the database for Gogs (default: gogs)
- `MYSQL_USER`: The MySQL user for Gogs (default: gogs)
- `MYSQL_PASSWORD`: The password for the Gogs MySQL user (required)

## Gogs Configuration

Gogs is primarily configured through its web interface during the initial setup. However, you can also modify the `app.ini` file for advanced configuration:

1. After the first run, the `app.ini` file will be created in the `gogs_data` volume.
2. You can edit this file by accessing the container:

   ```
   docker exec -it gogs /bin/bash
   vi /data/gogs/conf/app.ini
   ```

3. Restart the Gogs container after making changes:

   ```
   docker-compose restart gogs
   ```

## MySQL Configuration

MySQL is configured using environment variables in the `docker-compose.yml` file. For advanced configuration:

1. Create a `my.cnf` file in the project directory.
2. Add your MySQL configuration options to this file.
3. Mount this file in the MySQL container by adding the following line under the `volumes` section of the MySQL service in `docker-compose.yml`:

   ```yaml
   - ./my.cnf:/etc/mysql/conf.d/my.cnf
   ```

4. Restart the MySQL container:

   ```
   docker-compose restart mysql
   ```

## Networking

By default, a bridge network named `gogs_network` is created. This allows the Gogs and MySQL containers to communicate with each other.

## Volumes

Two named volumes are used for data persistence:

- `gogs_data`: Stores Gogs data and configurations
- `mysql_data`: Stores MySQL data

You can manage these volumes using Docker volume commands.

For more detailed information on Gogs configuration, please refer to the [official Gogs documentation](https://gogs.io/docs/installation/configuration_and_run.html).
