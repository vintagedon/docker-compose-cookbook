# Gitea Docker Setup with SQLite

This project contains a Docker Compose setup for Gitea using SQLite as the database, including basic and advanced configuration options.

Gitea is a lightweight, self-hosted Git service. It's a painless, self-hosted Git service that's easy to install and low on resource usage. This setup uses SQLite as the database backend, which is suitable for small to medium-sized installations and simplifies the overall setup.

**Disclaimer:** This setup is based on general best practices and may not reflect the most current configuration options or requirements for Gitea. Always refer to the [official Gitea documentation](https://docs.gitea.io/) for the most up-to-date and accurate information.

## GitHub Repository

https://github.com/vintagedon/docker-compose-cookbook/development-ci-cd/gitea-sqlite

## Prerequisites

- Docker
- Docker Compose
- Basic understanding of Git and version control systems

## Project Structure

```
.
├── docker-compose.yml
├── .env
└── README.md
```

## Files
- `docker-compose.yml`: Gitea service configuration
- `.env`: Environment variables for Gitea configuration
- `README.md`: Project information and instructions

## Usage

1. Edit the `.env` file with your desired configuration.
2. Run the container:

```bash
docker-compose up -d
```

3. Access Gitea at `http://localhost:3000` (or the port you specified in the `.env` file).

4. Check the logs to ensure Gitea is running correctly:

```bash
docker-compose logs gitea
```

You should see output similar to:

```
2023-07-27 12:00:00 INFO     [Gitea] Gitea v1.19.0 built with GNU Make 4.3, go1.20.5 : bindata, sqlite, sqlite_unlock_notify
2023-07-27 12:00:00 INFO     [Gitea] Log mode: console(info)
2023-07-27 12:00:00 INFO     [Gitea] SQLite3 support is enabled
2023-07-27 12:00:00 INFO     [Gitea] Run Mode: Production
2023-07-27 12:00:00 INFO     [Gitea] Listen: http://0.0.0.0:3000
```

## Expected Output

When Gitea is running correctly, you should see:

1. The Gitea web interface accessible at `http://localhost:3000` (or your specified port).
2. Log messages indicating successful startup and database connection.
3. The ability to create users, repositories, and perform Git operations.
4. The output of `docker ps` should show the Gitea container running. For example:

   ```
   $ docker ps
   CONTAINER ID   IMAGE                COMMAND                  CREATED          STATUS          PORTS                    NAMES
   abc123def456   gitea/gitea:latest   "/usr/bin/entrypoint…"   10 minutes ago   Up 10 minutes   0.0.0.0:3000->3000/tcp   gitea
   ```

## Configuration Options

### Basic Options

- `GITEA__database__DB_TYPE`: Database type (set to SQLite3)
- `GITEA__database__PATH`: Path to SQLite database file

### Common Options

- `USER_UID`: User ID for Gitea (default: 1000)
- `USER_GID`: Group ID for Gitea (default: 1000)
- `GITEA__server__ROOT_URL`: Public URL of your Gitea instance

### Advanced Options

- `GITEA__server__SSH_DOMAIN`: Domain name of your SSH server
- `GITEA__server__SSH_PORT`: SSH port number (if different from 22)

Usage:

1. Uncomment relevant lines in the `.env` file.
2. Set desired values.
3. Restart the container:

```bash
docker-compose down && docker-compose up -d
```

## Data Persistence

Gitea data is stored in Docker volumes:

- `gitea-data`: Contains Gitea's data, including repositories
- `gitea-config`: Contains Gitea's configuration files

These volumes ensure your data persists across container restarts and updates.

## Networking

The Gitea container is exposed on the host network. By default, it uses port 3000 for HTTP access and port 22 for SSH access. Ensure these ports are available on your host system or modify them in the `.env` file.

## Security Note

1. Change the default admin password after initial setup.
2. Use HTTPS in production environments.
3. Regularly update the Gitea image to get the latest security patches.
4. Limit SSH access if not needed.
5. Consider using external authentication (LDAP, OAuth) for larger installations.

## Troubleshooting

Check logs: `docker-compose logs gitea`

Common issues:

1. Cannot access Gitea web interface: Verify the port mapping in `docker-compose.yml` and your firewall settings.
2. Database errors: Ensure the SQLite database path is correct and the container has write permissions.

For more detailed troubleshooting, please refer to the [official Gitea documentation](https://docs.gitea.io/en-us/install-with-docker/).

## Contributing

Feel free to submit issues, fork the repository and send pull requests!

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
