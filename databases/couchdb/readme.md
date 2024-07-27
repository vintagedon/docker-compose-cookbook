# CouchDB Docker Setup

This project contains a Docker Compose file and environment configuration for setting up a CouchDB instance in a Docker container. It includes expanded configuration options for advanced users.

[CouchDB](https://couchdb.apache.org/) is a document-oriented NoSQL database, implemented in Erlang. CouchDB uses multiple formats and protocols to store, transfer, and process its data, it uses JSON to store data, JavaScript as its query language using MapReduce, and HTTP for an API.

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
- `docker-compose.yml`: Defines the CouchDB service configuration with expanded options
- `.env`: Contains environment variables for configuring the CouchDB instance, including advanced options
- `README.md`: Provides information and instructions for the project

## Usage

1. Edit the `.env` file and replace the placeholder values with your desired configuration. The basic configuration includes:

   ```
   COUCHDB_CONTAINER_NAME=couchdb
   COUCHDB_USER=admin
   COUCHDB_PASSWORD=your_secure_password
   COUCHDB_SECRET=your_secret_for_cookies
   COUCHDB_NODENAME=couchdb@localhost
   COUCHDB_PORT=5984
   COUCHDB_DATA_DIR=/path/to/your/couchdb/data
   COUCHDB_CONFIG_DIR=/path/to/your/couchdb/config
   ```

2. (Optional) Configure advanced options by uncommenting and adjusting the additional variables in the `.env` file. These include:

   - `COUCHDB_MAX_DBS_OPEN`: Set the maximum number of open databases
   - `COUCHDB_MAX_CONNECTIONS`: Set the maximum number of HTTP connections
   - `COUCHDB_SESSION_TIMEOUT`: Set the session timeout in seconds
   - `COUCHDB_OS_PROCESS_TIMEOUT`: Set the OS process timeout in milliseconds
   - `COUCHDB_ALLOW_PERSISTENT_COOKIES`: Allow persistent cookies (true/false)
   - `COUCHDB_MAX_DOCUMENT_SIZE`: Set the maximum document size in bytes

   To enable any of these options, uncomment the relevant line in the `.env` file and set the desired value.

3. Run the container using Docker Compose:
   ```
   docker-compose up -d
   ```

## Configuration
The Docker Compose file uses environment variables from the `.env` file for configuration. Ensure all variables in the `.env` file are set before running the container. The expanded options in the `.env` file allow for fine-tuned control over the CouchDB instance.

## Accessing CouchDB
You can access the CouchDB instance through its web interface or using any CouchDB client. The web interface is available at:

```
http://localhost:5984/_utils/
```

Replace `5984` with the port you specified in `COUCHDB_PORT` if you changed it.

You can also use curl to interact with CouchDB's REST API:

```
curl -X GET http://localhost:5984/
```

## Data Persistence
CouchDB data is stored in the directory specified by `COUCHDB_DATA_DIR`. Configuration files are stored in the directory specified by `COUCHDB_CONFIG_DIR`. Ensure these paths exist on your host system and have appropriate permissions.

## Advanced Configuration
The expanded options in the `.env` file allow for advanced configuration of the CouchDB instance. To use these options:

1. Open the `.env` file in a text editor.
2. Locate the commented out options (lines starting with `#`).
3. Remove the `#` from the start of any option you wish to enable.
4. Set the desired value for the option.

For example, to set the maximum number of open databases to 1000, you would change:

```
#COUCHDB_MAX_DBS_OPEN=500
```

to:

```
COUCHDB_MAX_DBS_OPEN=1000
```

After making changes, restart your CouchDB container for the new settings to take effect:

```
docker-compose down
docker-compose up -d
```

## Expected Results
After running `docker-compose up -d`, you should see the CouchDB container running. You can verify this by using the `docker ps` command. The output should look similar to this:

```
CONTAINER ID   IMAGE            COMMAND                  CREATED          STATUS          PORTS                              NAMES
1a2b3c4d5e6f   couchdb:latest   "tini -- /docker-ent…"   10 seconds ago   Up 9 seconds    0.0.0.0:5984->5984/tcp, 4369/tcp   couchdb
```

This output indicates that:
- The CouchDB container is running
- It's using the latest CouchDB image
- The container name matches what you set in `COUCHDB_CONTAINER_NAME`
- CouchDB's internal port 5984 is mapped to the host's port specified in your `.env` file

If you see this output, your CouchDB setup is running successfully and should be accessible via the web interface and CouchDB clients.

## Security Note
Use strong, unique values for the `COUCHDB_PASSWORD` and `COUCHDB_SECRET` in your `.env` file, especially in production environments. Be cautious when adjusting advanced settings, as they can significantly impact the performance and security of your CouchDB instance.

## Contributing
Please refer to the repository's contributing guidelines for information on how to contribute to this project.

## License
This repository is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.
