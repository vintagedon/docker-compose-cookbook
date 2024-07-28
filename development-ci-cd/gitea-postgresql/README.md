# Gitea with PostgreSQL Docker Setup

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Gitea is a painless self-hosted Git service. This setup includes PostgreSQL as the database backend for Gitea.

## Table of Contents

- [Gitea with PostgreSQL Docker Setup](#gitea-with-postgresql-docker-setup)
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
4. Access Gitea web interface at http://localhost:3000
5. Follow the installation wizard to complete the setup

## Configuration

See [CONFIGURATION.md](docs/CONFIGURATION.md) for detailed configuration options.

## Usage

After the quick start, you can use Gitea as your self-hosted Git service. Create repositories, manage users, and collaborate on projects.

## Advanced Configuration

For advanced configuration options, including SSL setup and custom themes, refer to the [Gitea documentation](https://docs.gitea.io/).

## Data Persistence

Data is persisted through Docker volumes. Gitea data is stored in the `gitea_data` volume, and PostgreSQL data in the `postgres_data` volume.

## Networking

By default, Gitea is accessible on port 3000, and SSH on port 22. Adjust these in the `docker-compose.yml` file if needed.

## Security Considerations

Refer to [SECURITY.md](docs/SECURITY.md) for important security considerations and best practices.

## Performance Tuning

For performance optimization tips, see [PERFORMANCE_TUNING.md](docs/PERFORMANCE_TUNING.md).

## Multi-Node Setup

For information on setting up Gitea in a multi-node environment, see [MULTI_NODE_SETUP.md](docs/MULTI_NODE_SETUP.md).

## Upgrading

For upgrade instructions, refer to [UPGRADING.md](docs/UPGRADING.md).

## Troubleshooting

If you encounter issues, check [TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md) for common problems and solutions.

## Contributing

Contributions are welcome! Please see [CONTRIBUTING.md](docs/CONTRIBUTING.md) for details.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Disclaimer

This is an unofficial Docker setup for Gitea. For official support, please refer to the [Gitea documentation](https://docs.gitea.io/).
