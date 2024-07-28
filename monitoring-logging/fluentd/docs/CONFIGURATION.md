# Configuration for Fluentd Docker Setup

This document provides detailed instructions on configuring Fluentd for use with Cacti and MySQL in a Docker environment.

## Table of Contents

- [Configuration for Fluentd Docker Setup](#configuration-for-fluentd-docker-setup)
  - [Table of Contents](#table-of-contents)
  - [Basic Configuration](#basic-configuration)
  - [Input Plugins](#input-plugins)
    - [Cacti Logs](#cacti-logs)
    - [MySQL Logs](#mysql-logs)
  - [Output Plugins](#output-plugins)
    - [Elasticsearch](#elasticsearch)
    - [AWS S3](#aws-s3)
  - [Advanced Configuration](#advanced-configuration)
  - [Environment Variables](#environment-variables)

## Basic Configuration

The basic configuration for Fluentd is provided in the `init.conf` file located in the `scripts` directory. This configuration sets up input plugins for Cacti and MySQL logs, and a simple stdout output plugin for debugging.

## Input Plugins

### Cacti Logs

Fluentd is configured to tail the Cacti log file:

```
<source>
  @type tail
  path /cacti/logs/cacti.log
  pos_file /fluentd/log/cacti.log.pos
  tag cacti
  <parse>
    @type regexp
    expression /^(?<time>\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}) - (?<level>\w+): (?<message>.*)$/
    time_format %Y-%m-%d %H:%M:%S
  </parse>
</source>
```

Adjust the `path` if your Cacti logs are located elsewhere.

### MySQL Logs

Two input plugins are configured for MySQL:

1. Error log:

```
<source>
  @type tail
  path /mysql/logs/error.log
  pos_file /fluentd/log/mysql_error.log.pos
  tag mysql.error
  <parse>
    @type regexp
    expression /^(?<time>\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}) (?<thread_id>\d+) \[(?<level>\w+)\] (?<message>.*)$/
    time_format %Y-%m-%d %H:%M:%S
  </parse>
</source>
```

2. Slow query log:

```
<source>
  @type tail
  path /mysql/logs/slow-query.log
  pos_file /fluentd/log/mysql_slow_query.log.pos
  tag mysql.slow_query
  <parse>
    @type multiline
    format_firstline /^# Time:/
    format1 /^# Time: (?<time>\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}.\d+Z)\n# User@Host: (?<user>\S+)\[(?<db>\S+)\] @ (?<host>\S+) \[(?<ip>\S+)\]\n# Query_time: (?<query_time>\d+\.\d+)\s+Lock_time: (?<lock_time>\d+\.\d+)\s+Rows_sent: (?<rows_sent>\d+)\s+Rows_examined: (?<rows_examined>\d+)\n(?<message>[\s\S]*)/
    time_format %Y-%m-%dT%H:%M:%S.%NZ
  </parse>
</source>
```

Adjust the `path` for both MySQL log sources if your logs are located elsewhere.

## Output Plugins

The default configuration uses a stdout output plugin for debugging:

```
<match **>
  @type stdout
</match>
```

For production use, you should configure appropriate output plugins. Here are some examples:

### Elasticsearch

```
<match **>
  @type elasticsearch
  host elasticsearch.example.com
  port 9200
  logstash_format true
</match>
```

### AWS S3

```
<match **>
  @type s3
  aws_key_id YOUR_AWS_KEY
  aws_sec_key YOUR_AWS_SECRET
  s3_bucket your-bucket-name
  s3_region your-region
  path logs/
  buffer_path /var/log/fluent/s3
  time_slice_format %Y%m%d%H
  time_slice_wait 10m
  utc
</match>
```

## Advanced Configuration

For more advanced setups, consider:

1. Using multiple output plugins with tag-based routing
2. Implementing filters for log transformation or enrichment
3. Setting up buffer configurations for better performance and reliability

Example of tag-based routing:

```
<match cacti.**>
  @type elasticsearch
  # Elasticsearch config here
</match>

<match mysql.**>
  @type s3
  # S3 config here
</match>
```

## Environment Variables

The following environment variables can be set in the `.env` file:

- `FLUENTD_VERSION`: The version of Fluentd to use (default: v1.14)
- `CONTAINER_NAME`: The name of the Fluentd container (default: fluentd)
- `FLUENTD_PORT`: The port Fluentd listens on (default: 24224)
- `TIMEZONE`: The timezone for the Fluentd container (default: UTC)

Adjust these variables as needed for your environment.
