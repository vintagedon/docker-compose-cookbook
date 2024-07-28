# Performance Tuning for Cacti with MySQL

This guide provides tips and best practices for optimizing the performance of your Cacti monitoring and logging setup.

## Table of Contents

- [Performance Tuning for Cacti with MySQL](#performance-tuning-for-cacti-with-mysql)
  - [Table of Contents](#table-of-contents)
  - [System Requirements](#system-requirements)
  - [MySQL Optimization](#mysql-optimization)
  - [Cacti Settings](#cacti-settings)
  - [Network Considerations](#network-considerations)
  - [RRDtool Tuning](#rrdtool-tuning)
  - [Monitoring Best Practices](#monitoring-best-practices)

## System Requirements

- CPU: 2+ cores recommended
- RAM: 4GB minimum, 8GB+ recommended
- Disk: SSD preferred for database and RRD files

## MySQL Optimization

Adjust these settings in your `my.cnf` or `init.sql`:

```sql
innodb_buffer_pool_size = 1G  # Adjust based on available RAM
innodb_file_per_table = 1
innodb_flush_log_at_trx_commit = 2
innodb_flush_method = O_DIRECT
innodb_log_file_size = 256M
innodb_large_prefix = 1
```

## Cacti Settings

In the Cacti web interface (Console > Configuration > Settings):

1. Poller

   - Set "Poller Type" to "Spine" for better performance
   - Adjust "Poller Interval" based on your needs (300 seconds is common)

2. Performance

   - Enable "Boost RRD Updates"
   - Set "Maximum Boost Records" based on your system capabilities

3. Spine
   - Increase "Script Timeout" if you have complex data queries

## Network Considerations

- Use SNMP v2c or v3 instead of v1 for better performance
- Implement QoS to prioritize monitoring traffic
- Consider using remote pollers for geographically distributed environments

## RRDtool Tuning

- Use the `--no-bulk` option with RRDtool to reduce I/O load
- Consider using RRDcached for improved performance with large numbers of RRD files

## Monitoring Best Practices

- Group devices logically to optimize polling
- Use appropriate data collection intervals (not too frequent, not too sparse)
- Regularly review and remove unused graphs and data sources
- Implement thresholds to focus on important metrics
- Use aggregate graphs for high-level views

Remember to test any changes in a non-production environment first, and monitor the impact of each optimization.
