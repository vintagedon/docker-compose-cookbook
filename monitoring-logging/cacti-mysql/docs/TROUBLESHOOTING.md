# Troubleshooting Cacti with MySQL

This guide provides solutions to common issues you might encounter with your Cacti monitoring and logging setup.

## Table of Contents

- [Troubleshooting Cacti with MySQL](#troubleshooting-cacti-with-mysql)
  - [Table of Contents](#table-of-contents)
  - [Cacti Web Interface Issues](#cacti-web-interface-issues)
  - [Data Collection Problems](#data-collection-problems)
  - [MySQL Connection Issues](#mysql-connection-issues)
  - [Performance Problems](#performance-problems)
  - [Graph Display Issues](#graph-display-issues)
  - [SNMP Troubleshooting](#snmp-troubleshooting)

## Cacti Web Interface Issues

1. **Cannot access Cacti web interface**

   - Check if the Cacti container is running: `docker ps`
   - Verify port mapping in `docker-compose.yml`
   - Check web server logs: `docker logs cacti_container_name`

2. **Login issues**
   - Verify correct username and password
   - Check MySQL connection (see MySQL Connection Issues)

## Data Collection Problems

1. **No data being collected**

   - Verify device is reachable (ping test)
   - Check SNMP settings on the device
   - Review Cacti poller logs: `docker exec cacti_container_name cat /var/www/html/log/cacti.log`

2. **Partial data collection**
   - Check individual data source settings
   - Verify SNMP OIDs are correct
   - Increase script timeout in Cacti settings

## MySQL Connection Issues

1. **Cacti cannot connect to MySQL**

   - Verify MySQL container is running: `docker ps`
   - Check MySQL logs: `docker logs mysql_container_name`
   - Verify correct database credentials in Cacti configuration

2. **MySQL performance issues**
   - Review MySQL configuration (see PERFORMANCE_TUNING.md)
   - Check system resources (CPU, RAM, Disk I/O)

## Performance Problems

1. **Slow web interface**

   - Enable Boost in Cacti settings
   - Optimize MySQL (see PERFORMANCE_TUNING.md)
   - Consider implementing caching (e.g., Redis)

2. **Polling taking too long**
   - Reduce polling frequency
   - Implement remote pollers
   - Optimize SNMP settings (use SNMPv2c or v3)

## Graph Display Issues

1. **Graphs not displaying**

   - Check RRDtool installation and permissions
   - Verify correct path to RRDtool in Cacti settings
   - Review Cacti's log for RRDtool errors

2. **Incorrect data in graphs**
   - Verify data input methods and data sources
   - Check for counter wraps or incorrect max values
   - Ensure time synchronization across all systems

## SNMP Troubleshooting

1. **Cannot retrieve SNMP data**

   - Verify SNMP is enabled on the device
   - Check SNMP community string (for v1/v2c) or credentials (for v3)
   - Use `snmpwalk` to test SNMP connectivity:
     ```
     docker exec cacti_container_name snmpwalk -v2c -c public device_ip_address
     ```

2. **SNMP timeouts**
   - Increase SNMP timeout in Cacti device settings
   - Check network connectivity and firewall rules
   - Verify SNMP process on the monitored device is not overloaded

For persistent issues, review Cacti's comprehensive logs and consider seeking help in the Cacti forums or mailing lists.
