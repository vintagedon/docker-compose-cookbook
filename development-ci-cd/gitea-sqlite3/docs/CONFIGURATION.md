# Configuration Guide for Gitea-SQLite3 Docker Setup

This document provides detailed information on configuring your Gitea instance with SQLite3 backend.

## Table of Contents

- [Configuration Guide for Gitea-SQLite3 Docker Setup](#configuration-guide-for-gitea-sqlite3-docker-setup)
  - [Table of Contents](#table-of-contents)
  - [Environment Variables](#environment-variables)
  - [Custom Configuration File](#custom-configuration-file)
  - [Database Configuration](#database-configuration)
  - [Server Settings](#server-settings)
  - [Security Settings](#security-settings)
  - [Logging](#logging)
  - [Advanced Configuration](#advanced-configuration)

## Environment Variables

The following environment variables can be set in the `.env` file or passed directly to `docker-compose`:

- `GITEA_VERSION`: Gitea version to use (default: latest)
- `CONTAINER_NAME`: Name of the Docker container (default: gitea)
- `USER_UID`: User ID for Gitea (default: 1000)
- `USER_GID`: Group ID for Gitea (default: 1000)
- `GITEA_ROOT_URL`: Root URL for Gitea (default: http://localhost:3000/)
- `GITEA_HTTP_PORT`: HTTP port for Gitea (default: 3000)
- `GITEA_SSH_PORT`: SSH port for Gitea (default: 22)

## Custom Configuration File

To use a custom configuration file:

1. Create a file named `app.ini.custom` in the `gitea_config` volume.
2. Add your custom configurations to this file.
3. The `init.sh` script will automatically apply this custom configuration on startup.

## Database Configuration

SQLite3 is pre-configured in the `docker-compose.yml` file. The database file is stored in `/data/gitea/gitea.db` inside the container.

To change the database path, modify the `GITEA__database__PATH` environment variable in `docker-compose.yml`.

## Server Settings

Server settings can be configured using environment variables in `docker-compose.yml`:

```yaml
environment:
  - GITEA__server__ROOT_URL=${GITEA_ROOT_URL:-http://localhost:3000/}
  - GITEA__server__HTTP_PORT=${GITEA_HTTP_PORT:-3000}
  - GITEA__server__SSH_PORT=${GITEA_SSH_PORT:-22}
```

## Security Settings

For security-related configurations, refer to the [SECURITY.md](SECURITY.md) file.

## Logging

To configure logging, add the following to your custom `app.ini` file:

```ini
[log]
MODE = file
LEVEL = Info
ROOT_PATH = /data/gitea/log
```

## Advanced Configuration

For advanced configuration options, refer to the [official Gitea documentation](https://docs.gitea.io/en-us/config-cheat-sheet/).
