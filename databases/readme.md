# Database Docker Setups

This section of the repository contains Docker Compose configurations for various database systems, designed for use in home labs and learning environments. Each sub-folder provides a complete setup for running a specific database in a Docker container, including configuration options for both basic and advanced use cases.

## Table of Contents

1. [Included Databases](#included-databases)
1. [General Structure](#general-structure)
1. [Usage](#usage)
1. [Security Considerations](#security-considerations)
1. [Contributing](#contributing)
1. [License](#license)



## Included Databases

This section includes Docker Compose setups for the following databases:

| Database | Type | Description | Repository | Project Homepage |
|----------|------|-------------|------------|------------------|
| MySQL | Relational | Open-source relational database management system | [MySQL](./mysql) | [mysql.com](https://www.mysql.com/) |
| MariaDB | Relational | Community-developed fork of MySQL | [MariaDB](./mariadb) | [mariadb.org](https://mariadb.org/) |
| PostgreSQL | Relational | Advanced open-source relational database | [PostgreSQL](./postgresql) | [postgresql.org](https://www.postgresql.org/) |
| MongoDB | Document | NoSQL database with JSON-like documents | [MongoDB](./mongodb) | [mongodb.com](https://www.mongodb.com/) |
| Redis | Key-Value | In-memory data structure store | [Redis](./redis) | [redis.io](https://redis.io/) |
| Cassandra | Wide Column | Highly scalable, distributed NoSQL database | [Cassandra](./cassandra) | [cassandra.apache.org](https://cassandra.apache.org/) |
| Neo4j | Graph | Native graph database with ACID compliance | [Neo4j](./neo4j) | [neo4j.com](https://neo4j.com/) |
| CouchDB | Document | JSON document-based database with HTTP API | [CouchDB](./couchdb) | [couchdb.apache.org](https://couchdb.apache.org/) |
| SQLite | Relational | Lightweight, serverless relational database | [SQLite](./sqlite) | [sqlite.org](https://www.sqlite.org/) |
| InfluxDB | Time Series | Purpose-built time series database | [InfluxDB](./influxdb) | [influxdata.com](https://www.influxdata.com/) |

The "Repository" column links will take you to the specific sub-repository for that database setup within this project. The "Project Homepage" links will take you to the official website for each database project.



## General Structure

Each database sub-repository typically includes the following files:

- `docker-compose.yml`: Defines the service configuration for the database
- `.env`: Contains environment variables for configuring the database instance
- `README.md`: Provides specific instructions and details for that database setup

Some setups may include additional configuration files or scripts as needed.

## Usage

To use any of these database setups:

1. Navigate to the specific database sub-repository you're interested in.
2. Follow the instructions in that sub-repository's README.md file.
3. Typically, you'll need to:
   - Edit the `.env` file to customize your configuration
   - Run `docker-compose up -d` to start the database container
   - Use the provided instructions to connect to and interact with your database

## Security Considerations

These setups are primarily intended for learning and development environments. When using these in any environment accessible to others, consider the following:

- Always change default passwords and credentials
- Restrict network access appropriately
- Keep your Docker and database images updated
- Be cautious about enabling features that may pose security risks
- For production use, additional security measures are typically necessary

## Contributing

Contributions to improve existing setups or add new database options are welcome. Please refer to the main repository's contributing guidelines for more information on how to contribute.

## License

This project is licensed under the MIT License. See the [LICENSE](../LICENSE) file in the main repository for more details.
