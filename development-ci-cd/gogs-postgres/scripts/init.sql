-- Initialize the database for Gogs

-- Create extensions
CREATE EXTENSION IF NOT EXISTS pg_trgm;
CREATE EXTENSION IF NOT EXISTS citext;

-- Create a user for Gogs (if not already created by Docker)
DO
$do$
BEGIN
   IF NOT EXISTS (
      SELECT FROM pg_catalog.pg_roles
      WHERE  rolname = 'gogs') THEN
      CREATE ROLE gogs LOGIN PASSWORD 'your_password_here';
   END IF;
END
$do$;

-- Create the database (if not already created by Docker)
CREATE DATABASE gogs
    WITH 
    OWNER = gogs
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.UTF-8'
    LC_CTYPE = 'en_US.UTF-8'
    TEMPLATE = template0;

-- Connect to the gogs database
\c gogs

-- Create schema
CREATE SCHEMA IF NOT EXISTS gogs AUTHORIZATION gogs;

-- Set search path
SET search_path TO gogs, public;

-- Create tables (example, adjust according to Gogs requirements)
CREATE TABLE IF NOT EXISTS user_table (
    id SERIAL PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS repository (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    owner_id INTEGER REFERENCES user_table(id),
    is_private BOOLEAN DEFAULT false,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Add indexes
CREATE INDEX IF NOT EXISTS idx_user_username ON user_table(username);
CREATE INDEX IF NOT EXISTS idx_repository_name ON repository(name);

-- Grant privileges
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA gogs TO gogs;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA gogs TO gogs;

-- You may add more initialization queries as needed for Gogs

-- Notify that initialization is complete
DO $$
BEGIN
    RAISE NOTICE 'Gogs database initialization complete.';
END $$;