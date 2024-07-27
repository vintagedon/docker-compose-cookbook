# Networking

Welcome to the networking section of the docker-compose-cookbook! This directory contains various Docker Compose configurations for setting up different networking tools and services.

## Table of Contents

1. [Available Setups](#available-setups)
2. [General Structure](#general-structure)
3. [Usage](#usage)
4. [Security Considerations](#security-considerations)
5. [Contributing](#contributing)
6. [License](#license)

## Available Setups

| Tool | Description | Repo Link |
|------|-------------|-----------|
| AdGuard Home | Network-wide ad and tracker blocking DNS server | [adguard-home](https://github.com/vintagedon/docker-compose-cookbook/tree/main/networking/adguard-home) |
| OpenVPN | Open-source VPN solution for secure remote access | [openvpn](https://github.com/vintagedon/docker-compose-cookbook/tree/main/networking/openvpn) |
| Pi-hole | Network-wide ad blocking and local DNS server | [pihole](https://github.com/vintagedon/docker-compose-cookbook/tree/main/networking/pihole) |
| SoftEther VPN | Multi-protocol VPN software | [softether-vpn](https://github.com/vintagedon/docker-compose-cookbook/tree/main/networking/softether-vpn) |
| WireGuard | Modern, fast, and secure VPN tunnel | [wireguard](https://github.com/vintagedon/docker-compose-cookbook/tree/main/networking/wireguard) |

## General Structure

Each subdirectory typically contains the following files:

- `docker-compose.yml`: The main configuration file for the Docker services
- `.env`: Environment variables file (you may need to create this)
- Additional configuration files specific to the tool

## Usage

To use any of these setups, follow these general steps:

1. Navigate to the desired tool's directory
2. Create and configure the `.env` file if necessary
3. Run the Docker Compose command to start the services

For example, to set up AdGuard Home:

```bash
cd adguard-home
cp .env.example .env  # Create .env file from example if available
nano .env  # Edit the .env file to configure your settings
docker-compose up -d
```

Refer to the specific README in each tool's directory for detailed instructions and configuration options.

## Security Considerations

When working with networking tools, keep these security practices in mind:

- Regularly update your Docker images and host system
- Use strong, unique passwords for all services
- Implement proper firewall rules to control access
- Be cautious when exposing services to the internet
- Regularly audit your configurations and logs

## Contributing

We welcome contributions to improve and expand this networking toolkit! If you have suggestions, bug reports, or want to add a new tool, please feel free to open an issue or submit a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](https://github.com/vintagedon/docker-compose-cookbook/blob/main/LICENSE) file for full details.
