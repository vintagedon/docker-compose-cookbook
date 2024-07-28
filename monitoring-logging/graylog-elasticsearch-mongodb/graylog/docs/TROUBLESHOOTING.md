# Troubleshooting Guide for Graylog Docker Setup

This document provides solutions to common issues you may encounter with your Graylog Docker setup.

## Table of Contents

1. [Container Startup Issues](#container-startup-issues)
2. [Connectivity Problems](#connectivity-problems)
3. [Performance Issues](#performance-issues)
4. [Log Ingestion Problems](#log-ingestion-problems)
5. [Web Interface Issues](#web-interface-issues)
6. [Elasticsearch Issues](#elasticsearch-issues)
7. [MongoDB Issues](#mongodb-issues)

## Container Startup Issues

### Problem: Containers fail to start

1. Check Docker logs:

   ```
   docker-compose logs
   ```

2. Ensure all required environment variables are set in your `.env` file.

3. Verify that the ports specified in `docker-compose.yml` are not already in use on your host machine.

## Connectivity Problems

### Problem: Unable to connect to Graylog web interface

1. Check if the Graylog container is running:

   ```
   docker-compose ps
   ```

2. Verify the `GRAYLOG_HTTP_EXTERNAL_URI` in your `.env` file matches your access URL.

3. Ensure your firewall allows traffic on the Graylog web interface port (default 9000).

## Performance Issues

### Problem: Slow log processing or web interface

1. Check system resources (CPU, memory, disk I/O) using:

   ```
   docker stats
   ```

2. Adjust Java heap size for Graylog and Elasticsearch in `docker-compose.yml`.

3. Consider scaling out your setup by adding more Graylog nodes or Elasticsearch nodes.

## Log Ingestion Problems

### Problem: Logs are not appearing in Graylog

1. Verify that your input is correctly configured in the Graylog web interface.

2. Check if the logs are reaching Graylog by looking at the Docker logs:

   ```
   docker-compose logs graylog
   ```

3. Ensure your firewall allows traffic on the input port (e.g., 12201 for GELF).

## Web Interface Issues

### Problem: Blank pages or errors in the web interface

1. Clear your browser cache and cookies.

2. Check browser console for JavaScript errors.

3. Verify that your browser is compatible with the Graylog web interface.

## Elasticsearch Issues

### Problem: Elasticsearch cluster status is yellow or red

1. Check Elasticsearch logs:

   ```
   docker-compose logs elasticsearch
   ```

2. Verify Elasticsearch cluster health:

   ```
   curl -XGET 'http://localhost:9200/_cluster/health?pretty'
   ```

3. Ensure Elasticsearch has enough disk space and memory.

## MongoDB Issues

### Problem: MongoDB connection errors

1. Check MongoDB logs:

   ```
   docker-compose logs mongodb
   ```

2. Verify MongoDB is running and accessible:

   ```
   docker-compose exec mongodb mongo --eval "db.adminCommand('ping')"
   ```

3. Ensure the `GRAYLOG_MONGODB_URI` in your `.env` file is correct.

If you encounter issues not covered in this guide, please refer to the [official Graylog documentation](https://docs.graylog.org/) or seek help in the [Graylog community forums](https://community.graylog.org/).
