# PostgreSQL Docker Setup

This project contains a Docker Compose file and environment configuration for setting up a standalone PostgreSQL instance in a Docker container, with expanded configuration options for advanced users.

[PostgreSQL](https://www.postgresql.org/), also known as Postgres, is a powerful, open source object-relational database system with over 30 years of active development. It has a strong reputation for reliability, feature robustness, and performance.

## GitHub Repository
[https://github.com/vintagedon/docker-compose-cookbook](https://github.com/vintagedon/docker-compose-cookbook)

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
- `docker-compose.yml`: Defines the PostgreSQL service configuration with expanded options
- `.env`: Contains environment variables for configuring the PostgreSQL instance, including advanced options
- `README.md`: Provides information and instructions for the project

## Usage

1. Edit the `.env` file and replace the placeholder values with your desired configuration. The basic configuration includes:

   ```
   POSTGRES_CONTAINER_NAME=postgres_db
   POSTGRES_DB=your_database_name
   POSTGRES_USER=your_username
   POSTGRES_PASSWORD=your_secure_password
   POSTGRES_PORT=5432
   POSTGRES_DATA_DIR=/path/to/your/postgresql/data
   POSTGRES_CONFIG_DIR=/path/to/your/postgresql/config
   ```

2. (Optional) Configure advanced options by uncommenting and adjusting the additional variables in the `.env` file. These include:

   - `POSTGRES_MAX_CONNECTIONS`: Set the maximum number of concurrent connections
   - `POSTGRES_SHARED_BUFFERS`: Set the amount of memory for shared buffers
   - `POSTGRES_SSL`: Enable or disable SSL
   - `POSTGRES_HOST_AUTH_METHOD`: Set the default authentication method
   - `POSTGRES_AUTOVACUUM`: Enable or disable automatic vacuuming
   - `POSTGRES_LOG_MIN_MESSAGES`: Set the logging level
   - `POSTGRES_WORK_MEM`: Set the maximum memory for query operations
   - `POSTGRES_MAINTENANCE_WORK_MEM`: Set the maximum memory for maintenance operations
   - `POSTGRES_PREPARED_STATEMENTS`: Enable or disable query plan caching
   - `POSTGRES_TIMEZONE`: Set the time zone for the database server
   - `POSTGRES_MAX_PARALLEL_WORKERS_PER_GATHER`: Configure parallel query execution
   - `POSTGRES_MAX_WAL_SIZE`: Set the maximum WAL size
   - `POSTGRES_CHECKPOINT_COMPLETION_TARGET`: Adjust the checkpoint completion target
   - `POSTGRES_ENABLE_PARTITIONWISE_JOIN` and `POSTGRES_ENABLE_PARTITIONWISE_AGGREGATE`: Enable table partitioning features

   To enable any of these options, uncomment the relevant line in the `.env` file and set the desired value.

3. Run the container using Docker Compose:
   ```
   docker-compose up -d
   ```

## Configuration
The Docker Compose file uses environment variables from the `.env` file for configuration. Ensure all variables in the `.env` file are set before running the container. The expanded options in the `.env` file allow for fine-tuned control over the PostgreSQL instance.

## Accessing PostgreSQL
Once the container is running, you can access PostgreSQL using a PostgreSQL client:
```
psql -h localhost -p ${POSTGRES_PORT} -U ${POSTGRES_USER} -d ${POSTGRES_DB}
```
You will be prompted to enter the password specified in the `.env` file.

## Data Persistence
PostgreSQL data is stored in the directory specified by `POSTGRES_DATA_DIR`. Custom configurations can be added to the directory specified by `POSTGRES_CONFIG_DIR`. Ensure these paths exist on your host system and have appropriate permissions.

## Advanced Configuration
The expanded options in the `.env` file and `docker-compose.yml` allow for advanced configuration of the PostgreSQL instance. To use these options:

1. Open the `.env` file in a text editor.
2. Locate the commented out options (lines starting with `#`).
3. Remove the `#` from the start of any option you wish to enable.
4. Set the desired value for the option.

For example, to set the maximum number of connections to 200, you would change:

```
#POSTGRES_MAX_CONNECTIONS=100
```

to:

```
POSTGRES_MAX_CONNECTIONS=200
```

After making changes, restart your PostgreSQL container for the new settings to take effect:

```
docker-compose down
docker-compose up -d
```

## Expected Results
After running `docker-compose up -d`, you should see the PostgreSQL container running. You can verify this by using the `docker ps` command. The output should look similar to this:

```
CONTAINER ID   IMAGE             COMMAND                  CREATED          STATUS          PORTS                    NAMES
1a2b3c4d5e6f   postgres:latest   "docker-entrypoint.s…"   10 seconds ago   Up 9 seconds    0.0.0.0:5432->5432/tcp   postgres_db
```

This output indicates that:
- The PostgreSQL container is running
- It's using the latest PostgreSQL image
- The container name is `postgres_db` (or whatever you set in `POSTGRES_CONTAINER_NAME`)
- The container's internal port 5432 is mapped to the host's port specified in your `.env` file (default is 5432)
- The container was created recently and is in an "Up" state

If you see this output, your PostgreSQL container is running successfully and should be accessible via PostgreSQL clients.

## Security Note
Use strong, unique values for the `POSTGRES_PASSWORD` in your `.env` file, especially in production environments. Also, be cautious when adjusting advanced settings, as they can significantly impact the performance and security of your PostgreSQL instance.

## Contributing
Please refer to the repository's contributing guidelines for information on how to contribute to this project.

## License
This repository is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.
