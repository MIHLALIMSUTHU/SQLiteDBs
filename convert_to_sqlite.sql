PRAGMA foreign_keys = ON;
BEGIN TRANSACTION;

-- Products table
CREATE TABLE IF NOT EXISTS products (
    product_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    category TEXT,
    price REAL NOT NULL
);

-- Customers table
CREATE TABLE IF NOT EXISTS customers (
    customer_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT,
    last_name TEXT,
    email TEXT
);

-- Orders table
CREATE TABLE IF NOT EXISTS orders (
    order_id INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_id INTEGER,
    order_date TEXT,
    total_amount REAL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Order items table
CREATE TABLE IF NOT EXISTS order_items (
    order_item_id INTEGER PRIMARY KEY AUTOINCREMENT,
    order_id INTEGER,
    product_id INTEGER,
    quantity INTEGER,
    price REAL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Insert sample data
INSERT INTO products (name, category, price) VALUES
('Laptop', 'Electronics', 12000),
('Mouse', 'Electronics', 250),
('Keyboard', 'Electronics', 500),
('Desk Chair', 'Furniture', 1500),
('Notebook', 'Stationery', 50);

INSERT INTO customers (first_name, last_name, email) VALUES
('John', 'Doe', 'john.doe@example.com'),
('Jane', 'Smith', 'jane.smith@example.com'),
('Alice', 'Johnson', 'alice.johnson@example.com');

INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1, '2025-11-01', 12500),
(2, '2025-11-05', 1800),
(3, '2025-11-10', 550);

INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 12000),
(1, 2, 2, 250),
(2, 4, 1, 1500),
(2, 5, 6, 50),
(3, 5, 11, 50);

COMMIT;
