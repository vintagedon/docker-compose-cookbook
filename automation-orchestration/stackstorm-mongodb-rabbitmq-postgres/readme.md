# StackStorm Docker Setup

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

This project contains a Docker Compose setup for StackStorm, including basic and advanced configuration options.

StackStorm (also known as "ST2") is an open-source automation platform that enables you to connect all your apps, services, and workflows. It provides a powerful event-driven automation engine, a wide range of integrations, and a user-friendly web interface.

## Project Structure

```
.
├── .github/
│   └── ISSUE_TEMPLATE/
│       ├── bug_report.md
│       └── feature_request.md
├── docs/
│   └── CONTRIBUTING.md
├── docker-compose.yml
├── .env.example
├── .gitignore
├── LICENSE
└── README.md
```

## Table of Contents

- [StackStorm Docker Setup](#stackstorm-docker-setup)
  - [Project Structure](#project-structure)
  - [Table of Contents](#table-of-contents)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Usage](#usage)
  - [Expected Output](#expected-output)
  - [Configuration](#configuration)
  - [Data Persistence](#data-persistence)
  - [Networking](#networking)
  - [Security](#security)
  - [Troubleshooting](#troubleshooting)
  - [Contributing](#contributing)
  - [License](#license)
  - [Disclaimer](#disclaimer)

## Prerequisites

- Docker (version 20.10.0 or later)
- Docker Compose (version 1.29.0 or later)
- At least 4GB of RAM available for StackStorm services

## Installation

1. Clone this repository:

   ```
   git clone https://github.com/vintagedon/docker-compose-cookbook.git
   cd docker-compose-cookbook/automation-orchestration/stackstorm-mongodb-rabbitmq-postgresql
   ```

2. Copy the example environment file and edit it with your desired configuration:

   ```
   cp .env.example .env
   nano .env
   ```

3. Build and start the containers:
   ```
   docker-compose up -d
   ```

## Usage

Once the containers are up and running, you can access the StackStorm web interface by navigating to `http://localhost:8080` in your web browser. The default login credentials are:

- Username: `st2admin`
- Password: `Ch@ngeMe`

You can also interact with StackStorm using the CLI. To access the StackStorm CLI, use the following command:

```
docker exec -it stackstorm /bin/bash
```

Once inside the container, you can use StackStorm CLI commands such as `st2 action list` to interact with the system.

## Expected Output

After running `docker-compose up -d`, you should see output similar to this:

```
Creating network "stackstorm_network" with the default driver
Creating volume "stackstorm_config" with default driver
Creating volume "stackstorm_packs" with default driver
Creating volume "stackstorm_logs" with default driver
Creating volume "mongo_data" with default driver
Creating volume "rabbitmq_data" with default driver
Creating volume "postgres_data" with default driver
Creating stackstorm_mongodb_1  ... done
Creating stackstorm_rabbitmq_1 ... done
Creating stackstorm_postgres_1 ... done
Creating stackstorm_stackstorm_1 ... done
```

To verify that the containers are running, use the `docker ps` command. You should see output similar to this:

```
CONTAINER ID   IMAGE                      COMMAND                  CREATED          STATUS                    PORTS                                       NAMES
1a2b3c4d5e6f   stackstorm/stackstorm:3.7  "/sbin/init"             10 seconds ago   Up 8 seconds              0.0.0.0:8080->8080/tcp, :::8080->8080/tcp   stackstorm_stackstorm_1
2b3c4d5e6f7g   postgres:13                "docker-entrypoint.s…"   12 seconds ago   Up 10 seconds             5432/tcp                                    stackstorm_postgres_1
3c4d5e6f7g8h   rabbitmq:3-management      "docker-entrypoint.s…"   12 seconds ago   Up 10 seconds             4369/tcp, 5671-5672/tcp, 25672/tcp          stackstorm_rabbitmq_1
4d5e6f7g8h9i   mongo:4.4                  "docker-entrypoint.s…"   12 seconds ago   Up 10 seconds             27017/tcp                                   stackstorm_mongodb_1
```

To check the logs of the StackStorm container, you can use:

```
docker logs stackstorm_stackstorm_1
```

You should see output indicating that StackStorm services are starting up. Here's an example of what you might see:

```
Starting MongoDB
Starting RabbitMQ
Starting PostgreSQL
Starting st2api
Starting st2auth
Starting st2stream
Starting st2rulesengine
Starting st2timersengine
Starting st2workflowengine
Starting st2notifier
Starting st2sensorcontainer
Starting st2garbagecollector
Starting st2actionrunner
Starting st2scheduler
Starting nginx
StackStorm is ready
```

If you see these services starting without errors, your StackStorm setup is likely working correctly.

## Configuration

See the [Configuration](docs/CONFIGURATION.md) document for detailed information on available options.

## Data Persistence

StackStorm uses several services that require data persistence:

- MongoDB: Stores StackStorm's data
- PostgreSQL: Used by Mistral workflow engine
- RabbitMQ: Message queue for StackStorm components

By default, Docker volumes are used to persist data for these services. You can use named volumes for easier management and backup. To enable named volumes, set `USE_NAMED_VOLUMES=true` in your `.env` file.

## Networking

This setup creates a Docker network named `stackstorm_network`. All StackStorm services are connected to this network, allowing them to communicate with each other.

The following ports are exposed to the host by default:

- 8080: StackStorm Web UI
- 9101: Authentication service

You can modify these port mappings in the `docker-compose.yml` file if needed.

## Security

For security best practices and considerations, please refer to our [Security](docs/SECURITY.md) document. Always change the default passwords and consider using HTTPS for production deployments.

## Troubleshooting

For common issues and their solutions, please check our [Troubleshooting](docs/TROUBLESHOOTING.md) guide.

## Contributing

We welcome contributions! Please see our [Contributing Guide](docs/CONTRIBUTING.md) for details on how to get started.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Disclaimer

This setup is based on general best practices and may not reflect the most current configuration options or requirements for StackStorm. Always refer to the [official StackStorm documentation](https://docs.stackstorm.com/) for the most up-to-date and accurate information.
