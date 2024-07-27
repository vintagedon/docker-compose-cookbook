# Gogs Docker Setup with PostgreSQL

This project contains a Docker Compose setup for Gogs, a self-hosted Git service, using PostgreSQL as the database backend. This setup includes basic and advanced configuration options suitable for home lab use.

Gogs is a painless self-hosted Git service written in Go. It aims to be the easiest, fastest, and most painless way of setting up a self-hosted Git service. With Gogs, you can easily set up your own GitHub-like Git server.

**Disclaimer:** This setup is based on general best practices and may not reflect the most current configuration options or requirements for Gogs. Always refer to the [official Gogs documentation](https://gogs.io/docs) for the most up-to-date and accurate information.

## GitHub Repository

https://github.com/vintagedon/docker-compose-cookbook/development-ci-cd/gogs-postgresql

## Prerequisites

- Docker
- Docker Compose
- Basic understanding of Git and version control systems
- Familiarity with PostgreSQL database

## Project Structure

```
.
├── docker-compose.yml
├── .env
└── README.md
```

## Files
- `docker-compose.yml`: Gogs and PostgreSQL service configuration
- `.env`: Environment variables for Gogs and PostgreSQL configuration
- `README.md`: Project information and instructions

## Usage

1. Edit the `.env` file with your desired configuration.
2. Run the containers:

```bash
docker-compose up -d
```

3. Access Gogs at `http://your-server-ip:3000`. On first run, you'll be redirected to the installation page.

4. Check the logs to ensure Gogs and PostgreSQL are running correctly:

```bash
docker-compose logs gogs postgres
```

You should see output similar to:

```
gogs_1      | 2023/07/27 12:00:00 [INFO] Gogs 0.12.3
gogs_1      | 2023/07/27 12:00:00 [INFO] Cache Service Enabled
gogs_1      | 2023/07/27 12:00:00 [INFO] Session Service Enabled
gogs_1      | 2023/07/27 12:00:00 [INFO] Run Mode: Production
gogs_1      | 2023/07/27 12:00:00 [INFO] Listen: http://0.0.0.0:3000
postgres_1  | 2023-07-27 12:00:00.000 UTC [1] LOG:  database system is ready to accept connections
```

## Expected Output

When Gogs and PostgreSQL are running correctly, you should see:

1. Both the Gogs and PostgreSQL containers running without any error messages in the logs.
2. The Gogs web interface accessible at `http://your-server-ip:3000`.
3. Ability to create users, repositories, and perform Git operations.
4. The output of `docker ps` should show both containers running. For example:

   ```
   $ docker ps
   CONTAINER ID   IMAGE                 COMMAND                  CREATED          STATUS          PORTS                    NAMES
   abc123def456   gogs/gogs:latest      "/app/gogs/docker/s…"   10 minutes ago   Up 10 minutes   0.0.0.0:3000->3000/tcp   gogs
   789012ghi345   postgres:13           "docker-entrypoint.s…"   10 minutes ago   Up 10 minutes   5432/tcp                 gogs-postgres
   ```

## Configuration Options

### Basic Options

- `GOGS_PORT`: The external port on which Gogs will be accessible (default: 3000)
- `GOGS_CONTAINER_NAME`: The name of the Gogs Docker container (default: gogs)
- `POSTGRES_CONTAINER_NAME`: The name of the PostgreSQL Docker container (default: gogs-postgres)

### Common Options

- `GOGS_APP_NAME`: The name of your Gogs instance (default: Gogs)
- `GOGS_RUN_MODE`: The run mode for Gogs (default: prod)
- `GOGS_DOMAIN`: The domain name of your Gogs instance (default: localhost)
- `GOGS_SSH_PORT`: The SSH port for Git operations (default: 22)
- `POSTGRES_USER`: The PostgreSQL user for Gogs (default: gogs)
- `POSTGRES_PASSWORD`: The PostgreSQL password for Gogs (default: gogspassword)
- `POSTGRES_DB`: The PostgreSQL database name for Gogs (default: gogs)

### Advanced Options

- `GOGS_SECRET_KEY`: A secret key for Gogs internal usage. Should be a long random string.
- `GOGS_DISABLE_REGISTRATION`: Set to true to disable self-registration (default: false)
- `GOGS_REQUIRE_SIGNIN_VIEW`: Set to true to require signin to view any page (default: false)

Usage:

1. Uncomment relevant lines in the `.env` file.
2. Set desired values.
3. Restart the containers:

```bash
docker-compose down && docker-compose up -d
```

## Data Persistence

Gogs and PostgreSQL data are stored in Docker volumes. You can choose between anonymous volumes (default) or named volumes:

### Anonymous Volumes (default):
- gogs_data: Stores Gogs data, including repositories
- gogs_config: Stores Gogs configuration files
- postgres_data: Stores PostgreSQL database files

### Named Volumes:
If you set `USE_NAMED_VOLUMES=true` in the `.env` file, the following named volumes will be used:
- gogs_data: Stores Gogs data, including repositories
- gogs_config: Stores Gogs configuration files
- postgres_data: Stores PostgreSQL database files

These volumes ensure your data persists across container restarts and updates. Named volumes make it easier to backup and manage your data.

## Networking

Gogs and PostgreSQL use a custom bridge network created by Docker Compose. This network, named `gogs_network`, allows the Gogs and PostgreSQL containers to communicate with each other while isolating them from other Docker networks.

## Security Note

1. Always use strong passwords for your Gogs accounts and PostgreSQL database.
2. Consider using HTTPS by setting up a reverse proxy (like Nginx) in front of Gogs.
3. Regularly update your Gogs and PostgreSQL instances to the latest versions to get security fixes.
4. Be cautious when exposing the SSH port (22) to the internet. Consider using a non-standard port for SSH.
5. Enable two-factor authentication for additional security.
6. The PostgreSQL port (5432) is not exposed outside the Docker network by default. If you need to access it externally, do so with caution and proper security measures.

## Troubleshooting

Check logs: `docker-compose logs gogs postgres`

Common issues:

1. Can't access Gogs web interface: Ensure the correct port is exposed in `docker-compose.yml` and not blocked by your firewall.
2. Git push/pull fails: Check if the SSH port is correctly configured and accessible.
3. Database connection errors: Ensure PostgreSQL is running and the connection details in Gogs configuration are correct.
4. PostgreSQL fails to start: Check if the data directory has the correct permissions.

For more detailed troubleshooting, please refer to the [official Gogs documentation](https://gogs.io/docs/intro/troubleshooting) and [PostgreSQL documentation](https://www.postgresql.org/docs/current/troubleshooting.html).

## Contributing

Feel free to submit issues, fork the repository and send pull requests!

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
