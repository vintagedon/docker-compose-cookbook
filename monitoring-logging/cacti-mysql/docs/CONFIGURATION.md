# Configuration for Cacti Docker Setup (Monitoring and Logging)

This document provides detailed information on configuring Cacti and MySQL in this Docker setup for optimal monitoring and logging performance.

## Table of Contents

- [Configuration for Cacti Docker Setup (Monitoring and Logging)](#configuration-for-cacti-docker-setup-monitoring-and-logging)
  - [Table of Contents](#table-of-contents)
  - [Environment Variables](#environment-variables)
  - [Cacti Configuration](#cacti-configuration)
  - [MySQL Configuration](#mysql-configuration)
  - [Network Configuration](#network-configuration)
  - [Volume Configuration](#volume-configuration)

## Environment Variables

The following environment variables can be set in the `.env` file:

- `CACTI_VERSION`: The version of Cacti to use (default: latest)
- `CONTAINER_NAME`: The name for the Cacti container (default: cacti_monitor)
- `CACTI_PORT`: The port to expose Cacti on (default: 80)
- `MYSQL_VERSION`: The version of MySQL to use (default: 8.0)
- `MYSQL_ROOT_PASSWORD`: The root password for MySQL
- `MYSQL_DATABASE`: The name of the Cacti database (default: cacti)
- `MYSQL_USER`: The MySQL user for Cacti (default: cactiuser)
- `MYSQL_PASSWORD`: The password for the Cacti MySQL user
- `TIMEZONE`: The timezone for Cacti and MySQL (default: UTC)
- `POLLER_INTERVAL`: The interval for Cacti's data collection (default: 300 seconds)

## Cacti Configuration

Cacti configuration is primarily done through the web interface after installation. However, some aspects can be configured through environment variables in the `docker-compose.yml` file:

```yaml
environment:
  - DB_HOST=mysql
  - DB_PORT=3306
  - DB_NAME=${MYSQL_DATABASE:-cacti}
  - DB_USER=${MYSQL_USER:-cactiuser}
  - DB_PASS=${MYSQL_PASSWORD:-cactipassword}
  - INITIALIZE_DB=1
  - TZ=${TIMEZONE:-UTC}
```

## MySQL Configuration

MySQL is configured with optimizations for Cacti monitoring and logging in the `init.sql` script. You can modify this script to further optimize MySQL for your specific monitoring needs.

## Network Configuration

By default, Cacti is exposed on port 80. You can change this by modifying the `CACTI_PORT` environment variable.

MySQL is not exposed externally for security reasons. It's only accessible to the Cacti container through the Docker network.

## Volume Configuration

The following volumes are defined for data persistence:

- `cacti_data`: Cacti application data
- `cacti_rra`: Cacti RRA files (Round Robin Archives for storing time-series data)
- `cacti_logs`: Cacti log files
- `
