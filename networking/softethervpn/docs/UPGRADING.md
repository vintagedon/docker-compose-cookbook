# Upgrading SoftEther VPN Docker Setup

This document provides instructions on how to upgrade your SoftEther VPN Docker setup.

## Before Upgrading

1. **Backup Your Data**

   - Create a backup of your VPN configuration:
     ```bash
     docker exec softethervpn vpncmd localhost:5555 /SERVER /CMD ConfigGet /FILE:/opt/vpn_server/backup_config.vpn
     ```
   - Copy the backup file from the container:
     ```bash
     docker cp softethervpn:/opt/vpn_server/backup_config.vpn ./backup_config.vpn
     ```

2. **Check for Breaking Changes**
   - Review the changelog for the new version of SoftEther VPN
   - Check for any changes in the Docker image you're using

## Upgrading Process

1. **Update the Image Version**

   - In your `.env` file, update the `SOFTETHER_VERSION` to the desired version:
     ```
     SOFTETHER_VERSION=v4.34-9745-beta
     ```

2. **Pull the New Image**

   ```bash
   docker-compose pull
   ```

3. **Recreate the Container**

   ```bash
   docker-compose up -d --force-recreate
   ```

4. **Verify the Upgrade**
   - Check the container logs:
     ```bash
     docker logs softethervpn
     ```
   - Verify the server version:
     ```bash
     docker exec softethervpn vpncmd localhost:5555 /SERVER /CMD About
     ```

## Post-Upgrade Steps

1. **Check Configuration**

   - Verify that your VPN settings are still correct
   - Reconnect VPN clients and test functionality

2. **Update Client Software**

   - If necessary, update VPN client software on user devices

3. **Review and Update Security Settings**
   - Check if any new security features are available in the new version
   - Update your security settings if needed

## Rollback Procedure

If you encounter issues after upgrading:

1. Stop the container:

   ```bash
   docker-compose down
   ```

2. Revert the `SOFTETHER_VERSION` in your `.env` file to the previous version

3. Recreate the container:

   ```bash
   docker-compose up -d
   ```

4. Restore your backup if necessary:
   ```bash
   docker cp ./backup_config.vpn softethervpn:/opt/vpn_server/backup_config.vpn
   docker exec softethervpn vpncmd localhost:5555 /SERVER /CMD ConfigSet /FILE:/opt/vpn_server/backup_config.vpn
   ```

Always test thoroughly after an upgrade and have a rollback plan ready in case of unexpected issues.
