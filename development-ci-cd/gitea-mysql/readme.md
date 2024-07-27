# Gitea Docker Setup with MySQL

This project contains a Docker Compose setup for Gitea using MySQL as the database, including basic and advanced configuration options.

Gitea is a lightweight, self-hosted Git service. It's a painless, self-hosted Git service that's easy to install and low on resource usage. This setup uses MySQL as the database backend, which provides robust performance and is suitable for larger installations.

**Disclaimer:** This setup is based on general best practices and may not reflect the most current configuration options or requirements for Gitea. Always refer to the [official Gitea documentation](https://docs.gitea.io/) for the most up-to-date and accurate information.

## GitHub Repository

https://github.com/vintagedon/docker-compose-cookbook/development-ci-cd/gitea-mysql

## Prerequisites

- Docker
- Docker Compose
- Basic understanding of Git and version control systems
- Familiarity with MySQL databases

## Project Structure

```
.
├── docker-compose.yml
├── .env
└── README.md
```

## Files
- `docker-compose.yml`: Gitea and MySQL service configuration
- `.env`: Environment variables for Gitea and MySQL configuration
- `README.md`: Project information and instructions

## Usage

1. Edit the `.env` file with your desired configuration.
2. Run the containers:

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
2023-07-27 12:00:00 INFO     [Gitea] Gitea v1.19.0 built with GNU Make 4.3, go1.20.5 : bindata, mysql
2023-07-27 12:00:00 INFO     [Gitea] Log mode: console(info)
2023-07-27 12:00:00 INFO     [Gitea] MySQL support is enabled
2023-07-27 12:00:00 INFO     [Gitea] Run Mode: Production
2023-07-27 12:00:00 INFO     [Gitea] Listen: http://0.0.0.0:3000
```

## Expected Output

When Gitea is running correctly, you should see:

1. The Gitea web interface accessible at `http://localhost:3000` (or your specified port).
2. Log messages indicating successful startup and database connection.
3. The ability to create users, repositories, and perform Git operations.
4. The output of `docker ps` should show both the Gitea and MySQL containers running. For example:

   ```
   $ docker ps
   CONTAINER ID   IMAGE                COMMAND                  CREATED          STATUS          PORTS                    NAMES
   abc123def456   gitea/gitea:latest   "/usr/bin/entrypoint…"   10 minutes ago   Up 10 minutes   0.0.0.0:3000->3000/tcp   gitea
   789ghi101112   mysql:8              "docker-entrypoint.s…"   10 minutes ago   Up 10 minutes   3306/tcp                 gitea-mysql
   ```

## Configuration Options

### Basic Options

- `GITEA__database__DB_TYPE`: Database type (set to MySQL)
- `GITEA__database__HOST`: Database host (mysql:3306)
- `GITEA__database__NAME`: Database name
- `GITEA__database__USER`: Database user
- `GITEA__database__PASSWD`: Database password

### Common Options

- `USER_UID`: User ID for Gitea (default: 1000)
- `USER_GID`: Group ID for Gitea (default: 1000)
- `GITEA__server__ROOT_URL`: Public URL of your Gitea instance

### Advanced Options

- `GITEA__server__SSH_DOMAIN`: Domain name of your SSH server
- `GITEA__server__SSH_PORT`: SSH port number (if different from 22)
- `MYSQL_ROOT_PASSWORD`: Root password for MySQL

Usage:

1. Uncomment relevant lines in the `.env` file.
2. Set desired values.
3. Restart the containers:

```bash
docker-compose down && docker-compose up -d
```

## Data Persistence

Gitea and MySQL data are stored in Docker volumes:

- `gitea-data`: Contains Gitea's data, including repositories
- `gitea-config`: Contains Gitea's configuration files
- `mysql-data`: Contains MySQL database files

These volumes ensure your data persists across container restarts and updates.

## Networking

The Gitea container is exposed on the host network. By default, it uses port 3000 for HTTP access and port 22 for SSH access. The MySQL container is not exposed to the host network for security reasons, but is accessible to the Gitea container via the internal Docker network.

## Security Note

1. Change the default admin password after initial setup.
2. Use HTTPS in production environments.
3. Regularly update both Gitea and MySQL images to get the latest security patches.
4. Limit SSH access if not needed.
5. Consider using external authentication (LDAP, OAuth) for larger installations.
6. Use strong, unique passwords for MySQL root and Gitea database user.
7. Consider implementing database backups for data redundancy.

## Troubleshooting

Check logs: 
- For Gitea: `docker-compose logs gitea`
- For MySQL: `docker-compose logs mysql`

Common issues:

1. Cannot access Gitea web interface: Verify the port mapping in `docker-compose.yml` and your firewall settings.
2. Database connection errors: Ensure the MySQL container is running and the database credentials in the `.env` file are correct.
3. MySQL container fails to start: Check if the specified MySQL port is already in use on your host system.

For more detailed troubleshooting, please refer to the [official Gitea documentation](https://docs.gitea.io/en-us/install-with-docker/).

## Contributing

Feel free to submit issues, fork the repository and send pull requests!

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
