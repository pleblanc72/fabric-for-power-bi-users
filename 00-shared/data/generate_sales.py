"""
Generate realistic sales transaction data for the workshop.
Run this script to create Sales.csv with ~100K transactions.
"""

import csv
import random
from datetime import datetime, timedelta
from pathlib import Path

# Configuration
NUM_TRANSACTIONS = 100000
START_DATE = datetime(2023, 1, 1)
END_DATE = datetime(2025, 12, 31)
OUTPUT_FILE = Path(__file__).parent / "Sales.csv"

# Load reference data
def load_products():
    products = []
    with open(Path(__file__).parent / "Products.csv", 'r') as f:
        reader = csv.DictReader(f)
        for row in reader:
            products.append({
                'ProductID': row['ProductID'],
                'UnitPrice': float(row['UnitPrice']),
                'UnitCost': float(row['UnitCost']),
                'Category': row['Category']
            })
    return products

def load_stores():
    stores = []
    with open(Path(__file__).parent / "Stores.csv", 'r') as f:
        reader = csv.DictReader(f)
        for row in reader:
            stores.append({
                'StoreID': row['StoreID'],
                'Region': row['Region'],
                'OpenDate': datetime.strptime(row['OpenDate'], '%Y-%m-%d')
            })
    return stores

# Seasonality factors by month (outdoor retail patterns)
SEASONALITY = {
    1: 0.7,   # January - post-holiday slump
    2: 0.65,  # February - winter clearance
    3: 0.85,  # March - spring prep
    4: 1.0,   # April - spring season
    5: 1.2,   # May - outdoor season starts
    6: 1.3,   # June - peak summer prep
    7: 1.35,  # July - peak season
    8: 1.25,  # August - back to school
    9: 0.95,  # September - transition
    10: 0.9,  # October - fall season
    11: 1.1,  # November - holiday shopping
    12: 1.4,  # December - holiday peak
}

# Day of week factors
DAY_FACTORS = {
    0: 0.9,   # Monday
    1: 0.85,  # Tuesday
    2: 0.9,   # Wednesday
    3: 0.95,  # Thursday
    4: 1.1,   # Friday
    5: 1.4,   # Saturday
    6: 1.2,   # Sunday
}

# Store size factors (based on square footage)
STORE_WEIGHTS = {
    'S001': 2.0,   # Flagship - largest
    'S002': 1.2,
    'S003': 0.8,
    'S004': 1.0,
    'S005': 1.6,   # Portland main
    'S006': 0.9,
    'S007': 0.75,
    'S008': 1.3,
    'S009': 0.7,
    'S010': 1.0,
    'S011': 0.75,
    'S012': 0.85,
}

def generate_customer_id():
    """Generate a customer ID (some transactions are anonymous)"""
    if random.random() < 0.7:  # 70% are loyalty members
        return f"C{random.randint(10001, 60000):05d}"
    return ""  # Anonymous customer

def generate_discount(unit_price, month):
    """Generate realistic discounts"""
    # Higher discount probability during clearance months
    if month in [1, 2, 8, 9]:
        discount_prob = 0.35
    elif month in [11, 12]:
        discount_prob = 0.25  # Holiday sales
    else:
        discount_prob = 0.15
    
    if random.random() < discount_prob:
        # Discount tiers: 10%, 15%, 20%, 25%, 30%
        discount_pct = random.choice([0.10, 0.15, 0.20, 0.25, 0.30])
        return round(unit_price * discount_pct, 2)
    return 0.0

def generate_transactions(products, stores):
    """Generate transaction records"""
    transactions = []
    transaction_id = 1000001
    
    # Calculate date range
    total_days = (END_DATE - START_DATE).days
    
    for _ in range(NUM_TRANSACTIONS):
        # Random date with seasonality weighting
        days_offset = random.randint(0, total_days)
        trans_date = START_DATE + timedelta(days=days_offset)
        
        # Apply seasonality and day-of-week weighting
        month_factor = SEASONALITY[trans_date.month]
        day_factor = DAY_FACTORS[trans_date.weekday()]
        
        # Weight toward higher-traffic periods
        if random.random() > (month_factor * day_factor) / 2:
            # Re-roll to bias toward busier times
            days_offset = random.randint(0, total_days)
            trans_date = START_DATE + timedelta(days=days_offset)
        
        # Select store (weighted by size)
        store = random.choices(
            stores,
            weights=[STORE_WEIGHTS.get(s['StoreID'], 1.0) for s in stores]
        )[0]
        
        # Skip if store wasn't open yet
        if trans_date < store['OpenDate']:
            continue
        
        # Select product (some categories more popular)
        product = random.choice(products)
        
        # Generate quantity (usually 1, sometimes more)
        if random.random() < 0.8:
            quantity = 1
        elif random.random() < 0.9:
            quantity = 2
        else:
            quantity = random.randint(3, 5)
        
        # Calculate amounts
        unit_price = product['UnitPrice']
        discount = generate_discount(unit_price, trans_date.month)
        net_price = unit_price - discount
        total_amount = round(net_price * quantity, 2)
        total_cost = round(product['UnitCost'] * quantity, 2)
        
        transactions.append({
            'TransactionID': f"T{transaction_id}",
            'TransactionDate': trans_date.strftime('%Y-%m-%d'),
            'StoreID': store['StoreID'],
            'ProductID': product['ProductID'],
            'CustomerID': generate_customer_id(),
            'Quantity': quantity,
            'UnitPrice': unit_price,
            'Discount': discount,
            'TotalAmount': total_amount,
            'TotalCost': total_cost
        })
        
        transaction_id += 1
    
    # Sort by date
    transactions.sort(key=lambda x: x['TransactionDate'])
    
    return transactions

def main():
    print("Loading reference data...")
    products = load_products()
    stores = load_stores()
    
    print(f"Generating {NUM_TRANSACTIONS:,} transactions...")
    transactions = generate_transactions(products, stores)
    
    print(f"Writing to {OUTPUT_FILE}...")
    with open(OUTPUT_FILE, 'w', newline='') as f:
        fieldnames = ['TransactionID', 'TransactionDate', 'StoreID', 'ProductID', 
                      'CustomerID', 'Quantity', 'UnitPrice', 'Discount', 
                      'TotalAmount', 'TotalCost']
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(transactions)
    
    print(f"Done! Generated {len(transactions):,} transactions.")
    
    # Summary stats
    total_revenue = sum(t['TotalAmount'] for t in transactions)
    total_cost = sum(t['TotalCost'] for t in transactions)
    print(f"\nSummary:")
    print(f"  Total Revenue: ${total_revenue:,.2f}")
    print(f"  Total Cost: ${total_cost:,.2f}")
    print(f"  Gross Margin: {(total_revenue - total_cost) / total_revenue * 100:.1f}%")

if __name__ == "__main__":
    main()
