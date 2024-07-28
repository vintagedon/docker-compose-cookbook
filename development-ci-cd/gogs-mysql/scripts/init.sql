-- Initialize Gogs database and user
CREATE DATABASE IF NOT EXISTS gogs CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
CREATE USER IF NOT EXISTS 'gogs'@'%' IDENTIFIED BY 'your_gogs_password_here';
GRANT ALL PRIVILEGES ON gogs.* TO 'gogs'@'%';
FLUSH PRIVILEGES;

-- Create initial tables (this is a simplified example, actual Gogs schema is more complex)
USE gogs;

CREATE TABLE IF NOT EXISTS user (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS repository (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  owner_id INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (owner_id) REFERENCES user(id)
);

-- Add any additional initialization queries here