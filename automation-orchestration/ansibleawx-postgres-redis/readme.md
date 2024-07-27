# Ansible AWX Docker Setup

This project contains a Docker Compose setup for Ansible AWX, including PostgreSQL and Redis, with basic and advanced configuration options.

Ansible AWX is the open-source version of Ansible Tower, a web-based solution that makes Ansible even more easy to use for IT teams of all kinds. It provides a user interface, REST API, and task engine for Ansible.

**Disclaimer:** This setup is based on general best practices and may not reflect the most current configuration options or requirements for Ansible AWX. Always refer to the [official Ansible AWX documentation](https://github.com/ansible/awx/blob/devel/INSTALL.md) for the most up-to-date and accurate information.

## GitHub Repository

https://github.com/vintagedon/docker-compose-cookbook/automation-orchestration/ansibleawx-postgres-redis

## Prerequisites

- Docker
- Docker Compose
- At least 4GB of RAM
- At least 2 CPU cores
- At least 20GB of free disk space

## Project Structure

```
.
├── docker-compose.yml
├── .env
└── README.md
```

## Files
- `docker-compose.yml`: Ansible AWX, PostgreSQL, and Redis service configuration
- `.env`: Environment variables for the setup configuration
- `README.md`: Project information and instructions

## Usage

1. Edit the `.env` file with your desired configuration.
2. Run the containers:

```bash
docker-compose up -d
```

3. Access Ansible AWX at http://localhost:80 (or the port you specified in the .env file).

4. Check the logs to ensure all services are running correctly:

```bash
docker-compose logs
```

You should see output similar to:

```
ansibleawx_1   | Operations to perform:
ansibleawx_1   |   Apply all migrations: auth, conf, contenttypes, django_celery_results, main, oauth2_provider, sessions, sites, social_django, sso, taggit
ansibleawx_1   | Running migrations:
...
ansibleawx_1   | Starting uwsgi with command: /usr/local/bin/uwsgi --socket 0.0.0.0:8050 --module awx.wsgi:application --vacuum --processes 5 --harakiri 120 --no-orphans --master --max-requests 1000 --master-fifo /var/lib/awx/awxfifo --lazy-apps -b 32768
postgres_1     | PostgreSQL init process complete; ready for start up.
redis_1        | 1:M 27 Jul 2024 12:00:00.000 # Server initialized
```

## Expected Output

When the setup is running correctly, you should see:

1. The Ansible AWX web interface is accessible at http://localhost:80 (or your specified port).
2. You can log in with the default credentials (unless changed in the .env file).
3. The AWX interface loads without errors and you can navigate through different sections.
4. The output of `docker ps` should show the containers running. For example:

   ```
   $ docker ps
   CONTAINER ID   IMAGE                COMMAND                  CREATED          STATUS          PORTS                                   NAMES
   abc123def456   ansible/awx:latest   "/usr/bin/tini -- /u…"   10 minutes ago   Up 10 minutes   0.0.0.0:80->8052/tcp                    ansibleawx-postgres-redis_ansibleawx_1
   def456ghi789   postgres:12          "docker-entrypoint.s…"   10 minutes ago   Up 10 minutes   5432/tcp                                ansibleawx-postgres-redis_postgres_1
   ghi789jkl012   redis:6              "docker-entrypoint.s…"   10 minutes ago   Up 10 minutes   6379/tcp                                ansibleawx-postgres-redis_redis_1
   ```

## Configuration Options

### Basic Options
- `POSTGRES_DATA_DIR`: Directory to store PostgreSQL data
- `AWX_ADMIN_USER`: Admin username for AWX
- `AWX_ADMIN_PASSWORD`: Admin password for AWX

### Common Options
- `AWX_HOST_PORT`: The port to access AWX on the host machine
- `POSTGRES_PASSWORD`: Password for the PostgreSQL database
- `AWX_SECRET_KEY`: Secret key for AWX

### Advanced Options
- `AWX_REPLICAS`: Number of AWX task replicas to run
- `AWX_TASK_TIMEOUT`: Timeout for AWX tasks in seconds

Usage:
1. Uncomment relevant lines in the `.env` file.
2. Set desired values.
3. Restart the containers:
```bash
docker-compose down && docker-compose up -d
```

## Data Persistence
Ansible AWX data is stored in the PostgreSQL database. The database files are persisted in the directory specified by `POSTGRES_DATA_DIR` in the .env file.

## Security Note
- Change the default admin password immediately after first login.
- Use strong, unique passwords for the admin user and PostgreSQL database.
- Consider using a reverse proxy with HTTPS for production deployments.
- Regularly update the Ansible AWX, PostgreSQL, and Redis images to get the latest security patches.

## Troubleshooting
Check logs: `docker-compose logs`

Common issues:
1. Database connection issues: Ensure the PostgreSQL container is running and the password is correct.
2. Web interface not accessible: Check if the correct port is exposed and not in use by another service.
3. Out of memory errors: Ensure your system meets the minimum RAM requirements (4GB).

For more detailed troubleshooting, please refer to the [official Ansible AWX documentation](https://github.com/ansible/awx/blob/devel/INSTALL.md).

## Contributing
Feel free to submit issues, fork the repository and send pull requests!

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
