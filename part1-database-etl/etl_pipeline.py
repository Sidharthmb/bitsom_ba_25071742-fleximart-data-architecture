import pandas as pd
import mysql.connector

print("ETL STARTED")

# -------------------------------
# EXTRACT
# -------------------------------

customers = pd.read_csv("../data/customers_raw.csv")
products = pd.read_csv("../data/products_raw.csv")
sales = pd.read_csv("../data/sales_raw.csv")

customers_raw_count = len(customers)
products_raw_count = len(products)
sales_raw_count = len(sales)

# -------------------------------
# DATA QUALITY COUNTERS
# -------------------------------

customer_duplicates_removed = 0
product_duplicates_removed = 0
sales_duplicates_removed = 0
sales_missing_customer_dropped = 0
sales_missing_product_dropped = 0

# -------------------------------
# TRANSFORM — CUSTOMERS
# -------------------------------

before = len(customers)
customers = customers.drop_duplicates(subset=["customer_id"])
customer_duplicates_removed = before - len(customers)

customers["phone"] = customers["phone"].astype(str)
customers["phone"] = customers["phone"].str.replace(r"[^0-9]", "", regex=True)
customers["phone"] = customers["phone"].apply(
    lambda x: "+91-" + x[-10:] if len(x) >= 10 else None
)

customers["registration_date"] = pd.to_datetime(
    customers["registration_date"],
    dayfirst=True,
    errors="coerce"
)

customers = customers.where(pd.notnull(customers), None)

customers_clean_count = len(customers)

# -------------------------------
# TRANSFORM — PRODUCTS
# -------------------------------

before = len(products)
products = products.drop_duplicates(subset=["product_id"])
product_duplicates_removed = before - len(products)

products["category"] = products["category"].str.strip().str.title()

products["price"] = products.groupby("category")["price"].transform(
    lambda x: x.fillna(x.mean())
)

products["stock_quantity"] = products["stock_quantity"].fillna(0)

products = products.where(pd.notnull(products), None)

products_clean_count = len(products)

# -------------------------------
# TRANSFORM — SALES
# -------------------------------

before = len(sales)
sales = sales.drop_duplicates(subset=["transaction_id"])
sales_duplicates_removed = before - len(sales)

sales["transaction_date"] = pd.to_datetime(
    sales["transaction_date"],
    dayfirst=True,
    errors="coerce"
)

before = len(sales)
sales = sales.dropna(subset=["customer_id"])
sales_missing_customer_dropped = before - len(sales)

before = len(sales)
sales = sales.dropna(subset=["product_id"])
sales_missing_product_dropped = before - len(sales)

sales["total_amount"] = sales["quantity"] * sales["unit_price"]

sales = sales.where(pd.notnull(sales), None)

sales_clean_count = len(sales)

# -------------------------------
# LOAD — MYSQL
# -------------------------------

conn = mysql.connector.connect(
    host="localhost",
    user="etl_user",
    password="etlpassword123",
    database="fleximart"
)

cursor = conn.cursor()

customer_key_map = {}
product_key_map = {}

# -------------------------------
# LOAD CUSTOMERS
# -------------------------------

for _, row in customers.iterrows():
    cursor.execute(
        """
        INSERT INTO customers (first_name, last_name, email, phone, city, registration_date)
        VALUES (%s, %s, %s, %s, %s, %s)
        """,
        (
            row["first_name"],
            row["last_name"],
            row["email"],
            row["phone"],
            row["city"],
            row["registration_date"]
        )
    )
    customer_key_map[row["customer_id"]] = cursor.lastrowid

# -------------------------------
# LOAD PRODUCTS
# -------------------------------

for _, row in products.iterrows():
    cursor.execute(
        """
        INSERT INTO products (product_name, category, price, stock_quantity)
        VALUES (%s, %s, %s, %s)
        """,
        (
            row["product_name"],
            row["category"],
            row["price"],
            row["stock_quantity"]
        )
    )
    product_key_map[row["product_id"]] = cursor.lastrowid

orders_loaded = 0
order_items_loaded = 0

# -------------------------------
# LOAD ORDERS & ORDER ITEMS
# -------------------------------

for _, row in sales.iterrows():
    customer_fk = customer_key_map.get(row["customer_id"])
    product_fk = product_key_map.get(row["product_id"])

    if customer_fk is None or product_fk is None:
        continue

    cursor.execute(
        """
        INSERT INTO orders (customer_id, order_date, total_amount, status)
        VALUES (%s, %s, %s, %s)
        """,
        (
            customer_fk,
            row["transaction_date"],
            row["total_amount"],
            row["status"]
        )
    )

    order_id = cursor.lastrowid
    orders_loaded += 1

    cursor.execute(
        """
        INSERT INTO order_items (order_id, product_id, quantity, unit_price, subtotal)
        VALUES (%s, %s, %s, %s, %s)
        """,
        (
            order_id,
            product_fk,
            row["quantity"],
            row["unit_price"],
            row["total_amount"]
        )
    )

    order_items_loaded += 1

conn.commit()
cursor.close()
conn.close()

# -------------------------------
# DATA QUALITY REPORT
# -------------------------------

with open("data_quality_report.txt", "w") as report:
    report.write("FLEXIMART DATA QUALITY REPORT\n")
    report.write("----------------------------------\n\n")

    report.write(f"Customers Records Processed: {customers_raw_count}\n")
    report.write(f"Customer Duplicates Removed: {customer_duplicates_removed}\n")
    report.write(f"Customers Loaded: {customers_clean_count}\n\n")

    report.write(f"Products Records Processed: {products_raw_count}\n")
    report.write(f"Product Duplicates Removed: {product_duplicates_removed}\n")
    report.write(f"Products Loaded: {products_clean_count}\n\n")

    report.write(f"Sales Records Processed: {sales_raw_count}\n")
    report.write(f"Sales Duplicates Removed: {sales_duplicates_removed}\n")
    report.write(f"Sales Missing Customer IDs Dropped: {sales_missing_customer_dropped}\n")
    report.write(f"Sales Missing Product IDs Dropped: {sales_missing_product_dropped}\n")
    report.write(f"Orders Loaded: {orders_loaded}\n")
    report.write(f"Order Items Loaded: {order_items_loaded}\n")

print("ETL FINISHED SUCCESSFULLY")
print("data_quality_report.txt GENERATED")