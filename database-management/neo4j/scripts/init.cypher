// Create constraints
CREATE CONSTRAINT ON (u:User) ASSERT u.id IS UNIQUE;
CREATE CONSTRAINT ON (p:Product) ASSERT p.id IS UNIQUE;

// Create indexes
CREATE INDEX ON :User(email);
CREATE INDEX ON :Product(name);

// Create some sample data
CREATE (u1:User {id: 1, name: 'John Doe', email: 'john@example.com'})
CREATE (u2:User {id: 2, name: 'Jane Smith', email: 'jane@example.com'})
CREATE (p1:Product {id: 1, name: 'Widget A', price: 19.99})
CREATE (p2:Product {id: 2, name: 'Gadget B', price: 29.99})
CREATE (u1)-[:PURCHASED]->(p1)
CREATE (u2)-[:PURCHASED]->(p2)
CREATE (u1)-[:REVIEWED {rating: 5, comment: 'Great product!'}]->(p1)
CREATE (u2)-[:REVIEWED {rating: 4, comment: 'Good value for money'}]->(p2);

// Print a message to confirm script execution
CALL dbms.procedures() YIELD name
WITH collect(name) AS procedures
RETURN 'Initialization complete. ' + size(procedures) + ' procedures available.' AS message;