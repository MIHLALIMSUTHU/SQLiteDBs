-- Create the database
CREATE DATABASE IF NOT EXISTS practice_db;
USE practice_db;

-- Products table
CREATE TABLE IF NOT EXISTS products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10,2) NOT NULL
);

-- Customers table
CREATE TABLE IF NOT EXISTS customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100)
);

-- Orders table
CREATE TABLE IF NOT EXISTS orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Order items table
CREATE TABLE IF NOT EXISTS order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
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