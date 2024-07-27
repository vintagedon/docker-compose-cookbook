# GitLab CE Docker Setup

This project contains a Docker Compose setup for GitLab CE (Community Edition), including basic and advanced configuration options.

GitLab CE is a complete DevOps platform that enables professionals to perform all the tasks in a project—from project planning and source code management to monitoring and security. It provides source code management, issue tracking, CI/CD pipeline features, and more.

**Disclaimer:** This setup is based on general best practices and may not reflect the most current configuration options or requirements for GitLab CE. Always refer to the [official GitLab documentation](https://docs.gitlab.com/ee/install/docker.html) for the most up-to-date and accurate information.

## GitHub Repository

https://github.com/vintagedon/docker-compose-cookbook/development-ci-cd/gitlabce

## Prerequisites

- Docker
- Docker Compose
- At least 4GB of free RAM (8GB recommended)
- At least 2 CPU cores

## Project Structure

```
.
├── docker-compose.yml
├── .env
└── README.md
```

## Files
- `docker-compose.yml`: GitLab CE service configuration
- `.env`: Environment variables for GitLab CE configuration
- `README.md`: Project information and instructions

## Usage

1. Edit the `.env` file with your desired configuration.
2. Run the container:

```bash
docker-compose up -d
```

3. Access GitLab CE at `http://localhost:8080` (or the port you specified).

4. Check the logs to ensure GitLab CE is running correctly:

```bash
docker-compose logs gitlab
```

You should see output similar to:

```
gitlab_1  | ================================================================================
gitlab_1  | GitLab is taking longer than expected to start up.
gitlab_1  | Please check the logs using: docker logs -f gitlab
gitlab_1  | 
gitlab_1  | For more information see:
gitlab_1  | https://docs.gitlab.com/omnibus/settings/logs.html
gitlab_1  | ================================================================================
gitlab_1  | gitlab Reconfigured!
```

## Expected Output

When GitLab CE is running correctly, you should see:

1. The GitLab CE container running without any error messages in the logs.
2. The GitLab web interface accessible at the configured URL.
3. Ability to create a new account or log in with the root account.
4. The output of `docker ps` should show the GitLab CE container running. For example:

   ```
   $ docker ps
   CONTAINER ID   IMAGE                     COMMAND             CREATED          STATUS                    PORTS                                                 NAMES
   abc123def456   gitlab/gitlab-ce:latest   "/assets/wrapper"   10 minutes ago   Up 10 minutes (healthy)   0.0.0.0:22->22/tcp, 0.0.0.0:8080->80/tcp, 443/tcp     gitlab
   ```

## Configuration Options

### Basic Options

- `GITLAB_HOME`: Directory where GitLab data will be stored
- `GITLAB_EXTERNAL_URL`: The URL where your GitLab CE instance will be accessible

### Common Options

- `GITLAB_ROOT_PASSWORD`: Initial password for the root user
- `GITLAB_INCOMING_EMAIL_ADDRESS`: Email address for incoming emails
- `SMTP_ENABLED`: Enable/disable SMTP
- `SMTP_HOST`: SMTP server hostname

### Advanced Options

- `GITLAB_OMNIBUS_CONFIG`: Additional GitLab configuration options
- `GITLAB_PAGES_ENABLED`: Enable/disable GitLab Pages

Usage:

1. Uncomment relevant lines in the `.env` file.
2. Set desired values.
3. Restart the container:

```bash
docker-compose down && docker-compose up -d
```

## Data Persistence

GitLab CE data is stored in the directory specified by `GITLAB_HOME` in the `.env` file. This includes repositories, database, and configuration files. Ensure this directory is backed up regularly.

## Networking

The GitLab CE container is connected to a Docker network named `gitlab_network`. This network can be used to connect other services that need to interact with GitLab.

## Security Note

- Change the root password immediately after the first login.
- Use HTTPS in production environments.
- Regularly update the GitLab CE image to get the latest security patches.
- Restrict access to the Docker host machine.

## Troubleshooting

Check logs: `docker-compose logs gitlab`

Common issues:

1. GitLab takes too long to start: This is normal for the first run. Wait for at least 5 minutes.
2. "Permission denied" errors: Ensure the `GITLAB_HOME` directory has the correct permissions.

For more detailed troubleshooting, please refer to the [official GitLab documentation](https://docs.gitlab.com/ee/administration/troubleshooting/).

## Contributing

Feel free to submit issues, fork the repository and send pull requests!

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
