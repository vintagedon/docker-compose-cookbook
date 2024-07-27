# Development CI/CD

Welcome to the Development CI/CD section of the docker-compose-cookbook! This directory contains various Docker Compose configurations for setting up development, continuous integration, and continuous deployment tools.

## Table of Contents

1. [Available Setups](#available-setups)
2. [General Structure](#general-structure)
3. [Usage](#usage)
4. [Security Considerations](#security-considerations)
5. [Contributing](#contributing)
6. [License](#license)

## Available Setups

| Tool | Description | Repo Link |
|------|-------------|-----------|
| Gitea (MySQL) | Lightweight Git service with MySQL database | [gitea-mysql](https://github.com/vintagedon/docker-compose-cookbook/tree/main/development-ci-cd/gitea-mysql) |
| Gitea (PostgreSQL) | Lightweight Git service with PostgreSQL database | [gitea-postgresql](https://github.com/vintagedon/docker-compose-cookbook/tree/main/development-ci-cd/gitea-postgresql) |
| Gitea (SQLite) | Lightweight Git service with SQLite database | [gitea-sqlite](https://github.com/vintagedon/docker-compose-cookbook/tree/main/development-ci-cd/gitea-sqlite) |
| GitLab CE | Open-source end-to-end software development platform | [gitlabce](https://github.com/vintagedon/docker-compose-cookbook/tree/main/development-ci-cd/gitlabce) |
| Gogs (MySQL) | Simple, stable, and extensible self-hosted Git service with MySQL | [gogs-mysql](https://github.com/vintagedon/docker-compose-cookbook/tree/main/development-ci-cd/gogs-mysql) |
| Gogs (PostgreSQL) | Simple, stable, and extensible self-hosted Git service with PostgreSQL | [gogs-postgresql](https://github.com/vintagedon/docker-compose-cookbook/tree/main/development-ci-cd/gogs-postgresql) |
| Gogs (SQLite) | Simple, stable, and extensible self-hosted Git service with SQLite | [gogs-sqlite](https://github.com/vintagedon/docker-compose-cookbook/tree/main/development-ci-cd/gogs-sqlite) |
| Jenkins | Leading open-source automation server for CI/CD | [jenkins](https://github.com/vintagedon/docker-compose-cookbook/tree/main/development-ci-cd/jenkins) |

## General Structure

Each subdirectory typically contains the following files:

- `docker-compose.yml`: The main configuration file for the Docker services
- `.env`: Environment variables file (you may need to create this)
- Additional configuration files specific to the tool

## Usage

To use any of these setups, follow these general steps:

1. Navigate to the desired tool's directory
2. Create and configure the `.env` file if necessary
3. Run the Docker Compose command to start the services

For example, to set up Gitea with MySQL:

```bash
cd gitea-mysql
cp .env.example .env  # Create .env file from example if available
nano .env  # Edit the .env file to configure your settings
docker-compose up -d
```

Refer to the specific README in each tool's directory for detailed instructions and configuration options.

## Security Considerations

When working with development and CI/CD tools, keep these security practices in mind:

- Regularly update your Docker images and host system
- Use strong, unique passwords for all services
- Implement proper firewall rules to control access
- Be cautious when exposing services to the internet
- Regularly audit your configurations and logs
- Implement proper access controls and user management
- Secure your repositories and CI/CD pipelines
- Use HTTPS for all connections when possible

## Contributing

We welcome contributions to improve and expand this development and CI/CD toolkit! If you have suggestions, bug reports, or want to add a new tool, please feel free to open an issue or submit a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](https://github.com/vintagedon/docker-compose-cookbook/blob/main/LICENSE) file for full details.
