# GitLab CE Docker Configuration Guide

This document provides detailed information on configuring your GitLab CE Docker installation.

## Table of Contents

- [GitLab CE Docker Configuration Guide](#gitlab-ce-docker-configuration-guide)
  - [Table of Contents](#table-of-contents)
  - [Environment Variables](#environment-variables)
  - [GitLab Configuration](#gitlab-configuration)
  - [Nginx Configuration](#nginx-configuration)
  - [Database Configuration](#database-configuration)
  - [Redis Configuration](#redis-configuration)
  - [SMTP Configuration](#smtp-configuration)
  - [LDAP Configuration](#ldap-configuration)
  - [SSL Configuration](#ssl-configuration)
  - [Backup Configuration](#backup-configuration)

## Environment Variables

The main configuration for the GitLab CE Docker setup is done through environment variables. These can be set in the `.env` file or passed directly to Docker Compose.

Key environment variables include:

- `GITLAB_VERSION`: The version of GitLab CE to use (default: latest)
- `CONTAINER_NAME`: The name of the GitLab container (default: gitlab)
- `GITLAB_HOSTNAME`: The hostname for GitLab (default: localhost)
- `GITLAB_EXTERNAL_URL`: The external URL for GitLab (default: http://localhost:8080)
- `HTTP_PORT`: The HTTP port for GitLab (default: 8080)
- `HTTPS_PORT`: The HTTPS port for GitLab (default: 8443)
- `SSH_PORT`: The SSH port for GitLab (default: 2222)

For a complete list of environment variables, refer to the `.env.example` file.

## GitLab Configuration

GitLab is configured using the `GITLAB_OMNIBUS_CONFIG` environment variable in the `docker-compose.yml` file. This variable allows you to set various GitLab configuration options.

Example:

```yaml
environment:
  GITLAB_OMNIBUS_CONFIG: |
    external_url 'http://gitlab.example.com'
    gitlab_rails['gitlab_shell_ssh_port'] = 2222
    # Add more configuration options here
```

For a comprehensive list of configuration options, refer to the [GitLab documentation](https://docs.gitlab.com/omnibus/settings/).

## Nginx Configuration

GitLab uses Nginx as its web server. To customize Nginx settings, you can add configurations to the `GITLAB_OMNIBUS_CONFIG`:

```yaml
GITLAB_OMNIBUS_CONFIG: |
  nginx['client_max_body_size'] = '250m'
  nginx['worker_processes'] = 4
```

## Database Configuration

GitLab uses PostgreSQL as its database. By default, it uses an internal PostgreSQL instance. To use an external database, configure it in the `GITLAB_OMNIBUS_CONFIG`:

```yaml
GITLAB_OMNIBUS_CONFIG: |
  postgresql['enable'] = false
  gitlab_rails['db_adapter'] = "postgresql"
  gitlab_rails['db_host'] = "your-postgresql-host"
  gitlab_rails['db_port'] = 5432
  gitlab_rails['db_username'] = "gitlab"
  gitlab_rails['db_password'] = "your-password"
  gitlab_rails['db_database'] = "gitlabhq_production"
```

## Redis Configuration

GitLab uses Redis for caching and background jobs. To use an external Redis instance:

```yaml
GITLAB_OMNIBUS_CONFIG: |
  redis['enable'] = false
  gitlab_rails['redis_host'] = "your-redis-host"
  gitlab_rails['redis_port'] = 6379
  # gitlab_rails['redis_password'] = "your-redis-password" # If using password authentication
```

## SMTP Configuration

To enable email notifications, configure SMTP settings:

```yaml
GITLAB_OMNIBUS_CONFIG: |
  gitlab_rails['smtp_enable'] = true
  gitlab_rails['smtp_address'] = "smtp.gmail.com"
  gitlab_rails['smtp_port'] = 587
  gitlab_rails['smtp_user_name'] = "your-email@gmail.com"
  gitlab_rails['smtp_password'] = "your-password"
  gitlab_rails['smtp_domain'] = "smtp.gmail.com"
  gitlab_rails['smtp_authentication'] = "login"
  gitlab_rails['smtp_enable_starttls_auto'] = true
  gitlab_rails['smtp_tls'] = false
  gitlab_rails['smtp_openssl_verify_mode'] = 'peer'
```

## LDAP Configuration

To integrate GitLab with LDAP:

```yaml
GITLAB_OMNIBUS_CONFIG: |
  gitlab_rails['ldap_enabled'] = true
  gitlab_rails['ldap_servers'] = {
    'main' => {
      'label' => 'LDAP',
      'host' =>  'ldap.example.com',
      'port' => 389,
      'uid' => 'uid',
      'encryption' => 'plain',
      'bind_dn' => 'cn=admin,dc=example,dc=com',
      'password' => 'admin_password',
      'base' => 'dc=example,dc=com'
    }
  }
```

## SSL Configuration

To enable HTTPS:

1. Place your SSL certificate and key in the `gitlab/config/ssl` directory.
2. Update the `GITLAB_OMNIBUS_CONFIG`:

```yaml
GITLAB_OMNIBUS_CONFIG: |
  external_url 'https://gitlab.example.com'
  nginx['ssl_certificate'] = "/etc/gitlab/ssl/gitlab.example.com.crt"
  nginx['ssl_certificate_key'] = "/etc/gitlab/ssl/gitlab.example.com.key"
```

## Backup Configuration

To configure automatic backups:

```yaml
GITLAB_OMNIBUS_CONFIG: |
  gitlab_rails['backup_keep_time'] = 604800
  gitlab_rails['backup_path'] = "/var/opt/gitlab/backups"
```

You can also set up a cron job to run backups regularly:

```yaml
GITLAB_OMNIBUS_CONFIG: |
  gitlab_rails['backup_keep_time'] = 604800
  gitlab_rails['backup_path'] = "/var/opt/gitlab/backups"
  gitlab_rails['backup_archive_permissions'] = 0644
  # Create a daily backup at 1 AM
  gitlab_rails['backup_cron_job'] = {
    'enable' => true,
    'hour' => 1,
    'minute' => 0
  }
```

For more detailed information on each configuration option, please refer to the [official GitLab documentation](https://docs.gitlab.com/omnibus/settings/).
