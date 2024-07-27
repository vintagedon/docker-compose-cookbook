# MongoDB Docker Setup

This project contains a Docker Compose file and environment configuration for setting up a MongoDB instance in a Docker container, along with the Mongo Express web-based admin interface. It includes expanded configuration options for advanced users.

[MongoDB](https://www.mongodb.com/) is a source-available cross-platform document-oriented database program. Classified as a NoSQL database program, MongoDB uses JSON-like documents with optional schemas.

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
- `docker-compose.yml`: Defines the MongoDB service configuration with expanded options and Mongo Express
- `.env`: Contains environment variables for configuring the MongoDB instance, including advanced options
- `README.md`: Provides information and instructions for the project

## Usage

1. Edit the `.env` file and replace the placeholder values with your desired configuration. The basic configuration includes:

   ```
   MONGO_CONTAINER_NAME=mongodb
   MONGO_ROOT_USERNAME=admin
   MONGO_ROOT_PASSWORD=your_secure_password
   MONGO_INITDB_DATABASE=your_database_name
   MONGO_PORT=27017
   MONGO_DATA_DIR=/path/to/your/mongodb/data
   MONGO_CONFIG_DIR=/path/to/your/mongodb/config
   MONGO_EXPRESS_CONTAINER_NAME=mongo-express
   MONGO_EXPRESS_PORT=8081
   ```

2. (Optional) Configure advanced options by uncommenting and adjusting the additional variables in the `.env` file. These include:

   - `MONGO_MAX_TRANSACTION_LOCK_REQUEST_TIMEOUT`: Set the maximum transaction lock request timeout in milliseconds
   - `MONGO_CURSOR_TIMEOUT`: Set the cursor timeout in milliseconds
   - `MONGO_MAX_TIME_MS`: Set the maximum time for operations in milliseconds
   - `MONGO_CACHE_SIZE`: Set the WiredTiger cache size in GB

   To enable any of these options, uncomment the relevant line in the `.env` file and set the desired value.

3. Run the containers using Docker Compose:
   ```
   docker-compose up -d
   ```

## Configuration
The Docker Compose file uses environment variables from the `.env` file for configuration. Ensure all variables in the `.env` file are set before running the containers. The expanded options in the `.env` file allow for fine-tuned control over the MongoDB instance.

## Accessing MongoDB
You can access the MongoDB instance using the MongoDB shell or any MongoDB client. To use the MongoDB shell:

```
docker exec -it mongodb mongo -u ${MONGO_ROOT_USERNAME} -p ${MONGO_ROOT_PASSWORD}
```

Replace `mongodb` with your `MONGO_CONTAINER_NAME` if you changed it.

Alternatively, you can use Mongo Express by navigating to `http://localhost:8081` (or the port you specified in `MONGO_EXPRESS_PORT`) in your web browser.

## Data Persistence
MongoDB data is stored in the directory specified by `MONGO_DATA_DIR`. Configuration files are stored in the directory specified by `MONGO_CONFIG_DIR`. Ensure these paths exist on your host system and have appropriate permissions.

## Advanced Configuration
The expanded options in the `.env` file allow for advanced configuration of the MongoDB instance. To use these options:

1. Open the `.env` file in a text editor.
2. Locate the commented out options (lines starting with `#`).
3. Remove the `#` from the start of any option you wish to enable.
4. Set the desired value for the option.

For example, to set the WiredTiger cache size to 1GB, you would change:

```
#MONGO_CACHE_SIZE=0.5
```

to:

```
MONGO_CACHE_SIZE=1
```

After making changes, restart your MongoDB container for the new settings to take effect:

```
docker-compose down
docker-compose up -d
```

## Expected Results
After running `docker-compose up -d`, you should see two containers running: one for MongoDB and one for Mongo Express. You can verify this by using the `docker ps` command. The output should look similar to this:

```
CONTAINER ID   IMAGE                   COMMAND                  CREATED          STATUS          PORTS                      NAMES
1a2b3c4d5e6f   mongo:latest            "docker-entrypoint.s…"   10 seconds ago   Up 9 seconds    0.0.0.0:27017->27017/tcp   mongodb
9h8g7f6e5d4c   mongo-express:latest    "tini -- /docker-ent…"   10 seconds ago   Up 9 seconds    0.0.0.0:8081->8081/tcp     mongo-express
```

This output indicates that:
- The MongoDB container is running
- The Mongo Express container is running
- The container names match what you set in `MONGO_CONTAINER_NAME` and `MONGO_EXPRESS_CONTAINER_NAME`
- MongoDB's internal port 27017 is mapped to the host's port specified in your `.env` file
- Mongo Express's internal port 8081 is mapped to the host's port specified in your `.env` file

If you see this output, your MongoDB setup is running successfully and should be accessible via MongoDB clients and the Mongo Express web interface.

## Security Note
Use strong, unique values for the `MONGO_ROOT_PASSWORD` in your `.env` file, especially in production environments. Be cautious when adjusting advanced settings, as they can significantly impact the performance and security of your MongoDB instance. The Mongo Express interface does not include authentication by default, so be careful about exposing the port publicly.

## Contributing
Please refer to the repository's contributing guidelines for information on how to contribute to this project.

## License
This repository is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.
