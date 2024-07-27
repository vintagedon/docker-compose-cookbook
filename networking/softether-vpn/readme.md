# SoftEther VPN Docker Setup

This project contains a Docker Compose file and environment configuration for setting up a SoftEther VPN server in a Docker container. It includes both basic and advanced configuration options for customizing your SoftEther VPN deployment.

[SoftEther VPN](https://www.softether.org/) is a powerful and easy-to-use multi-protocol VPN software. It supports various protocols including OpenVPN, IPsec, L2TP, MS-SSTP, L2TPv3, and EtherIP. SoftEther VPN has also implemented the newly-developed SoftEther VPN protocol, which is faster than OpenVPN.

## GitHub Repository
https://github.com/vintagedon/docker-compose-cookbook

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
- `docker-compose.yml`: Defines the SoftEther VPN service configuration
- `.env`: Contains environment variables for configuring the SoftEther VPN instance
- `README.md`: Provides information and instructions for the project

## Usage

1. Edit the `.env` file and replace the placeholder values with your desired configuration.

2. Run the container using Docker Compose:
   ```
   docker-compose up -d
   ```

3. To access the SoftEther VPN server management interface, use:
   ```
   docker-compose exec softether vpncmd
   ```

## Configuration Options

### Basic Options

- `SOFTETHER_CONTAINER_NAME`: Name of the SoftEther VPN container
- `SOFTETHER_CONFIG_DIR`: Directory for SoftEther VPN configuration files
- `SOFTETHER_ADMIN_PASSWORD`: Admin password for the VPN server

### Common Options

- `SOFTETHER_USER`: Username for the VPN server
- `SOFTETHER_USER_PASSWORD`: Password for the VPN user
- `SOFTETHER_HUB`: Name of the Virtual Hub
- `SOFTETHER_IPV4_SUBNET`: IPv4 subnet for VPN clients
- `SOFTETHER_DNS`: DNS server for VPN clients

### Advanced Options

- `SOFTETHER_PORTS`: Ports to expose (comma-separated list)
- `SOFTETHER_VPNCMD_INIT`: Initial vpncmd commands to run at startup
- `SOFTETHER_OBFUSCATION`: Enable or disable VPN packet obfuscation
- `SOFTETHER_CIPHER`: Set the cipher for data encryption
- `SOFTETHER_SERVER_CERT`: Path to server certificate file
- `SOFTETHER_SERVER_KEY`: Path to server key file
- `SOFTETHER_DHCP_START`: Start of DHCP address range
- `SOFTETHER_DHCP_END`: End of DHCP address range
- `SOFTETHER_KEEPALIVE_HOST`: Host to use for keepalive packets
- `SOFTETHER_KEEPALIVE_INTERVAL`: Interval for keepalive packets (in seconds)

To use these options:

1. Uncomment the relevant lines in the `.env` file.
2. Set your desired values.
3. Restart the SoftEther VPN container for the changes to take effect:
   ```
   docker-compose down
   docker-compose up -d
   ```

## Accessing SoftEther VPN
Clients can connect to the SoftEther VPN server using various protocols:

1. SoftEther VPN Client (recommended for best performance)
2. OpenVPN
3. IPsec/L2TP
4. MS-SSTP

For each protocol, you'll need to configure the client with the server's public IP or domain name, and the credentials set in the configuration.

## Data Persistence
SoftEther VPN configuration and data are stored in the directory specified by `SOFTETHER_CONFIG_DIR`. Ensure this path exists on your host system and has appropriate permissions.

## Security Note
While this setup provides a good starting point, additional security measures should be implemented for production use, including:
- Keeping the SoftEther VPN server and clients updated
- Using strong, unique passwords for admin and user accounts
- Implementing proper firewall rules
- Regularly auditing access logs
- Using SSL certificates for server authentication
- Enabling packet obfuscation to bypass deep packet inspection

## Troubleshooting
If you encounter issues, check the SoftEther VPN logs using:
```
docker-compose logs softether
```

Common issues:
1. Port conflicts: Ensure that the ports specified in `SOFTETHER_PORTS` are not being used by other services.
2. Firewall rules: Check that your firewall allows traffic on the specified ports.
3. NAT traversal: If clients have trouble connecting, you may need to configure NAT traversal on your router.
4. Certificate issues: If using custom SSL certificates, ensure they are properly formatted and placed in the correct location.

## Contributing
Please feel free to submit issues, fork the repository and send pull requests!

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.
