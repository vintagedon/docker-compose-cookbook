# Graylog Docker Setup

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Graylog is a powerful log management and analysis tool that works seamlessly with Elasticsearch for data storage and MongoDB for metadata storage. This Docker setup provides an easy way to deploy Graylog along with its required components.

## Table of Contents

- [Graylog Docker Setup](#graylog-docker-setup)
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
- Ports 9000 (Graylog web interface) and 12201 (GELF input) available on the host

## Quick Start

1. Clone this repository
2. Copy `.env.example` to `.env` and adjust the variables as needed
3. Run `docker-compose up -d`
4. Access the Graylog web interface at http://localhost:9000
5. Log in with the default credentials (admin/admin) and change the password immediately

## Configuration

See [CONFIGURATION.md](docs/CONFIGURATION.md) for detailed information on configuring Graylog, Elasticsearch, and MongoDB.

## Usage

After starting the containers, you can:

1. Access the Graylog web interface at http://localhost:9000
2. Configure inputs to start receiving logs
3. Create dashboards and alerts based on your log data

For more information on using Graylog, refer to the [official Graylog documentation](https://docs.graylog.org/).

## Advanced Configuration

For advanced configuration options, including:

- Configuring additional inputs
- Setting up log rotation
- Integrating with external authentication systems

Please refer to the [CONFIGURATION.md](docs/CONFIGURATION.md) file.

## Data Persistence

Data is persisted using Docker volumes. You can find the volume configuration in the `docker-compose.yml` file.

## Networking

By default, this setup creates a Docker network for communication between Graylog, Elasticsearch, and MongoDB. The Graylog web interface and GELF input ports are exposed to the host.

## Security Considerations

For important security considerations, including:

- Securing the Graylog web interface
- Encrypting communication between components
- Managing API tokens

Please refer to the [SECURITY.md](docs/SECURITY.md) file.

## Performance Tuning

For tips on optimizing performance, including:

- Adjusting Java heap sizes
- Optimizing Elasticsearch settings
- Scaling Graylog horizontally

Please refer to the [PERFORMANCE_TUNING.md](docs/PERFORMANCE_TUNING.md) file.

## Multi-Node Setup

For information on setting up a multi-node Graylog cluster, please refer to the [MULTI_NODE_SETUP.md](docs/MULTI_NODE_SETUP.md) file.

## Upgrading

For instructions on upgrading your Graylog setup, please refer to the [UPGRADING.md](docs/UPGRADING.md) file.

## Troubleshooting

For common issues and their solutions, please refer to the [TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md) file.

## Contributing

We welcome contributions! Please see the [CONTRIBUTING.md](docs/CONTRIBUTING.md) file for details on how to contribute to this project.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Disclaimer

This Docker setup is not officially maintained by Graylog, Inc. For production use, please refer to the official Graylog documentation and consider their recommended deployment methods.
