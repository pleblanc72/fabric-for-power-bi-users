# Workshop Scenario: Regional Retail Analytics

## The Setting

You are the **Senior BI Analyst** at a regional retail company with 12 store locations across the Pacific Northwest. The company sells outdoor and sporting goods - everything from hiking gear to fitness equipment.

**Your responsibilities:**
- Maintain sales dashboards for leadership
- Build reports for store managers
- Support the finance team with margin analysis
- Answer "urgent" ad-hoc requests from executives

**Your team:**
- You (the analyst building reports)
- A junior analyst who helps with data prep
- Store managers who consume reports
- VP of Sales who requests changes... often on Friday afternoons

---

## The Data

The company has been tracking:
- **3 years** of sales history (2023-2025)
- **12 stores** across 4 states (WA, OR, ID, MT)
- **~65 products** across 8 categories
- **~100,000 transactions** (configurable in notebook)

---

## Current Pain Points (Pre-Fabric)

1. **No version control** - "What did I change last week?"
2. **1GB model limit** - Sales history keeps growing
3. **Refresh failures** - Gateway timeouts with large datasets
4. **No collaboration workflow** - Email-based "can you check this?"
5. **No audit trail** - "Who changed the margin calculation?"

---

## Workshop Journey

Throughout this workshop, you'll solve each of these pain points:

| Section | Pain Point Solved |
|---------|------------------|
| 02 - Git Integration | Version control, audit trail, collaboration |
| 03 - Lakehouses | Centralized data, scalable storage |
| 04 - Dataflows & Pipelines | Reliable data refresh |
| 05 - Direct Lake | Break the 1GB limit |
| 06 - Security | Data protection, row & column security |
| 07 - Copilot | AI-assisted development |

---

## Key Metrics You'll Build

### Executive Dashboard
- Total Revenue
- Gross Margin %
- Total Transactions
- Revenue by Region (bar chart)
- Revenue Trend by Month (line chart)
- Store Performance table (StoreName, Revenue, Margin %)

### Store Manager View
- Store Revenue vs Target
- Product Category Mix
- Customer Traffic Trends

### Finance Deep Dive
- Margin by Category
- Cost Analysis (Budgeted vs Actual)
- Variance Analysis

---

## Realistic Scenarios Used in Demos

### Section 02: "The Friday Afternoon Disaster"
The VP asks for a "quick" % of Company Revenue measure before the board meeting. You rush it, forget the ALL() function for filter context, and need to identify and fix the error using Git history.

### Section 03: "The Budget vs. Reality Problem"
Finance discovers your margins are based on BUDGETED costs from January, but the supplier just sent ACTUAL invoice data showing 15% variance. You need to centralize this external cost data in OneLake.

### Section 04: "The Weekly Variance Report"
The CFO wants automated weekly variance analysis comparing budgeted vs. actual costs, with alerts when variance exceeds thresholds. Build a Dataflow Gen2 pipeline with notifications.

### Section 05: "The Scale Challenge"
Your 3-year sales history breaks the 1GB limit. Direct Lake lets you query it all without import.

### Section 06: "Who Can See Our ACTUAL Costs?"
Actual supplier costs are confidential—executives only. Budgeted costs are fine for everyone. Use OneLake Security with Column-Level Security to protect sensitive cost data across all access points.

### Section 07: "The Copilot Assist"
Use AI to write DAX, document measures, and build reports faster.

---

## Naming Conventions

To keep artifacts professional and reusable:

| Artifact Type | Naming Pattern | Example |
|--------------|----------------|---------|
| Workspace | `Workshop-[Purpose]` | `Workshop-Dev`, `Workshop-Prod` |
| Semantic Model | `Sales Analytics` | (no company name) |
| Report | `[Audience] Dashboard` | `Executive Dashboard` |
| Lakehouse | `SalesLakehouse` | |
| Pipeline | `[Source]_to_[Dest]` | `Raw_to_Bronze` |

---

## File Inventory

### Data Files (00-shared/data/)
```
Products.csv          - 65 products (outdoor/sporting goods)
Stores.csv            - 12 store locations (Pacific Northwest)
Calendar.csv          - Date dimension 2023-2025
Targets.csv           - Monthly targets by store
SupplierCosts.csv     - Actual supplier invoice costs
generate_sales.py     - Script to generate sales transactions
```

### Semantic Model Definition (00-shared/models/)
```
Sales Analytics.SemanticModel/
├── model.tmdl
├── relationships.tmdl
├── DAX-Query-Script.dax
└── tables/
    ├── Sales.tmdl
    ├── Products.tmdl
    ├── Stores.tmdl
    ├── Calendar.tmdl
    ├── Targets.tmdl
    ├── SupplierCosts.tmdl
    └── _Measures.tmdl
```

### Notebooks (00-shared/notebooks/)
```
01-Generate-Sales-Data.ipynb  - Creates Sales table in Lakehouse
```
