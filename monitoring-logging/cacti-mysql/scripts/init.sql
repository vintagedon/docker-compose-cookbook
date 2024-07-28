-- Initialize MySQL for Cacti Monitoring and Logging

-- Create Cacti database and user
CREATE DATABASE IF NOT EXISTS cacti;
CREATE USER IF NOT EXISTS 'cactiuser'@'%' IDENTIFIED BY 'cactipassword';
GRANT ALL PRIVILEGES ON cacti.* TO 'cactiuser'@'%';
FLUSH PRIVILEGES;

-- Set MySQL time zone
SET GLOBAL time_zone = 'UTC';

-- Optimize MySQL for Cacti monitoring and logging
SET GLOBAL innodb_file_per_table = 1;
SET GLOBAL innodb_buffer_pool_size = 256M;
SET GLOBAL innodb_additional_mem_pool_size = 80M;
SET GLOBAL innodb_log_file_size = 32M;
SET GLOBAL innodb_log_buffer_size = 16M;
SET GLOBAL innodb_flush_log_at_trx_commit = 1;
SET GLOBAL innodb_lock_wait_timeout = 50;
SET GLOBAL innodb_io_capacity = 5000;
SET GLOBAL max_heap_table_size = 128M;
SET GLOBAL tmp_table_size = 64M;
SET GLOBAL join_buffer_size = 64M;

-- Additional optimizations can be added here

-- Note: These settings are optimized for general monitoring and logging use cases.
-- You may need to adjust them based on your specific monitoring requirements and hardware capabilities.