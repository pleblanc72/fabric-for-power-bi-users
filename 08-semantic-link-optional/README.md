# Section 8: Semantic Link *(Optional)*

**Bridging Semantic Models and Python Notebooks**

---

| [← Previous: Copilot](../07-copilot/README.md) | [🏠 Home](../README.md) | |
|:--|:--:|--:|

---

## Workshop Sections

| # | Section | Duration | |
|---|---------|----------|--|
| 01 | [Strategic Context](../01-strategic-context/README.md) | 45 min | |
| 02 | [CI/CD & Git Integration](../02-cicd-git-integration/README.md) | 45 min | |
| 03 | [Data Centralization](../03-data-centralization/README.md) | 60 min | |
| 04 | [Dataflows & Pipelines](../04-dataflows-pipelines/README.md) | 60 min | |
| 05 | [Direct Lake](../05-direct-lake/README.md) | 45 min | |
| 06 | [Security](../06-security/README.md) | 40 min | |
| 07 | [Copilot](../07-copilot/README.md) | 45 min | |
| **08** | **Semantic Link** | **30 min** | ⬅️ You are here *(Optional)* |

---

## Overview

| | |
|---|---|
| **Duration** | 30 minutes |
| **Level** | Intermediate |
| **Prerequisites** | Semantic model from Section 5 (or any existing model); Basic Python helpful |
| **Hands-on** | Medium |

---

## Learning Objectives

By the end of this section, you will be able to:

- ✅ Explain what Semantic Link is and why it matters
- ✅ Read data from a semantic model in a Fabric notebook
- ✅ Execute DAX queries from Python and get pandas DataFrames
- ✅ Understand use cases for Semantic Link

---

## Topics Covered

### 1. What is Semantic Link?
- A Python library for connecting notebooks to semantic models
- Bridges the gap between BI and data science
- Uses your existing semantic model as a data source
- Preserves business logic (measures, relationships)

### 2. Why This Matters for Power BI Users
- You've invested in building semantic models
- Data scientists often rebuild the same logic in Python
- Semantic Link = single source of truth
- Governance: Use the approved model, not raw data

### 3. Reading Semantic Models from Notebooks
- `import sempy.fabric as fabric`
- `fabric.read_table()` - Read a table
- `fabric.evaluate_dax()` - Run DAX, get DataFrame
- `fabric.list_datasets()` - Discover available models

### 4. Using DAX from Python
```python
import sempy.fabric as fabric

# Execute DAX query
df = fabric.evaluate_dax(
    dataset="Sales Model",
    dax_string="""
        EVALUATE
        SUMMARIZECOLUMNS(
            'Date'[Year],
            'Product'[Category],
            "Total Sales", [Total Sales]
        )
    """
)

# Now you have a pandas DataFrame!
df.head()
```

### 5. Use Cases
- **Data Science on BI data**: Train ML models using curated semantic model data
- **Advanced analytics**: Statistics, forecasting beyond DAX capabilities
- **Data validation**: Compare model results to source systems
- **Automated reporting**: Generate reports programmatically
- **What-if analysis**: Parameterized DAX from Python

---

## Demo Ideas

### Demo 1: Connect to Semantic Model from Notebook
- Create a new notebook
- Import the sempy library
- List available semantic models
- Read a table into a DataFrame

### Demo 2: Run DAX Query, Get DataFrame
- Write a DAX query with measures
- Execute via `evaluate_dax()`
- Show the resulting DataFrame
- Do some pandas operations

### Demo 3: Simple ML/Analysis Example *(optional)*
- Use Semantic Link to get sales data
- Simple trend analysis or forecasting
- Show how measures are honored

---

## Lab Exercise

**Duration:** 15 minutes

### Hands-on: Your First Semantic Link Notebook

1. Create a new Fabric notebook
2. Connect to your semantic model from Section 5
3. List the tables in the model
4. Read the Products table into a DataFrame
5. Write a DAX query that uses a measure
6. Execute the DAX and explore the results

See [lab/semantic-link-basics.md](./lab/semantic-link-basics.md) for step-by-step instructions.

---

## Key Takeaways

1. **Semantic Link bridges BI and data science** - No more duplicating logic
2. **Your measures work in Python** - DAX executes server-side, results come back
3. **Governance win** - Data scientists use the approved semantic model
4. **It's a Python library** - Familiar for anyone who uses pandas

---

## Code Snippets

### List Available Semantic Models
```python
import sempy.fabric as fabric

# List all semantic models you have access to
models = fabric.list_datasets()
display(models)
```

### Read a Table
```python
# Read entire table as DataFrame
customers_df = fabric.read_table(
    dataset="Sales Model",
    table="Customers"
)
```

### Execute DAX Query
```python
# Run DAX and get results
results = fabric.evaluate_dax(
    dataset="Sales Model",
    dax_string="""
        EVALUATE
        CALCULATETABLE(
            TOPN(10, 'Customers', [Total Sales], DESC),
            'Date'[Year] = 2025
        )
    """
)
```

### Evaluate a Single Measure
```python
# Get a single measure value
total = fabric.evaluate_measure(
    dataset="Sales Model",
    measure="Total Sales",
    filters={"Date[Year]": 2025}
)
```

---

## Power BI User Perspective

| What you know (Power BI) | What's new (Semantic Link) |
|--------------------------|----------------------------|
| Write DAX in measures | Execute DAX from Python |
| View data in tables | Read tables into DataFrames |
| Export to Excel for analysis | Analyze directly in notebook |
| Separate BI and data science | Unified on same semantic model |

---

## Common Gotchas

⚠️ **Model must be in Fabric workspace** - Semantic Link works with Fabric-hosted models

⚠️ **Permissions matter** - You need access to the semantic model

⚠️ **Large results = slow** - Use filters, TOPN, or aggregations in DAX

⚠️ **Not all DAX functions return tabular results** - Some need EVALUATE wrapper

---

## Resources

- [Semantic Link Overview](https://learn.microsoft.com/fabric/data-science/semantic-link-overview)
- [SemPy Python Library](https://learn.microsoft.com/python/api/sempy/)
- [Tutorial: Semantic Link](https://learn.microsoft.com/fabric/data-science/tutorial-power-bi-semantic-link)

---

## Standalone Usage

This section appeals to organizations with both BI and data science teams who want to collaborate better.

**Standalone prerequisites:**
- Fabric workspace with semantic model
- Basic Python/pandas familiarity
- Understanding of DAX concepts

**Standalone title suggestion:** "Semantic Link: Unifying Power BI and Python in Microsoft Fabric"

---

## Folder Contents

```
08-semantic-link-optional/
├── README.md           # This file
├── slides/             # Presentation slides
├── demos/              # Demo notebooks
└── lab/                # Hands-on Semantic Link exercise
```

---

| [← Previous: Copilot](../07-copilot/README.md) | [🏠 Home](../README.md) | |
|:--|:--:|--:|
