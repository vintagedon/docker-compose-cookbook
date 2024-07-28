# Troubleshooting Guide for Rundeck Docker Setup

This guide provides solutions to common issues you may encounter when running Rundeck in Docker.

## Unable to Connect to Rundeck Web Interface

1. Check if the container is running:

   ```
   docker-compose ps
   ```

2. Verify the port mapping:

   ```
   docker-compose port rundeck 4440
   ```

3. Check Rundeck logs:

   ```
   docker-compose logs rundeck
   ```

4. Ensure the `RUNDECK_GRAILS_URL` is set correctly in your `.env` file.

## Database Connection Issues

1. Verify database credentials in `.env` file.

2. Check if the database container is running:

   ```
   docker-compose ps db
   ```

3. Inspect database logs:

   ```
   docker-compose logs db
   ```

4. Try connecting to the database manually:
   ```
   docker-compose exec db mysql -u rundeck -p
   ```

## Job Execution Failures

1. Check job logs in Rundeck web interface.

2. Verify that required plugins are installed and configured correctly.

3. Check system resources (CPU, memory) of the Rundeck container:

   ```
   docker stats rundeck
   ```

4. Inspect Rundeck server logs:
   ```
   docker-compose exec rundeck tail -f /home/rundeck/server/logs/rundeck.log
   ```

## LDAP/SSO Authentication Issues

1. Verify LDAP/SSO configuration in `rundeck-config.properties`.

2. Check Rundeck logs for authentication-related errors.

3. Ensure the LDAP/SSO server is accessible from the Rundeck container.

## Performance Issues

1. Monitor resource usage:

   ```
   docker stats rundeck db
   ```

2. Check for slow database queries in database logs.

3. Review and adjust JVM settings in `docker-compose.yml`.

4. Consider increasing resources allocated to Docker.

## Plugin Issues

1. Verify plugin compatibility with your Rundeck version.

2. Check plugin logs in Rundeck web interface.

3. Ensure plugins are correctly placed in the plugins directory.

## Upgrade Issues

1. Back up your data before upgrading.

2. Check Rundeck's upgrade notes for your specific version.

3. Verify compatibility of all plugins with the new Rundeck version.

4. If issues persist, try a clean install and restore your data.

## Container Crashes

1. Check Docker logs:

   ```
   docker-compose logs --tail=100 rundeck
   ```

2. Verify system resources on the host machine.

3. Check for any error messages during container startup.

## Network Issues

1. Verify network settings in `docker-compose.yml`.

2. Ensure all required ports are open on your host firewall.

3. Check Docker network configuration:
   ```
   docker network inspect rundeck_network
   ```

Remember to check the [official Rundeck documentation](https://docs.rundeck.com/) and [GitHub issues](https://github.com/rundeck/rundeck/issues) for more specific troubleshooting steps. If you can't resolve an issue, consider reaching out to the Rundeck community for help.
