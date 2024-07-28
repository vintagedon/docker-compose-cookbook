# Docker Compose Cookbook

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Docker](https://img.shields.io/badge/Docker-Powered-blue.svg)](https://www.docker.com/)
[![Contributions Welcome](https://img.shields.io/badge/Contributions-Welcome-brightgreen.svg)](CONTRIBUTING.md)

> A collection of Docker compose scripts centered around use in a home lab for learning IT technologies.

## 📋 Table of Contents

- [About](#-about)
- [Features](#-features)
- [Categories](#-categories)
- [How to Use](#-how-to-use)
- [Contributing](#-contributing)
- [License](#-license)

## 🚀 About

This repository provides Docker Compose files, along with .env files, in a standardized format that serve as a starting point for spinning up common services and applications in a cookbook-style format.

**NOTE:** This collection is meant to be used in a home lab, non-critical development environment, or for exploring technologies. These compose files should never be used in a production environment without modification to fit your security needs.

## 🌟 Features

- Comprehensive collection of Docker Compose files
- Utilizes .env files for easy configuration
- Focus on self-hosted technologies
- Designed for use in virtualization home labs
- Covers a wide range of IT and development technologies

## 📚 Categories

Our Docker Compose files are organized into the following categories:

### [Database Management](./database-management)

| Tool       | Description                                       | Repo Link                                      |
| ---------- | ------------------------------------------------- | ---------------------------------------------- |
| MySQL      | Open-source relational database management system | [mysql](./database-management/mysql)           |
| MariaDB    | Community-developed fork of MySQL                 | [mariadb](./database-management/mariadb)       |
| PostgreSQL | Advanced open-source relational database          | [postgresql](./database-management/postgresql) |
| MongoDB    | NoSQL database with JSON-like documents           | [mongodb](./database-management/mongodb)       |
| Redis      | In-memory data structure store                    | [redis](./database-management/redis)           |
| Cassandra  | Highly scalable, distributed NoSQL database       | [cassandra](./database-management/cassandra)   |
| Neo4j      | Native graph database with ACID compliance        | [neo4j](./database-management/neo4j)           |
| CouchDB    | JSON document-based database with HTTP API        | [couchdb](./database-management/couchdb)       |
| SQLite     | Lightweight, serverless relational database       | [sqlite3](./database-management/sqlite3)       |
| InfluxDB   | Purpose-built time series database                | [influx](./database-management/influx)         |

### [Networking](./networking)

| Tool         | Description                                   | Repo Link                                 |
| ------------ | --------------------------------------------- | ----------------------------------------- |
| AdGuard Home | Network-wide ad and tracker blocking          | [adguard-home](./networking/adguard-home) |
| OpenVPN      | Open-source VPN solution                      | [openvpn](./networking/openvpn)           |
| Pi-hole      | Network-wide ad blocking and local DNS server | [pihole](./networking/pihole)             |
| SoftEtherVPN | Multi-protocol VPN software                   | [softethervpn](./networking/softethervpn) |
| WireGuard    | Simple, fast, and modern VPN                  | [wireguard](./networking/wireguard)       |

### [Monitoring & Logging](./monitoring-logging)

| Tool                             | Description                                           | Repo Link                                                                           |
| -------------------------------- | ----------------------------------------------------- | ----------------------------------------------------------------------------------- |
| Cacti (MySQL)                    | Network graphing solution                             | [cacti-mysql](./monitoring-logging/cacti-mysql)                                     |
| Fluentd                          | Open-source data collector for unified logging layer  | [fluentd](./monitoring-logging/fluentd)                                             |
| Grafana                          | Open-source platform for monitoring and observability | [grafana](./monitoring-logging/grafana)                                             |
| Graylog (Elasticsearch, MongoDB) | Log management platform                               | [graylog-elasticsearch-mongodb](./monitoring-logging/graylog-elasticsearch-mongodb) |
| Prometheus                       | Open-source systems monitoring and alerting toolkit   | [prometheus](./monitoring-logging/prometheus)                                       |

### [Automation & Orchestration](./automation-orchestration)

| Tool        | Description                                  | Repo Link                                                                                               |
| ----------- | -------------------------------------------- | ------------------------------------------------------------------------------------------------------- |
| Ansible AWX | Web UI for Ansible with PostgreSQL and Redis | [ansibleawx-postgres-redis](./automation-orchestration/ansibleawx-postgres-redis)                       |
| Rundeck     | Job scheduler and runbook automation         | [rundeck](./automation-orchestration/rundeck)                                                           |
| Stackstorm  | Event-driven automation platform             | [stackstorm-mongodb-rabbitmq-postgres](./automation-orchestration/stackstorm-mongodb-rabbitmq-postgres) |

### [Development & CI/CD](./development-ci-cd)

| Tool               | Description                                         | Repo Link                                                |
| ------------------ | --------------------------------------------------- | -------------------------------------------------------- |
| Gitea (MySQL)      | Self-hosted Git service with MySQL                  | [gitea-mysql](./development-ci-cd/gitea-mysql)           |
| Gitea (PostgreSQL) | Self-hosted Git service with PostgreSQL             | [gitea-postgresql](./development-ci-cd/gitea-postgresql) |
| Gitea (SQLite3)    | Self-hosted Git service with SQLite3                | [gitea-sqlite3](./development-ci-cd/gitea-sqlite3)       |
| GitLab CE          | Self-hosted Git repository management               | [gitlabce](./development-ci-cd/gitlabce)                 |
| Gogs (MySQL)       | Lightweight self-hosted Git service with MySQL      | [gogs-mysql](./development-ci-cd/gogs-mysql)             |
| Gogs (Postgres)    | Lightweight self-hosted Git service with PostgreSQL | [gogs-postgres](./development-ci-cd/gogs-postgres)       |
| Gogs (SQLite3)     | Lightweight self-hosted Git service with SQLite3    | [gogs-sqlite3](./development-ci-cd/gogs-sqlite3)         |
| Jenkins (SQLite3)  | Automation server for CI/CD with SQLite3            | [jenkins-sqlite3](./development-ci-cd/jenkins-sqlite3)   |

### Storage Solutions (Planned)

_Note: This category is planned but does not have content yet._

### Security (Planned)

_Note: This category is planned but does not have content yet._

### Container Management (Planned)

_Note: This category is planned but does not have content yet._

### Web & Application Servers (Planned)

_Note: This category is planned but does not have content yet._

### Messaging & Collaboration (Planned)

_Note: This category is planned but does not have content yet._

### Virtualization (Planned)

_Note: This category is planned but does not have content yet._

### Home Automation (Planned)

_Note: This category is planned but does not have content yet._

### Media & Entertainment (Planned)

_Note: This category is planned but does not have content yet._

### Educational Tools (Planned)

_Note: This category is planned but does not have content yet._

### Miscellaneous (Planned)

_Note: This category is planned but does not have content yet._

## 🚀 How to Use

Each Docker Compose file in this repository is accompanied by a corresponding .env file for configuration. To use any of the setups:

1. Clone the repository:
   ```
   git clone https://github.com/vintagedon/docker-compose-cookbook
   ```
2. Navigate to the desired application's directory
3. Copy the .env.example file to .env
4. Modify the .env file with your specific configuration
5. Run `docker-compose up -d` to start the containers

## 🤝 Contributing

We welcome contributions! If you have a Docker Compose file for an application not yet included, please submit a pull request. For major changes, please open an issue first to discuss what you would like to change.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

⭐️ Thank you for using the Docker Compose Cookbook! If you find this project useful, please consider giving it a star on GitHub! ⭐️
