# Graylog Docker Setup

This project contains a Docker Compose setup for Graylog, including basic and advanced configuration options.

Graylog is a powerful open-source log management and analysis platform. It allows you to collect, index, and analyze log data from various sources, making it easier to troubleshoot issues, monitor systems, and ensure security compliance.

## GitHub Repository

https://github.com/vintagedon/docker-compose-cookbook/monitoring-logging/graylog

## Prerequisites

- Docker
- Docker Compose
- At least 4GB of RAM available for Graylog and its dependencies

## Project Structure

```
.
├── docker-compose.yml
├── .env
└── README.md
```

## Files
- `docker-compose.yml`: Graylog service configuration
- `.env`: Environment variables for Graylog configuration
- `README.md`: Project information and instructions

## Usage

1. Edit the `.env` file with your desired configuration.
2. Run the container:

```
docker-compose up -d
```

3. Access Graylog at `http://your-host-ip:9000` after a few minutes. The default login is admin/admin.

### Expected Output

When you run `docker-compose up -d`, you should see output similar to the following:

```
Creating network "graylog_network" with the default driver
Creating volume "graylog_mongodb_data" with local driver
Creating volume "graylog_es_data" with local driver
Creating volume "graylog_graylog_data" with local driver
Creating volume "graylog_graylog_journal" with local driver
Creating graylog_mongodb_1      ... done
Creating graylog_elasticsearch_1 ... done
Creating graylog_graylog_1       ... done
```

You can check the status of your containers by running:

```
docker-compose ps
```

Expected output:

```
         Name                       Command               State                                  Ports                               
-------------------------------------------------------------------------------------------------------------------------------------------
graylog_elasticsearch_1   /usr/local/bin/docker-entr ...   Up      9200/tcp, 9300/tcp                                                 
graylog_graylog_1         /usr/bin/tini -- wait-for- ...   Up      0.0.0.0:12201->12201/tcp, 0.0.0.0:12201->12201/udp, 1514/tcp, 1514/udp, 
                                                                   0.0.0.0:9000->9000/tcp                          
graylog_mongodb_1         docker-entrypoint.sh mongod      Up      27017/tcp                                                          
```

After a few minutes, you should be able to access the Graylog web interface at `http://your-host-ip:9000`.

## Configuration Options

### Basic Options
- `GRAYLOG_PASSWORD_SECRET`: Secret key for password encryption
- `GRAYLOG_ROOT_PASSWORD_SHA2`: SHA256 hash of the root password

### Common Options
- `GRAYLOG_HTTP_EXTERNAL_URI`: The public URL where Graylog will be accessible
- `GRAYLOG_ELASTICSEARCH_HOSTS`: Elasticsearch host(s)

### Advanced Options
- `GRAYLOG_MONGODB_URI`: Custom MongoDB URI
- `GRAYLOG_SMTP_SERVER`: SMTP server for email alerts

Usage:
1. Uncomment relevant lines in the `.env` file.
2. Set desired values.
3. Restart the container:

```
docker-compose down && docker-compose up -d
```

## Data Persistence
Graylog data is stored in Docker volumes:
- `graylog_data`: Graylog configuration and data
- `graylog_journal`: Graylog message journal

## Security Note
- Change the default admin password immediately after first login.
- Use a strong `GRAYLOG_PASSWORD_SECRET` and keep it consistent across restarts.
- Consider using HTTPS for production environments.

## Troubleshooting
Check logs: `docker-compose logs graylog`

Common issues:
1. Elasticsearch not starting: Ensure your system has enough memory and file descriptors.
2. Cannot connect to Graylog web interface: Check if the ports are correctly mapped and not blocked by a firewall.

## Contributing
Feel free to submit issues, fork the repository and send pull requests!

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
