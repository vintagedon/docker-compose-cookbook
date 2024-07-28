# Configuration Guide for Prometheus Docker Setup

This document provides detailed information on configuring your Prometheus Docker setup.

## Table of Contents

- [Configuration Guide for Prometheus Docker Setup](#configuration-guide-for-prometheus-docker-setup)
  - [Table of Contents](#table-of-contents)
  - [Basic Configuration](#basic-configuration)
  - [Environment Variables](#environment-variables)
  - [Prometheus Configuration File](#prometheus-configuration-file)
    - [Global Settings](#global-settings)
  - [Adding Scrape Targets](#adding-scrape-targets)
  - [Alerting Rules](#alerting-rules)
  - [Remote Storage](#remote-storage)
  - [Security Configuration](#security-configuration)

## Basic Configuration

The basic configuration for Prometheus is handled through the `docker-compose.yml` file and the `.env` file.

## Environment Variables

Environment variables are defined in the `.env` file. Here are the available options:

- `PROMETHEUS_VERSION`: The version of Prometheus to use (default: latest)
- `CONTAINER_NAME`: The name of the Docker container (default: prometheus)
- `PROMETHEUS_PORT`: The port on which Prometheus will be accessible (default: 9090)
- `TIMEZONE`: The timezone for the container (default: UTC)
- `RETENTION_PERIOD`: The data retention period (default: 15d)
- `STORAGE_SIZE`: The maximum storage size (default: 0, which means no limit)

## Prometheus Configuration File

The main Prometheus configuration file is `scripts/prometheus.yml`. This file defines global settings, scrape configurations, and rule files.

### Global Settings

```yaml
global:
  scrape_interval: 15s
  evaluation_interval: 15s
```

- `scrape_interval`: How frequently to scrape targets
- `evaluation_interval`: How frequently to evaluate rules

## Adding Scrape Targets

To add new targets for Prometheus to scrape, add new job configurations to the `scrape_configs` section of `prometheus.yml`:

```yaml
scrape_configs:
  - job_name: "new_target"
    static_configs:
      - targets: ["hostname:port"]
```

## Alerting Rules

Alerting rules are defined in separate YAML files and referenced in the `rule_files` section of `prometheus.yml`:

```yaml
rule_files:
  - "first_rules.yml"
  - "second_rules.yml"
```

Create these files in the same directory as `prometheus.yml` and define your alerting rules. For example:

```yaml
groups:
  - name: example
    rules:
      - alert: HighRequestLatency
        expr: job:request_latency_seconds:mean5m{job="myjob"} > 0.5
        for: 10m
        labels:
          severity: page
        annotations:
          summary: High request latency
```

## Remote Storage

Prometheus supports sending samples to remote storage systems. To configure this, add a `remote_write` section to your `prometheus.yml`:

```yaml
remote_write:
  - url: "http://remote-storage-host:port/api/v1/write"
```

## Security Configuration

For security reasons, it's recommended to:

1. Use HTTPS for all communications
2. Set up authentication for the Prometheus web interface
3. Use secure passwords and API keys
4. Regularly update Prometheus and all related components

For more detailed security configurations, refer to the `SECURITY.md` file.

Remember to restart your Prometheus container after making changes to the configuration:

```
docker-compose down
docker-compose up -d
```

For more information, refer to the [official Prometheus documentation](https://prometheus.io/docs/prometheus/latest/configuration/configuration/).
