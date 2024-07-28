# Configuration Guide for Gogs with SQLite3 Docker Setup

This document provides detailed information on configuring your Gogs instance with SQLite3 backend.

## Table of Contents

- [Configuration Guide for Gogs with SQLite3 Docker Setup](#configuration-guide-for-gogs-with-sqlite3-docker-setup)
  - [Table of Contents](#table-of-contents)
  - [Environment Variables](#environment-variables)
  - [Custom app.ini Configuration](#custom-appini-configuration)
    - [\[database\]](#database)
    - [\[repository\]](#repository)
    - [\[server\]](#server)
    - [\[mailer\]](#mailer)
    - [\[service\]](#service)
    - [\[picture\]](#picture)
    - [\[session\]](#session)
    - [\[log\]](#log)
  - [Database Configuration](#database-configuration)
  - [Authentication Settings](#authentication-settings)
  - [Repository Settings](#repository-settings)
  - [Server and Network Configuration](#server-and-network-configuration)
  - [Logging and Metrics](#logging-and-metrics)

## Environment Variables

The following environment variables can be set in the `.env` file or passed directly to the Docker container:

- `GOGS_VERSION`: Gogs version to use (default: latest)
- `CONTAINER_NAME`: Name of the Docker container (default: gogs)
- `GOGS_HTTP_PORT`: HTTP port for Gogs web interface (default: 3000)
- `GOGS_SSH_PORT`: SSH port for Git operations (default: 22)
- `USER_UID`: User ID for the Gogs user (default: 1000)
- `USER_GID`: Group ID for the Gogs user (default: 1000)
- `RUN_MODE`: Gogs run mode (dev, prod, test) (default: prod)
- `DOMAIN`: Domain name for your Gogs instance (default: localhost)
- `ROOT_URL`: Root URL for your Gogs instance (default: http://localhost:3000/)

## Custom app.ini Configuration

To customize the Gogs configuration, you can modify the `app.ini` file located at `/data/gogs/conf/app.ini` inside the container. Here are some important sections:

### [database]

```ini
TYPE  = sqlite3
PATH  = /data/gogs/gogs.db
```

### [repository]

```ini
ROOT = /data/git/gogs-repositories
```

### [server]

```ini
DOMAIN           = localhost
HTTP_PORT        = 3000
ROOT_URL         = http://localhost:3000/
DISABLE_SSH      = false
SSH_PORT         = 22
START_SSH_SERVER = true
OFFLINE_MODE     = false
```

### [mailer]

```ini
ENABLED = false
```

### [service]

```ini
REGISTER_EMAIL_CONFIRM = false
ENABLE_NOTIFY_MAIL     = false
DISABLE_REGISTRATION   = false
ENABLE_CAPTCHA         = true
REQUIRE_SIGNIN_VIEW    = false
```

### [picture]

```ini
DISABLE_GRAVATAR        = false
ENABLE_FEDERATED_AVATAR = true
```

### [session]

```ini
PROVIDER = file
```

### [log]

```ini
MODE      = file
LEVEL     = Info
ROOT_PATH = /app/gogs/log
```

## Database Configuration

This setup uses SQLite3 as the database backend. The database file is stored at `/data/gogs/gogs.db` inside the container.

## Authentication Settings

By default, Gogs uses its built-in authentication system. You can configure additional authentication methods (e.g., LDAP, OAuth) in the `app.ini` file.

## Repository Settings

Repositories are stored in `/data/git/gogs-repositories` inside the container. This directory is persisted using a Docker volume.

## Server and Network Configuration

The Gogs server listens on port 3000 for HTTP traffic and port 22 for SSH traffic by default. These ports are exposed to the host system and can be changed using environment variables.

## Logging and Metrics

Logs are stored in `/app/gogs/log` inside the container. You can adjust the log level and other logging settings in the `app.ini` file.

For more detailed configuration options, refer to the [official Gogs configuration cheat sheet](https://gogs.io/docs/advanced/configuration_cheat_sheet).
