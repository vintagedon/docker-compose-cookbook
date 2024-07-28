# Security Guide for Gitea with MySQL Docker Setup

This document outlines security best practices for your Gitea instance with MySQL using Docker.

## Table of Contents

- [Security Guide for Gitea with MySQL Docker Setup](#security-guide-for-gitea-with-mysql-docker-setup)
  - [Table of Contents](#table-of-contents)
  - [Docker Security](#docker-security)
  - [Network Security](#network-security)
  - [Gitea Security](#gitea-security)
  - [MySQL Security](#mysql-security)
  - [System Security](#system-security)
  - [Authentication and Authorization](#authentication-and-authorization)
  - [Data Protection](#data-protection)
  - [Monitoring and Logging](#monitoring-and-logging)

## Docker Security

1. **Keep Docker Updated**: Regularly update Docker to the latest version.

2. **Use Official Images**: Always use official Docker images for Gitea and MySQL.

3. **Limit Container Capabilities**: Use the `--cap-drop` flag to remove unnecessary capabilities.

4. **Read-only File System**: Use read-only file systems where possible:

   ```yaml
   gitea:
     read_only: true
     tmpfs:
       - /tmp
   ```

5. **Non-root User**: Run containers as non-root users:
   ```yaml
   gitea:
     user: "1000:1000"
   ```

## Network Security

1. **Use Internal Docker Network**: Use Docker's internal network for communication between containers.

2. **Limit Exposed Ports**: Only expose necessary ports to the host.

3. **Use a Reverse Proxy**: Set up a reverse proxy (like Nginx) with SSL/TLS termination.

4. **Enable TLS**: Configure Gitea to use HTTPS:
   ```ini
   [server]
   PROTOCOL = https
   CERT_FILE = /path/to/cert.pem
   KEY_FILE = /path/to/key.pem
   ```

## Gitea Security

1. **Keep Gitea Updated**: Regularly update Gitea to the latest stable version.

2. **Secure Cookies**: Enable secure cookies in `app.ini`:

   ```ini
   [security]
   COOKIE_SECURE = true
   ```

3. **SSH Key Authentication**: Encourage SSH key authentication over password authentication.

4. **Rate Limiting**: Enable rate limiting to prevent brute-force attacks:
   ```ini
   [server]
   ENABLE_RATE_LIMIT = true
   RATE_LIMIT_PER_HOUR = 10
   ```

## MySQL Security

1. **Strong Passwords**: Use strong, unique passwords for MySQL root and Gitea user.

2. **Least Privilege**: Grant only necessary privileges to the Gitea MySQL user.

3. **Encrypt Connections**: Enable SSL for MySQL connections:

   ```cnf
   [mysqld]
   ssl-cert=/path/to/server-cert.pem
   ssl-key=/path/to/server-key.pem
   ```

4. **Disable Remote Root Login**: Prevent root login from remote hosts:
   ```sql
   DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
   ```

## System Security

1. **Keep Host System Updated**: Regularly update and patch the host system.

2. **Use Firewall**: Configure a firewall (like ufw) to restrict incoming traffic.

3. **Secure SSH**: If using SSH, configure it securely (key-based auth, non-standard port).

4. **File Permissions**: Ensure proper file permissions on volumes and sensitive files.

## Authentication and Authorization

1. **Two-Factor Authentication**: Enable and encourage 2FA for Gitea accounts.

2. **LDAP/OAuth Integration**: Consider integrating with LDAP or OAuth providers for centralized authentication.

3. **Regular Access Review**: Periodically review user access and remove unused accounts.

## Data Protection

1. **Regular Backups**: Implement and test regular backup procedures.

2. **Encrypt Sensitive Data**: Use encryption for sensitive data at rest and in transit.

3. **Data Retention Policy**: Implement a clear data retention and deletion policy.

## Monitoring and Logging

1. **Enable Logging**: Configure comprehensive logging for Gitea and MySQL.

2. **Centralized Log Management**: Use a centralized log management solution (e.g., ELK stack).

3. **Intrusion Detection**: Consider implementing an intrusion detection system.

4. **Regular Audits**: Conduct regular security audits and penetration testing.

Remember, security is an ongoing process. Regularly review and update your security measures, and stay informed about the latest security best practices and vulnerabilities related to Gitea, MySQL, and Docker.
