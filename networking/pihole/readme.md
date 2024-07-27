# Pi-hole Docker Setup

This project contains a Docker Compose file and environment configuration for setting up a Pi-hole instance in a Docker container. It includes configuration options for customizing your Pi-hole deployment.

[Pi-hole](https://pi-hole.net/) is a network-wide ad blocker that acts as a DNS sinkhole and optionally a DHCP server, intended for use on a private network. It is designed to block ads and tracking domains across your entire network, improving privacy and potentially speeding up your internet browsing experience.

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
- `docker-compose.yml`: Defines the Pi-hole service configuration
- `.env`: Contains environment variables for configuring the Pi-hole instance
- `README.md`: Provides information and instructions for the project

## Usage

1. Edit the `.env` file and replace the placeholder values with your desired configuration. The basic configuration includes:

   ```
   PIHOLE_CONTAINER_NAME=pihole
   PIHOLE_WEB_PORT=80
   PIHOLE_DNS_PORT=53
   PIHOLE_DHCP_PORT=67
   PIHOLE_CONFIG_DIR=/path/to/your/pihole/config
   PIHOLE_TIMEZONE=America/New_York
   PIHOLE_PASSWORD=your_secure_password
   PIHOLE_DNS1=1.1.1.1
   PIHOLE_DNS2=1.0.0.1
   ```

2. Run the container using Docker Compose:
   ```
   docker-compose up -d
   ```

## Configuration
The Docker Compose file uses environment variables from the `.env` file for configuration. Ensure all variables in the `.env` file are set before running the container.

## Accessing Pi-hole
You can access the Pi-hole web interface by navigating to `http://localhost:80` in your web browser (replace 80 with the port specified in `PIHOLE_WEB_PORT` if you changed it).

To use Pi-hole as your DNS server, configure your router or individual devices to use the IP address of the machine running the Pi-hole container as the DNS server.

## Data Persistence
Pi-hole configuration and data are stored in the directory specified by `PIHOLE_CONFIG_DIR`. Ensure this path exists on your host system and has appropriate permissions.

## Expected Results
After running `docker-compose up -d`, you should see the Pi-hole container running. You can verify this by using the `docker ps` command. The output should look similar to this:

```
CONTAINER ID   IMAGE                  COMMAND             CREATED          STATUS          PORTS                                                                  NAMES
1a2b3c4d5e6f   pihole/pihole:latest   "/s6-init"          10 seconds ago   Up 9 seconds    0.0.0.0:53->53/tcp, 0.0.0.0:53->53/udp, 0.0.0.0:80->80/tcp, 67/udp   pihole
```

This output indicates that:
- The Pi-hole container is running
- It's using the latest Pi-hole image
- The container name matches what you set in `PIHOLE_CONTAINER_NAME`
- The necessary ports (53 for DNS, 80 for web interface, and optionally 67 for DHCP) are mapped to the host

If you see this output, your Pi-hole setup is running successfully and should be accessible via web interface and ready to use as a DNS server.

## Security Note
This setup is intended for development and testing purposes. For production environments, you should implement proper security measures, including but not limited to:
- Using HTTPS for the web interface
- Configuring firewalls to restrict access
- Regularly updating to the latest Pi-hole version

## Contributing
Please refer to the repository's contributing guidelines for information on how to contribute to this project.

## License
This repository is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.
