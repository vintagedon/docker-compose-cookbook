# Security Considerations for Gitea-SQLite3 Docker Setup

This document outlines important security considerations and best practices for your Gitea instance with SQLite3 backend.

## Table of Contents

- [Security Considerations for Gitea-SQLite3 Docker Setup](#security-considerations-for-gitea-sqlite3-docker-setup)
  - [Table of Contents](#table-of-contents)
  - [Authentication](#authentication)
  - [Access Control](#access-control)
  - [HTTPS](#https)
  - [SSH](#ssh)
  - [Firewall](#firewall)
  - [Updates](#updates)
  - [Backup and Recovery](#backup-and-recovery)
  - [Monitoring](#monitoring)

## Authentication

1. Use strong passwords for all accounts, especially the admin account.
2. Enable two-factor authentication (2FA) for enhanced security.
3. Consider using external authentication providers (OAuth, LDAP) for centralized user management.

To enable 2FA, add the following to your custom `app.ini`:

```ini
[security]
ENABLE_TWO_FACTOR_AUTH = true
```

## Access Control

1. Use the principle of least privilege when assigning permissions.
2. Regularly audit user access and remove unnecessary privileges.
3. Use organizations and teams to manage access to repositories efficiently.

## HTTPS

It's crucial to use HTTPS to encrypt all traffic to and from your Gitea instance. To enable HTTPS:

1. Obtain an SSL/TLS certificate (e.g., from Let's Encrypt).
2. Update your `app.ini` with the following:

```ini
[server]
PROTOCOL = https
CERT_FILE = /path/to/cert.pem
KEY_FILE = /path/to/key.pem
```

3. Update the `GITEA_ROOT_URL` in your `.env` file to use `https://`.

## SSH

Ensure that your SSH keys are secure:

1. Use ED25519 or RSA keys with at least 2048 bits.
2. Protect your private keys with a strong passphrase.
3. Regularly rotate SSH keys.

## Firewall

Configure your firewall to only allow necessary incoming connections:

- HTTP/HTTPS (ports 80/443)
- SSH (port 22 or your custom SSH port)

Block all other incoming connections to the Gitea server.

## Updates

Regularly update Gitea to the latest stable version to ensure you have the latest security patches:

1. Back up your data
2. Update the `GITEA_VERSION` in your `.env` file
3. Run `docker-compose up -d` to apply the update

## Backup and Recovery

Implement a robust backup strategy:

1. Regularly backup the `gitea_data` and `gitea_config` volumes.
2. Store backups in a secure, off-site location.
3. Periodically test your backup restoration process.

## Monitoring

Set up monitoring and alerting for your Gitea instance:

1. Monitor system resources (CPU, memory, disk usage).
2. Set up log monitoring for suspicious activities.
3. Configure alerts for failed login attempts and other security events.

For detailed security settings and best practices, refer to the [official Gitea documentation](https://docs.gitea.io/en-us/security/).
