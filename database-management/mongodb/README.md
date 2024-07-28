# MongoDB Docker Setup

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

MongoDB is a popular, open-source document-oriented database program. It uses JSON-like documents with optional schemas, making it highly flexible and scalable for modern application development.

## Table of Contents

- [MongoDB Docker Setup](#mongodb-docker-setup)
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
- `docs/`: Detailed documentation on various aspects of the MongoDB setup.
- `docker-compose.yml`: Defines the Docker services for running MongoDB.
- `.env.example`: Example environment variables file.
- `.gitignore`: Specifies intentionally untracked files to ignore.
- `LICENSE`: MIT License file.
- `README.md`: This file, providing an overview and instructions.

## Prerequisites

- Docker Engine 20.10.0 or later
- Docker Compose 1.29.0 or later
- At least 4GB of RAM for the MongoDB container

## Installation

1. Clone this repository:

   ```
   git clone https://github.com/your-repo/mongodb-docker-setup.git
   cd mongodb-docker-setup
   ```

2. Copy the example environment file and adjust the variables as needed:

   ```
   cp .env.example .env
   ```

3. Start the MongoDB container:
   ```
   docker-compose up -d
   ```

## Usage

To connect to the MongoDB instance:

```
docker exec -it mongodb mongo
```

For more detailed usage instructions, refer to the [Configuration](#configuration) section.

## Configuration

Basic configuration options are set in the `.env` file. For a full list of available options, see the [CONFIGURATION.md](docs/CONFIGURATION.md) file.

Key configuration options:

- `MONGO_INITDB_ROOT_USERNAME`: The root username for MongoDB
- `MONGO_INITDB_ROOT_PASSWORD`: The root password for MongoDB
- `MONGO_PORT`: The port on which MongoDB will be accessible

## Advanced Configuration

For advanced configuration options, including replication and sharding, refer to the [CONFIGURATION.md](docs/CONFIGURATION.md) file.

## Data Persistence

Data is persisted in a Docker volume. By default, this is a local volume named `mongodb_data`. To use a named volume, set `USE_NAMED_VOLUMES=true` in your `.env` file.

## Networking

MongoDB is exposed on the port specified by the `MONGO_PORT` environment variable. By default, this is set to 27017.

## Security

Security best practices for MongoDB in Docker:

1. Use strong, unique passwords for the root and application users.
2. Enable authentication (enabled by default in this setup).
3. Use TLS/SSL for encrypted connections.
4. Regularly update to the latest MongoDB version.

For more details, see the [SECURITY.md](docs/SECURITY.md) file.

## Performance Tuning

For performance tuning tips, including memory allocation and index optimization, see the [PERFORMANCE_TUNING.md](docs/PERFORMANCE_TUNING.md) file.

## Multi-Node Setup

For instructions on setting up a MongoDB replica set or sharded cluster, refer to the [MULTI_NODE_SETUP.md](docs/MULTI_NODE_SETUP.md) file.

## Upgrading

To upgrade MongoDB to a newer version:

1. Update the `MONGO_VERSION` in your `.env` file.
2. Run `docker-compose up -d` to apply the changes.

For detailed upgrade procedures, see the [UPGRADING.md](docs/UPGRADING.md) file.

## Troubleshooting

For common issues and their solutions, refer to the [TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md) file.

## Known Limitations

- This setup is primarily designed for development and testing environments. For production use, additional security measures and performance optimizations may be necessary.
- Automatic backups are not included in this basic setup. Consider implementing a backup strategy for important data.

## Contributing

Contributions are welcome! Please see the [CONTRIBUTING.md](docs/CONTRIBUTING.md) file for guidelines.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Expected Output

When running `docker ps`, you should see output similar to:

```
CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS          PORTS                      NAMES
abc123def456   mongo:5.0.9    "docker-entrypoint.s…"   10 minutes ago   Up 10 minutes   0.0.0.0:27017->27017/tcp   mongodb
```

Example logs (accessible via `docker logs mongodb`):

```
{"t":{"$date":"2023-07-27T12:00:00.000+00:00"},"s":"I",  "c":"CONTROL",  "id":23285,   "ctx":"main","msg":"Automatically disabling TLS 1.0, to force-enable TLS 1.0 specify --sslDisabledProtocols 'none'"}
{"t":{"$date":"2023-07-27T12:00:00.100+00:00"},"s":"I",  "c":"NETWORK",  "id":23015,   "ctx":"listener","msg":"Listening on","attr":{"address":"/tmp/mongodb-27017.sock"}}
{"t":{"$date":"2023-07-27T12:00:00.200+00:00"},"s":"I",  "c":"NETWORK",  "id":23015,   "ctx":"listener","msg":"Listening on","attr":{"address":"0.0.0.0"}}
{"t":{"$date":"2023-07-27T12:00:00.300+00:00"},"s":"I",  "c":"CONTROL",  "id":23403,   "ctx":"initandlisten","msg":"MongoDB starting","attr":{"pid":1,"port":27017,"dbPath":"/data/db","architecture":"64-bit","host":"mongodb"}}
```

## Disclaimer

This Docker setup aims to follow best practices, but it's essential to refer to the [official MongoDB documentation](https://docs.mongodb.com/) for the most up-to-date and comprehensive information, especially for production deployments.
