# Neo4j Docker Setup

This project contains a Docker Compose file and environment configuration for setting up a Neo4j instance in a Docker container. It includes expanded configuration options for advanced users.

[Neo4j](https://neo4j.com/) is a graph database management system developed by Neo4j, Inc. It is an ACID-compliant transactional database with native graph storage and processing. Neo4j is particularly well-suited for connected data and complex queries.

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
- `docker-compose.yml`: Defines the Neo4j service configuration with expanded options
- `.env`: Contains environment variables for configuring the Neo4j instance, including advanced options
- `README.md`: Provides information and instructions for the project

## Usage

1. Edit the `.env` file and replace the placeholder values with your desired configuration. The basic configuration includes:

   ```
   NEO4J_CONTAINER_NAME=neo4j
   NEO4J_HTTP_PORT=7474
   NEO4J_BOLT_PORT=7687
   NEO4J_DATA_DIR=/path/to/your/neo4j/data
   NEO4J_LOGS_DIR=/path/to/your/neo4j/logs
   NEO4J_IMPORT_DIR=/path/to/your/neo4j/import
   NEO4J_PLUGINS_DIR=/path/to/your/neo4j/plugins
   NEO4J_AUTH=neo4j/your_secure_password
   NEO4J_PAGECACHE_SIZE=512M
   NEO4J_HEAP_INITIAL_SIZE=512M
   NEO4J_HEAP_MAX_SIZE=1G
   ```

2. (Optional) Configure advanced options by uncommenting and adjusting the additional variables in the `.env` file. These include options for database upgrades, procedure whitelisting, GC logging, transaction timeouts, and more.

3. Run the container using Docker Compose:
   ```
   docker-compose up -d
   ```

## Configuration
The Docker Compose file uses environment variables from the `.env` file for configuration. Ensure all variables in the `.env` file are set before running the container. The expanded options in the `.env` file allow for fine-tuned control over the Neo4j instance.

## Accessing Neo4j
You can access the Neo4j browser interface by navigating to `http://localhost:7474` in your web browser. Replace `7474` with the port you specified in `NEO4J_HTTP_PORT` if you changed it.

To connect to Neo4j using a client application or library, use the Bolt protocol with the address `bolt://localhost:7687`. Replace `7687` with the port you specified in `NEO4J_BOLT_PORT` if you changed it.

## Data Persistence
Neo4j data is stored in the directory specified by `NEO4J_DATA_DIR`. Logs are stored in `NEO4J_LOGS_DIR`, import files in `NEO4J_IMPORT_DIR`, and plugins in `NEO4J_PLUGINS_DIR`. Ensure these paths exist on your host system and have appropriate permissions.

## Advanced Configuration
The expanded options in the `.env` file allow for advanced configuration of the Neo4j instance. To use these options:

1. Open the `.env` file in a text editor.
2. Locate the commented out options (lines starting with `#`).
3. Remove the `#` from the start of any option you wish to enable.
4. Set the desired value for the option.

For example, to enable query logging, you would change:

```
#NEO4J_dbms_logs_query_enabled=true
```

to:

```
NEO4J_dbms_logs_query_enabled=true
```

After making changes, restart your Neo4j container for the new settings to take effect:

```
docker-compose down
docker-compose up -d
```

## Expected Results
After running `docker-compose up -d`, you should see the Neo4j container running. You can verify this by using the `docker ps` command. The output should look similar to this:

```
CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS          PORTS                                                      NAMES
1a2b3c4d5e6f   neo4j:latest   "tini -g -- /startup…"   10 seconds ago   Up 9 seconds    0.0.0.0:7474->7474/tcp, 7473/tcp, 0.0.0.0:7687->7687/tcp   neo4j
```

This output indicates that:
- The Neo4j container is running
- It's using the latest Neo4j image
- The container name matches what you set in `NEO4J_CONTAINER_NAME`
- Neo4j's HTTP port (default 7474) and Bolt port (default 7687) are mapped to the host's ports specified in your `.env` file

If you see this output, your Neo4j setup is running successfully and should be accessible via the browser interface and Neo4j clients.

## Security Note
- Use strong, unique passwords for Neo4j authentication, especially in production environments.
- Be cautious when enabling unrestricted procedures or whitelisting procedures, as this can potentially expose security vulnerabilities.
- In production environments, consider enabling SSL/TLS for encrypted communications.
- Regularly update to the latest Neo4j version to ensure you have the latest security patches.

## Plugin Management
To add plugins to your Neo4j instance, place the plugin JAR files in the directory specified by `NEO4J_PLUGINS_DIR`. You may need to restart the container for new plugins to be recognized.

## Contributing
Please refer to the repository's contributing guidelines for information on how to contribute to this project.

## License
This repository is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.
