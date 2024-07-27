# Fluentd Docker Setup

This project contains a Docker Compose setup for Fluentd, including basic and advanced configuration options.

Fluentd is an open-source data collector for unified logging layer. It allows you to unify data collection and consumption for a better use and understanding of data.

## GitHub Repository

https://github.com/vintagedon/docker-compose-cookbook/monitoring-logging/fluentd

## Prerequisites

- Docker
- Docker Compose
- Basic understanding of log management and data pipelines

## Project Structure

```
.
├── docker-compose.yml
├── .env
├── fluent.conf
└── README.md
```

## Files
- `docker-compose.yml`: Fluentd service configuration
- `.env`: Environment variables for Fluentd configuration
- `fluent.conf`: Fluentd configuration file
- `README.md`: Project information and instructions

## Usage

1. Edit the `.env` file with your desired configuration.
2. Customize the `fluent.conf` file to set up your data sources and outputs.
3. Run the container:

```bash
docker-compose up -d
```

4. Fluentd will start collecting and forwarding logs based on your configuration.

5. Check the logs to ensure Fluentd is running correctly:

   ```bash
   docker-compose logs fluentd
   ```

   You should see output similar to:

   ```
   fluentd_1  | 2023-07-27 12:00:00 +0000 [info]: parsing config file is succeeded path="/fluentd/etc/fluent.conf"
   fluentd_1  | 2023-07-27 12:00:00 +0000 [info]: using configuration file: <ROOT>
   fluentd_1  |   <source>
   fluentd_1  |     @type forward
   fluentd_1  |     port 24224
   fluentd_1  |     bind 0.0.0.0
   fluentd_1  |   </source>
   fluentd_1  |   <match **>
   fluentd_1  |     @type file
   fluentd_1  |     path /fluentd/log/${tag}
   fluentd_1  |     append true
   fluentd_1  |     <buffer>
   fluentd_1  |       timekey 1d
   fluentd_1  |       timekey_use_utc true
   fluentd_1  |       timekey_wait 10m
   fluentd_1  |     </buffer>
   fluentd_1  |   </match>
   fluentd_1  | </ROOT>
   fluentd_1  | 2023-07-27 12:00:00 +0000 [info]: starting fluentd-1.16.1 pid=1 ruby="3.1.4"
   fluentd_1  | 2023-07-27 12:00:00 +0000 [info]: spawn command to main:  cmdline=["/usr/bin/ruby", "-Eascii-8bit:ascii-8bit", "/usr/bin/fluentd", "-c", "/fluentd/etc/fluent.conf", "-p", "/fluentd/plugins", "--under-supervisor"]
   fluentd_1  | 2023-07-27 12:00:00 +0000 [info]: adding match pattern="**" type="file"
   fluentd_1  | 2023-07-27 12:00:00 +0000 [info]: adding source type="forward"
   fluentd_1  | 2023-07-27 12:00:00 +0000 [info]: #0 starting fluentd worker pid=6 ppid=1 worker=0
   fluentd_1  | 2023-07-27 12:00:00 +0000 [info]: #0 fluentd worker is now running worker=0
   ```

## Expected Output

When Fluentd is running correctly, you should see:

1. The log output as shown in the Usage section above, indicating that Fluentd has started successfully and loaded its configuration.

2. The log files specified in your `fluent.conf` should be created in the mapped log directory. For the default configuration, you should see files appearing in the `./log` directory.

3. If you've set up any input sources (like the forward input in the default configuration), you should be able to send test log messages and see them processed. For example, using the `fluent-cat` command:
   ```
   echo '{"message":"Hello Fluentd!"}' | fluent-cat test.tag
   ```
   This should result in a new log file in your log directory containing this message.

4. If you've set up any outputs to external systems (like Elasticsearch or S3), you should see logs appearing in those systems.

5. The Fluentd process should be running inside the container. You can verify this with:
   ```
   docker-compose exec fluentd ps aux | grep fluentd
   ```
   You should see at least one fluentd process running.

6. The output of `docker ps` should show the Fluentd container running. For example:

   ```
   $ docker ps
   CONTAINER ID   IMAGE                 COMMAND                  CREATED          STATUS          PORTS                               NAMES
   abc123def456   fluent/fluentd:v1.16-1   "/bin/entrypoint.sh …"   10 minutes ago   Up 10 minutes   0.0.0.0:24224->24224/tcp, 24224/udp   fluentd
   ```

   This output confirms that the Fluentd container is up and running, and the necessary ports are properly mapped.

If you don't see these expected outputs, refer to the Troubleshooting section below.

## Configuration Options

### Basic Options
- `FLUENTD_CONF`: Path to the Fluentd configuration file
- `LOG_LEVEL`: Log level for Fluentd (trace, debug, info, warn, error, fatal)

### Common Options
- `FLUENT_UID`: User ID to run Fluentd
- `FLUENT_GID`: Group ID to run Fluentd
- `TZ`: Timezone for the container

### Advanced Options
- `FLUENT_CONF_ENCODING`: Specify the encoding of the configuration file (e.g., utf-8)
- `FLUENT_WORKERS`: Number of workers to run Fluentd with (for performance tuning)
- `FLUENT_ROOT_DIR`: Root directory for Fluentd (useful for custom plugins)
- `FLUENT_DISABLE_SHARED_SOCKET`: Disable shared socket between workers (true/false)

Usage:
1. Uncomment relevant lines in the `.env` file.
2. Set desired values.
3. Restart the container:

```bash
docker-compose down && docker-compose up -d
```

## Data Persistence
Fluentd stores its logs and buffer files in the `/fluentd/log` and `/fluentd/data` directories respectively. These are mapped to volumes in the Docker Compose file to ensure data persistence.

## Security Note
- Always use secure protocols (like HTTPS) when sending logs over the network.
- Be cautious about logging sensitive information.
- Regularly update Fluentd and its plugins to the latest versions to address any security vulnerabilities.
- Consider using environment variables for sensitive configuration values instead of hardcoding them in `fluent.conf`.

## Troubleshooting
Check logs: `docker-compose logs fluentd`

Common issues:
1. Configuration syntax errors: Double-check your `fluent.conf` file for any syntax issues.
2. Permission issues: Ensure the `FLUENT_UID` and `FLUENT_GID` are set correctly and have necessary permissions.
3. Plugin missing: If you're using custom plugins, make sure they're properly installed and configured.

## Contributing
Feel free to submit issues, fork the repository and send pull requests!

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
