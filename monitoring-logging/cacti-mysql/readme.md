# Cacti with MySQL Docker Setup

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Cacti is a comprehensive network monitoring and graphing tool designed to harness the power of RRDTool's data storage and graphing functionality. This Docker setup includes Cacti along with MySQL for database management, providing a robust solution for monitoring and logging network performance.

## Table of Contents

- [Cacti with MySQL Docker Setup](#cacti-with-mysql-docker-setup)
  - [Table of Contents](#table-of-contents)
  - [Project Structure](#project-structure)
  - [Prerequisites](#prerequisites)
  - [Quick Start](#quick-start)
  - [Configuration](#configuration)
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

## Project Structure

```
.
├── .github/
│   └── ISSUE_TEMPLATE/
│       ├── bug_report.md
│       └── feature_request.md
├── docs/
│   ├── CONFIGURATION.md
│   ├── CONTRIBUTING.md
│   ├── MULTI_NODE_SETUP.md
│   ├── PERFORMANCE_TUNING.md
│   ├── SECURITY.md
│   ├── TROUBLESHOOTING.md
│   └── UPGRADING.md
├── scripts/
│   └── init.sql
├── docker-compose.yml
├── .env.example
├── .gitignore
├── LICENSE
└── README.md
```

## Prerequisites

- Docker
- Docker Compose
- At least 2GB of free memory

## Quick Start

1. Clone this repository
2. Copy `.env.example` to `.env` and adjust the variables as needed
3. Run `docker-compose up -d`
4. Access Cacti web interface at http://localhost:80
5. Log in using the default credentials (admin/admin) and set a new password

## Configuration

See [CONFIGURATION.md](docs/CONFIGURATION.md) for detailed information on configuring Cacti and MySQL for optimal monitoring and logging performance.

## Usage

After starting the containers, you can access the Cacti web interface to set up your network monitoring and logging tasks. Cacti provides a wide range of features for collecting, storing, and visualizing network performance data.

## Advanced Configuration

For advanced configuration options, including setting up custom data sources and graph templates, refer to [CONFIGURATION.md](docs/CONFIGURATION.md).

## Data Persistence

Monitoring and logging data is persisted through Docker volumes. See docker-compose.yml for volume configurations.

## Networking

By default, the Cacti web interface is exposed on port 80. MySQL is not exposed externally for security reasons.

## Security Considerations

Refer to [SECURITY.md](docs/SECURITY.md) for important security information and best practices for securing your monitoring and logging setup.

## Performance Tuning

For performance tuning tips specific to monitoring and logging workloads, see [PERFORMANCE_TUNING.md](docs/PERFORMANCE_TUNING.md).

## Multi-Node Setup

Information on setting up Cacti in a multi-node environment for distributed monitoring and logging can be found in [MULTI_NODE_SETUP.md](docs/MULTI_NODE_SETUP.md).

## Upgrading

For upgrade instructions specific to this monitoring and logging setup, refer to [UPGRADING.md](docs/UPGRADING.md).

## Troubleshooting

If you encounter issues with your monitoring or logging setup, check [TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md) for common problems and solutions.

## Contributing

We welcome contributions to improve this monitoring and logging setup! Please see [CONTRIBUTING.md](docs/CONTRIBUTING.md) for details on how to contribute.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Disclaimer

This is an unofficial Docker setup for Cacti. While we strive to maintain best practices for monitoring and logging, please use it at your own risk and refer to the official Cacti documentation for authoritative information.
