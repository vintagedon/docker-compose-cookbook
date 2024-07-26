# MySQL Docker Setup

This project contains a Docker Compose file and environment configuration for setting up a standalone MySQL instance in a Docker container.

## Author
vintagedon

## GitHub Repository
[https://github.com/vintagedon/infrastructure-scripting/blob/main/docker-compose/](https://github.com/vintagedon/infrastructure-scripting/blob/main/docker-compose/)

## Description
This setup creates a containerized instance of MySQL with customizable configuration using environment variables.

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
- `docker-compose.yml`: Defines the MySQL service configuration
- `.env`: Contains environment variables for configuring the MySQL instance
- `README.md`: Provides information and instructions for the project

## Usage

1. Copy the `.env.example` file to `.env`:
   ```
   cp .env.example .env
   ```

2. Edit the `.env` file and replace the placeholder values with your desired configuration:
   ```
   MYSQL_CONTAINER_NAME=mysql_db
   MYSQL_ROOT_PASSWORD=your_secure_root_password
   MYSQL_DATABASE=your_database_name
   MYSQL_USER=your_username
   MYSQL_PASSWORD=your_secure_password
   MYSQL_PORT=3306
   MYSQL_DATA_DIR=/path/to/your/mysql/data
   MYSQL_CONFIG_DIR=/path/to/your/mysql/config
   ```

3. Run the container using Docker Compose:
   ```
   docker-compose up -d
   ```

## Configuration
The Docker Compose file uses environment variables from the `.env` file for configuration. Ensure all variables in the `.env` file are set before running the container.

## Accessing MySQL
Once the container is running, you can access MySQL using a MySQL client:
```
mysql -h localhost -P ${MYSQL_PORT} -u ${MYSQL_USER} -p
```
You will be prompted to enter the password specified in the `.env` file.

## Data Persistence
MySQL data is stored in the directory specified by `MYSQL_DATA_DIR`. Custom configurations can be added to the directory specified by `MYSQL_CONFIG_DIR`. Ensure these paths exist on your host system and have appropriate permissions.

## Expected Results
After running `docker-compose up -d`, you should see the MySQL container running. You can verify this by using the `docker ps` command. The output should look similar to this:

```
CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS          PORTS                               NAMES
1a2b3c4d5e6f   mysql:latest   "docker-entrypoint.s…"   10 seconds ago   Up 9 seconds    0.0.0.0:3306->3306/tcp, 33060/tcp   mysql_db
```

This output indicates that:
- The MySQL container is running
- It's using the latest MySQL image
- The container name is `mysql_db` (or whatever you set in `MYSQL_CONTAINER_NAME`)
- The container's internal port 3306 is mapped to the host's port specified in your `.env` file (default is 3306)
- The container was created recently and is in an "Up" state

If you see this output, your MySQL container is running successfully and should be accessible via MySQL clients.

## Security Note
Use strong, unique values for the `MYSQL_ROOT_PASSWORD` and `MYSQL_PASSWORD` in your `.env` file, especially in production environments.

## Contributing
Please refer to the repository's contributing guidelines for information on how to contribute to this project.

## License
[Include license information here]
