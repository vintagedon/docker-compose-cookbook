# Configuration Guide for Graylog Docker Setup

This document provides detailed information on configuring Graylog, Elasticsearch, and MongoDB in our Docker setup.

## Table of Contents

- [Configuration Guide for Graylog Docker Setup](#configuration-guide-for-graylog-docker-setup)
  - [Table of Contents](#table-of-contents)
  - [Environment Variables](#environment-variables)
  - [Graylog Configuration](#graylog-configuration)
    - [Web Interface](#web-interface)
    - [Inputs](#inputs)
    - [Plugins](#plugins)
  - [Elasticsearch Configuration](#elasticsearch-configuration)
  - [MongoDB Configuration](#mongodb-configuration)
  - [Networking](#networking)
  - [Logging](#logging)
  - [Advanced Topics](#advanced-topics)
    - [TLS Configuration](#tls-configuration)
    - [LDAP Integration](#ldap-integration)
    - [Email Alerts](#email-alerts)

## Environment Variables

The `.env` file controls most of the configuration for this setup. Here are some key variables:

- `GRAYLOG_PASSWORD_SECRET`: Used to encrypt sensitive data in the Graylog database. Must be at least 16 characters.
- `GRAYLOG_ROOT_PASSWORD_SHA2`: SHA256 hash of the admin password.
- `GRAYLOG_HTTP_EXTERNAL_URI`: The external URL where Graylog will be accessible.

Refer to the `.env.example` file for a complete list of configurable variables.

## Graylog Configuration

### Web Interface

The Graylog web interface is accessible at `http://localhost:9000` by default. You can change this by modifying the `GRAYLOG_HTTP_PORT` in the `.env` file.

### Inputs

The default setup includes a GELF UDP input on port 12201. You can add more inputs through the web interface or by modifying the `init.sh` script.

### Plugins

To add plugins to Graylog:

1. Add the plugin JAR file to a `plugins` directory in the project root.
2. Add a volume mount in the `docker-compose.yml` file:
   ```yaml
   volumes:
     - ./plugins:/usr/share/graylog/plugin
   ```

## Elasticsearch Configuration

Elasticsearch is configured with the following settings:

- Memory limit: 1GB (configurable via `ES_MEM_LIMIT`)
- Java heap size: 512MB (configurable via `ES_JAVA_OPTS_XMS` and `ES_JAVA_OPTS_XMX`)

Adjust these values based on your available resources and expected log volume.

## MongoDB Configuration

MongoDB is used to store Graylog's metadata. The default setup uses basic authentication. In a production environment, consider implementing more robust security measures.

## Networking

All services are connected via a Docker network named `graylog_network`. Ensure that the required ports (9000 for web interface, 12201 for GELF input) are accessible from your host machine.

## Logging

Container logs can be viewed using `docker-compose logs`. For persistent logging, consider configuring a logging driver in your `docker-compose.yml` file.

## Advanced Topics

### TLS Configuration

To enable TLS for the web interface:

1. Generate SSL certificates
2. Mount the certificates into the Graylog container
3. Update the `GRAYLOG_HTTP_EXTERNAL_URI` to use HTTPS
4. Add the necessary environment variables to enable HTTPS in Graylog

### LDAP Integration

Graylog supports LDAP authentication. Configure this through the web interface under System -> Authentication.

### Email Alerts

To enable email alerts:

1. Configure an SMTP server in the Graylog web interface
2. Create streams and alerts as needed

For more advanced configurations, refer to the [official Graylog documentation](https://docs.graylog.org/).
