# Pi-hole Configuration Guide

This document provides detailed information on configuring your Pi-hole Docker setup.

## Table of Contents

- [Pi-hole Configuration Guide](#pi-hole-configuration-guide)
  - [Table of Contents](#table-of-contents)
  - [Environment Variables](#environment-variables)
  - [Custom DNS Settings](#custom-dns-settings)
  - [DHCP Configuration](#dhcp-configuration)
  - [Blocklists](#blocklists)
  - [Whitelists](#whitelists)
  - [Web Interface](#web-interface)
  - [Persistent Volumes](#persistent-volumes)

## Environment Variables

Key environment variables in `.env`:

- `PIHOLE_VERSION`: Pi-hole version (default: latest)
- `WEBPASSWORD`: Admin interface password
- `TIMEZONE`: Your timezone
- `SERVER_IP`: Static IP of your Docker host
- `PIHOLE_DNS_PORT`: DNS port (default: 53)
- `PIHOLE_WEB_PORT`: Web interface port (default: 80)
- `PIHOLE_DHCP_PORT`: DHCP port (default: 67)
- `UPSTREAM_DNS_1` and `UPSTREAM_DNS_2`: Upstream DNS servers
- `DNSMASQ_LISTENING`: DNS listening behavior (options: all, local, single)
- `PIHOLE_DNS`: Pi-hole DNS configuration (e.g., unbound for recursive DNS)

## Custom DNS Settings

To add custom DNS entries:

1. Edit `scripts/custom.list`
2. Add entries in the format: `domain.com`
3. Restart the Pi-hole container

## DHCP Configuration

To use Pi-hole as a DHCP server:

1. Ensure `PIHOLE_DHCP_PORT` is set in `.env`
2. Enable DHCP in the Pi-hole web interface
3. Configure DHCP range and options

## Blocklists

To add custom blocklists:

1. Access the Pi-hole web interface
2. Go to Settings > Blocklists
3. Add URLs of additional blocklists
4. Update Gravity

## Whitelists

To whitelist domains:

1. Access the Pi-hole web interface
2. Go to Whitelist
3. Add domains you want to whitelist

## Web Interface

Access the web interface at `http://<your-pi-hole-ip>/admin`

To change the admin password:

1. Run: `docker exec -it pihole pihole -a -p newpassword`

## Persistent Volumes

Pi-hole uses two persistent volumes:

- `etc-pihole`: Pi-hole configurations
- `etc-dnsmasq.d`: DNSMasq configurations

These ensure your settings persist across container restarts.

For advanced configurations, refer to the [official Pi-hole documentation](https://docs.pi-hole.net/).
