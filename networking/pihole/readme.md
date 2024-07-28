# Pi-hole Docker Setup

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Pi-hole is a network-wide ad blocker that acts as a DNS sinkhole and optionally a DHCP server, intended for use on a private network. This Docker setup allows you to quickly deploy Pi-hole in a containerized environment.

## Table of Contents

- [Pi-hole Docker Setup](#pi-hole-docker-setup)
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
│   └── custom.list
├── docker-compose.yml
├── .env.example
├── .gitignore
├── LICENSE
└── README.md
```

## Prerequisites

- Docker
- Docker Compose
- A dedicated IP address for Pi-hole

## Quick Start

1. Clone this repository
2. Copy `.env.example` to `.env` and adjust the variables as needed
3. Run `docker-compose up -d`
4. Access the Pi-hole admin interface at `http://<your-pi-hole-ip>/admin`
5. Log in using the password set in your `.env` file

## Configuration

See [CONFIGURATION.md](docs/CONFIGURATION.md) for detailed configuration options.

## Usage

After starting Pi-hole, configure your devices or router to use Pi-hole as the DNS server. Pi-hole will then start blocking ads and tracking domains network-wide.

## Advanced Configuration

For advanced setup options, including custom DNS settings and blocklists, refer to [CONFIGURATION.md](docs/CONFIGURATION.md).

## Data Persistence

Pi-hole data is persisted using Docker volumes. See [docker-compose.yml](docker-compose.yml) for volume configurations.

## Networking

Pi-hole requires specific port configurations. Ensure your firewall allows traffic on the necessary ports. See [CONFIGURATION.md](docs/CONFIGURATION.md) for details.

## Security Considerations

Review [SECURITY.md](docs/SECURITY.md) for important security considerations when running Pi-hole.

## Performance Tuning

For performance optimization tips, see [PERFORMANCE_TUNING.md](docs/PERFORMANCE_TUNING.md).

## Multi-Node Setup

For high-availability setups, refer to [MULTI_NODE_SETUP.md](docs/MULTI_NODE_SETUP.md).

## Upgrading

Follow the upgrade instructions in [UPGRADING.md](docs/UPGRADING.md) to keep your Pi-hole installation up-to-date.

## Troubleshooting

If you encounter issues, check [TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md) for common problems and solutions.

## Contributing

Contributions are welcome! Please see [CONTRIBUTING.md](docs/CONTRIBUTING.md) for details.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Disclaimer

This project is not officially associated with Pi-hole. Use at your own risk.
