# MariaDB Docker Setup

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

MariaDB is an open-source relational database management system (RDBMS) that is a fork of MySQL. It offers high performance, reliability, and ease of use, making it a popular choice for various applications and enterprises.

## Table of Contents

- [MariaDB Docker Setup](#mariadb-docker-setup)
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
- `docs/`: Detailed documentation on various aspects of the MariaDB setup.
- `docker-compose.yml`: Defines the Docker services for running MariaDB.
- `.env.example`: Example environment variables file.
- `.gitignore`: Specifies intentionally untracked files to ignore.
- `LICENSE`: MIT License file.
- `README.md`: This file, providing an overview and instructions.

## Prerequisites

- Docker Engine (version 20.10.0 or later)
- Docker Compose (version 1.29.0 or later)
- Basic understanding of Docker and database concepts

## Installation

1. Clone this repository:

   ```
   git clone https://github.com/yourusername/mariadb-docker-setup.git
   cd mariadb-docker-setup
   ```

2. Copy the example environment file and adjust the variables as needed:

   ```
   cp .env.example .env
   ```

3. Start the MariaDB container:
   ```
   docker-compose up -d
   ```

## Usage

To connect to the MariaDB instance:

```
docker exec -it mariadb mysql -u root -p
```

Enter the root password when prompted (as specified in your .env file).

## Configuration

Basic configuration options are available in the `.env` file. For more detailed configuration options, refer to the [CONFIGURATION.md](docs/CONFIGURATION.md) file in the docs directory.

## Advanced Configuration

For advanced configuration options, including custom my.cnf settings, refer to the [CONFIGURATION.md](docs/CONFIGURATION.md) file.

## Data Persistence

Data is persisted using Docker volumes. By default, a volume named `mariadb_data` is created and mounted to `/var/lib/mysql` in the container.

## Networking

The MariaDB instance is exposed on port 3306 by default. You can change this in the `.env` file if needed.

## Security

For security best practices and recommendations, please refer to the [SECURITY.md](docs/SECURITY.md) file in the docs directory.

## Performance Tuning

For tips on optimizing MariaDB performance in Docker, see the [PERFORMANCE_TUNING.md](docs/PERFORMANCE_TUNING.md) file.

## Upgrading

For instructions on upgrading your MariaDB instance, refer to the [UPGRADING.md](docs/UPGRADING.md) file.

## Troubleshooting

If you encounter any issues, please check the [TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md) file for common problems and solutions.

## Known Limitations

- This setup is intended for single-node deployments. For multi-node setups or clustering, please refer to the MariaDB Galera Cluster repository.
- Performance may vary depending on the host system and Docker configuration.

## Contributing

We welcome contributions! Please see the [CONTRIBUTING.md](docs/CONTRIBUTING.md) file for details on how to contribute to this project.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Expected Output

After running `docker-compose up -d`, you should see output similar to:

```
Creating mariadb ... done
```

You can verify the container is running with:

```
$ docker ps
CONTAINER ID   IMAGE          COMMAND                  CREATED         STATUS         PORTS                    NAMES
abcdef123456   mariadb:10.6   "docker-entrypoint.s…"   2 minutes ago   Up 2 minutes   0.0.0.0:3306->3306/tcp   mariadb
```

Example logs (accessible via `docker logs mariadb`):

```
2023-07-27 12:34:56+00:00 [Note] [Entrypoint]: Entrypoint script for MariaDB Server 10.6.x started.
2023-07-27 12:34:57+00:00 [Note] [Entrypoint]: Switching to dedicated user 'mysql'
2023-07-27 12:34:57+00:00 [Note] [Entrypoint]: Entrypoint script for MariaDB Server 10.6.x started.
2023-07-27 12:34:57+00:00 [Note] [Entrypoint]: Initializing database files
...
2023-07-27 12:35:01+00:00 [Note] [Entrypoint]: Database files initialized
2023-07-27 12:35:01+00:00 [Note] [Entrypoint]: Starting temporary server
2023-07-27 12:35:01+00:00 [Note] [Entrypoint]: Waiting for server startup
2023-07-27 12:35:02+00:00 [Note] [Entrypoint]: Temporary server started.
...
2023-07-27 12:35:05+00:00 [Note] [Entrypoint]: Stopping temporary server
2023-07-27 12:35:07+00:00 [Note] [Entrypoint]: Temporary server stopped
2023-07-27 12:35:07+00:00 [Note] [Entrypoint]: MariaDB init process done. Ready for start up.
...
2023-07-27 12:35:08+00:00 [Note] [Server] /usr/sbin/mysqld: ready for connections.
Version: '10.6.12-MariaDB-1:10.6.12+maria~ubu2004'  socket: '/run/mysqld/mysqld.sock'  port: 3306  mariadb.org binary distribution
```

## Disclaimer

This Docker setup is provided as-is, and while we strive to keep it up-to-date and secure, you should always refer to the [official MariaDB documentation](https://mariadb.com/kb/en/documentation/) for the most current information and best practices.
