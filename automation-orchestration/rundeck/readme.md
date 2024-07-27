# Rundeck Docker Setup

This project contains a Docker Compose setup for Rundeck, including basic and advanced configuration options.

Rundeck is an open-source automation service with a web console, command-line tools, and a WebAPI. It lets you easily run automation tasks across a set of nodes.

**Disclaimer:** This setup is based on general best practices and may not reflect the most current configuration options or requirements for Rundeck. Always refer to the [official Rundeck documentation](https://docs.rundeck.com/docs/) for the most up-to-date and accurate information.

## GitHub Repository

https://github.com/vintagedon/docker-compose-cookbook/automation-orchestration/rundeck

## Prerequisites

- Docker
- Docker Compose
- At least 1GB of RAM available for Rundeck

## Project Structure

```
.
├── docker-compose.yml
├── .env
└── README.md
```

## Files
- `docker-compose.yml`: Rundeck service configuration
- `.env`: Environment variables for Rundeck configuration
- `README.md`: Project information and instructions

## Usage

1. Edit the `.env` file with your desired configuration.
2. Run the container:

```bash
docker-compose up -d
```

3. Access Rundeck at http://localhost:4440 (or the port you specified in the .env file).

4. Check the logs to ensure Rundeck is running correctly:

```bash
docker-compose logs rundeck
```

You should see output similar to:

```
rundeck    | Grails application running at http://localhost:4440 in environment: production
```

## Expected Output

When Rundeck is running correctly, you should see:

1. The Rundeck login page when accessing the web interface.
2. Log messages indicating successful startup and database initialization.
3. The ability to log in with the default credentials (admin/admin) unless changed in the configuration.
4. The output of `docker ps` should show the Rundeck container running. For example:

   ```
   $ docker ps
   CONTAINER ID   IMAGE            COMMAND                  CREATED          STATUS          PORTS                               NAMES
   abc123def456   rundeck/rundeck   "/tini -- /docker-en…"   10 minutes ago   Up 10 minutes   0.0.0.0:4440->4440/tcp            rundeck
   ```

## Configuration Options

### Basic Options
- `RUNDECK_GRAILS_URL`: The base URL for Rundeck (e.g., http://localhost:4440)
- `RUNDECK_SERVER_ADDRESS`: The IP address or hostname Rundeck should bind to

### Common Options
- `RUNDECK_DATABASE_URL`: JDBC URL for the database
- `RUNDECK_DATABASE_DRIVER`: Database driver class name
- `RUNDECK_DATABASE_USERNAME`: Database username
- `RUNDECK_DATABASE_PASSWORD`: Database password

### Advanced Options
- `RUNDECK_SECURITY_HTTPHEADERS_ENABLED`: Enable additional HTTP security headers
- `RUNDECK_SECURITY_CSP_ENABLED`: Enable Content Security Policy

Usage:
1. Uncomment relevant lines in the `.env` file.
2. Set desired values.
3. Restart the container:
```bash
docker-compose down && docker-compose up -d
```

## Data Persistence
Rundeck data is stored in the volume specified by `RUNDECK_DATADIR` in the `.env` file. This ensures that your projects, jobs, and other configurations persist across container restarts.

## Security Note
- Change the default admin password immediately after the first login.
- Use HTTPS in production environments by setting up a reverse proxy with SSL termination.
- Regularly update the Rundeck image to the latest version to get security patches.

## Troubleshooting
Check logs: `docker-compose logs rundeck`

Common issues:
1. Unable to access Rundeck web interface: Ensure the correct ports are exposed and not blocked by a firewall.
2. Database connection issues: Verify the database credentials and connection string in the `.env` file.

For more detailed troubleshooting, please refer to the [official Rundeck documentation](https://docs.rundeck.com/docs/administration/maintenance/troubleshooting.html).

## Contributing
Feel free to submit issues, fork the repository and send pull requests!

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
