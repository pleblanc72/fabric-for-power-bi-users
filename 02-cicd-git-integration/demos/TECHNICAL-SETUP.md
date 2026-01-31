# Technical Setup: Section 02 Demo Environment

This guide provides step-by-step instructions to build the Power BI Semantic Model and Report used in the CI/CD & Git Integration demo.

---

## Overview

| Component | Name | Purpose |
|-----------|------|---------|
| Lakehouse | `SalesLakehouse` | Data storage (Delta tables) |
| Semantic Model | `Sales Analytics` | Data model for reporting |
| Report | `Executive Dashboard` | Sample report for demo |
| Workspace | `Workshop-Dev` | Development workspace (Git-connected) |

---

## Prerequisites

Before starting, ensure you have:

- [ ] Microsoft Fabric capacity (trial or paid)
- [ ] Workspace admin permissions
- [ ] Sample data loaded (see Section 00-shared)
- [ ] GitHub account with PAT (see main demo-design.md)

---

## Part 1: Data Setup (Lakehouse)

### Step 1.1: Create the Lakehouse

1. Go to [app.fabric.microsoft.com](https://app.fabric.microsoft.com)
2. Open or create workspace: `Workshop-Dev`
3. Click **+ New** → **Lakehouse**
4. Name: `SalesLakehouse`
5. Click **Create**

### Step 1.2: Load Sample Data

**Option A: Use the Notebook (Recommended)**

1. In your workspace, click **+ New** → **Import notebook**
2. Upload: `00-shared/notebooks/01-Generate-Sales-Data.ipynb`
3. Open the notebook and attach to a Spark environment
4. Run all cells
5. Verify tables appear in the Lakehouse: `Products`, `Stores`, `Calendar`, `Targets`, `Sales`

**Option B: Upload CSV Files Manually**

1. Download CSV files from `00-shared/data/`:
   - `Products.csv`
   - `Stores.csv`
   - `Calendar.csv`
   - `Targets.csv`
   - (Sales will be generated or you'll need a sample)
2. In the Lakehouse, click **Get data** → **Upload files**
3. Upload each CSV
4. Right-click each file → **Load to table**
5. Verify all 5 tables appear in the Tables section

### Step 1.3: Verify Data

Run this SQL in the Lakehouse SQL endpoint to verify:

```sql
-- Check row counts
SELECT 'Products' as TableName, COUNT(*) as RowCount FROM Products
UNION ALL
SELECT 'Stores', COUNT(*) FROM Stores
UNION ALL
SELECT 'Calendar', COUNT(*) FROM Calendar
UNION ALL
SELECT 'Targets', COUNT(*) FROM Targets
UNION ALL
SELECT 'Sales', COUNT(*) FROM Sales;
```

**Expected counts (approximate):**
| Table | Rows |
|-------|------|
| Products | 50-100 |
| Stores | 12 |
| Calendar | 1,095 (3 years) |
| Targets | 144 (12 stores × 12 months) |
| Sales | 50,000+ |

---

## Part 2: Semantic Model Setup

### Step 2.1: Create the Semantic Model

1. In your workspace, click **+ New** → **Semantic model**
2. Select **SalesLakehouse** as the data source
3. Choose tables to include:
   - ✅ Sales
   - ✅ Products
   - ✅ Stores
   - ✅ Calendar
   - ✅ Targets
4. Click **Confirm**
5. Name the model: `Sales Analytics`

### Step 2.2: Configure Relationships

The model should auto-detect some relationships. Verify or create these:

| From Table | From Column | To Table | To Column | Cardinality |
|------------|-------------|----------|-----------|-------------|
| Sales | TransactionDate | Calendar | Date | Many-to-One |
| Sales | StoreID | Stores | StoreID | Many-to-One |
| Sales | ProductID | Products | ProductID | Many-to-One |
| Targets | StoreID | Stores | StoreID | Many-to-One |

**To create/verify relationships:**

1. Open the semantic model in the Fabric portal
2. Go to the **Model view** (diagram icon)
3. Drag from foreign key to primary key, or right-click → **Manage relationships**
4. Ensure cross-filter direction is **Single** for all relationships

### Step 2.3: Create Measures

Create a measures table with the following DAX measures. These are intentionally simple for the demo—the focus is on Git workflow, not complex DAX.

**Create the Measures Table:**

1. In Model view, click **New table** (or use an existing table)
2. For a dedicated measures table, use: `_Measures = ROW("Placeholder", 1)`
3. Mark the table as hidden (right-click → Hide)

**Core Measures (Required for Demo):**

```dax
// Total Revenue
Total Revenue = 
SUM(Sales[TotalAmount])

// Total Quantity
Total Quantity = 
SUM(Sales[Quantity])

// Total Cost
Total Cost = 
SUM(Sales[TotalCost])

// Gross Profit
Gross Profit = 
[Total Revenue] - [Total Cost]

// Gross Margin %
Gross Margin % = 
DIVIDE([Gross Profit], [Total Revenue])
```

**Additional Measures (Helpful for Demo):**

```dax
// Total Transactions
Total Transactions = 
COUNTROWS(Sales)

// Avg Transaction Value
Avg Transaction Value = 
DIVIDE([Total Revenue], [Total Transactions])
```

**Format the Measures:**

| Measure | Format |
|---------|--------|
| Total Revenue | Currency ($#,0.00) |
| Total Quantity | Whole Number (#,0) |
| Total Cost | Currency ($#,0.00) |
| Gross Profit | Currency ($#,0.00) |
| Gross Margin % | Percentage (0.0%) |
| Total Transactions | Whole Number (#,0) |
| Avg Transaction Value | Currency ($#,0.00) |

### Step 2.4: Verify the Model

Before proceeding, test your model:

1. Open the semantic model
2. Click **New report** (temporary, just for testing)
3. Add a **Card** visual with `Total Revenue`
4. Add a **Table** visual with `Stores[StoreName]` and `Total Revenue`
5. Verify numbers appear and filter correctly
6. Close without saving (or save if desired)

---

## Part 3: Report Setup

### Step 3.1: Create the Executive Dashboard

1. In your workspace, click **+ New** → **Report** → **Pick a published dataset**
2. Select **Sales Analytics** semantic model
3. Name the report: `Executive Dashboard`

### Step 3.2: Build the Report Layout

Create a simple but professional-looking dashboard. This report will be modified during the demo to show Git tracking.

**Page 1: Executive Summary**

| Visual | Position | Fields |
|--------|----------|--------|
| **Card** - Total Revenue | Top left | Total Revenue |
| **Card** - Gross Margin % | Top center | Gross Margin % |
| **Card** - Total Transactions | Top right | Total Transactions |
| **Clustered Bar Chart** | Middle left | Axis: Stores[Region], Values: Total Revenue |
| **Line Chart** | Middle right | X-Axis: Calendar[Month], Values: Total Revenue |
| **Table** | Bottom | Stores[StoreName], Total Revenue, Gross Margin % |

**Styling Guidelines:**
- Use a clean theme (try "Executive" or similar)
- Add a title: "Contoso Sales Dashboard"
- Add a text box with current date placeholder
- Keep it simple—this report exists to demo Git, not win design awards

### Step 3.3: Report Layout Diagram

```
┌─────────────────────────────────────────────────────────────────────┐
│                     CONTOSO SALES DASHBOARD                         │
├──────────────────┬──────────────────┬──────────────────────────────┤
│   TOTAL REVENUE  │   GROSS MARGIN   │   TOTAL TRANSACTIONS         │
│     $2.4M        │      32.5%       │        52,847                 │
├──────────────────┴──────────────────┴──────────────────────────────┤
│                                                                     │
│  ┌─────────────────────────┐    ┌─────────────────────────────┐   │
│  │  REVENUE BY REGION      │    │  REVENUE TREND               │   │
│  │  █████████ Pacific NW   │    │         ╱╲                   │   │
│  │  ██████ Mountain        │    │    ╱╲  ╱  ╲                  │   │
│  │  ████ Southwest         │    │   ╱  ╲╱    ╲                 │   │
│  └─────────────────────────┘    └─────────────────────────────┘   │
│                                                                     │
│  ┌─────────────────────────────────────────────────────────────┐   │
│  │ STORE PERFORMANCE                                            │   │
│  │ Store Name          │ Revenue    │ Margin %                  │   │
│  │ Seattle Downtown    │ $425,000   │ 34.2%                     │   │
│  │ Portland Central    │ $380,000   │ 31.8%                     │   │
│  │ ...                 │ ...        │ ...                       │   │
│  └─────────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────────┘
```

### Step 3.4: Save the Report

1. Click **File** → **Save**
2. Confirm name: `Executive Dashboard`
3. Save to: `Workshop-Dev` workspace

---

## Part 4: Pre-Demo Verification

Before the workshop, run through this checklist:

### Workspace State Checklist

- [ ] Workspace `Workshop-Dev` exists and has Fabric capacity
- [ ] Lakehouse `SalesLakehouse` exists with 5 tables
- [ ] Semantic Model `Sales Analytics` exists with:
  - [ ] 5 tables connected
  - [ ] 4+ relationships configured
  - [ ] 5-7 measures created
- [ ] Report `Executive Dashboard` exists with:
  - [ ] At least 3 KPI cards
  - [ ] At least 1 chart
  - [ ] At least 1 table
- [ ] Git integration is **NOT** connected yet (demo starts by connecting)

### Quick Test

1. Open `Executive Dashboard` report
2. Verify all visuals load with data
3. Click on a region in the bar chart—verify cross-filtering works
4. Close the report

---

## Part 5: Demo-Ready State

When ready for the demo, your workspace should look like this:

```
Workshop-Dev (Workspace)
├── SalesLakehouse (Lakehouse)
│   └── Tables
│       ├── Calendar
│       ├── Products
│       ├── Sales
│       ├── Stores
│       └── Targets
├── Sales Analytics (Semantic Model)
│   └── [Not Git-connected yet]
└── Executive Dashboard (Report)
    └── [Not Git-connected yet]
```

**GitHub Repository:** Empty (no files yet)

**The demo will:**
1. Connect the workspace to Git (showing initial sync)
2. Show the TMDL files created in GitHub
3. Make a change (add a measure)
4. Commit and show the diff
5. Break something and recover using Git

---

## Appendix: TMDL Reference

After Git sync, your semantic model will appear in GitHub as TMDL files. Here's what to expect:

```
Sales Analytics.SemanticModel/
├── model.tmdl           # Model metadata
├── relationships.tmdl   # All relationships
└── tables/
    ├── _Measures.tmdl   # Measures table
    ├── Calendar.tmdl    # Calendar dimension
    ├── Products.tmdl    # Products dimension
    ├── Sales.tmdl       # Sales fact table
    ├── Stores.tmdl      # Stores dimension
    └── Targets.tmdl     # Targets table
```

**Sample TMDL (what participants will see in GitHub):**

```plaintext
/// Sample measure in TMDL format
measure 'Total Revenue' =
    SUM(Sales[TotalAmount])
    formatString: "$#,0.00"
    displayFolder: Revenue
```

This human-readable format is what makes code review possible!

---

## Troubleshooting

**"Semantic model won't connect to Lakehouse"**
- Ensure the Lakehouse SQL endpoint is available
- Check that tables exist in the Tables section (not just Files)
- Refresh the data source list

**"Relationships aren't auto-detected"**
- Column names must match exactly (StoreID = StoreID)
- Data types must match
- Create relationships manually if needed

**"Measures show errors"**
- Check that column names in DAX match your actual table columns
- Verify the Sales table has `TotalAmount` and `TotalCost` columns

**"Report visuals are blank"**
- Ensure the semantic model is published (not just in edit mode)
- Check that the report is connected to the correct semantic model
- Verify there's data in the underlying tables

---

## Time Estimate

| Task | Duration |
|------|----------|
| Create Lakehouse + Load Data | 10-15 min |
| Create Semantic Model | 10-15 min |
| Configure Relationships + Measures | 10-15 min |
| Create Report | 10-15 min |
| Verification | 5 min |
| **Total** | **45-60 min** |

> 💡 **Tip:** Do this setup at least a day before the workshop. This gives you time to troubleshoot any issues and become familiar with the model.
