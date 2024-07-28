# Troubleshooting SQLite3 Docker Setup

This document provides solutions to common issues you might encounter when using SQLite3 in a Docker environment.

## Table of Contents

- [Troubleshooting SQLite3 Docker Setup](#troubleshooting-sqlite3-docker-setup)
  - [Table of Contents](#table-of-contents)
  - [Container Issues](#container-issues)
  - [Database Connection Issues](#database-connection-issues)
  - [Performance Issues](#performance-issues)
  - [Data Persistence Issues](#data-persistence-issues)
  - [SQL Query Issues](#sql-query-issues)

## Container Issues

1. **Container fails to start**

   - Check Docker logs: `docker logs sqlite3`
   - Ensure the Docker image is pulled correctly: `docker pull keinos/sqlite3:latest`
   - Verify your docker-compose.yml file for syntax errors

2. **Container starts but exits immediately**
   - Check if the command in docker-compose.yml is correct
   - Ensure the init.sql script doesn't have errors causing early exit

## Database Connection Issues

1. **Unable to connect to the database**

   - Verify the database file path in the docker-compose.yml
   - Check if the volume is mounted correctly
   - Ensure the database file has the correct permissions

2. **"database is locked" error**
   - This usually occurs due to concurrent write operations
   - Consider using WAL mode: `PRAGMA journal_mode = WAL;`
   - Increase the busy_timeout: `PRAGMA busy_timeout = 5000;`

## Performance Issues

1. **Slow query execution**

   - Use EXPLAIN QUERY PLAN to analyze your queries
   - Ensure proper indexes are in place
   - Check if you're using appropriate PRAGMA settings for your use case

2. **High CPU usage**
   - Monitor with `docker stats sqlite3`
   - Check for any infinite loops in your application code
   - Consider optimizing complex queries or adding indexes

## Data Persistence Issues

1. **Data lost after container restart**

   - Ensure you're using a named volume in docker-compose.yml
   - Check if the volume is correctly mounted to the container
   - Verify the database file is being saved in the correct location

2. **Unable to see updated data**
   - Ensure you're connecting to the correct database file
   - Check if transactions are being committed properly

## SQL Query Issues

1. **"no such table" error**

   - Verify the table name and case sensitivity
   - Check if the init.sql script is executed correctly on container start
   - Ensure you're connected to the correct database

2. **"column not found" error**
   - Check for typos in column names
   - Ensure the table schema matches your expectations
   - Verify if any recent ALTER TABLE commands were successful

If you encounter an issue not listed here, please check the SQLite documentation or create an issue in our GitHub repository for further assistance.
