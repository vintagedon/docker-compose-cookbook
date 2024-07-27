# Grafana Docker Setup

This project contains a Docker Compose file and environment configuration for setting up a Grafana instance in a Docker container. It includes both basic and advanced configuration options for customizing your Grafana deployment.

[Grafana](https://grafana.com/) is an open-source platform for monitoring and observability. It allows you to query, visualize, alert on, and understand your metrics no matter where they are stored. It provides tools to turn your time-series database (TSDB) data into beautiful graphs and visualizations.

## GitHub Repository
[https://github.com/vintagedon/docker-compose-cookbook/tree/main/monitoring-logging/Grafana](https://github.com/vintagedon/docker-compose-cookbook/tree/main/monitoring-logging/Grafana)

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
- `docker-compose.yml`: Defines the Grafana service configuration
- `.env`: Contains environment variables for configuring the Grafana instance
- `README.md`: Provides information and instructions for the project

## Usage

1. Edit the `.env` file and replace the placeholder values with your desired configuration.

2. Run the container using Docker Compose:
   ```
   docker-compose up -d
   ```

3. Access the Grafana web interface at `http://localhost:3000` (replace `localhost` with your server's IP if needed).

4. Log in with the default credentials (admin/admin) and change the password when prompted.

## Configuration Options

### Basic Options

- `GRAFANA_CONTAINER_NAME`: Name of the Grafana container
- `GRAFANA_CONFIG_DIR`: Directory for Grafana configuration files
- `GRAFANA_DATA_DIR`: Directory for Grafana data storage
- `GRAFANA_PORT`: Port for the Grafana web interface

### Common Options

- `GF_SECURITY_ADMIN_USER`: The name of the Grafana admin user
- `GF_SECURITY_ADMIN_PASSWORD`: The password of the Grafana admin user
- `GF_USERS_ALLOW_SIGN_UP`: Allow users to sign up
- `GF_AUTH_ANONYMOUS_ENABLED`: Enable anonymous access

### Advanced Options

- `GF_SERVER_ROOT_URL`: The full URL used to access Grafana from a web browser
- `GF_SMTP_ENABLED`: Enable SMTP for email notifications
- `GF_SMTP_HOST`: SMTP server host
- `GF_SMTP_USER`: SMTP server user
- `GF_SMTP_PASSWORD`: SMTP server password
- `GF_INSTALL_PLUGINS`: Comma-separated list of plugins to install

To use these options:

1. Uncomment the relevant lines in the `.env` file.
2. Set your desired values.
3. Restart the Grafana container for the changes to take effect:
   ```
   docker-compose down
   docker-compose up -d
   ```

## Accessing Grafana
The Grafana web interface is accessible at `http://localhost:3000` (replace `localhost` with your server's IP if needed). From here, you can:
- Create and manage dashboards
- Configure data sources
- Set up alerts
- Manage users and organizations

## Data Persistence
Grafana data is stored in the directory specified by `GRAFANA_DATA_DIR`. Ensure this path exists on your host system and has appropriate permissions.

## Security Note
While this setup provides a good starting point, additional security measures should be implemented for production use, including:
- Using HTTPS for secure communication
- Implementing proper firewall rules
- Regularly updating Grafana and its dependencies
- Setting up authentication providers (LDAP, OAuth, etc.) for user management
- Configuring role-based access control (RBAC)

## Troubleshooting
If you encounter issues, check the Grafana logs using:
```
docker-compose logs grafana
```

Common issues:
1. Database connection errors: Ensure your database (if using an external one) is properly configured and accessible.
2. Plugin installation failures: Check internet connectivity and verify plugin names and versions.
3. SMTP configuration issues: Double-check your SMTP server settings if email notifications aren't working.
4. Permission problems: Ensure the `GRAFANA_CONFIG_DIR` and `GRAFANA_DATA_DIR` have the correct ownership and permissions.

## Contributing
Please feel free to submit issues, fork the repository and send pull requests!

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.
