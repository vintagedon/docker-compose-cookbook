# Redis Docker Setup

This project contains a Docker Compose file and environment configuration for setting up a Redis instance in a Docker container. It includes expanded configuration options for advanced users.

[Redis](https://redis.io/) is an open-source, in-memory data structure store, used as a database, cache, message broker, and queue. Redis supports various data structures such as strings, hashes, lists, sets, sorted sets with range queries, bitmaps, hyperloglogs, geospatial indexes, and streams.

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
├── redis.conf
└── README.md
```

## Files
- `docker-compose.yml`: Defines the Redis service configuration with expanded options
- `.env`: Contains environment variables for configuring the Redis instance, including advanced options
- `redis.conf`: Redis configuration file (sample provided below)
- `README.md`: Provides information and instructions for the project

## Sample redis.conf

The following is a sample `redis.conf` file to get you started. Create a file named `redis.conf` in the same directory as your docker-compose.yml and copy the following content into it:

```
# Sample Redis configuration file

# Note that in order to read the configuration file, Redis must be
# started with the file path as first argument:
#
# ./redis-server /path/to/redis.conf

# Accept connections on the specified port, default is 6379.
port 6379

# Set the max number of connected clients at the same time.
# maxclients 10000

# Specify the log file name. Also the empty string can be used to force
# Redis to log on the standard output. Note that if you use standard
# output for logging but daemonize, logs will be sent to /dev/null
logfile ""

# Set the number of databases. The default database is DB 0, you can select
# a different one on a per-connection basis using SELECT <dbid> where
# dbid is a number between 0 and 'databases'-1
databases 16

# By default Redis does not run as a daemon. Use 'yes' if you need it.
# Note that Redis will write a pid file in /var/run/redis.pid when daemonized.
daemonize no

# Set the working directory.
#
# The DB will be written inside this directory, with the filename specified
# above using the 'dbfilename' configuration directive.
#
# The Append Only File will also be created inside this directory.
#
# Note that you must specify a directory here, not a file name.
dir ./

# Persistence
appendonly yes
appendfsync everysec

# Memory management
maxmemory 100mb
maxmemory-policy allkeys-lru

# Security
# Uncomment to enable authentication
# requirepass yourverystrongpassword

# Set the max memory limit. Useful to prevent Redis from using too much memory.
# maxmemory <bytes>

# Uncomment to enable protected mode
# protected-mode yes
```

You can modify this configuration file according to your needs. Remember to update the `REDIS_CONFIG_FILE` variable in your `.env` file to point to this configuration file.

## Usage

1. Create the `redis.conf` file as shown above in the same directory as your docker-compose.yml file.

2. Edit the `.env` file and replace the placeholder values with your desired configuration. The basic configuration includes:

   ```
   REDIS_CONTAINER_NAME=redis
   REDIS_PORT=6379
   REDIS_DATA_DIR=/path/to/your/redis/data
   REDIS_CONFIG_FILE=/path/to/your/redis/redis.conf
   ```

3. (Optional) Configure advanced options by uncommenting and adjusting the additional variables in the `.env` file. These include:

   - `REDIS_MAXMEMORY`: Set the maximum memory Redis can use
   - `REDIS_MAXMEMORY_POLICY`: Set the max memory policy

   To enable any of these options, uncomment the relevant line in the `.env` file and set the desired value.

4. (Optional) Modify the `redis.conf` file to adjust Redis configuration as needed.

5. Run the container using Docker Compose:
   ```
   docker-compose up -d
   ```

## Configuration
The Docker Compose file uses environment variables from the `.env` file for configuration. Ensure all variables in the `.env` file are set before running the container. The expanded options in the `.env` file and `redis.conf` allow for fine-tuned control over the Redis instance.

## Accessing Redis
You can access the Redis instance using the redis-cli tool within the container:

```
docker exec -it redis redis-cli
```

Replace `redis` with your `REDIS_CONTAINER_NAME` if you changed it.

You can also use any Redis client by connecting to `localhost` and the port specified in `REDIS_PORT`.

## Data Persistence
Redis data is stored in the directory specified by `REDIS_DATA_DIR`. Ensure this path exists on your host system and has appropriate permissions.

## Advanced Configuration
The expanded options in the `.env` file and `redis.conf` allow for advanced configuration of the Redis instance. To use these options:

1. Open the `.env` file in a text editor.
2. Locate the commented out options (lines starting with `#`).
3. Remove the `#` from the start of any option you wish to enable.
4. Set the desired value for the option.

For example, to set the maximum memory to 200MB, you would change:

```
#REDIS_MAXMEMORY=100mb
```

to:

```
REDIS_MAXMEMORY=200mb
```

For options that need to be set in the `redis.conf` file, add or modify the relevant lines in that file.

After making changes, restart your Redis container for the new settings to take effect:

```
docker-compose down
docker-compose up -d
```

## Expected Results
After running `docker-compose up -d`, you should see the Redis container running. You can verify this by using the `docker ps` command. The output should look similar to this:

```
CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS          PORTS                    NAMES
1a2b3c4d5e6f   redis:latest   "docker-entrypoint.s…"   10 seconds ago   Up 9 seconds    0.0.0.0:6379->6379/tcp   redis
```

This output indicates that:
- The Redis container is running
- It's using the latest Redis image
- The container name matches what you set in `REDIS_CONTAINER_NAME`
- Redis's internal port 6379 is mapped to the host's port specified in your `.env` file

If you see this output, your Redis setup is running successfully and should be accessible via Redis clients.

## Security Note
If you enable Redis authentication by setting a password in the `redis.conf` file, ensure you use a strong, unique password, especially in production environments. Be cautious when adjusting advanced settings, as they can significantly impact the performance and security of your Redis instance.

## Contributing
Please refer to the repository's contributing guidelines for information on how to contribute to this project.

## License
This repository is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.
