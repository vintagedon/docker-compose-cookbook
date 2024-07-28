-- Initialize MySQL database for Gitea

-- Create the database (if not already created by Docker)
CREATE DATABASE IF NOT EXISTS gitea;

-- Use the gitea database
USE gitea;

-- Create a user for Gitea (if not already created by Docker)
-- Replace 'gitea_user' and 'password' with your desired username and password
-- CREATE USER 'gitea_user'@'%' IDENTIFIED BY 'password';

-- Grant privileges to the Gitea user
-- GRANT ALL PRIVILEGES ON gitea.* TO 'gitea_user'@'%';

-- Flush privileges to ensure changes take effect
FLUSH PRIVILEGES;

-- Create necessary tables and indexes
-- Note: Gitea will create its own schema, so we don't need to create tables here

-- You can add any additional initialization SQL commands here
-- For example, you might want to set some MySQL configuration options:

SET GLOBAL innodb_file_per_table=ON;
SET GLOBAL innodb_file_format=Barracuda;
SET GLOBAL innodb_large_prefix=ON;

-- Add any other initialization steps as needed