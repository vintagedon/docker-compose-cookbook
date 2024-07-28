# Configuration Guide for Gitea with MySQL Docker Setup

This document provides detailed information on configuring your Gitea instance with MySQL using Docker.

## Table of Contents

- [Configuration Guide for Gitea with MySQL Docker Setup](#configuration-guide-for-gitea-with-mysql-docker-setup)
  - [Table of Contents](#table-of-contents)
  - [Environment Variables](#environment-variables)
    - [Gitea Configuration](#gitea-configuration)
    - [MySQL Configuration](#mysql-configuration)
  - [Gitea Configuration](#gitea-configuration-1)
  - [MySQL Configuration](#mysql-configuration-1)
  - [Networking](#networking)
  - [Volumes](#volumes)
  - [Custom Configuration](#custom-configuration)

## Environment Variables

The `.env` file contains important configuration variables. Here's an explanation of each:

### Gitea Configuration

- `GITEA_VERSION`: The version of Gitea to use (default: latest)
- `GITEA_CONTAINER_NAME`: The name of the Gitea container
- `USER_UID` and `USER_GID`: The UID and GID for the Gitea user inside the container
- `GITEA_ROOT_URL`: The root URL where Gitea will be accessible
- `GITEA_HTTP_PORT`: The port to expose Gitea's HTTP service
- `GITEA_SSH_PORT`: The port to expose Gitea's SSH service

### MySQL Configuration

- `MYSQL_VERSION`: The version of MySQL to use
- `MYSQL_CONTAINER_NAME`: The name of the MySQL container
- `MYSQL_ROOT_PASSWORD`: The root password for MySQL
- `MYSQL_DATABASE`: The name of the database for Gitea
- `MYSQL_USER`: The MySQL user for Gitea
- `MYSQL_PASSWORD`: The password for the Gitea MySQL user

## Gitea Configuration

Gitea is primarily configured through its web interface after installation. However, you can also modify the `app.ini` file for advanced configuration. This file is located at `/data/gitea/conf/app.ini` inside the Gitea container.

To modify this file:

1. Access the Gitea container:
   ```
   docker exec -it gitea /bin/bash
   ```
2. Edit the file using a text editor like `vi`:
   ```
   vi /data/gitea/conf/app.ini
   ```

Remember to restart the Gitea container after making changes:

```
docker-compose restart gitea
```

## MySQL Configuration

MySQL is configured using environment variables in the `docker-compose.yml` file. If you need to make advanced configuration changes, you can add a custom `my.cnf` file:

1. Create a `my.cnf` file in your project directory
2. Add your MySQL configurations to this file
3. Mount this file in the MySQL container by adding the following line under the `volumes` section of the MySQL service in `docker-compose.yml`:
   ```yaml
   - ./my.cnf:/etc/mysql/conf.d/custom.cnf
   ```

## Networking

The services are connected through a Docker network named `gitea`. This network is created automatically by Docker Compose.

## Volumes

Two named volumes are used for data persistence:

- `gitea_data`: Stores Gitea's data
- `mysql_data`: Stores MySQL's data

These volumes persist data even if the containers are removed.

## Custom Configuration

For any custom configurations not covered here, refer to the official documentation:

- [Gitea Documentation](https://docs.gitea.io/)
- [MySQL Docker Documentation](https://hub.docker.com/_/mysql/)

Remember to restart your services after making configuration changes:

```
docker-compose down
docker-compose up -d
```
