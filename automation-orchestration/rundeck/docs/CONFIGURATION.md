# Rundeck Configuration Guide

This document provides detailed information on configuring your Rundeck Docker instance.

## Environment Variables

The following environment variables can be set in the `.env` file:

- `RUNDECK_VERSION`: Rundeck version to use (default: latest)
- `CONTAINER_NAME`: Name of the Rundeck container (default: rundeck)
- `RUNDECK_PORT`: Port to expose Rundeck on (default: 4440)
- `RUNDECK_URL`: External URL for Rundeck (default: http://localhost:4440)
- `RUNDECK_DB_USER`: Database user for Rundeck (default: rundeck)
- `RUNDECK_DB_PASSWORD`: Database password for Rundeck (default: rundeck)
- `MYSQL_ROOT_PASSWORD`: Root password for MariaDB (default: rootpassword)
- `MARIADB_VERSION`: MariaDB version to use (default: 10.5)

## Database Configuration

Rundeck is configured to use MariaDB as its database. The connection details are set in the `docker-compose.yml` file:

```yaml
RUNDECK_DATABASE_DRIVER: org.mariadb.jdbc.Driver
RUNDECK_DATABASE_USERNAME: ${RUNDECK_DB_USER:-rundeck}
RUNDECK_DATABASE_PASSWORD: ${RUNDECK_DB_PASSWORD:-rundeck}
RUNDECK_DATABASE_URL: jdbc:mariadb://db/rundeck?autoReconnect=true&useSSL=false
```

## Plugins

To add plugins to Rundeck, place the plugin files in a directory and mount it to `/home/rundeck/libext` in the Rundeck container. For example, add this to the `volumes` section of the Rundeck service in `docker-compose.yml`:

```yaml
- ./plugins:/home/rundeck/libext
```

## Custom Configuration

To add custom configuration, you can create a `rundeck-config.properties` file and mount it to `/home/rundeck/server/config/` in the Rundeck container.

## SSL Configuration

To enable SSL, you need to:

1. Generate or obtain SSL certificates
2. Mount the certificates into the container
3. Update the Rundeck configuration to use HTTPS

Add the following to your `docker-compose.yml`:

```yaml
volumes:
  - ./path/to/keystore.jks:/home/rundeck/server/config/keystore
environment:
  - RUNDECK_SERVER_HTTPS_KEYSTORE: /home/rundeck/server/config/keystore
  - RUNDECK_SERVER_HTTPS_KEYSTORE_PASSWORD: your_keystore_password
  - RUNDECK_SERVER_HTTPS_KEY_PASSWORD: your_key_password
```

Then update `RUNDECK_GRAILS_URL` to use `https://`.

## External Database

To use an external database instead of the bundled MariaDB:

1. Remove the `db` service from `docker-compose.yml`
2. Update the `RUNDECK_DATABASE_URL` environment variable with your external database connection string

## Logging

Rundeck logs are stored in the `rundeck_logs` volume. You can access these logs by mounting this volume to a directory on your host system.

For more advanced configuration options, please refer to the [official Rundeck documentation](https://docs.rundeck.com/).
