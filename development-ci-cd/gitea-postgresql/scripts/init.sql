-- Initialize the Gitea database

-- Create the gitea user if it doesn't exist
DO
$do$
BEGIN
   IF NOT EXISTS (
      SELECT FROM pg_catalog.pg_roles
      WHERE  rolname = 'gitea') THEN

      CREATE ROLE gitea LOGIN PASSWORD 'gitea_password';
   END IF;
END
$do$;

-- Create the gitea database if it doesn't exist
CREATE DATABASE gitea
    WITH 
    OWNER = gitea
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.utf8'
    LC_CTYPE = 'en_US.utf8'
    TEMPLATE = template0;

-- Connect to the gitea database
\c gitea

-- Create extensions
CREATE EXTENSION IF NOT EXISTS citext;
CREATE EXTENSION IF NOT EXISTS pg_trgm;

-- Set default privileges
ALTER DEFAULT PRIVILEGES FOR ROLE gitea IN SCHEMA public
GRANT ALL ON TABLES TO gitea;

ALTER DEFAULT PRIVILEGES FOR ROLE gitea IN SCHEMA public
GRANT ALL ON SEQUENCES TO gitea;

ALTER DEFAULT PRIVILEGES FOR ROLE gitea IN SCHEMA public
GRANT ALL ON FUNCTIONS TO gitea;

-- You can add more initialization commands here if needed