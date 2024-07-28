# Configuring SoftEther VPN Docker Setup

This document provides detailed information on how to configure your SoftEther VPN Docker setup.

## Environment Variables

The following environment variables can be set in the `.env` file:

- `SOFTETHER_VERSION`: The version of SoftEther VPN to use (default: latest)
- `CONTAINER_NAME`: The name of the Docker container (default: softethervpn)
- `VPN_PORT`: The main VPN port (default: 5555)
- `OPENVPN_PORT`: The OpenVPN port (default: 1194)
- `L2TP_PORT`: The L2TP port (default: 500)
- `SSTP_PORT`: The SSTP port (default: 443)
- `SERVER_PASSWORD`: The server admin password
- `HUB_PASSWORD`: The password for the default VPN hub
- `VPN_USERS`: A comma-separated list of users and their passwords (format: user1:pass1,user2:pass2)

## Advanced Configuration

For more advanced configuration, you can modify the `init.sh` script in the `scripts/` directory. This script runs when the container starts and sets up the VPN server.

### Modifying VPN Settings

To change VPN settings, you can add or modify commands in the `init.sh` script. For example, to change the MTU size:

```bash
vpncmd localhost:5555 /SERVER /CMD NatSet /MTU:1400
```

### Adding Custom Routing

To add custom routing rules, you can use the `DhcpSet` command in the `init.sh` script:

```bash
vpncmd localhost:5555 /SERVER /HUB:DEFAULT /CMD DhcpSet /Start:192.168.30.10 /End:192.168.30.200 /Mask:255.255.255.0 /Expire:7200 /GW:192.168.30.1 /DNS:8.8.8.8 /DNS2:8.8.4.4 /Domain:local /Log:yes
```

### Enabling or Disabling Protocols

You can enable or disable specific VPN protocols by modifying the relevant commands in the `init.sh` script.

## Persistent Configuration

Any changes made through the SoftEther VPN Server Manager will be persisted in the `softethervpn_data` volume. If you need to make persistent changes that survive container restarts, it's best to make them through the Server Manager rather than the `init.sh` script.

For more information on advanced configuration options, please refer to the official SoftEther VPN documentation.
