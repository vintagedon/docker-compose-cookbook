# Troubleshooting Fluentd Docker Setup

This guide provides solutions to common issues you may encounter when using the Fluentd Docker setup.

## Table of Contents

- [Troubleshooting Fluentd Docker Setup](#troubleshooting-fluentd-docker-setup)
  - [Table of Contents](#table-of-contents)
  - [Container Startup Issues](#container-startup-issues)
  - [Log Collection Problems](#log-collection-problems)
  - [Performance Issues](#performance-issues)
  - [Output Destination Problems](#output-destination-problems)
  - [Network-related Issues](#network-related-issues)
  - [Configuration Errors](#configuration-errors)
  - [Debugging Techniques](#debugging-techniques)

## Container Startup Issues

1. **Container fails to start**

   - Check Docker logs: `docker logs fluentd`
   - Verify the Fluentd configuration file syntax
   - Ensure all required environment variables are set

2. **Permission issues**
   - Make sure the Fluentd user has necessary permissions to access log files and write to output destinations

## Log Collection Problems

1. **Fluentd not collecting logs**

   - Verify log file paths in the Fluentd configuration
   - Check file permissions on log files
   - Ensure log files are not rotated or deleted unexpectedly

2. **Parsing errors**
   - Review the log format and adjust the parsing configuration
   - Use Fluentd's debug log to identify parsing issues

## Performance Issues

1. **High CPU usage**

   - Check for complex regular expressions in parsing rules
   - Increase the number of Fluentd workers
   - Optimize buffer configurations

2. **Memory leaks**
   - Update Fluentd and plugins to the latest versions
   - Review and optimize complex configurations

## Output Destination Problems

1. **Logs not reaching the output destination**

   - Verify network connectivity to the output destination
   - Check authentication credentials
   - Review output plugin configuration

2. **Data loss or duplication**
   - Implement proper error handling and retry mechanisms
   - Use persistent buffer paths to prevent data loss during restarts

## Network-related Issues

1. **Unable to forward logs**

   - Check firewall rules and network policies
   - Verify port configurations in docker-compose.yml

2. **TLS/SSL issues**
   - Ensure certificates are valid and properly configured
   - Check for certificate expiration

## Configuration Errors

1. **Syntax errors in fluent.conf**

   - Use `fluentd --dry-run` to check configuration syntax
   - Review Fluentd logs for detailed error messages

2. **Plugin loading issues**
   - Ensure all required plugins are installed and properly configured
   - Check for version compatibility between Fluentd and plugins

## Debugging Techniques

1. **Enable debug logging**
   Add the following to your Fluentd configuration:

   ```
   <system>
     log_level debug
   </system>
   ```

2. **Use the stdout output for testing**
   Replace your output configuration with:

   ```
   <match **>
     @type stdout
   </match>
   ```

3. **Inspect Fluentd internal metrics**
   Enable the monitor agent and use curl to fetch metrics:

   ```
   <source>
     @type monitor_agent
     bind 0.0.0.0
     port 24220
   </source>
   ```

   Then use: `curl http://localhost:24220/api/plugins.json`

4. **Use Docker commands for investigation**

   - View logs: `docker logs fluentd`
   - Exec into the container: `docker exec -it fluentd /bin/sh`

5. **Check system resources**
   Use Docker commands to check resource usage:
   - `docker stats fluentd`

Remember to always backup your configuration before making changes, and test in a non-production environment first.
