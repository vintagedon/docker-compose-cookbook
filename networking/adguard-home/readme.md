# AdGuard Home Docker Setup

This project contains a Docker Compose file and environment configuration for setting up an AdGuard Home instance in a Docker container. It includes configuration options for customizing your AdGuard Home deployment.

[AdGuard Home](https://adguard.com/en/adguard-home/overview.html) is a network-wide software for blocking ads & tracking. After you set it up, it'll cover ALL your home devices, and you don't need any client-side software for that. With the rise of Internet-Of-Things devices, this becomes increasingly important.

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
- `docker-compose.yml`: Defines the AdGuard Home service configuration
- `.env`: Contains environment variables for configuring the AdGuard Home instance
- `README.md`: Provides information and instructions for the project

## Usage

1. Edit the `.env` file and replace the placeholder values with your desired configuration. The basic configuration includes:

   ```
   ADGUARD_CONTAINER_NAME=adguardhome
   ADGUARD_HTTP_PORT=3000
   ADGUARD_DNS_PORT=53
   ADGUARD_CONFIG_DIR=/path/to/your/adguard/config
   ADGUARD_WORK_DIR=/path/to/your/adguard/work
   ```

2. Run the container using Docker Compose:
   ```
   docker-compose up -d
   ```

## Configuration
The Docker Compose file uses environment variables from the `.env` file for configuration. Ensure all variables in the `.env` file are set before running the container.

## Accessing AdGuard Home
You can access the AdGuard Home web interface by navigating to `http://localhost:3000` in your web browser (replace 3000 with the port specified in `ADGUARD_HTTP_PORT` if you changed it).

To use AdGuard Home as your DNS server, configure your router or individual devices to use the IP address of the machine running the AdGuard Home container as the DNS server.

## Data Persistence
AdGuard Home configuration and data are stored in the directories specified by `ADGUARD_CONFIG_DIR` and `ADGUARD_WORK_DIR`. Ensure these paths exist on your host system and have appropriate permissions.

## Expected Results
After running `docker-compose up -d`, you should see the AdGuard Home container running. You can verify this by using the `docker ps` command. The output should look similar to this:

```
CONTAINER ID   IMAGE                    COMMAND     CREATED          STATUS          PORTS                                                           NAMES
1a2b3c4d5e6f   adguard/adguardhome:latest   "/entrypoint.sh"   10 seconds ago   Up 9 seconds    0.0.0.0:53->53/tcp, 0.0.0.0:53->53/udp, 0.0.0.0:3000->3000/tcp   adguardhome
```

This output indicates that:
- The AdGuard Home container is running
- It's using the latest AdGuard Home image
- The container name matches what you set in `ADGUARD_CONTAINER_NAME`
- The necessary ports (53 for DNS and 3000 for web interface) are mapped to the host

If you see this output, your AdGuard Home setup is running successfully and should be accessible via web interface and ready to use as a DNS server.

## Initial Setup
When you first access the AdGuard Home web interface, you'll need to go through an initial setup process:

1. Create an admin account
2. Configure your network settings
3. Choose which upstream DNS servers to use
4. Select which blocklists to enable

## Security Note
This setup is intended for development and testing purposes. For production environments, you should implement proper security measures, including but not limited to:
- Using HTTPS for the web interface
- Configuring firewalls to restrict access
- Regularly updating to the latest AdGuard Home version

## Contributing
Please refer to the repository's contributing guidelines for information on how to contribute to this project.

## License
This repository is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.
