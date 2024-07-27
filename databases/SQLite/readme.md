# SQLite Docker Setup

This project contains a Docker Compose file and environment configuration for setting up a SQLite instance in a Docker container, along with an optional web-based management interface. It includes expanded configuration options for advanced users.

[SQLite](https://www.sqlite.org/) is a C-language library that implements a small, fast, self-contained, high-reliability, full-featured, SQL database engine. SQLite is the most used database engine in the world, embedded in countless applications.

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
- `docker-compose.yml`: Defines the SQLite service configuration with expanded options and an optional web interface
- `.env`: Contains environment variables for configuring the SQLite instance, including advanced options
- `README.md`: Provides information and instructions for the project

## Usage

1. Edit the `.env` file and replace the placeholder values with your desired configuration. The basic configuration includes:

   ```
   SQLITE_CONTAINER_NAME=sqlite_db
   SQLITE_DATABASE=your_database.db
   SQLITE_DATA_DIR=/path/to/your/sqlite/data
   SQLITE_WEB_CONTAINER_NAME=sqlite_web
   SQLITE_WEB_PORT=8080
   ```

2. (Optional) Configure advanced options by uncommenting and adjusting the additional variables in the `.env` file. These include:

   - `SQLITE_JOURNAL_MODE`: Set the journal mode (DELETE, TRUNCATE, PERSIST, MEMORY, WAL, OFF)
   - `SQLITE_SYNCHRONOUS`: Set the synchronous mode (0=OFF, 1=NORMAL, 2=FULL, 3=EXTRA)
   - `SQLITE_TEMP_STORE`: Set the temp store mode (0=DEFAULT, 1=FILE, 2=MEMORY)
   - `SQLITE_MMAP_SIZE`: Set the mmap size (in bytes, 0 to disable)
   - `SQLITE_CACHE_SIZE`: Set the cache size (in pages, negative values for kibibytes)

   To enable any of these options, uncomment the relevant line in the `.env` file and set the desired value.

3. Run the containers using Docker Compose:
   ```
   docker-compose up -d
   ```

## Configuration
The Docker Compose file uses environment variables from the `.env` file for configuration. Ensure all variables in the `.env` file are set before running the containers. The expanded options in the `.env` file allow for fine-tuned control over the SQLite instance.

## Accessing SQLite
You can access the SQLite database directly through the container:

```
docker exec -it sqlite_db sqlite3 /data/your_database.db
```

Replace `sqlite_db` with your `SQLITE_CONTAINER_NAME` and `your_database.db` with your `SQLITE_DATABASE` value.

Alternatively, you can use the web-based management interface by navigating to `http://localhost:8080` (or the port you specified in `SQLITE_WEB_PORT`) in your web browser.

## Data Persistence
SQLite data is stored in the directory specified by `SQLITE_DATA_DIR`. Ensure this path exists on your host system and has appropriate permissions.

## Advanced Configuration
The expanded options in the `.env` file allow for advanced configuration of the SQLite instance. To use these options:

1. Open the `.env` file in a text editor.
2. Locate the commented out options (lines starting with `#`).
3. Remove the `#` from the start of any option you wish to enable.
4. Set the desired value for the option.

For example, to set the journal mode to WAL, you would change:

```
#SQLITE_JOURNAL_MODE=WAL
```

to:

```
SQLITE_JOURNAL_MODE=WAL
```

After making changes, restart your SQLite container for the new settings to take effect:

```
docker-compose down
docker-compose up -d
```

## Expected Results
After running `docker-compose up -d`, you should see two containers running: one for SQLite and one for the web interface. You can verify this by using the `docker ps` command. The output should look similar to this:

```
CONTAINER ID   IMAGE                     COMMAND                  CREATED          STATUS          PORTS                    NAMES
1a2b3c4d5e6f   keinos/sqlite3:latest     "tail -f /dev/null"      10 seconds ago   Up 9 seconds                             sqlite_db
9h8g7f6e5d4c   coleifer/sqlite-web       "gunicorn --bind :80…"   10 seconds ago   Up 9 seconds    0.0.0.0:8080->8080/tcp   sqlite_web
```

This output indicates that:
- The SQLite container is running
- The SQLite Web interface container is running
- The container names match what you set in `SQLITE_CONTAINER_NAME` and `SQLITE_WEB_CONTAINER_NAME`
- The web interface's internal port 8080 is mapped to the host's port specified in your `.env` file

If you see this output, your SQLite setup is running successfully and should be accessible via the command line and web interface.

## Security Note
Be cautious when adjusting advanced settings, as they can significantly impact the performance and reliability of your SQLite instance. The web interface does not include authentication by default, so be careful about exposing the port publicly.

## Contributing
Please refer to the repository's contributing guidelines for information on how to contribute to this project.

## License
This repository is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.
