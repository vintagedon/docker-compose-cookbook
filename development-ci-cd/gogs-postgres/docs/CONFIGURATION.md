# Configuration Guide for Gogs with PostgreSQL

This document provides detailed information on configuring Gogs and PostgreSQL in this Docker setup.

## Table of Contents

- [Configuration Guide for Gogs with PostgreSQL](#configuration-guide-for-gogs-with-postgresql)
  - [Table of Contents](#table-of-contents)
  - [Environment Variables](#environment-variables)
  - [Gogs Configuration](#gogs-configuration)
  - [PostgreSQL Configuration](#postgresql-configuration)
  - [Custom App.ini](#custom-appini)
  - [SSL/TLS Configuration](#ssltls-configuration)
  - [External URL](#external-url)
  - [Email Configuration](#email-configuration)
  - [Authentication](#authentication)

## Environment Variables

The main configuration is done through environment variables in the `.env` file. Here's a breakdown of the available options:

- `GOGS_VERSION`: The version of Gogs to use (default: latest)
- `GOGS_CONTAINER_NAME`: The name of the Gogs container
- `GOGS_HTTP_PORT`: The port to expose Gogs HTTP server
- `GOGS_SSH_PORT`: The port to expose Gogs SSH server
- `POSTGRES_VERSION`: The version of PostgreSQL to use
- `POSTGRES_CONTAINER_NAME`: The name of the PostgreSQL container
- `POSTGRES_DB`: The name of the database for Gogs
- `POSTGRES_USER`: The username for the database
- `POSTGRES_PASSWORD`: The password for the database user

## Gogs Configuration

Gogs is primarily configured through its `app.ini` file. In this Docker setup, you can override settings by adding environment variables to the `gogs` service in `docker-compose.yml`.

Example:

```yaml
environment:
  - "APP_NAME=My Gogs Instance"
  - "RUN_USER=git"
  - "RUN_MODE=prod"
```

For a full list of configuration options, refer to the [Gogs configuration cheat sheet](https://gogs.io/docs/advanced/configuration_cheat_sheet).

## PostgreSQL Configuration

PostgreSQL configuration can be adjusted by adding environment variables to the `postgres` service in `docker-compose.yml`.

Example:

```yaml
environment:
  - "POSTGRES_MAX_CONNECTIONS=200"
  - "POSTGRES_SHARED_BUFFERS=512MB"
```

## Custom App.ini

To use a custom `app.ini` file:

1. Create your `custom_app.ini` file
2. Mount it as a volume in the `gogs` service:

```yaml
volumes:
  - ./custom_app.ini:/data/gogs/conf/app.ini
```

## SSL/TLS Configuration

To enable HTTPS:

1. Obtain SSL/TLS certificates
2. Mount the certificates in the `gogs` service:

```yaml
volumes:
  - ./ssl/cert.pem:/data/ssl/cert.pem
  - ./ssl/key.pem:/data/ssl/key.pem
```

3. Update the `app.ini` or set environment variables:

```
PROTOCOL=https
CERT_FILE=/data/ssl/cert.pem
KEY_FILE=/data/ssl/key.pem
```

## External URL

Set the external URL for your Gogs instance:

```
EXTERNAL_URL=https://git.example.com/
```

## Email Configuration

Configure email settings for notifications:

```
SMTP_HOST=smtp.example.com
SMTP_FROM=noreply@example.com
SMTP_USER=your_email@example.com
SMTP_PASSWD=your_email_password
```

## Authentication

Gogs supports various authentication methods. To enable LDAP, for example:

```
AUTH_LDAP_ENABLED=true
AUTH_LDAP_HOST=ldap.example.com
AUTH_LDAP_PORT=389
AUTH_LDAP_BASE=ou=Users,dc=example,dc=com
```

For more detailed information on these configurations, please refer to the [official Gogs documentation](https://gogs.io/docs).
