# Lab: Direct Lake Semantic Model

**Duration:** 25 minutes

---

## Objectives

By the end of this lab, you will have:
- Created a Direct Lake semantic model
- Added relationships and measures
- Verified no refresh is needed
- Built a simple report

---

## Prerequisites

- [ ] Lakehouse with data (from Section 3-4)
- [ ] At least 2-3 tables for relationships

---

## Part 1: Create the Semantic Model (5 minutes)

### Step 1: Open Your Lakehouse

1. Go to your Fabric workspace
2. Open `sales_lakehouse`
3. Verify you have tables (Products, Sales, Customers, etc.)

### Step 2: Create Semantic Model

1. In the Lakehouse toolbar, click **New semantic model**
2. Name: `Sales Analytics Model`
3. Select tables to include:
   - ✅ Products
   - ✅ Sales
   - ✅ Customers
   - ✅ (any other relevant tables)
4. Click **Confirm**

### Step 3: Verify Direct Lake Mode

1. The model opens in the web modeling experience
2. Note: There's no "Import/DirectQuery" toggle
3. This IS Direct Lake mode - it's automatic!

---

## Part 2: Build the Model (10 minutes)

### Step 4: Create Relationships

1. In the model diagram, identify related tables
2. Drag from one column to another to create relationships

   **Common relationships:**
   - Sales[ProductID] → Products[ProductID] (Many to One)
   - Sales[CustomerID] → Customers[CustomerID] (Many to One)

3. For each relationship, verify:
   - Cardinality is correct
   - Cross-filter direction (usually Single)

### Step 5: Add Measures

Select the Sales table, then add measures:

**Measure 1: Total Sales**
```dax
Total Sales = SUM(Sales[Amount])
```

**Measure 2: Total Quantity**
```dax
Total Quantity = SUM(Sales[Quantity])
```

**Measure 3: Average Sale**
```dax
Average Sale = AVERAGE(Sales[Amount])
```

**Measure 4: Customer Count**
```dax
Customer Count = DISTINCTCOUNT(Sales[CustomerID])
```

### Step 6: Organize Measures

1. Select all your measures
2. Create a display folder: `KPIs`
3. Or create a Measures table to keep them organized

---

## Part 3: Test the Model (10 minutes)

### Step 7: Create a Quick Report

1. From the model, click **New report**
2. The report editor opens

3. Create these visuals:

   **Visual 1: Card**
   - Value: Total Sales

   **Visual 2: Bar Chart**
   - Axis: Products[Category] (or ProductName)
   - Values: Total Sales

   **Visual 3: Table**
   - Columns: Customer Name, Total Sales, Total Quantity

### Step 8: Verify "Live" Data

1. Look for any "Last refreshed" indicator - there isn't one!
2. The data is always current with the Lakehouse
3. Add new data to Lakehouse → It appears in reports (after frame refresh)

### Step 9: The Magic Moment - Live Data Update

This is the key difference from Import mode. Let's prove it works!

**Part A: Note the Current Value**
1. Look at your **Total Sales** card
2. Write down the current value: `$____________`

**Part B: Modify Data in the Lakehouse**
1. Open a new browser tab
2. Go to your Lakehouse → **SQL analytics endpoint**
3. Run this INSERT statement (adjust table/column names to match yours):
   ```sql
   INSERT INTO Sales (ProductID, CustomerID, Quantity, Amount, SaleDate)
   VALUES (1, 1, 100, 9999.00, GETDATE());
   ```
   
   > ⚠️ If INSERT isn't supported, use the Lakehouse UI to upload a small CSV with one new row.

**Part C: See the Change Instantly**
1. Go back to your report tab
2. Click **Refresh visuals** (or press Ctrl+F5)
3. Look at the **Total Sales** card
4. **The value changed!** No model refresh needed.

**What just happened?**
- In Import mode: You'd need to trigger a dataset refresh (minutes)
- In Direct Lake: The report reads directly from OneLake (seconds)

> 🎉 **This is Direct Lake's superpower:** Fresh data without refresh jobs.

### Step 10: Check Model Properties

1. Go back to the semantic model in the workspace
2. Click **Settings** (or right-click → Settings)
3. Note: No scheduled refresh configuration!
4. The model reads directly from Lakehouse

---

## Bonus: Performance Test

### Use Performance Analyzer

1. In the report, enable **Performance Analyzer** (View menu)
2. Click **Start recording**
3. Refresh visuals or interact with the report
4. Click **Stop**
5. Examine the timings:
   - Look for "DAX query" times
   - Note: First query may be slower (cache warming)

### Run Again

1. Click **Start recording** again
2. Refresh the same visuals
3. Compare times - should be faster (cached)

---

## Reflection Questions

1. How is creating this model different from creating one in Power BI Desktop?
2. What happens if the underlying Lakehouse data changes?
3. When would you still choose Import mode over Direct Lake?

---

## Key Observations

Note these differences from traditional modeling:

| Traditional (Import) | Direct Lake |
|---------------------|-------------|
| Schedule refresh | No refresh needed |
| Data copied into model | Data stays in Lakehouse |
| Model file grows with data | Model file stays small |
| Publish to refresh | Publish to update model metadata only |

---

## Troubleshooting

**"Can't create semantic model"**
- Ensure Lakehouse has Delta tables (not just Files)
- Check you have permissions on the Lakehouse

**"Relationships won't create"**
- Ensure columns have matching data types
- Check for null values in key columns

**"Measures show errors"**
- Verify column names match your tables
- Check DAX syntax (quotes, brackets)

**"Report visuals are empty"**
- Ensure tables have data
- Check relationships are correct
- Verify measure calculations

---

## Clean Up

Keep this model! You'll use it in:
- Section 6: Semantic Link
- Section 7: Copilot

The model is small (just metadata) so storage isn't a concern.
