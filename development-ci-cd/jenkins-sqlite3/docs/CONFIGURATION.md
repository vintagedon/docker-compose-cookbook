# Configuration Guide for Jenkins with SQLite3 Docker Setup

This document provides detailed information on configuring Jenkins and SQLite3 in this Docker setup.

## Table of Contents

- [Configuration Guide for Jenkins with SQLite3 Docker Setup](#configuration-guide-for-jenkins-with-sqlite3-docker-setup)
  - [Table of Contents](#table-of-contents)
  - [Environment Variables](#environment-variables)
  - [Jenkins Configuration](#jenkins-configuration)
    - [Initial Setup](#initial-setup)
    - [System Configuration](#system-configuration)
  - [SQLite3 Configuration](#sqlite3-configuration)
  - [Plugin Management](#plugin-management)
  - [Security Settings](#security-settings)
  - [Backup and Restore](#backup-and-restore)

## Environment Variables

The following environment variables can be set in the `.env` file:

- `JENKINS_VERSION`: The version of Jenkins to use (default: lts-jdk11)
- `CONTAINER_NAME`: The name of the Docker container (default: jenkins)
- `JENKINS_HTTP_PORT`: The port for Jenkins web interface (default: 8080)
- `JENKINS_AGENT_PORT`: The port for Jenkins agent connections (default: 50000)
- `JENKINS_OPTS`: Additional Jenkins options
- `JAVA_OPTS`: Java options for Jenkins
- `TIMEZONE`: The timezone for the Jenkins container (default: UTC)
- `SQLITE_DB_PATH`: The path to the SQLite database file inside the container

## Jenkins Configuration

### Initial Setup

1. After starting the container, access Jenkins at `http://localhost:8080`.
2. The initial admin password can be found in the container logs:
   ```
   docker logs jenkins
   ```
3. Follow the setup wizard to install recommended plugins and create the first admin user.

### System Configuration

1. Go to "Manage Jenkins" > "Configure System".
2. Set the Jenkins URL to your server's address.
3. Configure the number of executor threads based on your server's capabilities.
4. Set up the SMTP server for email notifications if required.

## SQLite3 Configuration

SQLite3 is configured to store its database file at `/var/jenkins_sqlite/jenkins.db` inside the container. This path is mounted as a volume to persist data.

To access the SQLite3 database:

1. Enter the container:
   ```
   docker exec -it jenkins /bin/bash
   ```
2. Use the SQLite3 command-line tool:
   ```
   sqlite3 /var/jenkins_sqlite/jenkins.db
   ```

## Plugin Management

1. Go to "Manage Jenkins" > "Manage Plugins".
2. In the "Available" tab, you can search and install new plugins.
3. In the "Installed" tab, you can update or remove existing plugins.

## Security Settings

1. Go to "Manage Jenkins" > "Configure Global Security".
2. Enable security and choose an appropriate authorization strategy.
3. Configure the Jenkins user database or integrate with LDAP/Active Directory if required.

## Backup and Restore

To backup Jenkins data:

1. Stop the Jenkins container.
2. Copy the contents of the `jenkins_home` and `jenkins_sqlite` volumes.
3. Store the backup in a secure location.

To restore:

1. Stop the Jenkins container.
2. Replace the contents of the `jenkins_home` and `jenkins_sqlite` volumes with your backup.
3. Start the Jenkins container.

For more detailed information on specific configurations, please refer to the [official Jenkins documentation](https://www.jenkins.io/doc/).
