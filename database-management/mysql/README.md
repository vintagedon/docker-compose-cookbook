# MySQL Docker Setup

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

MySQL is an open-source relational database management system. It is widely used for web applications, content management systems, and various software projects. This Docker setup provides an easy way to deploy and manage MySQL instances.

## Table of Contents

- [MySQL Docker Setup](#mysql-docker-setup)
  - [Table of Contents](#table-of-contents)
  - [Prerequisites](#prerequisites)
  - [Quick Start](#quick-start)
  - [Configuration](#configuration)
    - [Version Management](#version-management)
  - [Usage](#usage)
  - [Advanced Configuration](#advanced-configuration)
  - [Data Persistence](#data-persistence)
  - [Networking](#networking)
  - [Security Considerations](#security-considerations)
  - [Performance Tuning](#performance-tuning)
  - [Multi-Node Setup](#multi-node-setup)
  - [Upgrading](#upgrading)
  - [Troubleshooting](#troubleshooting)
  - [Contributing](#contributing)
  - [License](#license)
  - [Disclaimer](#disclaimer)

## Prerequisites

- Docker
- Docker Compose
- At least 512 MB RAM for MySQL container

## Quick Start

1. Clone this repository
2. Copy `.env.example` to `.env` and adjust the variables as needed
3. Run `docker-compose up -d`
4. Access MySQL using a client of your choice (e.g., MySQL Workbench) at localhost:3306

## Configuration

Basic configuration options are available in the `.env` file. For more detailed configuration, see [CONFIGURATION.md](docs/CONFIGURATION.md).

### Version Management

This setup uses the `latest` MySQL image to ensure you're always using the most up-to-date version. However, for production environments, you may want to specify a particular version for better consistency and easier rollback. To do this, modify the `image` line in `docker-compose.yml`:

```yaml
image: mysql:8.0 # Replace 8.0 with your desired version
```

Remember to test thoroughly when upgrading MySQL versions, as new versions may introduce changes that could affect your application.

## Usage

To connect to the MySQL instance:

```bash
docker exec -it mysql mysql -uroot -p
```

Enter the root password when prompted.

## Advanced Configuration

For advanced configuration options, including setting up replication and customizing MySQL configuration files, see [CONFIGURATION.md](docs/CONFIGURATION.md).

## Data Persistence

MySQL data is persisted in a Docker volume. By default, it's stored in `mysql_data` volume. You can change this in the `docker-compose.yml` file.

## Networking

The MySQL server is exposed on port 3306 by default. You can change this in the `.env` file.

## Security Considerations

For important security considerations and best practices, see [SECURITY.md](docs/SECURITY.md).

## Performance Tuning

For performance tuning tips and recommendations, see [PERFORMANCE_TUNING.md](docs/PERFORMANCE_TUNING.md).

## Multi-Node Setup

For information on setting up MySQL in a multi-node configuration, see [MULTI_NODE_SETUP.md](docs/MULTI_NODE_SETUP.md).

## Upgrading

For instructions on upgrading your MySQL instance, see [UPGRADING.md](docs/UPGRADING.md).

## Troubleshooting

For common issues and their solutions, see [TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md).

## Contributing

Please read [CONTRIBUTING.md](docs/CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Disclaimer

This Docker setup for MySQL is maintained independently. Always refer to the official MySQL documentation for authoritative information.
