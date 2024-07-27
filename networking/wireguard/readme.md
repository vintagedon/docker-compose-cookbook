# Wireguard Docker Setup

This project contains a Docker Compose file and environment configuration for setting up a Wireguard VPN server in a Docker container. It includes both basic and advanced configuration options for customizing your Wireguard deployment.

[Wireguard](https://www.wireguard.com/) is a simple yet fast and modern VPN that utilizes state-of-the-art cryptography. It aims to be faster, simpler, leaner, and more useful than IPsec, while avoiding the massive headache.

## GitHub Repository
[https://github.com/yourusername/docker-wireguard-setup](https://github.com/yourusername/docker-wireguard-setup)

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
- `docker-compose.yml`: Defines the Wireguard service configuration
- `.env`: Contains environment variables for configuring the Wireguard instance
- `README.md`: Provides information and instructions for the project

## Usage

1. Edit the `.env` file and replace the placeholder values with your desired configuration.

2. Run the container using Docker Compose:
   ```
   docker-compose up -d
   ```

3. To view the Wireguard client configuration, use:
   ```
   docker-compose logs wireguard
   ```

## Configuration Options

### Basic Options

- `WIREGUARD_CONTAINER_NAME`: Name of the Wireguard container
- `WIREGUARD_PORT`: Port for Wireguard to listen on
- `WIREGUARD_CONFIG_DIR`: Directory for Wireguard configuration files
- `WIREGUARD_PEERS`: Number of peer configurations to generate

### Common Options

- `SERVERURL`: External IP or domain name for the Wireguard server
- `SERVERPORT`: External port to reach the Wireguard server
- `INTERNAL_SUBNET`: Internal subnet for VPN clients
- `ALLOWEDIPS`: Allowed IPs for VPN clients (default: 0.0.0.0/0, ::/0)

### Advanced Options

- `PEERDNS`: DNS server set in peer/client configs
- `PERSISTENTKEEPALIVE`: Keep connections alive with periodic traffic
- `LOG_CONFS`: Log peer configuration files when they are created
- `DEVICE_NAME`: Name of the network device (default: wg0)
- `PRESERVE_CONFIG`: Set to `true` to preserve existing configs
- `NET_ADMIN`: Set to `false` to disable NET_ADMIN capability

To use these options:

1. Uncomment the relevant lines in the `.env` file.
2. Set your desired values.
3. Restart the Wireguard container for the changes to take effect:
   ```
   docker-compose down
   docker-compose up -d
   ```

## Accessing Wireguard
Clients can connect to the Wireguard server using the generated configuration files. You can find these in the `WIREGUARD_CONFIG_DIR` directory on your host system.

## Data Persistence
Wireguard configuration and data are stored in the directory specified by `WIREGUARD_CONFIG_DIR`. Ensure this path exists on your host system and has appropriate permissions.

## Security Note
While this setup provides a good starting point, additional security measures should be implemented for production use, including:
- Keeping the Wireguard server and clients updated
- Implementing proper firewall rules
- Regularly auditing access logs
- Using strong and unique pre-shared keys for each peer
- Limiting the `ALLOWEDIPS` to only necessary subnets

## Troubleshooting
If you encounter issues, check the Wireguard logs using:
```
docker-compose logs wireguard
```

Common issues:
1. Port forwarding: Ensure that the Wireguard port is properly forwarded on your router.
2. Firewall rules: Check that your firewall allows UDP traffic on the Wireguard port.
3. Mismatched configurations: Verify that the server and client configurations match, especially the public keys and allowed IPs.

## Contributing
Please feel free to submit issues, fork the repository and send pull requests!

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.
