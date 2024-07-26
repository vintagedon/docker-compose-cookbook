# MariaDB Docker Setup

This project contains a Docker Compose file and environment configuration for setting up a standalone MariaDB instance in a Docker container.

[MariaDB](https://mariadb.org/) is a community-developed, commercially supported fork of the MySQL relational database management system. It is designed as a drop-in replacement for MySQL with more features, new storage engines, fewer bugs, and better performance. MariaDB is used by many large organizations including Wikipedia, WordPress.com, and Google.

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
- `docker-compose.yml`: Defines the MariaDB service configuration
- `.env`: Contains environment variables for configuring the MariaDB instance
- `README.md`: Provides information and instructions for the project

## Usage

1. Edit the `.env` file and replace the placeholder values with your desired configuration:
   ```
   MARIADB_CONTAINER_NAME=mariadb_db
   MARIADB_ROOT_PASSWORD=your_secure_root_password
   MARIADB_DATABASE=your_database_name
   MARIADB_USER=your_username
   MARIADB_PASSWORD=your_secure_password
   MARIADB_PORT=3306
   MARIADB_DATA_DIR=/path/to/your/mariadb/data
   MARIADB_CONFIG_DIR=/path/to/your/mariadb/config
   ```

2. Run the container using Docker Compose:
   ```
   docker-compose up -d
   ```

## Configuration
The Docker Compose file uses environment variables from the `.env` file for configuration. Ensure all variables in the `.env` file are set before running the container.

## Accessing MariaDB
Once the container is running, you can access MariaDB using a MySQL client:
```
mysql -h localhost -P ${MARIADB_PORT} -u ${MARIADB_USER} -p
```
You will be prompted to enter the password specified in the `.env` file.

## Data Persistence
MariaDB data is stored in the directory specified by `MARIADB_DATA_DIR`. Custom configurations can be added to the directory specified by `MARIADB_CONFIG_DIR`. Ensure these paths exist on your host system and have appropriate permissions.

## Expected Results
After running `docker-compose up -d`, you should see the MariaDB container running. You can verify this by using the `docker ps` command. The output should look similar to this:

```
CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS          PORTS                               NAMES
1a2b3c4d5e6f   mariadb:latest "docker-entrypoint.s…"   10 seconds ago   Up 9 seconds    0.0.0.0:3306->3306/tcp, 33060/tcp   mariadb_db
```

This output indicates that:
- The MariaDB container is running
- It's using the latest MariaDB image
- The container name is `mariadb_db` (or whatever you set in `MARIADB_CONTAINER_NAME`)
- The container's internal port 3306 is mapped to the host's port specified in your `.env` file (default is 3306)
- The container was created recently and is in an "Up" state

If you see this output, your MariaDB container is running successfully and should be accessible via MySQL clients.

## Security Note
Use strong, unique values for the `MARIADB_ROOT_PASSWORD` and `MARIADB_PASSWORD` in your `.env` file, especially in production environments.

## Contributing
Please refer to the repository's contributing guidelines for information on how to contribute to this project.

## License
This repository is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.
