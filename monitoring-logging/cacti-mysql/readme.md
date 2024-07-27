# Cacti-MySQL Docker Setup

This project contains a Docker Compose setup for Cacti with MySQL, including basic and advanced configuration options.

Cacti is an open-source, web-based network monitoring and graphing tool designed as a frontend application for RRDtool's data storage and graphing functionality. It allows you to collect and visualize time-series data from various networked devices. This setup includes a MySQL database for Cacti's data storage.

## GitHub Repository

https://github.com/vintagedon/docker-compose-cookbook/monitoring-logging/cacti-mysql

## Prerequisites

- Docker
- Docker Compose

## Project Structure

```
.
├── docker-compose.yml
├── .env
└── README.md
```

## Files
- `docker-compose.yml`: Cacti and MySQL service configuration
- `.env`: Environment variables for Cacti and MySQL configuration
- `README.md`: Project information and instructions

## Usage

1. Edit the `.env` file with your desired configuration.
2. Run the containers:

```bash
docker-compose up -d
```

3. Access Cacti at http://your-host-ip:80 (or the port you've configured).

4. Check the logs to ensure Cacti is running correctly:

```bash
docker-compose logs cacti
```

You should see output similar to:

```
[httpd] Starting Apache web server...
[cacti] Initializing Cacti database...
[cacti] Cacti initialization complete. Starting cron service...
```

## Expected Output

When Cacti is running correctly, you should see:

1. The Cacti login page when accessing the web interface.
2. Successful database connection messages in the logs.
3. Periodic polling messages in the logs as Cacti collects data.
4. The output of `docker ps` should show both the Cacti and MySQL containers running. For example:

   ```
   $ docker ps
   CONTAINER ID   IMAGE                 COMMAND                  CREATED          STATUS          PORTS                               NAMES
   abc123def456   cacti/cacti:latest   "/entrypoint.sh"         10 minutes ago   Up 10 minutes   0.0.0.0:80->80/tcp                  cacti-mysql_cacti_1
   789ghi101112   mysql:5.7            "docker-entrypoint.s…"   10 minutes ago   Up 10 minutes   3306/tcp, 33060/tcp                 cacti-mysql_db_1
   ```

## Configuration Options

### Basic Options
- `MYSQL_HOST`: MySQL host (default: db)
- `MYSQL_PORT`: MySQL port (default: 3306)

### Common Options
- `CACTI_URL`: The URL where Cacti will be accessible
- `CACTI_CSRF_SECRET`: A secret key for CSRF protection
- `TZ`: Time zone for the containers

### Advanced Options
- `RDB_OPTIMIZATION`: Enable RRDtool optimization (default: 1)
- `SPINE_THREADS`: Number of threads for Spine poller (default: 10)

Usage:
1. Uncomment relevant lines in the `.env` file.
2. Set desired values.
3. Restart the containers:
```bash
docker-compose down && docker-compose up -d
```

## Data Persistence
Data is stored in the configured volumes. Ensure to back up these directories regularly:
- `./cacti`: Main Cacti application files
- `./rra`: RRD files for storing and graphing data
- `./mysql`: MySQL database files

## Security Note
- Always change the default admin password after initial setup.
- Use a strong `CACTI_CSRF_SECRET` to prevent CSRF attacks.
- Consider using HTTPS with a reverse proxy for secure access.
- Regularly update Cacti and MySQL to the latest versions to patch security vulnerabilities.

## Troubleshooting
Check logs: `docker-compose logs cacti` or `docker-compose logs db`

Common issues:
1. Database connection errors: Ensure MySQL is running and accessible.
2. Permissions issues: Check that the Cacti container has proper permissions for its volumes.

## Contributing
Feel free to submit issues, fork the repository and send pull requests!

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
