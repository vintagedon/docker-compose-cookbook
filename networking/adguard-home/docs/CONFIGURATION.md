# Configuration Guide for AdGuard Home Docker Setup

This document provides detailed information on configuring your AdGuard Home Docker setup.

## Environment Variables

The following environment variables can be set in the `.env` file:

- `ADGUARD_VERSION`: The version of AdGuard Home to use (default: latest)
- `CONTAINER_NAME`: The name of the Docker container (default: adguardhome)
- `ADGUARD_UI_PORT`: The port for the AdGuard Home web UI (default: 3000)
- `ADGUARD_DNS_PORT`: The port for DNS queries (default: 53)
- `TIMEZONE`: The timezone for the container (default: UTC)

## Docker Compose Configuration

The `docker-compose.yml` file defines the AdGuard Home service. Key configuration points include:

- Ports: Ensure the ports are not in use by other services on your host.
- Volumes: Two volumes are created for persistent storage of work and configuration files.
- Restart policy: Set to "unless-stopped" for automatic restarts.

## AdGuard Home Configuration

After starting the container, you can configure AdGuard Home through its web interface:

1. Access the web UI at `http://<your-ip>:3000`
2. Follow the setup wizard to configure:
   - Admin password
   - DNS settings
   - Filtering rules

## Advanced Configuration

For advanced configuration options, refer to the official AdGuard Home documentation.

Remember to restart the container after making changes to the environment variables or Docker Compose file:

```
docker-compose down
docker-compose up -d
```
