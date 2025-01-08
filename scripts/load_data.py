import pandas as pd
from sqlalchemy import create_engine

db_user = "postgres"
db_password = "admin"
db_host = "localhost"
db_port = "5432"
db_name = "bicycle_store"

# Create an engine for PostgreSQL
engine = create_engine(
    f'postgresql://{db_user}:{db_password}@{db_host}:{db_port}/{db_name}'
)

# Create an engine for MySQL
# engine = create_engine(
#     f'mysql+pymysql://{db_user}:{db_password}@{db_host}/{db_name}')


def load_csv_to_db(file_path, table_name, columns, unique_key=None, date_columns=None, filter_column=None, reference_table=None):
    try:
        data = pd.read_csv(file_path, usecols=lambda x: x.lower() in [col.lower() for col in columns])
        data.columns = [col.lower() for col in data.columns]

        if unique_key:
            data = data.drop_duplicates(subset=[unique_key])

        if date_columns:
            for date_column in date_columns:
                data[date_column] = pd.to_datetime(data[date_column], format='%d-%m-%Y', errors='coerce')

        if filter_column and reference_table:
            existing_ids = pd.read_sql(f"SELECT customer_id FROM {reference_table}", con=engine)
            data = data[data[filter_column].isin(existing_ids['customer_id'])]

        data = data.dropna(subset=date_columns)

        data.to_sql(table_name, con=engine, if_exists='append', index=False)
        print(f"Data loaded successfully into {table_name}")
    except Exception as e:
        print(f"Error loading data into {table_name}: {e}")


load_csv_to_db(
    file_path='data/customer_list.csv',
    table_name='customers',
    columns=['first_name', 'last_name', 'gender', 'dob', 'address', 'postcode', 'state', 'country', 'property_valuation'],
    date_columns=['dob']
)

load_csv_to_db(
    file_path='data/transactions.csv',
    table_name='products',
    columns=['product_id', 'brand', 'product_line', 'product_class', 'product_size', 'list_price'],
    unique_key='product_id'
)

load_csv_to_db(
    file_path='data/transactions.csv',
    table_name='orders',
    columns=['transaction_id', 'transaction_date', 'customer_id', 'product_id', 'online_order', 'order_status'],
    date_columns=['transaction_date'],
    filter_column='customer_id',
    reference_table='customers'
)

