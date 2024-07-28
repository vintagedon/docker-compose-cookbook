# Performance Tuning for Gitea with PostgreSQL Docker Setup

This document provides guidance on optimizing the performance of your Gitea instance with PostgreSQL using Docker.

## Table of Contents

- [Performance Tuning for Gitea with PostgreSQL Docker Setup](#performance-tuning-for-gitea-with-postgresql-docker-setup)
  - [Table of Contents](#table-of-contents)
  - [Docker Performance](#docker-performance)
  - [Gitea Performance](#gitea-performance)
  - [PostgreSQL Performance](#postgresql-performance)
  - [Network Performance](#network-performance)
  - [Monitoring](#monitoring)

## Docker Performance

1. Use Docker volumes instead of bind mounts for better I/O performance.
2. Allocate sufficient CPU and memory resources to your containers.
3. Use the `--cpu-shares` and `--memory` flags to limit and allocate resources appropriately.
4. Consider using Docker Compose version 3 syntax for better resource management.

Example in `docker-compose.yml`:

```yaml
services:
  gitea:
    deploy:
      resources:
        limits:
          cpus: "0.50"
          memory: 512M
        reservations:
          cpus: "0.25"
          memory: 256M
```

## Gitea Performance

1. Enable caching in Gitea's configuration:

```ini
[cache]
ADAPTER = memory
INTERVAL = 60
HOST =
```

2. Optimize Gitea's database settings:

```ini
[database]
DB_TYPE = postgres
HOST = postgres:5432
NAME = gitea
USER = gitea
PASSWD = gitea_password
ITERATE_BUFFER_SIZE = 50
LOG_SQL = false
```

3. Adjust the number of Gitea workers based on your system's capabilities:

```ini
[server]
DISABLE_SSH = false
SSH_DOMAIN = localhost
START_SSH_SERVER = false
LFS_START_SERVER = true
LFS_CONTENT_PATH = /data/git/lfs
LFS_JWT_SECRET =
OFFLINE_MODE = false
APP_DATA_PATH = /data/gitea
ENABLE_GZIP = true
LANDING_PAGE = home

[service]
DISABLE_REGISTRATION = false
REQUIRE_SIGNIN_VIEW = false
REGISTER_EMAIL_CONFIRM = false
ENABLE_NOTIFY_MAIL = false
ALLOW_ONLY_EXTERNAL_REGISTRATION = false
ENABLE_CAPTCHA = false
DEFAULT_KEEP_EMAIL_PRIVATE = false
DEFAULT_ALLOW_CREATE_ORGANIZATION = true
DEFAULT_ENABLE_TIMETRACKING = true
NO_REPLY_ADDRESS = noreply.localhost

[mailer]
ENABLED = false

[session]
PROVIDER = file

[log]
MODE = file
LEVEL = Info
ROOT_PATH = /data/gitea/log

[repository]
ROOT = /data/git/repositories

[repository.local]
LOCAL_COPY_PATH = /data/gitea/tmp/local-repo

[repository.upload]
TEMP_PATH = /data/gitea/uploads

[security]
INSTALL_LOCK = true
SECRET_KEY =
INTERNAL_TOKEN =

[service]
DISABLE_REGISTRATION = false
REQUIRE_SIGNIN_VIEW = false
REGISTER_EMAIL_CONFIRM = false
ENABLE_NOTIFY_MAIL = false
ALLOW_ONLY_EXTERNAL_REGISTRATION = false
ENABLE_CAPTCHA = false
DEFAULT_KEEP_EMAIL_PRIVATE = false
DEFAULT_ALLOW_CREATE_ORGANIZATION = true
DEFAULT_ENABLE_TIMETRACKING = true
NO_REPLY_ADDRESS = noreply.localhost

[indexer]
ISSUE_INDEXER_PATH = /data/gitea/indexers/issues.bleve

[queue]
TYPE = immediate

[queue.issue_indexer]
TYPE = leveldb
DATADIR = /data/gitea/queues/issue-indexer

[queue.mailer]
TYPE = channel
DATADIR = /data/gitea/queues/mailer
```

4. Use an efficient reverse proxy like Nginx or Traefik for SSL termination and static file serving.

## PostgreSQL Performance

1. Adjust PostgreSQL's configuration for better performance. Add these settings to your PostgreSQL container:

```yaml
command:
  - "postgres"
  - "-c"
  - "max_connections=200"
  - "-c"
  - "shared_buffers=256MB"
  - "-c"
  - "effective_cache_size=768MB"
  - "-c"
  - "maintenance_work_mem=64MB"
  - "-c"
  - "checkpoint_completion_target=0.9"
  - "-c"
  - "wal_buffers=7864kB"
  - "-c"
  - "default_statistics_target=100"
  - "-c"
  - "random_page_cost=1.1"
  - "-c"
  - "effective_io_concurrency=200"
```

2. Consider using PostgreSQL extensions like `pg_stat_statements` for query performance analysis.

## Network Performance

1. Use Docker's bridge network for communication between Gitea and PostgreSQL.
2. If your Gitea instance is accessed over the internet, consider using a CDN for static assets.

## Monitoring

1. Use Docker's built-in health checks to monitor container health.
2. Implement monitoring solutions like Prometheus and Grafana for detailed performance metrics.
3. Regularly review Gitea and PostgreSQL logs for performance issues.

Example health check in `docker-compose.yml`:

```yaml
services:
  gitea:
    healthcheck:
      test: ["CMD", "/usr/sbin/gitea", "health"]
      interval: 30s
      timeout: 10s
      retries: 3
```

Remember to test thoroughly after making any performance adjustments, as the optimal settings can vary depending on your specific use case and hardware.
