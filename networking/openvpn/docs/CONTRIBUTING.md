# Upgrading Guide for OpenVPN Docker Setup

This document provides instructions for upgrading your OpenVPN Docker setup.

## Table of Contents

- [Upgrading Guide for OpenVPN Docker Setup](#upgrading-guide-for-openvpn-docker-setup)
  - [Table of Contents](#table-of-contents)
  - [Preparing for Upgrade](#preparing-for-upgrade)
  - [Upgrading the Docker Image](#upgrading-the-docker-image)
  - [Upgrading Configuration](#upgrading-configuration)
  - [Post-Upgrade Steps](#post-upgrade-steps)
  - [Rollback Procedure](#rollback-procedure)

## Preparing for Upgrade

Before upgrading, take the following precautions:

1. **Backup your data**:

   ```bash
   docker-compose run --rm openvpn ovpn_getconfiguration > openvpn_backup.conf
   ```

2. **Backup your entire OpenVPN directory**:

   ```bash
   sudo cp -r /path/to/openvpn/data /path/to/openvpn/data_backup
   ```

3. **Document current version**:

   ```bash
   docker-compose run --rm openvpn openvpn --version
   ```

4. **Notify users**: Inform your users about potential downtime.

## Upgrading the Docker Image

1. Update the image version in your `docker-compose.yml` file:

   ```yaml
   services:
     openvpn:
       image: kylemanna/openvpn:2.4
   ```

2. Pull the new image:

   ```bash
   docker-compose pull openvpn
   ```

3. Restart the container:
   ```bash
   docker-compose up -d openvpn
   ```

## Upgrading Configuration

1. Check for any new configuration options:

   ```bash
   docker-compose run --rm openvpn ovpn_genconfig --help
   ```

2. Update your configuration if necessary:

   ```bash
   docker-compose run --rm openvpn ovpn_genconfig -u udp://VPN.SERVERNAME.COM
   ```

3. If you've made custom changes, merge them with the new configuration.

## Post-Upgrade Steps

1. Verify the upgrade:

   ```bash
   docker-compose run --rm openvpn openvpn --version
   ```

2. Check the logs for any errors:

   ```bash
   docker-compose logs openvpn
   ```

3. Test connectivity from a client.

4. If everything is working, remove the backup:
   ```bash
   rm openvpn_backup.conf
   ```

## Rollback Procedure

If issues occur, follow these steps to rollback:

1. Stop the container:

   ```bash
   docker-compose down
   ```

2. Revert to the previous image in `docker-compose.yml`.

3. Restore the backup configuration:

   ```bash
   cat openvpn_backup.conf | docker-compose run --rm openvpn ovpn_genconfig -u udp://VPN.SERVERNAME.COM
   ```

4. Restart the container:
   ```bash
   docker-compose up -d
   ```

Always test thoroughly after an upgrade. If persistent issues occur, consider seeking help from the OpenVPN community or professional support.
