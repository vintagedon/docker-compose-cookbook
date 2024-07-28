# Upgrading GitLab CE Docker Setup

This guide provides instructions for upgrading your GitLab CE Docker installation to a newer version.

## Table of Contents

- [Upgrading GitLab CE Docker Setup](#upgrading-gitlab-ce-docker-setup)
  - [Table of Contents](#table-of-contents)
  - [Before You Begin](#before-you-begin)
  - [Upgrade Process](#upgrade-process)
  - [Post-Upgrade Tasks](#post-upgrade-tasks)
  - [Rolling Back](#rolling-back)
  - [Troubleshooting](#troubleshooting)

## Before You Begin

1. **Backup Your Data**: Always create a full backup before upgrading.

   ```
   docker exec -t gitlab gitlab-backup create
   ```

2. **Check for Version-Specific Upgrade Notes**: Visit the [GitLab upgrade recommendations](https://docs.gitlab.com/ee/update/) for any specific instructions for your version upgrade.

3. **Review System Requirements**: Ensure your system meets the requirements for the new GitLab version.

4. **Plan for Downtime**: Upgrades may require some downtime. Plan accordingly.

## Upgrade Process

1. **Update GitLab Image**:
   Edit your `docker-compose.yml` file to use the new GitLab version:

   ```yaml
   services:
     gitlab:
       image: gitlab/gitlab-ce:NEW_VERSION
   ```

   Replace `NEW_VERSION` with the version you're upgrading to (e.g., `14.0.0-ce.0`).

2. **Pull the New Image**:

   ```
   docker-compose pull
   ```

3. **Stop the Current Container**:

   ```
   docker-compose down
   ```

4. **Start the New Container**:

   ```
   docker-compose up -d
   ```

5. **Monitor the Upgrade Process**:
   Watch the logs to ensure the upgrade is proceeding without errors:
   ```
   docker-compose logs -f
   ```

## Post-Upgrade Tasks

1. **Check GitLab Status**:
   Visit your GitLab URL and ensure you can log in and access your projects.

2. **Run Version-Specific Upgrade Tasks** (if any):
   Consult the [GitLab documentation](https://docs.gitlab.com/ee/update/) for any additional tasks required for your specific version upgrade.

3. **Update GitLab Runners** (if applicable):
   If you're using GitLab Runners, make sure to upgrade them to a compatible version.

4. **Review and Test**:
   - Check key functionalities (e.g., CI/CD pipelines, merge requests)
   - Verify integrations are working correctly
   - Test user access and permissions

## Rolling Back

If you encounter issues after upgrading, you can roll back to the previous version:

1. Stop the current container:

   ```
   docker-compose down
   ```

2. Revert the GitLab image version in your `docker-compose.yml` file.

3. Restore from your backup:

   ```
   docker exec -it gitlab gitlab-backup restore BACKUP=TIMESTAMP_OF_BACKUP
   ```

4. Start the container with the previous version:
   ```
   docker-compose up -d
   ```

## Troubleshooting

If you encounter issues during or after the upgrade:

1. **Check Logs**:

   ```
   docker-compose logs -f
   ```

2. **Verify Database Migrations**:

   ```
   docker exec -it gitlab gitlab-rake db:migrate:status
   ```

3. **Run GitLab Check**:

   ```
   docker exec -it gitlab gitlab-rake gitlab:check
   ```

4. **Reconfigure GitLab**:
   ```
   docker exec -it gitlab gitlab-ctl reconfigure
   ```

If problems persist, consult the [GitLab troubleshooting guide](https://docs.gitlab.com/ee/administration/troubleshooting.html) or seek help from the GitLab community forums.

Remember to always keep your GitLab instance updated to the latest version to ensure you have the latest features and security updates.
