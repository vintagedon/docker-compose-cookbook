# Configuration for SQLite3 Docker Setup

This document outlines the configuration options available for the SQLite3 Docker setup.

## Table of Contents

- [Configuration for SQLite3 Docker Setup](#configuration-for-sqlite3-docker-setup)
  - [Table of Contents](#table-of-contents)
  - [Environment Variables](#environment-variables)
  - [Docker Compose Configuration](#docker-compose-configuration)
  - [SQLite3 Configuration](#sqlite3-configuration)
  - [Initialization Script](#initialization-script)

## Environment Variables

The following environment variables can be set in the `.env` file:

- `SQLITE_VERSION`: The version of SQLite3 to use (default: latest)
- `CONTAINER_NAME`: The name of the Docker container (default: sqlite3)
- `SQLITE_DATABASE`: The name of the SQLite database file (default: db.sqlite)

## Docker Compose Configuration

The `docker-compose.yml` file defines the SQLite3 service. Key configuration options include:

- `image`: The Docker image used (keinos/sqlite3)
- `volumes`: Defines data persistence and initialization script mounting
- `environment`: Sets environment variables for the container
- `command`: Specifies the command to run on container start
- `healthcheck`: Defines a health check for the container

## SQLite3 Configuration

SQLite3 itself doesn't have a configuration file. Most configuration is done through SQL commands or compile-time options. However, you can adjust SQLite's behavior through PRAGMA statements in your SQL queries or initialization script.

Common PRAGMA statements include:

- `PRAGMA journal_mode = WAL;`: Enables Write-Ahead Logging for better concurrency
- `PRAGMA synchronous = NORMAL;`: Balances data safety and performance
- `PRAGMA foreign_keys = ON;`: Enables foreign key constraints

## Initialization Script

The `init.sql` script in the `scripts/` directory is executed when the container starts. Use this script to:

- Create initial database schema
- Insert seed data
- Set PRAGMA statements for SQLite configuration

Example:

```sql
PRAGMA journal_mode = WAL;
PRAGMA synchronous = NORMAL;
PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL
);

INSERT INTO users (name, email) VALUES ('Admin', 'admin@example.com');
```

For more advanced configuration options, refer to the [official SQLite documentation](https://www.sqlite.org/docs.html).
