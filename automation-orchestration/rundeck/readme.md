# Rundeck Docker Setup

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Rundeck is an open-source automation service with a web console, command-line tools, and a WebAPI. It allows you to easily run automation tasks across a set of nodes.

## Table of Contents

- [Rundeck Docker Setup](#rundeck-docker-setup)
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
│   └── init.sh
├── docker-compose.yml
├── .env.example
├── .gitignore
├── LICENSE
└── README.md
```

## Prerequisites

- Docker
- Docker Compose
- At least 4GB of free memory

## Quick Start

1. Clone this repository
2. Copy `.env.example` to `.env` and adjust the variables as needed
3. Run `docker-compose up -d`
4. Access Rundeck web interface at http://localhost:4440
5. Log in using the default credentials (admin/admin) and change the password immediately

## Configuration

Refer to the [CONFIGURATION.md](docs/CONFIGURATION.md) file for detailed information on configuring your Rundeck instance.

## Usage

After starting the Rundeck container, you can:

1. Create projects
2. Define jobs
3. Schedule tasks
4. Monitor executions

For more detailed usage instructions, please refer to the [official Rundeck documentation](https://docs.rundeck.com/).

## Advanced Configuration

For advanced configuration options, including custom plugins and external database integration, see the [CONFIGURATION.md](docs/CONFIGURATION.md) file.

## Data Persistence

Rundeck data is persisted using Docker volumes. You can find the volume configuration in the `docker-compose.yml` file.

## Networking

By default, Rundeck is exposed on port 4440. You can modify this in the `docker-compose.yml` file if needed.

## Security Considerations

Please refer to the [SECURITY.md](docs/SECURITY.md) file for important security considerations and best practices.

## Performance Tuning

For tips on optimizing Rundeck performance, see the [PERFORMANCE_TUNING.md](docs/PERFORMANCE_TUNING.md) file.

## Multi-Node Setup

Instructions for setting up a multi-node Rundeck environment can be found in the [MULTI_NODE_SETUP.md](docs/MULTI_NODE_SETUP.md) file.

## Upgrading

For information on upgrading your Rundeck instance, please refer to the [UPGRADING.md](docs/UPGRADING.md) file.

## Troubleshooting

If you encounter any issues, please check the [TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md) file for common problems and their solutions.

## Contributing

We welcome contributions! Please see the [CONTRIBUTING.md](docs/CONTRIBUTING.md) file for details on how to contribute to this project.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Disclaimer

This Docker setup is not officially supported by Rundeck. Use at your own risk.
