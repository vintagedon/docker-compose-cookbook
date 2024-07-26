# InfluxDB Docker Setup

This project contains a Docker Compose file and environment configuration for setting up InfluxDB in a Docker container.

InfluxDB is an open-source time series database designed to handle high write and query loads. It is a key component of the TICK stack (Telegraf, InfluxDB, Chronograf, Kapacitor) and is optimized for fast, high-availability storage and retrieval of time series data in fields such as operations monitoring, application metrics, Internet of Things sensor data, and real-time analytics.

## GitHub Repository
[https://github.com/vintagedon/infrastructure-scripting/blob/main/docker-compose/](https://github.com/vintagedon/infrastructure-scripting/blob/main/docker-compose/)

## Description
This setup creates a containerized instance of InfluxDB with customizable configuration using environment variables.

## Prerequisites
- Docker
- Docker Compose

## Project Structure
```
.
├── docker-compose.yml
├── .env
└── README.md
```

## Files
- `docker-compose.yml`: Defines the InfluxDB service configuration
- `.env`: Contains environment variables for configuring the InfluxDB instance
- `README.md`: Provides information and instructions for the project

## Usage

1. Copy the `.env.example` file to `.env`:
   ```
   cp .env.example .env
   ```

2. Edit the `.env` file and replace the placeholder values with your desired configuration:
   ```
   INFLUX_PORT_PUBLIC=8086
   INFLUX_DIRECTORY_ETC=/path/to/your/etc
   INFLUX_DIRECTORY_VARLIB=/path/to/your/varlib
   INFLUX_DB=your_db_name
   INFLUX_INIT_USER_NAME=your_username
   INFLUX_INIT_USER_PASSWORD=your_secure_password
   INFLUX_INIT_ORGANIZATION_NAME=your_org_name
   INFLUX_INTI_BUCKET_NAME=your_bucket_name
   INFLUX_INIT_RETENTION_TIME=30d
   INFLUX_INIT_ADMIN_TOKEN=your_secure_admin_token
   ```

3. Run the container using Docker Compose:
   ```
   docker-compose up -d
   ```

## Configuration
The Docker Compose file uses environment variables from the `.env` file for configuration. Ensure all variables in the `.env` file are set before running the container.

## Accessing InfluxDB
Once the container is running, you can access the InfluxDB web interface at `http://localhost:${INFLUX_PORT_PUBLIC}`.

## Data Persistence
InfluxDB data is stored in the directories specified by `INFLUX_DIRECTORY_ETC` and `INFLUX_DIRECTORY_VARLIB`. Ensure these paths exist on your host system and have appropriate permissions.

## Expected Results
After running `docker-compose up -d`, you should see the InfluxDB container running. You can verify this by using the `docker ps` command. The output should look similar to this:

```
CONTAINER ID   IMAGE             COMMAND                  CREATED          STATUS          PORTS                    NAMES
1a2b3c4d5e6f   influxdb:latest   "/entrypoint.sh infl…"   10 seconds ago   Up 9 seconds    0.0.0.0:8086->8086/tcp   influxdb
```

This output indicates that:
- The InfluxDB container is running
- It's using the latest InfluxDB image
- The container name is `influxdb`
- The container's internal port 8086 is mapped to the host's port specified in your `.env` file (default is 8086)
- The container was created recently and is in an "Up" state

If you see this output, your InfluxDB container is running successfully and should be accessible via the web interface.

## Security Note
Use strong, unique values for the `INFLUX_INIT_USER_PASSWORD` and `INFLUX_INIT_ADMIN_TOKEN` in your `.env` file, especially in production environments.

## Contributing
Please refer to the repository's contributing guidelines for information on how to contribute to this project.

## License
This repository is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.
