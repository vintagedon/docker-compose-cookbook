# Troubleshooting Grafana

This document provides solutions to common issues you might encounter when running Grafana in Docker.

## Table of Contents

- [Troubleshooting Grafana](#troubleshooting-grafana)
  - [Table of Contents](#table-of-contents)
  - [Container Won't Start](#container-wont-start)
  - [Can't Access Grafana UI](#cant-access-grafana-ui)
  - [Database Connection Issues](#database-connection-issues)
  - [Plugin Installation Failures](#plugin-installation-failures)
  - [Authentication Problems](#authentication-problems)
  - [Dashboard Loading Issues](#dashboard-loading-issues)
  - [Data Source Connection Problems](#data-source-connection-problems)
  - [Performance Issues](#performance-issues)
  - [Logging Issues](#logging-issues)
  - [Upgrade Problems](#upgrade-problems)
  - [HTTPS/SSL Issues](#httpsssl-issues)
  - [Alert Notification Problems](#alert-notification-problems)
  - [General Troubleshooting Steps](#general-troubleshooting-steps)

## Container Won't Start

1. Check the container logs:
   ```
   docker-compose logs grafana
   ```
2. Ensure you have the correct permissions on your volume mounts.
3. Verify that the ports specified in your `docker-compose.yml` are not already in use.

## Can't Access Grafana UI

1. Verify that the container is running:
   ```
   docker-compose ps
   ```
2. Check that you're using the correct port as specified in your `docker-compose.yml`.
3. Ensure your firewall isn't blocking the Grafana port.

## Database Connection Issues

1. Verify your database configuration in the Grafana config file or environment variables.
2. Ensure the database server is running and accessible from the Grafana container.
3. Check for any network issues between Grafana and the database.

## Plugin Installation Failures

1. Verify that you have write permissions to the plugin directory.
2. Check if the plugin is compatible with your Grafana version.
3. Try installing the plugin manually inside the container:
   ```
   docker-compose exec grafana grafana-cli plugins install <plugin-id>
   ```

## Authentication Problems

1. Verify your authentication settings in the Grafana configuration.
2. If using LDAP or OAuth, ensure your configuration is correct and the authentication server is accessible.
3. Check Grafana logs for any authentication-related errors.

## Dashboard Loading Issues

1. Clear your browser cache and try reloading the dashboard.
2. Check for any JavaScript errors in your browser's developer console.
3. Verify that all required data sources are available and working correctly.
4. Ensure that the user has the necessary permissions to view the dashboard.

## Data Source Connection Problems

1. Verify the data source configuration in Grafana.
2. Ensure the data source is accessible from the Grafana container.
3. Check for any network issues or firewall rules blocking the connection.
4. Verify that the credentials used for the data source are correct and have the necessary permissions.

## Performance Issues

1. Check the resource usage of your Grafana container:
   ```
   docker stats grafana
   ```
2. Consider increasing the resources allocated to the container if necessary.
3. Optimize your dashboards by reducing the number of panels or increasing the refresh interval.
4. If using a database other than SQLite, ensure it's properly tuned for performance.

## Logging Issues

1. Verify that the log directory is writable by the Grafana process.
2. Check the logging configuration in your Grafana settings.
3. If logs are not appearing, ensure that the log level is set appropriately.

## Upgrade Problems

1. If issues occur after an upgrade, check the [Grafana changelog](https://github.com/grafana/grafana/blob/main/CHANGELOG.md) for any breaking changes.
2. Ensure that your configurations and plugins are compatible with the new version.
3. Consider rolling back to the previous version if the issues persist (see [UPGRADING.md](UPGRADING.md)).

## HTTPS/SSL Issues

1. Verify your SSL certificate configuration.
2. Ensure that the certificate files are accessible to the Grafana container.
3. Check for any certificate expiration issues.

## Alert Notification Problems

1. Verify your alert notification channel configuration.
2. Ensure that Grafana has network access to send notifications (e.g., SMTP server for email notifications).
3. Check Grafana logs for any errors related to alert notifications.

## General Troubleshooting Steps

1. Always check the Grafana logs for error messages:
   ```
   docker-compose logs grafana
   ```
2. Verify your Grafana configuration (grafana.ini or environment variables).
3. Ensure all required dependencies (database, caching server, etc.) are running and accessible.
4. Check the [Grafana community forums](https://community.grafana.com/) for similar issues and solutions.
5. If the problem persists, consider opening an issue on the [Grafana GitHub repository](https://github.com/grafana/grafana/issues), providing detailed information about your setup and the problem you're experiencing.

Remember, when posting about issues online, be careful not to share sensitive information such as passwords or API keys.

For more troubleshooting information, please refer to the [official Grafana troubleshooting guide](https://grafana.com/docs/grafana/latest/troubleshooting/).
