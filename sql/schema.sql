-- Create the BicycleStore database
-- CREATE DATABASE IF NOT EXISTS bicycle_store;
-- USE bicycle_store;

-- Create the Customers table
CREATE TABLE IF NOT EXISTS customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100),
    gender VARCHAR(10),
    dob DATE,
    address VARCHAR(100),
    postcode VARCHAR(20),
    state VARCHAR(50),
    country VARCHAR(50) NOT NULL,
    property_valuation INT
);

-- Create the Products table
CREATE TABLE IF NOT EXISTS products (
    product_id INT PRIMARY KEY,
    brand VARCHAR(50) NOT NULL,
    product_line VARCHAR(50) NULL,
    product_class VARCHAR(50) NULL,
    product_size VARCHAR(50) NULL,
    list_price DECIMAL(10, 2) NOT NULL 
);

-- Create the Orders table
CREATE TABLE IF NOT EXISTS orders (
    transaction_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    transaction_date DATE NOT NULL,
    online_order BOOLEAN DEFAULT NULL,
    order_status VARCHAR(20) NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
