# OpenVPN Docker Setup

This project contains a Docker Compose file and environment configuration for setting up an OpenVPN server in a Docker container. It includes both basic and advanced configuration options for customizing your OpenVPN deployment.

[OpenVPN](https://openvpn.net/) is a full-featured open source SSL VPN solution that accommodates a wide range of configurations, including remote access, site-to-site VPNs, Wi-Fi security, and enterprise-scale remote access solutions with load balancing.

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
- `docker-compose.yml`: Defines the OpenVPN service configuration
- `.env`: Contains environment variables for configuring the OpenVPN instance
- `README.md`: Provides information and instructions for the project

## Usage

1. Edit the `.env` file and replace the placeholder values with your desired configuration. 

2. Initialize the OpenVPN configuration:
   ```
   docker-compose run --rm openvpn ovpn_genconfig -u udp://your_server_domain_or_ip
   docker-compose run --rm openvpn ovpn_initpki
   ```
   Follow the prompts to set up your PKI (Public Key Infrastructure).

3. Run the container using Docker Compose:
   ```
   docker-compose up -d
   ```

## Configuration Options

### Basic Options

- `OPENVPN_CONTAINER_NAME`: Name of the OpenVPN container
- `OPENVPN_PORT`: Port for OpenVPN to listen on
- `OPENVPN_PROTO`: Protocol for OpenVPN (udp or tcp)
- `OPENVPN_CONFIG_DIR`: Directory for OpenVPN configuration files
- `OPENVPN_DATA_DIR`: Directory for OpenVPN data
- `OPENVPN_SERVERNAME`: Name of the OpenVPN server

### Common Options

- `OPENVPN_DNS1` and `OPENVPN_DNS2`: Set the DNS servers for VPN clients
- `OPENVPN_CIPHER`: Set the cipher for data channel packets
- `OPENVPN_AUTH`: Set the authentication algorithm
- `OPENVPN_VERB`: Set the verbosity level of OpenVPN's logs (0-9)
- `OPENVPN_CLIENT_TO_CLIENT`: Enable or disable client-to-client communication
- `OPENVPN_MAX_CLIENTS`: Set the maximum number of concurrent clients

### Advanced Options

- `OPENVPN_PUSH`: Set additional push options (e.g., routes)
- `OPENVPN_TLS_VERSION_MIN`: Set the minimum TLS version
- `OPENVPN_TLS_CIPHER`: Set the TLS cipher
- `OPENVPN_DUPLICATE_CN`: Allow duplicate Common Names
- `OPENVPN_KEEPALIVE`: Set keepalive parameters
- `OPENVPN_RENEG_SEC`: Set renegotiation time in seconds
- `OPENVPN_COMP_LZO`: Set compression algorithm
- `OPENVPN_REMOTE_CERT_TLS`: Require specific key usage and extended key usage for peer certificate
- `OPENVPN_USER` and `OPENVPN_GROUP`: Set the user and group for the OpenVPN daemon

To use these options:

1. Uncomment the relevant lines in the `.env` file.
2. Set your desired values.
3. Restart the OpenVPN container for the changes to take effect:
   ```
   docker-compose down
   docker-compose up -d
   ```

Note: Some changes may require regenerating the OpenVPN configuration. If you make significant changes, you may need to re-run the `ovpn_genconfig` command with appropriate options.

## Generating Client Certificates
To generate a client certificate, use the following command:
```
docker-compose run --rm openvpn easyrsa build-client-full CLIENT_NAME nopass
```
Replace CLIENT_NAME with the desired name for the client.

To retrieve the client configuration, use:
```
docker-compose run --rm openvpn ovpn_getclient CLIENT_NAME > CLIENT_NAME.ovpn
```

## Accessing OpenVPN
Clients can connect to the OpenVPN server using the generated .ovpn file and an OpenVPN client application.

## Data Persistence
OpenVPN configuration and data are stored in the directories specified by `OPENVPN_CONFIG_DIR` and `OPENVPN_DATA_DIR`. Ensure these paths exist on your host system and have appropriate permissions.

## Security Note
While this setup provides a good starting point, additional security measures should be implemented for production use, including:
- Keeping the OpenVPN server and clients updated
- Using strong authentication methods
- Implementing proper firewall rules
- Regularly auditing access logs
- Considering the use of perfect forward secrecy (PFS) in your OpenVPN configuration

## Troubleshooting
If you encounter issues, check the OpenVPN logs using:
```
docker-compose logs openvpn
```

## Contributing
Please refer to the repository's contributing guidelines for information on how to contribute to this project.

## License
This repository is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.
