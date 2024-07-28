# InfluxDB Configuration Guide

This document provides detailed information on configuring your InfluxDB Docker setup.

## Basic Configuration

Basic configuration is done through environment variables in the `.env` file. Here are the key variables:

- `CONTAINER_NAME`: Name of the InfluxDB container (default: influxdb)
- `INFLUXDB_PORT`: Port on which InfluxDB will be accessible (default: 8086)
- `INFLUXDB_VERSION`: Version of InfluxDB to use (default: 2.7)
- `INFLUXDB_INIT_MODE`: Initialization mode (default: setup)
- `INFLUXDB_INIT_USERNAME`: Initial admin username (default: admin)
- `INFLUXDB_INIT_PASSWORD`: Initial admin password (default: password123)
- `INFLUXDB_INIT_ORG`: Initial organization name (default: myorg)
- `INFLUXDB_INIT_BUCKET`: Initial bucket name (default: mybucket)
- `INFLUXDB_INIT_RETENTION`: Initial data retention period (default: 1w)
- `INFLUXDB_INIT_ADMIN_TOKEN`: Initial admin token (default: mytoken)

## Advanced Configuration

For more advanced configurations, you can add the following variables to your `.env` file:

- `INFLUXDB_REPORTING_DISABLED`: Disable usage reporting to InfluxData (default: false)
- `INFLUXDB_HTTP_AUTH_ENABLED`: Enable authentication for HTTP endpoints (default: true)
- `INFLUXDB_HTTP_FLUX_ENABLED`: Enable Flux queries (default: true)

## Custom InfluxDB Configuration

If you need to customize the InfluxDB configuration beyond what's possible with environment variables, you can mount a custom configuration file:

1. Create a file named `influxdb.conf` with your custom configuration.
2. Add the following line to the `volumes` section of the InfluxDB service in `docker-compose.yml`:

   ```yaml
   - ./influxdb.conf:/etc/influxdb2/config.yml
   ```

3. Restart the InfluxDB container for the changes to take effect.

## Security Configuration

For security best practices, please refer to the `SECURITY.md` file.

## Performance Tuning

For performance tuning options, please refer to the `PERFORMANCE_TUNING.md` file.

## Multi-Node Setup

For information on configuring a multi-node InfluxDB cluster, please refer to the `MULTI_NODE_SETUP.md` file.

Remember to restart your InfluxDB container after making configuration changes:

```bash
docker-compose down
docker-compose up -d
```

For more detailed information on InfluxDB configuration, please refer to the [official InfluxDB documentation](https://docs.influxdata.com/influxdb/v2.7/reference/config-options/).
