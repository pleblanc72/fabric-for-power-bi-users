# Section 3: Data Centralization

**OneLake, Lakehouse & Warehouse**

---

## Overview

| | |
|---|---|
| **Duration** | 60 minutes |
| **Level** | Intermediate |
| **Prerequisites** | Fabric workspace access |
| **Hands-on** | Heavy |

---

## Learning Objectives

By the end of this section, you will be able to:

- ✅ Explain OneLake as the unified storage layer
- ✅ Create a Lakehouse and load data
- ✅ Understand when to use Lakehouse vs. Warehouse
- ✅ Use Shortcuts to connect external data without copying
- ✅ Query data using the SQL Analytics Endpoint
- ✅ Understand Delta Lake format fundamentals

---

## Topics Covered

### 1. OneLake: The Foundation
- What is OneLake?
- "One copy of data" philosophy
- How it differs from traditional storage
- OneLake File Explorer

### 2. Lakehouse vs. Warehouse
- When to use a Lakehouse
- When to use a Warehouse
- Can you use both? (Yes!)
- Decision matrix

| Feature | Lakehouse | Warehouse |
|---------|-----------|-----------|
| Best for | Data engineering, ML | Traditional BI, SQL users |
| Query language | Spark + SQL | T-SQL |
| Schema enforcement | Schema-on-read | Schema-on-write |
| Data format | Delta Lake (Parquet) | Delta Lake (Parquet) |

### 3. Shortcuts
- What are Shortcuts?
- Connecting to ADLS Gen2
- Connecting to S3
- Connecting to other Fabric items
- No data movement = no data duplication costs

### 4. Delta Lake Fundamentals
- What is Delta Lake?
- Parquet + transaction log
- Time travel capabilities
- Why this matters for Power BI users

### 5. SQL Analytics Endpoint
- Every Lakehouse gets one automatically
- Query Lakehouse data with T-SQL
- Familiar for Power BI/SQL users
- Limitations vs. full Warehouse

---

## Demo Ideas

### Demo 1: Create a Lakehouse
- Create new Lakehouse
- Explore the three sections (Tables, Files, Shortcuts)
- Upload a CSV file
- Convert to Delta table

### Demo 2: Add Data via Shortcut
- Create shortcut to external storage (or another Lakehouse)
- Show that data isn't copied
- Query across shortcut and local data

### Demo 3: Query with SQL Endpoint
- Open the SQL Analytics Endpoint
- Write T-SQL queries
- Show the auto-generated schema
- Compare to traditional Power BI data sources

### Demo 4: Compare to Traditional Power BI
- Import same data into Power BI Desktop
- Show file in Lakehouse
- Discuss: "Where should this data live?"

---

## Lab Exercise

**Duration:** 25 minutes

### Hands-on: Build Your First Lakehouse

1. Create a Lakehouse named `sales_lakehouse`
2. Upload sample CSV files
3. Convert CSVs to Delta tables
4. Create a shortcut (to provided external location)
5. Query data using SQL Analytics Endpoint
6. Write a query joining local and shortcut data

See [lab/lakehouse-basics.md](./lab/lakehouse-basics.md) for step-by-step instructions.

---

## Key Takeaways

1. **OneLake is not optional** - It's the foundation of Fabric
2. **Lakehouse ≠ just storage** - It's storage + compute + SQL
3. **Shortcuts are powerful** - Connect, don't copy
4. **Delta Lake enables time travel** - And efficient incremental processing
5. **SQL Endpoint bridges the gap** - Familiar for Power BI users

---

## Power BI User Perspective

| What you know (Power BI) | What's new (Fabric) |
|--------------------------|---------------------|
| Import data into model | Store data in Lakehouse, reference from model |
| DirectQuery to SQL Server | DirectQuery to SQL Endpoint (or Direct Lake) |
| Dataflows output to CDM | Dataflows Gen2 output to Lakehouse tables |
| Dataset refresh moves data | Data already in OneLake, model reads it |

---

## Common Gotchas

⚠️ **Files ≠ Tables** - Files in the Files section aren't queryable until converted to tables

⚠️ **SQL Endpoint is read-only** - You can't INSERT/UPDATE via SQL Endpoint

⚠️ **Shortcuts have latency** - External data changes may take time to reflect

⚠️ **Delta Lake requires Parquet** - CSVs need conversion

---

## Resources

- [What is OneLake?](https://learn.microsoft.com/fabric/onelake/onelake-overview)
- [Lakehouse Overview](https://learn.microsoft.com/fabric/data-engineering/lakehouse-overview)
- [Warehouse Overview](https://learn.microsoft.com/fabric/data-warehouse/data-warehousing)
- [OneLake Shortcuts](https://learn.microsoft.com/fabric/onelake/onelake-shortcuts)

---

## Standalone Usage

This section is foundational for understanding Fabric's data architecture. It can be delivered standalone for teams evaluating data platform options.

**Standalone prerequisites:**
- Fabric workspace access
- Basic SQL knowledge

**Standalone title suggestion:** "OneLake, Lakehouses & Warehouses: Fabric's Data Foundation for Power BI Users"

---

## Folder Contents

```
03-data-centralization/
├── README.md           # This file
├── slides/             # Presentation slides
├── demos/              # Demo scripts and sample data
└── lab/                # Lakehouse creation exercise
```
