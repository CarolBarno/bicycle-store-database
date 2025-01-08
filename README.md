# Bicycle Store Database

This project provides a relational database setup for a bicycle store, using data on customers, employees, products, and orders. 

## Project Structure

- `sql/schema.sql`: Defines the database schema.
- `sql/insert_data.sql`: SQL script to load data from CSV files into tables.
- `data/`: Contains the CSV files for loading data.
- `scripts/load_data.py`: Optional Python script to load data into the database.

## Prerequisites

- MySQL or MariaDB server
- (Optional) Python 3.x with `pandas` and `SQLAlchemy` for the Python loader

## Setup Instructions

### 1. Run the Schema Script
This creates the necessary tables and relationships.

```bash
mysql -u username -p < sql/schema.sql
psql -U username -d bicycle_store -f sql/schema.sql
python scripts/load_data.py
