# Prometheus Docker Setup

This project contains a Docker Compose file and environment configuration for setting up a Prometheus monitoring system in a Docker container. It includes both basic and advanced configuration options for customizing your Prometheus deployment.

[Prometheus](https://prometheus.io/) is an open-source systems monitoring and alerting toolkit. It collects and stores its metrics as time series data, i.e. metrics information is stored with the timestamp at which it was recorded, alongside optional key-value pairs called labels.

## GitHub Repository
https://github.com/vintagedon/docker-compose-cookbook/tree/main/monitoring-logging/Prometheus

## Prerequisites
- Docker
- Docker Compose

## Project Structure
```
.
├── docker-compose.yml
├── .env
├── prometheus.yml
└── README.md
```

## Files
- `docker-compose.yml`: Defines the Prometheus service configuration
- `.env`: Contains environment variables for configuring the Prometheus instance
- `prometheus.yml`: The main configuration file for Prometheus
- `README.md`: Provides information and instructions for the project

## Usage

1. Edit the `.env` file and replace the placeholder values with your desired configuration.

2. Modify the `prometheus.yml` file to include your specific scrape configs and alerting rules.

3. Run the container using Docker Compose:
   ```
   docker-compose up -d
   ```

4. Access the Prometheus web interface at `http://localhost:9090` (replace `localhost` with your server's IP if needed).

## Configuration Options

### Basic Options

- `PROMETHEUS_CONTAINER_NAME`: Name of the Prometheus container
- `PROMETHEUS_CONFIG_DIR`: Directory for Prometheus configuration files
- `PROMETHEUS_DATA_DIR`: Directory for Prometheus data storage
- `PROMETHEUS_PORT`: Port for the Prometheus web interface

### Common Options

- `PROMETHEUS_RETENTION_TIME`: How long to retain metrics data
- `PROMETHEUS_SCRAPE_INTERVAL`: How frequently to scrape targets
- `PROMETHEUS_EVALUATION_INTERVAL`: How frequently to evaluate rules

### Advanced Options

- `PROMETHEUS_WEB_EXTERNAL_URL`: The URL under which Prometheus is externally reachable
- `PROMETHEUS_WEB_ROUTE_PREFIX`: A path prefix for the web interface
- `PROMETHEUS_LOG_LEVEL`: The log level for Prometheus (debug, info, warn, error)
- `PROMETHEUS_STORAGE_TSDB_PATH`: Path of the TSDB storage
- `PROMETHEUS_ALERTMANAGER_URL`: URL of the Alertmanager to send notifications to
- `PROMETHEUS_QUERY_MAX_SAMPLES`: Maximum number of samples a single query can load into memory

To use these options:

1. Uncomment the relevant lines in the `.env` file.
2. Set your desired values.
3. Restart the Prometheus container for the changes to take effect:
   ```
   docker-compose down
   docker-compose up -d
   ```

## Accessing Prometheus
The Prometheus web interface is accessible at `http://localhost:9090` (replace `localhost` with your server's IP if needed). From here, you can:
- View and graph metrics
- Explore the status of scrape targets
- Use the PromQL query language to analyze your metrics

## Data Persistence
Prometheus data is stored in the directory specified by `PROMETHEUS_DATA_DIR`. Ensure this path exists on your host system and has appropriate permissions.

## Security Note
While this setup provides a good starting point, additional security measures should be implemented for production use, including:
- Setting up authentication for the Prometheus web interface
- Using HTTPS for secure communication
- Implementing proper firewall rules
- Regularly updating Prometheus and its dependencies
- Limiting access to the Prometheus API

## Troubleshooting
If you encounter issues, check the Prometheus logs using:
```
docker-compose logs prometheus
```

Common issues:
1. Configuration errors: Check your `prometheus.yml` file for syntax errors or misconfigurations.
2. Scrape failures: Verify that your targets are reachable and correctly configured.
3. Storage issues: Ensure that the data directory has sufficient disk space and proper permissions.
4. Resource constraints: Monitor CPU and memory usage, and adjust resources if needed.

## Contributing
Please feel free to submit issues, fork the repository and send pull requests!

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.
