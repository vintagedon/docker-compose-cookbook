# PostgreSQL Docker Setup

This project contains a Docker Compose file and environment configuration for setting up a standalone PostgreSQL instance in a Docker container.

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
- `docker-compose.yml`: Defines the PostgreSQL service configuration
- `.env`: Contains environment variables for configuring the PostgreSQL instance
- `README.md`: Provides information and instructions for the project

## Usage

1. Edit the `.env` file and replace the placeholder values with your desired configuration:
   ```
   POSTGRES_CONTAINER_NAME=postgres_db
   POSTGRES_DB=your_database_name
   POSTGRES_USER=your_username
   POSTGRES_PASSWORD=your_secure_password
   POSTGRES_PORT=5432
   POSTGRES_DATA_DIR=/path/to/your/postgresql/data
   POSTGRES_CONFIG_DIR=/path/to/your/postgresql/config
   ```

2. Run the container using Docker Compose:
   ```
   docker-compose up -d
   ```

## Configuration
The Docker Compose file uses environment variables from the `.env` file for configuration. Ensure all variables in the `.env` file are set before running the container.

## Accessing PostgreSQL
Once the container is running, you can access PostgreSQL using a PostgreSQL client:
```
psql -h localhost -p ${POSTGRES_PORT} -U ${POSTGRES_USER} -d ${POSTGRES_DB}
```
You will be prompted to enter the password specified in the `.env` file.

## Data Persistence
PostgreSQL data is stored in the directory specified by `POSTGRES_DATA_DIR`. Custom configurations can be added to the directory specified by `POSTGRES_CONFIG_DIR`. Ensure these paths exist on your host system and have appropriate permissions.

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
Use strong, unique values for the `POSTGRES_PASSWORD` in your `.env` file, especially in production environments.

## Contributing
Please refer to the repository's contributing guidelines for information on how to contribute to this project.

## License
This repository is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.
