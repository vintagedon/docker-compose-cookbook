# Ansible AWX Docker Setup

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Ansible AWX is the open-source version of Ansible Tower, a web-based solution that makes Ansible even more easy to use for IT teams of all kinds. It's designed to be the hub for all of your automation tasks.

## Table of Contents

- [Ansible AWX Docker Setup](#ansible-awx-docker-setup)
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
- At least 20GB of free disk space

## Quick Start

1. Clone this repository
2. Copy `.env.example` to `.env` and adjust the variables as needed
3. Run `docker-compose up -d`
4. Access Ansible AWX at http://localhost:8080
5. Log in using the default credentials (admin/password) and change the password immediately

## Configuration

Ansible AWX can be configured using environment variables in the `.env` file. For detailed configuration options, refer to the [CONFIGURATION.md](docs/CONFIGURATION.md) file.

## Usage

After starting the containers, you can access the Ansible AWX web interface and start creating inventories, projects, and job templates. For more information on how to use Ansible AWX, refer to the [official Ansible AWX documentation](https://docs.ansible.com/ansible-tower/).

## Advanced Configuration

For advanced configuration options, including setting up external databases, configuring LDAP authentication, and more, refer to the [CONFIGURATION.md](docs/CONFIGURATION.md) file.

## Data Persistence

Ansible AWX data is stored in Docker volumes to ensure persistence across container restarts. For more information on managing data, refer to the [Data Persistence](#data-persistence) section in this README.

## Networking

By default, Ansible AWX is accessible on port 8080. You can modify this in the `docker-compose.yml` file if needed. For more complex networking setups, refer to the [Networking](#networking) section in this README.

## Security Considerations

Security is crucial for Ansible AWX. Make sure to change default passwords, use HTTPS, and follow best practices for securing your installation. For more information, refer to the [SECURITY.md](docs/SECURITY.md) file.

## Performance Tuning

For tips on optimizing Ansible AWX performance, including memory allocation and database tuning, refer to the [PERFORMANCE_TUNING.md](docs/PERFORMANCE_TUNING.md) file.

## Multi-Node Setup

For information on setting up Ansible AWX in a multi-node configuration for high availability and scalability, refer to the [MULTI_NODE_SETUP.md](docs/MULTI_NODE_SETUP.md) file.

## Upgrading

For instructions on upgrading your Ansible AWX installation, refer to the [UPGRADING.md](docs/UPGRADING.md) file.

## Troubleshooting

If you encounter any issues, check the [TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md) file for common problems and their solutions.

## Contributing

We welcome contributions! Please see the [CONTRIBUTING.md](docs/CONTRIBUTING.md) file for details on how to contribute to this project.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Disclaimer

This is an unofficial Docker setup for Ansible AWX. For official installation methods, please refer to the [Ansible AWX documentation](https://github.com/ansible/awx/blob/devel/INSTALL.md).
