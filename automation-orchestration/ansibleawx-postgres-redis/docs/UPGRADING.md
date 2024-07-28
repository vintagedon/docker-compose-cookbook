# Upgrading Guide for Ansible AWX Docker Setup

This document provides instructions for upgrading your Ansible AWX Docker installation to a newer version.

## Table of Contents

- [Upgrading Guide for Ansible AWX Docker Setup](#upgrading-guide-for-ansible-awx-docker-setup)
  - [Table of Contents](#table-of-contents)
  - [Before You Begin](#before-you-begin)
  - [Upgrade Process](#upgrade-process)
  - [Post-Upgrade Steps](#post-upgrade-steps)
  - [Rollback Procedure](#rollback-procedure)
  - [Troubleshooting](#troubleshooting)

## Before You Begin

1. **Backup Your Data:**

   - Create a full backup of your PostgreSQL database
   - Backup your AWX configuration files
   - Export any custom settings, inventories, and job templates

2. **Review Release Notes:**

   - Check the [AWX GitHub releases page](https://github.com/ansible/awx/releases) for any breaking changes or new features

3. **Check System Requirements:**

   - Ensure your system meets the requirements for the new AWX version

4. **Plan Downtime:**
   - Schedule the upgrade during a maintenance window

## Upgrade Process

1. **Stop the Current AWX Containers:**

   ```
   docker-compose down
   ```

2. **Update the AWX Image Version:**
   Edit your `docker-compose.yml` file and update the image version:

   ```yaml
   services:
     web:
       image: ansible/awx:X.Y.Z # Replace X.Y.Z with the new version
     task:
       image: ansible/awx:X.Y.Z # Replace X.Y.Z with the new version
   ```

3. **Pull the New Images:**

   ```
   docker-compose pull
   ```

4. **Start the Updated Containers:**

   ```
   docker-compose up -d
   ```

5. **Run Database Migrations:**

   ```
   docker exec awx_task awx-manage migrate
   ```

6. **Collect Static Files:**
   ```
   docker exec awx_task awx-manage collectstatic --noinput
   ```

## Post-Upgrade Steps

1. **Verify the Upgrade:**

   - Check the AWX web interface
   - Verify all services are running: `docker-compose ps`
   - Review AWX logs for any errors: `docker-compose logs`

2. **Update Inventories and Job Templates:**

   - Review and update inventories if needed
   - Check job templates for compatibility with the new version

3. **Test Key Functionality:**

   - Run test jobs to ensure everything works as expected
   - Verify integration with external systems (e.g., LDAP, source control)

4. **Clear Browser Cache:**
   - Instruct users to clear their browser cache to ensure they get the latest UI updates

## Rollback Procedure

If you encounter issues after upgrading, follow these steps to rollback:

1. Stop the current containers:

   ```
   docker-compose down
   ```

2. Revert the image versions in `docker-compose.yml` to the previous version

3. Restore your database backup

4. Start the containers with the previous version:

   ```
   docker-compose up -d
   ```

5. Verify the rollback was successful

## Troubleshooting

If you encounter issues during or after the upgrade:

1. **Check Logs:**

   ```
   docker-compose logs
   ```

2. **Verify Database Connectivity:**
   Ensure the AWX containers can connect to the database

3. **Check for Port Conflicts:**
   Ensure there are no port conflicts with the new version

4. **Review Settings:**
   Check if any deprecated settings need to be updated

5. **Consult Community Resources:**
   - Check the [AWX GitHub Issues](https://github.com/ansible/awx/issues) for similar problems
   - Seek help on the [Ansible Community Forums](https://groups.google.com/g/ansible-project)

Remember to always test the upgrade process in a non-production environment before applying it to your production setup. If you encounter persistent issues, consider opening an issue on the AWX GitHub repository or seeking help from the AWX community.
