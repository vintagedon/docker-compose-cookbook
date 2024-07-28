# Configuration Guide for Gitea with PostgreSQL Docker Setup

This document provides detailed information on configuring your Gitea instance with PostgreSQL using Docker.

## Table of Contents

- [Configuration Guide for Gitea with PostgreSQL Docker Setup](#configuration-guide-for-gitea-with-postgresql-docker-setup)
  - [Table of Contents](#table-of-contents)
  - [Environment Variables](#environment-variables)
  - [Gitea Configuration](#gitea-configuration)
  - [PostgreSQL Configuration](#postgresql-configuration)
  - [Networking](#networking)
  - [Volumes](#volumes)
  - [Custom Configuration](#custom-configuration)

## Environment Variables

The main configuration for this setup is done through environment variables. These are defined in the `.env` file. Here's an explanation of each variable:

- `GITEA_VERSION`: The version of Gitea to use. Default is `latest`.
- `GITEA_CONTAINER_NAME`: The name of the Gitea container. Default is `gitea`.
- `GITEA_HTTP_PORT`: The port on which Gitea's web interface will be accessible. Default is `3000`.
- `GITEA_SSH_PORT`: The port for SSH access to Gitea. Default is `22`.
- `USER_UID` and `USER_GID`: The user ID and group ID under which Gitea will run. Default is `1000` for both.
- `POSTGRES_VERSION`: The version of PostgreSQL to use. Default is `13-alpine`.
- `POSTGRES_CONTAINER_NAME`: The name of the PostgreSQL container. Default is `gitea-postgres`.
- `POSTGRES_DB`: The name of the database for Gitea. Default is `gitea`.
- `POSTGRES_USER`: The username for the PostgreSQL database. Default is `gitea`.
- `POSTGRES_PASSWORD`: The password for the PostgreSQL database. Default is `gitea_password`.

## Gitea Configuration

Gitea is primarily configured through environment variables in the `docker-compose.yml` file. For more advanced configuration, you can mount a custom `app.ini` file to `/data/gitea/conf/app.ini` inside the Gitea container.

Important Gitea-specific environment variables:

- `USER_UID` and `USER_GID`: Set these to match your host system's user ID and group ID to avoid permission issues.
- `GITEA__database__DB_TYPE`: Set to `postgres` to use PostgreSQL.
- `GITEA__database__HOST`: Set to `postgres:5432` to connect to the PostgreSQL container.

For more Gitea configuration options, refer to the [official Gitea documentation](https://docs.gitea.io/en-us/config-cheat-sheet/).

## PostgreSQL Configuration

PostgreSQL is configured through environment variables in the `docker-compose.yml` file. The main variables are:

- `POSTGRES_USER`: The username for the PostgreSQL database.
- `POSTGRES_PASSWORD`: The password for the PostgreSQL database.
- `POSTGRES_DB`: The name of the database to create for Gitea.

The `init.sql` script in the `scripts` directory is used to initialize the database and create necessary extensions.

## Networking

By default, this setup creates a bridge network named `gitea`. Both the Gitea and PostgreSQL containers are connected to this network, allowing them to communicate with each other.

The Gitea web interface is exposed on the host machine on the port specified by `GITEA_HTTP_PORT` (default 3000).

SSH access to Gitea is exposed on the port specified by `GITEA_SSH_PORT` (default 22).

## Volumes

Two Docker volumes are used for data persistence:

- `gitea_data`: Stores Gitea's data, including repositories and configuration.
- `postgres_data`: Stores PostgreSQL's data.

These volumes ensure that your data persists even if the containers are removed and recreated.

## Custom Configuration

For advanced users who need more control over the configuration:

1. Create a custom `app.ini` file based on the [Gitea configuration cheat sheet](https://docs.gitea.io/en-us/config-cheat-sheet/).
2. Mount this file to `/data/gitea/conf/app.ini` inside the Gitea container by adding a volume in `docker-compose.yml`:

   ```yaml
   volumes:
     - ./custom_app.ini:/data/gitea/conf/app.ini
   ```

3. Restart the containers for the changes to take effect.

Remember to handle sensitive information carefully when using a custom configuration file.

For more detailed information on configuring Gitea, please refer to the [official Gitea documentation](https://docs.gitea.io/).
