# Apache Cassandra Docker Setup

This project contains a Docker Compose file and environment configuration for setting up an Apache Cassandra instance in a Docker container. It includes expanded configuration options for advanced users.

[Apache Cassandra](https://cassandra.apache.org/) is a free and open-source, distributed, wide-column store, NoSQL database management system designed to handle large amounts of data across many commodity servers, providing high availability with no single point of failure.

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
- `docker-compose.yml`: Defines the Cassandra service configuration with expanded options
- `.env`: Contains environment variables for configuring the Cassandra instance, including advanced options
- `README.md`: Provides information and instructions for the project

## Usage

1. Edit the `.env` file and replace the placeholder values with your desired configuration. The basic configuration includes:

   ```
   CASSANDRA_CONTAINER_NAME=cassandra
   CASSANDRA_NATIVE_TRANSPORT_PORT=9042
   CASSANDRA_RPC_PORT=9160
   CASSANDRA_DATA_DIR=/path/to/your/cassandra/data
   CASSANDRA_CONFIG_DIR=/path/to/your/cassandra/config
   CASSANDRA_CLUSTER_NAME=MyCluster
   CASSANDRA_SEEDS=cassandra
   CASSANDRA_NUM_TOKENS=256
   CASSANDRA_DC=datacenter1
   CASSANDRA_RACK=rack1
   CASSANDRA_ENDPOINT_SNITCH=SimpleSnitch
   CASSANDRA_MAX_HEAP_SIZE=512M
   CASSANDRA_HEAP_NEWSIZE=100M
   ```

2. (Optional) Configure advanced options by uncommenting and adjusting the additional variables in the `.env` file. These include options for commit log sync, compaction settings, memtable allocation, and more.

3. Run the container using Docker Compose:
   ```
   docker-compose up -d
   ```

## Configuration
The Docker Compose file uses environment variables from the `.env` file for configuration. Ensure all variables in the `.env` file are set before running the container. The expanded options in the `.env` file allow for fine-tuned control over the Cassandra instance.

## Accessing Cassandra
You can access the Cassandra instance using the Cassandra Query Language (CQL) shell:

```
docker exec -it cassandra cqlsh
```

Replace `cassandra` with your `CASSANDRA_CONTAINER_NAME` if you changed it.

You can also use any Cassandra client by connecting to `localhost` and the port specified in `CASSANDRA_NATIVE_TRANSPORT_PORT`.

## Data Persistence
Cassandra data is stored in the directory specified by `CASSANDRA_DATA_DIR`. Configuration files are stored in the directory specified by `CASSANDRA_CONFIG_DIR`. Ensure these paths exist on your host system and have appropriate permissions.

## Advanced Configuration
The expanded options in the `.env` file allow for advanced configuration of the Cassandra instance. To use these options:

1. Open the `.env` file in a text editor.
2. Locate the commented out options (lines starting with `#`).
3. Remove the `#` from the start of any option you wish to enable.
4. Set the desired value for the option.

For example, to set the commit log sync mode to 'batch', you would change:

```
#CASSANDRA_COMMITLOG_SYNC=periodic
```

to:

```
CASSANDRA_COMMITLOG_SYNC=batch
```

After making changes, restart your Cassandra container for the new settings to take effect:

```
docker-compose down
docker-compose up -d
```

## Expected Results
After running `docker-compose up -d`, you should see the Cassandra container running. You can verify this by using the `docker ps` command. The output should look similar to this:

```
CONTAINER ID   IMAGE             COMMAND                  CREATED          STATUS          PORTS                                                                     NAMES
1a2b3c4d5e6f   cassandra:latest  "docker-entrypoint.s…"   10 seconds ago   Up 9 seconds    7000-7001/tcp, 7199/tcp, 9160/tcp, 0.0.0.0:9042->9042/tcp, 9042/tcp   cassandra
```

This output indicates that:
- The Cassandra container is running
- It's using the latest Cassandra image
- The container name matches what you set in `CASSANDRA_CONTAINER_NAME`
- Cassandra's native transport port (default 9042) is mapped to the host's port specified in your `.env` file

If you see this output, your Cassandra setup is running successfully and should be accessible via Cassandra clients.

## Security Note
This setup is intended for development and testing purposes. For production environments, you should implement proper security measures, including but not limited to:
- Enabling authentication
- Configuring SSL/TLS for client-server and inter-node communication
- Setting up firewalls and network segregation
- Regularly updating to the latest Cassandra version

## Scaling Cassandra
To scale Cassandra to multiple nodes, you can modify the docker-compose.yml file to include additional Cassandra services. Make sure to adjust the `CASSANDRA_SEEDS` environment variable to include the names of all seed nodes.

## Contributing
Please refer to the repository's contributing guidelines for information on how to contribute to this project.

## License
This repository is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.
