# Wireguard Configuration Guide

This document provides detailed information on configuring your Wireguard Docker setup.

## Environment Variables

The following environment variables can be set in the `.env` file:

- `PUID` and `PGID`: User and group IDs for the Wireguard process (default: 1000)
- `TZ`: Timezone (default: Etc/UTC)
- `SERVER_URL`: Public IP or domain of your server (default: auto)
- `SERVER_PORT`: UDP port for Wireguard (default: 51820)
- `PEERS`: Number of peer configurations to generate (default: 1)
- `PEER_DNS`: DNS server set in peer configurations (default: auto)
- `INTERNAL_SUBNET`: Internal subnet for VPN (default: 10.13.13.0)
- `ALLOWED_IPS`: Allowed IPs for peers (default: 0.0.0.0/0)
- `CONFIG_DIR`: Directory to store Wireguard configurations (default: ./config)

## Wireguard Configuration

### Server Configuration

The server configuration is automatically generated based on the environment variables. You can find it in `${CONFIG_DIR}/wg0.conf` after starting the container.

### Peer Configurations

Peer configurations are automatically generated based on the `PEERS` variable. You can find them in `${CONFIG_DIR}/peer_[NAME].conf` files.

## Advanced Configuration

For advanced configuration options, you can modify the `wg0.conf` file directly. Remember to restart the container after making changes:

```bash
docker-compose down
docker-compose up -d
```

## Firewall Configuration

Ensure that the UDP port specified in `SERVER_PORT` is open on your firewall.

## DNS Configuration

If you're using a custom DNS server, set the `PEER_DNS` variable to its IP address.

## Routing

To route only specific traffic through the VPN, modify the `ALLOWED_IPS` variable. For example, to only route traffic to the internal VPN network:

```
ALLOWED_IPS=10.13.13.0/24
```

Remember to adjust your client configurations accordingly.

For more detailed information on Wireguard configuration, refer to the [official Wireguard documentation](https://www.wireguard.com/quickstart/).
