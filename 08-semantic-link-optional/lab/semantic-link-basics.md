# Lab: Your First Semantic Link Notebook

**Duration:** 15 minutes

---

## Objectives

By the end of this lab, you will have:
- Connected to a semantic model from a notebook
- Read table data into a pandas DataFrame
- Executed DAX queries from Python
- Performed basic data analysis

---

## Prerequisites

- [ ] Semantic model (from Section 5, or any existing model)
- [ ] Access to Fabric notebooks
- [ ] Basic Python familiarity helpful

---

## Part 1: Setup (3 minutes)

### Step 1: Create a New Notebook

1. In your workspace, click **+ New** → **Notebook**
2. Name: `Semantic Link Lab`
3. The notebook opens with an empty cell

### Step 2: Import the Library

In the first cell, type and run:

```python
# Import Semantic Link library
import sempy.fabric as fabric

print("Semantic Link imported successfully!")
```

**Run the cell** (Shift+Enter or click Play)

---

## Part 2: Explore Available Models (3 minutes)

### Step 3: List Semantic Models

Add a new cell and run:

```python
# List all semantic models you can access
datasets = fabric.list_datasets()
display(datasets)
```

**What you should see:**
- A table listing semantic models
- Your `Sales Analytics Model` should appear
- Note the exact name (you'll need it)

### Step 4: Note Your Model Name

Find your model in the list and note the exact name:
- Model name: `_______________________`

---

## Part 3: Read Table Data (4 minutes)

### Step 5: Read a Table

Add a new cell and run (replace with your model name):

```python
# Read Products table
products_df = fabric.read_table(
    dataset="Sales Analytics Model",  # ← Your model name
    table="Products"                   # ← A table in your model
)

# Show first 10 rows
display(products_df.head(10))
```

### Step 6: Explore the DataFrame

Add another cell:

```python
# Check the shape
print(f"Rows: {len(products_df)}")
print(f"Columns: {products_df.columns.tolist()}")

# Basic stats
display(products_df.describe())
```

**Key insight:** This is now a standard pandas DataFrame! All pandas operations work.

---

## Part 4: Execute DAX Queries (5 minutes)

### Step 7: Simple DAX Query

Run this cell (adjust table/column names to match your model):

```python
# Execute DAX query
results = fabric.evaluate_dax(
    dataset="Sales Analytics Model",
    dax_string="""
        EVALUATE
        TOPN(
            10,
            SUMMARIZECOLUMNS(
                'Products'[ProductName],
                "Total Sales", [Total Sales]
            ),
            [Total Sales], DESC
        )
    """
)

display(results)
```

### Step 8: DAX with Your Measures

Try using measures from your model:

```python
# Use your measures
summary = fabric.evaluate_dax(
    dataset="Sales Analytics Model",
    dax_string="""
        EVALUATE
        ROW(
            "Total Sales", [Total Sales],
            "Total Quantity", [Total Quantity],
            "Customer Count", [Customer Count]
        )
    """
)

display(summary)
```

### Step 9: Filtered DAX Query

Add filters to your query:

```python
# DAX with filter
category_sales = fabric.evaluate_dax(
    dataset="Sales Analytics Model",
    dax_string="""
        EVALUATE
        CALCULATETABLE(
            SUMMARIZECOLUMNS(
                'Products'[Category],
                "Sales", [Total Sales]
            )
        )
        ORDER BY [Sales] DESC
    """
)

display(category_sales)
```

---

## Bonus: Quick Visualization

If you have time, add a chart:

```python
import matplotlib.pyplot as plt

# Use results from previous query
plt.figure(figsize=(10, 5))
plt.barh(category_sales['Category'], category_sales['Sales'])
plt.xlabel('Total Sales')
plt.title('Sales by Category')
plt.tight_layout()
plt.show()
```

---

## Reflection Questions

1. How is this different from querying the Lakehouse directly?
2. What's the advantage of using DAX measures in Python?
3. When would you use Semantic Link vs. just reading from Lakehouse?

---

## Key Takeaways

| Aspect | Benefit |
|--------|---------|
| **Governance** | Uses the approved semantic model |
| **Measures** | Reuse existing DAX calculations |
| **Flexibility** | Full Python/pandas ecosystem |
| **Simplicity** | No connection strings or credentials |

---

## Troubleshooting

**"sempy not found"**
- Ensure you're in a Fabric notebook (not local Jupyter)
- Try: `%pip install semantic-link` (shouldn't be needed)

**"Dataset not found"**
- Check exact model name (case-sensitive)
- Ensure you have access to the model
- Try `fabric.list_datasets()` to see available models

**"Table not found"**
- Check exact table name
- Table must be included in the semantic model

**"DAX error"**
- Verify column names with brackets: `'Table'[Column]`
- Check measure names match your model
- Test DAX in Power BI first

---

## Next Steps

You now know how to:
- ✅ Connect notebooks to semantic models
- ✅ Read tables as DataFrames
- ✅ Execute DAX queries

**Advanced possibilities:**
- Train ML models on semantic model data
- Automate reports with scheduled notebooks
- Build custom analytics dashboards
