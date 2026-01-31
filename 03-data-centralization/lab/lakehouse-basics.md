# Lab: Build Your First Lakehouse

[← Back to Section 3: Data Centralization](../README.md)

**Duration:** 30 minutes

---

## Objectives

By the end of this lab, you will have:
- Created a Lakehouse
- Uploaded and converted data to Delta tables
- Created a shortcut
- Queried data using SQL

---

## Prerequisites

- [ ] Fabric workspace access
- [ ] Sample data files (download from 00-shared/data/ or use provided URLs)

---

## Part 1: Create a Lakehouse (5 minutes)

### Step 1: Create the Lakehouse

1. Open your Fabric workspace
2. Click **+ New** → **Lakehouse**
3. Name: `sales_lakehouse`
4. Click **Create**

### Step 2: Explore the Structure

Take a moment to understand the three sections:

| Section | Purpose | Contains |
|---------|---------|----------|
| **Tables** | Structured data (Delta format) | Queryable tables |
| **Files** | Raw files (any format) | CSVs, Parquet, JSON, etc. |
| **Shortcuts** | Pointers to external data | Links, not copies |

---

## Part 2: Load Sample Data (10 minutes)

### Step 3: Upload CSV Files

1. Download sample files (if not already done):
   - `Products.csv`
   - `Customers.csv`
   - `Sales.csv`

2. In your Lakehouse, click **Files**
3. Click **Upload** → **Upload files**
4. Select all three CSV files
5. Click **Upload**

### Step 4: Convert to Delta Tables

For each CSV file:

1. Right-click the file (e.g., `Products.csv`)
2. Select **Load to Tables**
3. Table name: Accept default or simplify (e.g., `Products`)
4. Click **Load**
5. Wait for conversion to complete

Repeat for Customers and Sales files.

### Step 5: Verify Tables

1. Click on **Tables** section
2. You should see three tables: Products, Customers, Sales
3. Click on each table to preview the data

---

## Part 3: Create Shortcuts (10 minutes)

### Understanding Shortcuts

Shortcuts are one of OneLake's most powerful features. They let you **reference data without copying it**—whether from another Lakehouse, Azure Blob Storage, AWS S3, or other sources.

| Shortcut Type | Use Case |
|---------------|----------|
| **Internal (OneLake)** | Reference tables in another Lakehouse |
| **External (ADLS, Blob, S3)** | Connect to data lake files outside Fabric |
| **Table Shortcut** | Auto-convert CSV/Parquet to Delta on read |

### Step 6: Create an Internal Shortcut

1. In your Lakehouse, right-click **Tables** → **New shortcut**
2. Choose **Microsoft OneLake**
3. Browse to:
   - Another Lakehouse in your workspace, OR
   - Your same Lakehouse's Files section (for demo purposes)
4. Select a table or folder
5. Name: `shortcut_products`
6. Click **Create**

> **What just happened?** You created a pointer to data—not a copy. Changes in the source appear instantly here.

### Step 7: Create an External Shortcut (The Magic!)

This is the **Shortcut Transformation** feature that got huge applause at Microsoft Ignite!

1. Right-click **Tables** → **New shortcut**
2. Choose **Azure Data Lake Storage Gen2** (or **Azure Blob Storage**)
3. Enter connection details:
   - **URL:** Your Azure storage account URL
   - **Authentication:** Account key, SAS token, or OAuth
   
   > 💡 **No Azure storage?** Skip to Step 8, or use a public dataset URL if available.

4. Navigate to a CSV file in your storage
5. **Here's the magic:** Select the CSV file
6. Name the shortcut: `supplier_costs_external`
7. Click **Create**

### Step 8: Observe the Transformation

1. Go to the **Tables** section
2. Find your new shortcut (has a shortcut icon)
3. Click to preview the data
4. **Notice:** The CSV is now queryable as a Delta table!

**What happened behind the scenes:**
- Fabric reads the CSV through the shortcut
- Automatically converts it to Delta format on read
- **No ETL pipeline needed**
- **Auto-syncs forever**—source changes appear automatically

```
Traditional ETL:          Shortcut Transformation:
┌─────┐  Pipeline  ┌─────┐    ┌─────┐  Shortcut  ┌─────┐
│ CSV │ ──────────▶│Delta│    │ CSV │ ──────────▶│Delta│
└─────┘  (build,   └─────┘    └─────┘  (2 min,   └─────┘
         maintain,             auto-sync)
         monitor)
```

### Step 9: Query the Shortcut via SQL

1. Open the **SQL analytics endpoint**
2. Run:
   ```sql
   SELECT * FROM supplier_costs_external;
   ```
3. The shortcut data is fully queryable—just like native tables!

**✅ Checkpoint:** You now understand the "zero-copy, zero-ETL" power of shortcuts!

---

## Part 4: Query with SQL (5 minutes)

### Step 10: Open SQL Analytics Endpoint

1. In the top-right of the Lakehouse view, click **SQL analytics endpoint**
   - Or find it in the workspace: `sales_lakehouse (SQL analytics endpoint)`
2. Wait for it to open

### Step 11: Write Queries

Try these queries:

**Query 1: Simple Select**
```sql
SELECT TOP 10 * FROM Products;
```

**Query 2: Aggregation**
```sql
SELECT 
    COUNT(*) as TotalProducts
FROM Products;
```

**Query 3: Join (if you have Sales and Products)**
```sql
SELECT 
    p.ProductName,
    SUM(s.Quantity) as TotalQuantity,
    SUM(s.Amount) as TotalRevenue
FROM Sales s
INNER JOIN Products p ON s.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER BY TotalRevenue DESC;
```

### Step 12: Save a Query (Optional)

1. After writing a query, click **Save as** → **Query**
2. Name: `Top Products by Revenue`
3. This saves the query for reuse

---

## Bonus Challenges

If you finish early:

### Challenge 1: Time Travel
Delta Lake supports querying historical versions:
```sql
SELECT * FROM Products VERSION AS OF 1;
```
(Note: May need to make changes first to have multiple versions)

### Challenge 2: Describe Table
```sql
DESCRIBE Products;
```
See the schema and column types.

### Challenge 3: Connect Power BI
1. Open Power BI Desktop
2. Get Data → Microsoft Fabric → Lakehouse
3. Connect to your `sales_lakehouse`
4. See how the tables appear

---

## Reflection Questions

1. How is this different from importing data directly into Power BI?
2. What types of data would you put in a Lakehouse?
3. When would you use Files vs. Tables?

---

## Clean Up

Keep this Lakehouse - we'll use it in later sections!

If you want to start fresh later:
1. Delete tables: Right-click → Delete
2. Delete files: Right-click → Delete
3. Or delete the entire Lakehouse from the workspace

---

## Troubleshooting

**"Load to Tables is taking forever"**
- Large files take longer
- Check file size (try smaller sample first)
- Ensure you have capacity CUs available

**"SQL Analytics Endpoint shows no tables"**
- Tables may take a few minutes to sync
- Refresh the browser
- Ensure tables were created successfully

**"Can't create shortcuts"**
- May be a capacity or tenant setting
- Try internal shortcuts (OneLake) first
- Check with your admin if external shortcuts fail
