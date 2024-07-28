# Security Considerations for Rundeck Docker Setup

This document outlines important security considerations and best practices for your Rundeck Docker deployment.

## Authentication

1. Change default admin password immediately after first login.
2. Use strong, unique passwords for all accounts.
3. Consider implementing LDAP or SSO for centralized authentication:

   ```properties
   rundeck.security.auth.provider.1.type=ldap
   rundeck.security.auth.provider.1.url=ldap://ldap.example.com
   rundeck.security.auth.provider.1.bindDn=cn=Manager,dc=example,dc=com
   rundeck.security.auth.provider.1.bindPassword=secret
   rundeck.security.auth.provider.1.userBaseDn=ou=People,dc=example,dc=com
   rundeck.security.auth.provider.1.userRdnAttribute=uid
   rundeck.security.auth.provider.1.userIdAttribute=uid
   rundeck.security.auth.provider.1.userPasswordAttribute=userPassword
   rundeck.security.auth.provider.1.roleBaseDn=ou=Groups,dc=example,dc=com
   rundeck.security.auth.provider.1.roleNameAttribute=cn
   rundeck.security.auth.provider.1.roleMemberAttribute=memberUid
   rundeck.security.auth.provider.1.supplementalRoles=user
   ```

## Authorization

1. Implement role-based access control (RBAC) using Rundeck's ACL policies.
2. Follow the principle of least privilege when assigning permissions.
3. Regularly audit and review access permissions.

## Network Security

1. Use HTTPS for all communications. Update `docker-compose.yml`:

   ```yaml
   services:
     rundeck:
       environment:
         - RUNDECK_SERVER_HTTPS_ENABLED=true
         - RUNDECK_SERVER_HTTPS_KEYSTORE=/home/rundeck/server/config/keystore
         - RUNDECK_SERVER_HTTPS_KEYSTORE_PASSWORD=your_keystore_password
         - RUNDECK_SERVER_HTTPS_KEY_PASSWORD=your_key_password
   ```

2. Restrict access to Rundeck's ports (4440 for HTTP, 4443 for HTTPS) using firewall rules.
3. Use a reverse proxy (e.g., Nginx) with proper security headers:

   ```nginx
   add_header X-Frame-Options "SAMEORIGIN";
   add_header X-XSS-Protection "1; mode=block";
   add_header X-Content-Type-Options "nosniff";
   add_header Strict-Transport-Security "max-age=31536000; includeSubDomains";
   ```

## Data Protection

1. Encrypt sensitive data in Rundeck's database:

   ```properties
   rundeck.config.storage.converter.1.type=jasypt-encryption
   rundeck.config.storage.converter.1.config.password=your_secret_password
   rundeck.config.storage.converter.1.config.algorithm=PBEWITHSHA256AND128BITAES-CBC-BC
   ```

2. Regularly backup Rundeck's database and file storage, and ensure backups are encrypted.

## Container Security

1. Run Rundeck container as a non-root user:

   ```yaml
   services:
     rundeck:
       user: "1000:1000"
   ```

2. Keep the Rundeck image and all dependencies up to date.
3. Use Docker secrets for sensitive information instead of environment variables when possible.

## API Security

1. Use API tokens instead of username/password for API access.
2. Implement API request signing for added security.
3. Regularly rotate API tokens.

## Logging and Monitoring

1. Enable comprehensive logging:

   ```properties
   rundeck.execution.logs.fileStoragePlugin=db
   rundeck.log4j.config.file=/home/rundeck/server/config/log4j.properties
   ```

2. Set up log aggregation and analysis (e.g., ELK stack).
3. Implement alerts for suspicious activities or failed login attempts.

## Regular Security Audits

1. Conduct regular security audits of your Rundeck setup.
2. Keep informed about Rundeck security advisories and apply patches promptly.
3. Perform penetration testing on your Rundeck environment.

Remember, security is an ongoing process. Regularly review and update your security measures to protect against new threats and vulnerabilities.
