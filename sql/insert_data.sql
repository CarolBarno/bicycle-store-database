USE bicycle_store;

-- Insert data into Customers table
LOAD DATA INFILE 'data/customer_list.csv'
INTO TABLE customers
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(first_name, last_name, gender, DOB, address, postcode, state, country, property_valuation);

-- Insert data into Products table
LOAD DATA INFILE 'data/transactions.csv'
INTO TABLE products
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(product_id, brand, product_line, product_class, product_size, list_price);

-- Insert data into Orders table
LOAD DATA INFILE 'data/transactions.csv'
INTO TABLE orders
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(transaction_id, transaction_date, customer_id, product_id, online_order, order_status);
