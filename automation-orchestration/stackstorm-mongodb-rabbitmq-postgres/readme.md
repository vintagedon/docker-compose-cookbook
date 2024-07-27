# Stackstorm Docker Setup with MongoDB, RabbitMQ, and PostgreSQL

This project contains a Docker Compose setup for Stackstorm, including MongoDB, RabbitMQ, and PostgreSQL, with basic and advanced configuration options.

Stackstorm (often written as StackStorm or ST2) is an event-driven automation platform that allows you to connect all of your apps, services, and workflows. It's designed to make it easy to integrate various systems and automate complex workflows.

**Disclaimer:** This setup is based on general best practices and may not reflect the most current configuration options or requirements for Stackstorm. Always refer to the [official Stackstorm documentation](https://docs.stackstorm.com/) for the most up-to-date and accurate information.

## GitHub Repository

https://github.com/vintagedon/docker-compose-cookbook/automation-orchestration/stackstorm-mongodb-rabbitmq-postgres

## Prerequisites

- Docker
- Docker Compose
- Git (optional, for cloning the repository)

## Project Structure

```
.
├── docker-compose.yml
├── .env
└── README.md
```

## Files
- `docker-compose.yml`: Stackstorm, MongoDB, RabbitMQ, and PostgreSQL service configuration
- `.env`: Environment variables for all services configuration
- `README.md`: Project information and instructions

## Usage

1. Clone this repository or download the files.
2. Edit the `.env` file with your desired configuration.
3. Run the containers:

```bash
docker-compose up -d
```

4. Access Stackstorm Web UI at `https://localhost:443`.

5. Check the logs to ensure all services are running correctly:

```bash
docker-compose logs
```

You should see output similar to:

```
stackstorm_1    | 2023-07-27 12:00:00,000 INFO [-] Using coordination driver: zake://
stackstorm_1    | 2023-07-27 12:00:00,000 INFO [-] Using db connection: mongodb://mongo:27017/st2
stackstorm_1    | 2023-07-27 12:00:00,000 INFO [-] StackStorm v3.7.0 (commit=None)
stackstorm_1    | 2023-07-27 12:00:00,000 INFO [-] Python: 3.8.16
stackstorm_1    | 2023-07-27 12:00:00,000 INFO [-] Starting API server in HTTP mode
mongodb_1       | 2023-07-27T12:00:00.000+0000 I NETWORK  [initandlisten] waiting for connections on port 27017
rabbitmq_1      | 2023-07-27 12:00:00.00 [info] Starting RabbitMQ 3.8.9 on Erlang 23.1.1
postgres_1      | 2023-07-27 12:00:00.000 UTC [1] LOG:  database system is ready to accept connections
```

## Expected Output

When all services are running correctly, you should see:

1. All services defined in the `docker-compose.yml` file should be up and running.
2. The Stackstorm Web UI should be accessible at `https://localhost:443`.
3. You should be able to log in to the Web UI using the credentials defined in the `.env` file.
4. The output of `docker ps` should show all containers running. For example:

   ```
   $ docker ps
   CONTAINER ID   IMAGE                       COMMAND                  CREATED          STATUS          PORTS                               NAMES
   abc123def456   stackstorm/stackstorm:latest   "/bin/sh -c /st2ent…"   10 minutes ago   Up 10 minutes   0.0.0.0:443->443/tcp               stackstorm-mongodb-rabbitmq-postgres_stackstorm_1
   def456ghi789   mongo:4.4                      "docker-entrypoint.s…"   10 minutes ago   Up 10 minutes   27017/tcp                           stackstorm-mongodb-rabbitmq-postgres_mongodb_1
   ghi789jkl012   rabbitmq:3.8-management        "docker-entrypoint.s…"   10 minutes ago   Up 10 minutes   5672/tcp, 15672/tcp                 stackstorm-mongodb-rabbitmq-postgres_rabbitmq_1
   jkl012mno345   postgres:13                    "docker-entrypoint.s…"   10 minutes ago   Up 10 minutes   5432/tcp                            stackstorm-mongodb-rabbitmq-postgres_postgres_1
   ```

## Configuration Options

### Basic Options

- `ST2_AUTH_USERNAME`: The username for Stackstorm authentication
- `ST2_AUTH_PASSWORD`: The password for Stackstorm authentication

### Common Options

- `ST2_VERSION`: The version of Stackstorm to use
- `MONGO_VERSION`: The version of MongoDB to use
- `RABBITMQ_VERSION`: The version of RabbitMQ to use
- `POSTGRES_VERSION`: The version of PostgreSQL to use

### Advanced Options

- `ST2_OAUTH_API_KEY`: API key for OAuth authentication
- `ST2_INTEGRATION_PACKS`: Comma-separated list of integration packs to install

Usage:

1. Uncomment relevant lines in the `.env` file.
2. Set desired values.
3. Restart the containers:

```bash
docker-compose down && docker-compose up -d
```

## Data Persistence

This setup uses several volumes for data persistence:

- `stackstorm-packs`: For custom packs and configurations
- `stackstorm-config`: For Stackstorm configuration files
- `stackstorm-logs`: For Stackstorm logs
- `mongo-data`: For MongoDB data
- `rabbitmq-data`: For RabbitMQ data
- `postgres-data`: For PostgreSQL data

These volumes are created automatically when you start the containers.

## Networking

The setup creates a custom network named `stackstorm_network`. This network allows all the services to communicate with each other.

External access is provided through port mappings defined in the `docker-compose.yml` file. By default, the Stackstorm Web UI is accessible on port 443.

## Security Note

- Always change the default `ST2_AUTH_USERNAME` and `ST2_AUTH_PASSWORD` in the `.env` file.
- Use strong, unique passwords for all services, especially for PostgreSQL.
- Consider using a reverse proxy with SSL termination for production environments.
- Regularly update to the latest versions of all services to get security patches.

## Troubleshooting

Check logs: `docker-compose logs`

Common issues:

1. Web UI not accessible: Ensure that port 443 is not being used by another service on your host machine.
2. Authentication issues: Verify that the `ST2_AUTH_USERNAME` and `ST2_AUTH_PASSWORD` in the `.env` file match what you're using to log in.
3. Database connection issues: Check the logs for MongoDB, RabbitMQ, and PostgreSQL to ensure they're running correctly.

For more detailed troubleshooting, please refer to the [official Stackstorm documentation](https://docs.stackstorm.com/troubleshooting/index.html).

## Contributing

Feel free to submit issues, fork the repository and send pull requests!

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
