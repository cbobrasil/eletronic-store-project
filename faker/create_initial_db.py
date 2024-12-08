
from faker import Faker
import pandas as pd
import random
from datetime import datetime, timedelta

# Initialize Faker instance
fake = Faker()

# Constants for data generation
NUM_CUSTOMERS = 100
NUM_PRODUCTS = 50
NUM_SUPPLIERS = 20
NUM_TRANSACTIONS = 50000

# Helper function to generate random dates
def random_date(start, end):
    delta = end - start
    random_days = random.randint(0, delta.days)
    return start + timedelta(days=random_days)

# Generate Suppliers
suppliers = []
for supplier_id in range(1, NUM_SUPPLIERS + 1):
    suppliers.append({
        "supplier_id": supplier_id,
        "name": fake.company(),
        "contact_email": fake.company_email(),
        "phone": fake.phone_number(),
        "address": fake.address()
    })

# Generate Products
products = []
for product_id in range(1, NUM_PRODUCTS + 1):
    products.append({
        "product_id": product_id,
        "name": fake.catch_phrase(),
        "category": random.choice(["Smartphones", "Laptops", "Accessories", "Smart Home Devices", "Wearables"]),
        "price": round(random.uniform(10, 1000), 2),  # Prices between $10 and $1000
        "stock": random.randint(50, 500),  # Initial stock between 50 and 500 units
        "supplier_id": random.randint(1, NUM_SUPPLIERS)
    })

# Generate Customers
customers = []
for customer_id in range(1, NUM_CUSTOMERS + 1):
    customers.append({
        "customer_id": customer_id,
        "name": fake.name(),
        "email": fake.email(),
        "phone": fake.phone_number(),
        "address": fake.address(),
        "registration_date": random_date(datetime(2020, 1, 1), datetime(2023, 12, 31))
    })

# Generate Transactions and Transaction Items
transactions = []
transaction_items = []
current_transaction_id = 1
start_date = datetime(2021, 1, 1)
end_date = datetime(2023, 12, 31)

for _ in range(NUM_TRANSACTIONS):
    # Generate transaction
    customer_id = random.randint(1, NUM_CUSTOMERS)
    transaction_date = random_date(start_date, end_date)
    transaction_total = 0
    transaction_items_count = random.randint(1, 5)  # Number of items in the transaction

    for _ in range(transaction_items_count):
        product = random.choice(products)
        quantity = random.randint(1, 5)  # Random quantity for the item

        # Check if sufficient stock is available
        if product["stock"] >= quantity:
            product["stock"] -= quantity  # Update stock
            subtotal = product["price"] * quantity
            transaction_total += subtotal

            # Append transaction item
            transaction_items.append({
                "item_id": len(transaction_items) + 1,
                "transaction_id": current_transaction_id,
                "product_id": product["product_id"],
                "quantity": quantity,
                "unit_price": product["price"],
                "subtotal": subtotal
            })

    # Append the transaction only if it has items
    if transaction_total > 0:
        transactions.append({
            "transaction_id": current_transaction_id,
            "customer_id": customer_id,
            "transaction_date": transaction_date,
            "total_amount": transaction_total
        })
        current_transaction_id += 1

# Convert to DataFrames for better visualization and manipulation
df_suppliers = pd.DataFrame(suppliers)
df_products = pd.DataFrame(products)
df_customers = pd.DataFrame(customers)
df_transactions = pd.DataFrame(transactions)
df_transaction_items = pd.DataFrame(transaction_items)

def clean_text(value):
    if isinstance(value, str):
        # Remove quebras de linha e espaços desnecessários
        value = value.replace("\n", " ").replace("\r", " ")
        # Escapar aspas duplas
        value = value.replace('"', '""')
    return value

# Clean all DataFrames before saving
df_suppliers = df_suppliers.applymap(clean_text)
df_products = df_products.applymap(clean_text)
df_customers = df_customers.applymap(clean_text)
df_transactions = df_transactions.applymap(clean_text)
df_transaction_items = df_transaction_items.applymap(clean_text)

# Save as CSV or Excel files if needed
df_suppliers.to_csv("suppliers.csv", index=False)
df_products.to_csv("products.csv", index=False)
df_customers.to_csv("customers.csv", index=False)
df_transactions.to_csv("transactions.csv", index=False)
df_transaction_items.to_csv("transaction_items.csv", index=False)

# Print first few rows for verification
print("Suppliers:", df_suppliers.head(), sep="\n")
print("\nProducts:", df_products.head(), sep="\n")
print("\nCustomers:", df_customers.head(), sep="\n")
print("\nTransactions:", df_transactions.head(), sep="\n")
print("\nTransaction Items:", df_transaction_items.head(), sep="\n")