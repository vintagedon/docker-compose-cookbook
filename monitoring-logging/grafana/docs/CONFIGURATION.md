# Configuration Guide for Grafana Docker Setup

This document provides detailed information on how to configure your Grafana instance.

## Table of Contents

- [Configuration Guide for Grafana Docker Setup](#configuration-guide-for-grafana-docker-setup)
  - [Table of Contents](#table-of-contents)
  - [Environment Variables](#environment-variables)
  - [Grafana Configuration File](#grafana-configuration-file)
  - [Data Sources](#data-sources)
  - [Dashboards](#dashboards)
  - [Plugins](#plugins)
  - [Authentication](#authentication)
  - [Alerting](#alerting)

## Environment Variables

You can configure Grafana using environment variables in the `.env` file. Here are some important variables:

- `GRAFANA_VERSION`: The version of Grafana to use (default: latest)
- `GRAFANA_PORT`: The port on which Grafana will be accessible (default: 3000)
- `GRAFANA_ADMIN_USER`: The admin username (default: admin)
- `GRAFANA_ADMIN_PASSWORD`: The admin password (default: admin)
- `GRAFANA_ALLOW_SIGN_UP`: Whether to allow user sign-up (default: false)
- `GRAFANA_ROOT_URL`: The root URL of your Grafana instance
- `GRAFANA_PLUGINS`: A comma-separated list of plugins to install

## Grafana Configuration File

For more advanced configuration, you can create a `grafana.ini` file and mount it to `/etc/grafana/grafana.ini` in the container. Here's an example of how to do this in your `docker-compose.yml`:

```yaml
services:
  grafana:
    # ...
    volumes:
      - ./grafana.ini:/etc/grafana/grafana.ini
```

## Data Sources

You can configure data sources through the Grafana UI or by using provisioning. To use provisioning, create a YAML file in the `provisioning/datasources` directory. Here's an example:

```yaml
apiVersion: 1

datasources:
  - name: Prometheus
    type: prometheus
    access: proxy
    url: http://prometheus:9090
    isDefault: true
```

## Dashboards

You can create dashboards through the Grafana UI or by using provisioning. To use provisioning, create a YAML file in the `provisioning/dashboards` directory. Here's an example:

```yaml
apiVersion: 1

providers:
  - name: "default"
    orgId: 1
    folder: ""
    type: file
    disableDeletion: false
    updateIntervalSeconds: 10
    options:
      path: /var/lib/grafana/dashboards
```

## Plugins

You can install plugins by setting the `GRAFANA_PLUGINS` environment variable or by using the Grafana CLI inside the container:

```bash
docker-compose exec grafana grafana-cli plugins install <plugin-id>
```

## Authentication

Grafana supports various authentication methods. To configure these, you'll need to modify the `grafana.ini` file or use environment variables. Here's an example of configuring LDAP authentication:

```ini
[auth.ldap]
enabled = true
config_file = /etc/grafana/ldap.toml
```

## Alerting

To configure alerting, you'll need to set up an SMTP server. You can do this through environment variables:

```
GF_SMTP_ENABLED=true
GF_SMTP_HOST=smtp.example.com:587
GF_SMTP_USER=myuser
GF_SMTP_PASSWORD=mypassword
```

For more detailed configuration options, please refer to the [official Grafana documentation](https://grafana.com/docs/grafana/latest/setup-grafana/configure-grafana/).
