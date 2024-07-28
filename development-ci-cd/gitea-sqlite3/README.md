# Gitea-SQLite3 Docker Setup

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Gitea is a painless self-hosted Git service. This Docker setup uses SQLite3 as the database backend, providing a lightweight and easy-to-deploy solution for version control and collaboration.

## Table of Contents

- [Gitea-SQLite3 Docker Setup](#gitea-sqlite3-docker-setup)
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
- At least 1GB of free memory

## Quick Start

1. Clone this repository
2. Copy `.env.example` to `.env` and adjust the variables as needed
3. Run `docker-compose up -d`
4. Access Gitea at http://localhost:3000
5. Follow the installation wizard to complete the setup

## Configuration

See [CONFIGURATION.md](docs/CONFIGURATION.md) for detailed configuration options.

## Usage

After the installation is complete, you can start using Gitea:

1. Create a new user account
2. Create or import repositories
3. Collaborate with other users

For more information on using Gitea, refer to the [official documentation](https://docs.gitea.io/).

## Advanced Configuration

For advanced configuration options, including customizing the `app.ini` file, see [CONFIGURATION.md](docs/CONFIGURATION.md).

## Data Persistence

Data is persisted using Docker volumes. The following volumes are created:

- `gitea_data`: Stores Gitea data and SQLite database
- `gitea_config`: Stores Gitea configuration files

## Networking

By default, Gitea is exposed on port 3000. You can change this in the `docker-compose.yml` file or by setting the `GITEA_HTTP_PORT` environment variable.

## Security Considerations

Refer to [SECURITY.md](docs/SECURITY.md) for important security considerations and best practices.

## Performance Tuning

For performance tuning tips, see [PERFORMANCE_TUNING.md](docs/PERFORMANCE_TUNING.md).

## Upgrading

For instructions on upgrading your Gitea instance, see [UPGRADING.md](docs/UPGRADING.md).

## Troubleshooting

If you encounter any issues, please check [TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md) for common problems and solutions.

## Contributing

We welcome contributions! Please see [CONTRIBUTING.md](docs/CONTRIBUTING.md) for details on how to contribute to this project.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Disclaimer

This Docker setup is not officially supported by the Gitea project. Use at your own risk.
