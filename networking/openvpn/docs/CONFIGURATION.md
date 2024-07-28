# Configuration Guide for OpenVPN Docker Setup

This document provides detailed information on configuring your OpenVPN Docker setup.

## Table of Contents

1. [Environment Variables](#environment-variables)
2. [Server Configuration](#server-configuration)
3. [Client Configuration](#client-configuration)
4. [Advanced Settings](#advanced-settings)

## Environment Variables

The following environment variables can be set in the `.env` file:

- `OPENVPN_VERSION`: The version of the OpenVPN Docker image to use (default: latest)
- `CONTAINER_NAME`: The name of the Docker container (default: openvpn)
- `OPENVPN_PORT`: The UDP port OpenVPN will listen on (default: 1194)
- `KEY_SIZE`: The size of the RSA key in bits (default: 2048)
- `CERT_EXPIRE`: The number of days before client certificates expire (default: 3650)
- `CA_EXPIRE`: The number of days before the CA certificate expires (default: 3650)
- `OVPN_SERVER`: The OpenVPN server subnet (default: 10.8.0.0/24)
- `OVPN_DNS`: Comma-separated list of DNS servers to use (default: 8.8.8.8,8.8.4.4)
- `OVPN_PROTO`: The protocol to use (udp or tcp, default: udp)

## Server Configuration

The server configuration is generated automatically based on the environment variables. To customize the server configuration further, you can modify the `openvpn.conf` file inside the Docker volume after initialization.

To access the configuration file:

```bash
docker-compose run --rm openvpn cat /etc/openvpn/openvpn.conf > openvpn.conf
```

Edit the `openvpn.conf` file and then copy it back into the container:

```bash
docker-compose run --rm -v $PWD/openvpn.conf:/etc/openvpn/openvpn.conf openvpn ovpn_genconfig -u udp://${OVPN_SERVER_URL}
```

## Client Configuration

To generate a client configuration:

1. Generate client certificates:

   ```bash
   docker-compose run --rm openvpn easyrsa build-client-full CLIENT_NAME nopass
   ```

2. Retrieve the client configuration:
   ```bash
   docker-compose run --rm openvpn ovpn_getclient CLIENT_NAME > CLIENT_NAME.ovpn
   ```

Replace `CLIENT_NAME` with the desired client name.

## Advanced Settings

### Routing all client traffic through the VPN

To route all client traffic through the VPN, add the following to your server configuration:

```
push "redirect-gateway def1 bypass-dhcp"
```

### Enabling compression

To enable compression, add the following to both server and client configurations:

```
comp-lzo
```

### Adjusting encryption settings

To adjust encryption settings, modify the `--cipher` option in the server configuration. For example:

```
cipher AES-256-CBC
```

For more advanced configurations, please refer to the [official OpenVPN documentation](https://openvpn.net/community-resources/reference-manual-for-openvpn-2-4/).
