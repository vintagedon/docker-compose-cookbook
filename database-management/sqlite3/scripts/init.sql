-- Create a sample table
CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Insert some sample data
INSERT INTO users (name, email) VALUES
    ('John Doe', 'john@example.com'),
    ('Jane Smith', 'jane@example.com');

-- Create an index on the email column
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);

-- Print a message to confirm script execution
SELECT 'Initialization complete. ' || COUNT(*) || ' users created.' AS message FROM users;