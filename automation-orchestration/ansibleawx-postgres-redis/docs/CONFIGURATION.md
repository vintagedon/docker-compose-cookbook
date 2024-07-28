# Configuration Guide for Ansible AWX Docker Setup

This document provides detailed information on configuring your Ansible AWX Docker setup.

## Environment Variables

The following environment variables can be set in the `.env` file:

- `AWX_VERSION`: The version of Ansible AWX to use (default: latest)
- `CONTAINER_NAME_PREFIX`: Prefix for container names (default: awx)
- `AWX_WEB_PORT`: The port to access the AWX web interface (default: 8080)
- `POSTGRES_USER`: PostgreSQL username (default: awx)
- `POSTGRES_PASSWORD`: PostgreSQL password (default: awxpass)
- `POSTGRES_DB`: PostgreSQL database name (default: awx)
- `SECRET_KEY`: Django secret key for AWX (default: awxsecret)
- `AWX_ADMIN_USER`: AWX admin username (default: admin)
- `AWX_ADMIN_PASSWORD`: AWX admin password (default: password)

## Docker Compose Configuration

The `docker-compose.yml` file defines the services required for Ansible AWX:

1. `web`: The AWX web interface
2. `task`: The AWX task processor
3. `postgres`: The PostgreSQL database
4. `redis`: The Redis cache

You can modify the `docker-compose.yml` file to adjust resource limits, add custom volumes, or change network settings.

## Database Configuration

By default, AWX uses the internal PostgreSQL container. To use an external database:

1. Update the `postgres` service in `docker-compose.yml` to point to your external database.
2. Update the database connection details in the `.env` file.

## Redis Configuration

The default Redis configuration should be sufficient for most use cases. If you need to use an external Redis instance:

1. Update the `redis` service in `docker-compose.yml` to point to your external Redis instance.
2. Update the Redis connection details in the AWX configuration.

## LDAP Authentication

To configure LDAP authentication:

1. Access the AWX web interface.
2. Go to Settings > Authentication > LDAP.
3. Configure your LDAP server details and mappings.

## SSL/TLS Configuration

To enable HTTPS:

1. Obtain SSL/TLS certificates for your domain.
2. Update the `web` service in `docker-compose.yml` to use the certificates.
3. Update the AWX settings to use HTTPS.

## Logging

AWX logs are stored within the containers by default. To persist logs:

1. Add a volume for logs in `docker-compose.yml`.
2. Update the AWX configuration to use the new log location.

## Backup and Restore

To backup your AWX installation:

1. Backup the PostgreSQL database.
2. Backup the `/var/lib/awx` directory.

To restore:

1. Restore the PostgreSQL database.
2. Restore the `/var/lib/awx` directory.
3. Restart the AWX containers.

For more detailed information on specific configurations, please refer to the [official Ansible AWX documentation](https://docs.ansible.com/ansible-tower/).
