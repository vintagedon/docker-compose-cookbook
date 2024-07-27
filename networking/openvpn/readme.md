# OpenVPN Docker Setup

This project contains a Docker Compose file and environment configuration for setting up an OpenVPN server in a Docker container. It includes configuration options for customizing your OpenVPN deployment.

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

1. Edit the `.env` file and replace the placeholder values with your desired configuration. The configuration includes:

   ```
   OPENVPN_CONTAINER_NAME=openvpn
   OPENVPN_PORT=1194
   OPENVPN_PROTO=udp
   OPENVPN_CONFIG_DIR=/path/to/your/openvpn/config
   OPENVPN_DATA_DIR=/path/to/your/openvpn/data
   OPENVPN_SERVERNAME=myopenvpnserver

   # Additional options
   OPENVPN_DNS1=8.8.8.8
   OPENVPN_DNS2=8.8.4.4
   OPENVPN_CIPHER=AES-256-GCM
   OPENVPN_AUTH=SHA256
   OPENVPN_VERB=3
   OPENVPN_CLIENT_TO_CLIENT=false
   OPENVPN_MAX_CLIENTS=100
   ```

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

The following additional options can be configured in the `.env` file:

- `OPENVPN_DNS1` and `OPENVPN_DNS2`: Set the DNS servers for VPN clients. Default: 8.8.8.8 and 8.8.4.4 (Google DNS)
- `OPENVPN_CIPHER`: Set the cipher for data channel packets. Default: AES-256-GCM
- `OPENVPN_AUTH`: Set the authentication algorithm. Default: SHA256
- `OPENVPN_VERB`: Set the verbosity level of OpenVPN's logs (0-9). Default: 3
- `OPENVPN_CLIENT_TO_CLIENT`: Enable or disable client-to-client communication. Set to 'true' to enable. Default: false
- `OPENVPN_MAX_CLIENTS`: Set the maximum number of concurrent clients. Default: 100

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

## Expected Results
After running `docker-compose up -d`, you should see the OpenVPN container running. You can verify this by using the `docker ps` command. The output should look similar to this:

```
CONTAINER ID   IMAGE                 COMMAND                  CREATED          STATUS          PORTS                   NAMES
1a2b3c4d5e6f   kylemanna/openvpn     "ovpn_run"               10 seconds ago   Up 9 seconds    0.0.0.0:1194->1194/udp  openvpn
```

This output indicates that:
- The OpenVPN container is running
- It's using the kylemanna/openvpn image
- The container name matches what you set in `OPENVPN_CONTAINER_NAME`
- The OpenVPN port (default 1194) is mapped to the host

If you see this output, your OpenVPN setup is running successfully and should be ready to accept client connections.

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
