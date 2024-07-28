# Security Considerations for SoftEther VPN Docker Setup

This document outlines important security considerations for your SoftEther VPN Docker setup.

## Password Security

1. **Change Default Passwords**: Always change the default passwords set in the `.env` file. Use strong, unique passwords for the server admin password (`SERVER_PASSWORD`) and the VPN hub password (`HUB_PASSWORD`).

2. **User Passwords**: Ensure that all user passwords (set in `VPN_USERS`) are strong and unique.

3. **Regular Password Rotation**: Implement a policy to regularly rotate all passwords, including server, hub, and user passwords.

## Network Security

1. **Firewall Configuration**: Ensure your host's firewall is properly configured to only allow necessary incoming connections to the VPN ports.

2. **Port Exposure**: Only expose the ports that are absolutely necessary for your VPN setup. If you're not using all protocols, consider commenting out unused port mappings in the `docker-compose.yml` file.

3. **Use of HTTPS**: When managing the VPN server remotely, always use HTTPS for the management connection.

## Encryption and Protocols

1. **Strong Encryption**: Ensure that strong encryption algorithms are used. SoftEther VPN supports AES 256-bit and RSA 4096-bit encryption.

2. **Secure Protocols**: Prefer more secure VPN protocols like SSL-VPN and IPsec/L2TP with strong pre-shared keys.

## Access Control

1. **Principle of Least Privilege**: Only grant users the minimum level of access they need.

2. **Regular Audits**: Regularly audit user accounts and remove any that are no longer needed.

3. **Two-Factor Authentication**: Consider implementing two-factor authentication for VPN access if supported by your client devices.

## Logging and Monitoring

1. **Enable Logging**: Ensure that logging is enabled and regularly review logs for any suspicious activity.

2. **Monitoring**: Implement a monitoring solution to alert on suspicious activities or unusual traffic patterns.

## Keep Software Updated

1. **Regular Updates**: Regularly update the SoftEther VPN software to the latest version to ensure you have the latest security patches.

2. **Update Notifications**: Subscribe to SoftEther VPN security notifications to stay informed about any security issues or updates.

## Secure Server Environment

1. **Host Security**: Ensure the host system running the Docker container is secure and regularly updated.

2. **Isolate the Container**: Use Docker's security features to isolate the VPN container from other containers and the host system.

Remember, security is an ongoing process. Regularly review and update your security measures to protect against new threats and vulnerabilities.
