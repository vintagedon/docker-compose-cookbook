# Cassandra Docker Setup

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Apache Cassandra is a highly-scalable, distributed NoSQL database management system designed to handle large amounts of structured data across many commodity servers, providing high availability with no single point of failure.

## Table of Contents

- [Cassandra Docker Setup](#cassandra-docker-setup)
  - [Table of Contents](#table-of-contents)
  - [Project Structure](#project-structure)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Usage](#usage)
  - [Configuration](#configuration)
  - [Advanced Configuration](#advanced-configuration)
  - [Data Persistence](#data-persistence)
  - [Networking](#networking)
  - [Security](#security)
  - [Performance Tuning](#performance-tuning)
  - [Multi-Node Setup](#multi-node-setup)
  - [Upgrading](#upgrading)
  - [Troubleshooting](#troubleshooting)
  - [Known Limitations](#known-limitations)
  - [Contributing](#contributing)
  - [License](#license)
  - [Expected Output](#expected-output)
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
├── docker-compose.yml
├── .env.example
├── .gitignore
├── LICENSE
└── README.md
```

- `.github/`: Contains issue templates for bug reports and feature requests.
- `docs/`: Detailed documentation on various aspects of the Cassandra setup.
- `docker-compose.yml`: Defines the Docker services for running Cassandra.
- `.env.example`: Example environment variables file.
- `.gitignore`: Specifies intentionally untracked files to ignore.
- `LICENSE`: MIT License file.
- `README.md`: This file, providing an overview and instructions.

## Prerequisites

- Docker Engine 20.10.0 or later
- Docker Compose 1.29.0 or later
- At least 4GB of RAM for a single-node setup (8GB or more recommended for production)
- Sufficient disk space for your data (depends on your use case)

## Installation

1. Clone this repository:

   ```
   git clone https://github.com/yourusername/cassandra-docker-setup.git
   cd cassandra-docker-setup
   ```

2. Copy the example environment file and adjust the variables as needed:

   ```
   cp .env.example .env
   ```

3. Start the Cassandra container:
   ```
   docker-compose up -d
   ```

## Usage

To connect to the Cassandra instance:

```
docker exec -it cassandra cqlsh
```

This will open the Cassandra Query Language Shell (cqlsh) where you can interact with your Cassandra database.

## Configuration

Basic configuration options are available in the `.env` file. For more detailed configuration, refer to the `CONFIGURATION.md` file in the `docs` directory.

## Advanced Configuration

For advanced configuration options, including performance tuning and multi-node setup, please refer to the respective documentation files in the `docs` directory.

## Data Persistence

Data is persisted using Docker volumes. By default, a volume named `cassandra_data` is created and mounted to `/var/lib/cassandra` in the container.

## Networking

Cassandra exposes the following ports:

- 7000: Inter-node communication
- 7001: TLS inter-node communication (if enabled)
- 7199: JMX
- 9042: CQL
- 9160: Thrift client API (deprecated)

Adjust the port mappings in `docker-compose.yml` if needed.

## Security

For security best practices and configuration options, refer to the `SECURITY.md` file in the `docs` directory.

## Performance Tuning

For performance tuning guidelines, refer to the `PERFORMANCE_TUNING.md` file in the `docs` directory.

## Multi-Node Setup

For instructions on setting up a multi-node Cassandra cluster, refer to the `MULTI_NODE_SETUP.md` file in the `docs` directory.

## Upgrading

For upgrade procedures, refer to the `UPGRADING.md` file in the `docs` directory.

## Troubleshooting

For common issues and their solutions, refer to the `TROUBLESHOOTING.md` file in the `docs` directory.

## Known Limitations

- This setup is primarily designed for development and testing environments. For production use, additional security measures and performance optimizations may be necessary.
- Single-node setups do not provide high availability or data redundancy. For production use, a multi-node cluster is recommended.

## Contributing

Contributions are welcome! Please read the `CONTRIBUTING.md` file in the `docs` directory for details on how to contribute to this project.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Expected Output

When running `docker-compose up -d`, you should see output similar to:

```
Creating network "cassandra_network" with the default driver
Creating volume "cassandra_data" with default driver
Creating cassandra ... done
```

When running `docker ps`, you should see output similar to:

```
CONTAINER ID   IMAGE                    COMMAND                  CREATED         STATUS         PORTS                                                                                                        NAMES
abcdef123456   cassandra:latest         "docker-entrypoint.s…"   2 minutes ago   Up 2 minutes   7000-7001/tcp, 7199/tcp, 9042/tcp, 9160/tcp                                                                  cassandra
```

## Disclaimer

This Docker setup is provided as-is, without any guarantees or warranty. The authors are not responsible for any damage or data loss that may occur from using this setup. Always refer to the official Apache Cassandra documentation for the most up-to-date and accurate information.
