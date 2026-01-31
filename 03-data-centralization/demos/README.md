# Demos: Data Centralization

[← Back to Section 3: Data Centralization](../README.md)

---

## Demo 1: Create a Lakehouse

### Setup Required
- Fabric workspace
- Sample CSV files (from 00-shared/data/)

### Demo Script

1. **Create the Lakehouse**
   - In workspace, click **+ New** → **Lakehouse**
   - Name: `sales_lakehouse`
   - Click **Create**

2. **Explore the empty Lakehouse**
   - Point out the three sections: Tables, Files, Shortcuts
   - Explain each section's purpose

3. **Upload sample data**
   - Go to **Files** section
   - Click **Upload** → **Upload files**
   - Upload sample CSV files (Products.csv, Sales.csv)
   - Show the files appear

4. **Convert CSV to Delta table**
   - Right-click on Products.csv
   - Select **Load to Tables**
   - Accept defaults
   - Watch the conversion
   - Show the table appear in Tables section

5. **Explore the table**
   - Click on the Products table
   - Show the data preview
   - Point out the Delta format indicators

### Key Points to Highlight
- Files ≠ Tables (must convert to query)
- Delta format is automatic
- Same data, now queryable

---

## Demo 2: Add Data via Shortcut

### Setup Required
- Lakehouse from Demo 1
- External data source (ADLS, or use another Fabric item)

### Demo Script

1. **Create a shortcut**
   - In Lakehouse, right-click **Shortcuts** → **New shortcut**
   - Choose source:
     - **Option A:** Another Fabric Lakehouse/Warehouse
     - **Option B:** Azure Data Lake Storage Gen2
     - **Option C:** Amazon S3

2. **Configure the shortcut**
   - Navigate to the source data
   - Select specific folder or table
   - Name the shortcut
   - Create

3. **Show the shortcut**
   - Notice the shortcut icon (arrow indicator)
   - Open and view the data
   - Point out: "This data is NOT copied"

4. **Query across shortcut and local data**
   - Open SQL Analytics Endpoint
   - Write a query joining local table and shortcut
   - Show results

### Key Points to Highlight
- No data movement = no extra storage cost
- Updates in source reflected automatically
- Can query as if it's local data

---

## Demo 3: Query with SQL Analytics Endpoint

### Setup Required
- Lakehouse with tables from previous demos

### Demo Script

1. **Open SQL Analytics Endpoint**
   - From Lakehouse, click **SQL analytics endpoint** in top-right
   - Or find it in the workspace item list

2. **Explore the auto-generated schema**
   - Show the schema browser
   - Tables are automatically exposed
   - Point out data types

3. **Write T-SQL queries**
   ```sql
   -- Simple select
   SELECT TOP 100 * FROM Products;
   
   -- Aggregation
   SELECT 
       Category,
       COUNT(*) as ProductCount,
       AVG(Price) as AvgPrice
   FROM Products
   GROUP BY Category;
   
   -- Join (if multiple tables)
   SELECT 
       p.ProductName,
       SUM(s.Amount) as TotalSales
   FROM Products p
   JOIN Sales s ON p.ProductID = s.ProductID
   GROUP BY p.ProductName
   ORDER BY TotalSales DESC;
   ```

4. **Compare to Power BI experience**
   - "This is the same T-SQL you'd write for SQL Server"
   - "But the data lives in your Lakehouse"

### Key Points to Highlight
- Familiar T-SQL syntax
- Read-only (can't INSERT/UPDATE here)
- Great for ad-hoc exploration
- Can connect Power BI to this endpoint

---

## Demo 4: Compare to Traditional Power BI

### Setup Required
- Power BI Desktop
- Same sample data

### Demo Script

1. **Traditional approach (Power BI Desktop)**
   - Open Power BI Desktop
   - Get Data → CSV
   - Import the same Products.csv
   - Show it loads into the model
   - "The data is now inside the PBIX file"

2. **Fabric approach**
   - Show Lakehouse with same data
   - Create semantic model from Lakehouse
   - "The data stays in the Lakehouse"
   - "Model just references it"

3. **Discussion**
   - "Where should data live?"
   - "What happens when data grows?"
   - "What about sharing across models?"

### Key Points to Highlight
- Traditional: Data embedded in each model
- Fabric: Data centralized, models reference it
- Centralized = single source of truth
