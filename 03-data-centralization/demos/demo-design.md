# Section 03: Data Centralization - Demo Design

[← Back to Section 3: Data Centralization](../README.md)

## The Story: "The Budget vs. Reality Problem"

**Continuing from Section 02:** The Friday disaster is behind you. Git saved you from the filter context mistake. But now the VP has a different problem...

**Scenario:** The VP pulls you aside after the board meeting: *"Finance just flagged something. Our reported margins are based on BUDGETED costs from January. But the supplier just sent their actual invoice data for Q3—and some products cost 15% more than we budgeted. Our margins might be overstated. Can you get the REAL supplier costs into our analysis?"*

**The challenge:** 
- You have budgeted costs in your Products table (planned at start of year)
- The supplier just sent ACTUAL invoiced costs (reality)
- This is SUPPLIER data—costs, lead times, minimum orders—not in our system
- Where does this external data go? 
- How do you make it available for analysis alongside your sales data?

---

## The Narrative Arc

| Act | What Happens | Emotion | Lesson |
|-----|--------------|---------|--------|
| 1 | Finance flags budget vs. actual variance | Recognition | "This is a real business problem" |
| 2 | Discover OneLake & Lakehouse | Enlightenment | "One place for all data" |
| 3 | Upload actual supplier costs, see it become a table | Satisfaction | "That was easy" |
| 4 | Create a shortcut to shared data | Revelation | "No copying needed!" |
| 5 | Query with SQL endpoint | Comfort | "I already know this!" |
| 6 | Add to semantic model, see the gap | Setup | "I need to combine this with Products..." |

---

## Characters (Continuing from Section 02)

- **Alex** - The report developer (you, demoing)
- **The VP** - Concerned about overstated margins
- **Finance** - Flagged the budget vs. actual variance
- **The Supplier** - Sends a CSV with ACTUAL invoiced costs (external data source)
- **The Data Engineering Team** - Has company-wide data in another Lakehouse (we'll shortcut to it)

---

## Pre-Demo Setup Checklist

### Already Done (from Section 02)
- [x] Lakehouse: `SalesLakehouse` with generated data
- [x] Semantic model: "Sales Analytics"
- [x] Tables: Products, Stores, Calendar, Targets, Sales

### New for This Section
- [ ] Create CSV file: `SupplierCosts.csv` (already in 00-shared/data/)
- [ ] **Azure Blob Storage setup for Shortcut Transformations demo:**
  - [ ] Create storage account with anonymous public read access
  - [ ] Upload `SupplierCosts.csv` to a container
  - [ ] Note the blob URL for demo
- [ ] (Optional) Second Lakehouse: `CompanyDataLakehouse` to demo internal shortcuts
- [ ] OneLake File Explorer installed (for Windows demo)

### Browser Tabs Ready
1. Fabric portal (workspace)
2. Azure portal (to show the blob exists)
3. (Optional) OneLake File Explorer open

---

## DEMO SCRIPT

---

### ACT 1: "The Request" (2 minutes)

**You say:**
> "So the board meeting went well, but Finance dropped a bombshell afterward..."

**Do:**
1. Show the "email" or just narrate:
   > *"We've been reporting margins using our BUDGETED costs from January. But the supplier just sent their actual invoice data—and it doesn't match. Some products cost 15% more than we planned. We need to see ACTUAL margins, not budgeted ones."*

**You say:**
> "Here's the thing—we DO have cost data in our model. But it's the BUDGETED cost from the start of the year. What the supplier sent is the ACTUAL invoiced cost. These are different numbers, and Finance needs to see both."

**Show the comparison:**
| Product | Budgeted Cost | Actual Cost | Variance |
|---------|---------------|-------------|----------|
| Trail Runner Pro | $45.00 | $51.75 | +15% 😬 |
| Summit Hiking Boot | $62.00 | $58.90 | -5% ✅ |

**You say:**
> "This is a real business problem. Budgeted vs. Actual. And now I need to bring this external supplier data into our analytics. In Power BI Pro world, I'd import it into Desktop, refresh, publish. But where's the source of truth? What if Finance needs this same data for their reports?"

**You say:**
> "This is where OneLake changes everything."

---

### ACT 2: "Meet OneLake" (5 minutes)

**You say:**
> "OneLake is like OneDrive, but for your organization's analytics data. One lake. One copy of data. Every Fabric tenant gets one automatically."

#### Demo 2.1: The OneLake Concept

**Do:**
1. Draw or show this diagram:
```
┌─────────────────────────────────────────────────────────┐
│                       OneLake                           │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐     │
│  │ Workspace A │  │ Workspace B │  │ Workspace C │     │
│  │ ┌─────────┐ │  │ ┌─────────┐ │  │ ┌─────────┐ │     │
│  │ │Lakehouse│ │  │ │Warehouse│ │  │ │Lakehouse│ │     │
│  │ └─────────┘ │  │ └─────────┘ │  │ └─────────┘ │     │
│  └─────────────┘  └─────────────┘  └─────────────┘     │
└─────────────────────────────────────────────────────────┘
```

**You say:**
> "Think of OneLake as one giant ADLS Gen2 account for your entire organization. Workspaces are containers. Lakehouses and Warehouses are folders. Everything is stored in Delta Parquet format—open, readable, queryable."

#### Demo 2.2: OneLake File Explorer (Optional but impressive)

**Do:**
1. Open OneLake File Explorer (Windows)
2. Navigate: `OneLake > Workshop-Dev > SalesLakehouse`
3. Show the `Tables` folder with Delta tables
4. Show the `Files` folder (empty or with raw files)

**You say:**
> "This is your data lake, right in Windows Explorer. You can drag and drop files. Business users can access data without learning Spark or SQL. This is what 'democratizing data' actually looks like."

---

### ACT 3: "Upload the Supplier Data" (8 minutes)

**You say:**
> "Let's add the supplier cost data to our Lakehouse."

#### Demo 3.1: Navigate to the Lakehouse

**Do:**
1. Go to Fabric portal → Workshop-Dev workspace
2. Open `SalesLakehouse`
3. Point out the two sections:
   - **Tables** - Managed Delta tables (structured)
   - **Files** - Raw files (unstructured or semi-structured)

**You say:**
> "Tables are for structured, queryable data. Files are for raw data, images, logs—anything. We want our cost data to be a table."

#### Demo 3.2: Upload the CSV

**Do:**
1. Click **Get data** → **Upload files**
2. Select `SupplierCosts.csv`
3. Upload to the **Files** section first (show the raw upload)

**You say:**
> "I've uploaded it to Files. But it's just sitting there as a CSV. I can't query it with SQL yet. Let me convert it to a Delta table."

#### Demo 3.3: Convert to Delta Table

**Do:**
1. Right-click the CSV file
2. Select **Load to Tables** → **New table**
3. Name it: `SupplierCosts`
4. Wait for conversion
5. Show the new table appear in the Tables section

**You say:**
> "Now it's a Delta table. What does that mean? It's stored as Parquet files with a transaction log. I get:
> - ACID transactions
> - Time travel (I can see previous versions)
> - Schema enforcement
> - It's queryable by Spark, SQL, AND Power BI"

#### Demo 3.4: Quick Data Preview

**Do:**
1. Click on the `SupplierCosts` table
2. Show the data preview
3. Point out the auto-detected schema (columns and data types)

**You say:**
> "Fabric automatically figured out the column names and types. No manual schema definition needed."

---

### ACT 4: "The Magic of Shortcut Transformations" (12 minutes)

**You say:**
> "Now, here's where it gets REALLY interesting. This is the feature I showed at Microsoft Ignite and people lost their minds."

#### Demo 4.1: The Problem with Traditional ETL

**You say:**
> "In the old world, if our supplier puts a CSV on their blob storage, what do I have to do? Build a pipeline. Schedule it. Handle errors. Monitor it. Maintain it forever. For one CSV file."

**Show concept:**
```
Traditional Approach:
  Supplier CSV → Pipeline → Staging → Transform → Load → Delta Table
  (Days to build, forever to maintain)

Shortcut Transformation:
  Supplier CSV → Table Shortcut → Delta Table ✓
  (2 minutes, auto-syncs forever)
```

#### Demo 4.2: Create a Table Shortcut (The Magic Moment)

**You say:**
> "Watch this. The supplier put their cost file on a public blob. I'm going to turn it into a SQL-queryable table in about 60 seconds."

**Do:**
1. In your Lakehouse, go to the **Tables** section
2. Click **New Table Shortcut** (not regular shortcut!)
3. Select **Azure Blob Storage**
4. Enter the connection details:
   - URL: `https://yourstorageaccount.blob.core.windows.net/`
   - Authentication: **Choose the appropriate method for your storage** (Account Key, SAS, Service Principal, or Anonymous for public blobs)
5. Browse to the folder containing `SupplierCosts.csv`
6. Select the folder
7. Click **Next**
8. Configure transformation:
   - **Delimiter:** Comma
   - **First row as headers:** Yes
   - **Table name:** `SupplierCosts`
9. Click **Create**

**You say:**
> "That's it. Watch what happens..."

**Do:**
1. Show the progress in the Manage Shortcut pane
2. Wait for the initial sync to complete (~30-60 seconds)
3. Show the new table appear in the **Tables** section
4. Click on it - show the data preview!

**You say:**
> "A CSV file sitting on external storage is now a Delta table in my Lakehouse. No pipeline. No code. No Spark notebook. Just... done."

#### Demo 4.3: The Real Magic - Auto-Sync

**You say:**
> "But here's the part that made people at Ignite stand up. What happens when the supplier updates their file?"

**Do:**
1. Right-click the table → **Manage shortcut**
2. Show the monitoring panel:
   - Status
   - Last refresh time
   - Refresh history

**You say:**
> "Fabric checks the source **every 2 minutes**. If the supplier adds rows, updates prices, deletes products—it syncs automatically. No pipeline. No scheduling. No maintenance. Forever."

**Show the sync behavior:**
```
Source CSV changes → Fabric detects (within 2 min) → Delta table updates
   ↓                        ↓                            ↓
New rows added      Automatic poll                 Appends new data
Rows modified       Change detection               Updates Delta
Rows deleted        File comparison                Removes from table
```

#### Demo 4.4: Query It Immediately

**Do:**
1. Switch to the SQL Analytics Endpoint
2. Run a quick query:
```sql
SELECT TOP 10 
    SupplierName,
    COUNT(*) AS ProductCount,
    AVG(SupplierCost) AS AvgCost
FROM SupplierCosts
GROUP BY SupplierName
ORDER BY ProductCount DESC
```
3. Show the results

**You say:**
> "External CSV. Zero code. SQL-queryable. Auto-refreshing. This is what 'no more ETL' actually looks like."

#### Demo 4.5: What Formats Are Supported?

**Show this table (or mention verbally):**

| Source Format | Compression Supported | Output |
|---------------|----------------------|--------|
| CSV (.csv, .txt, .tsv, .psv) | .gz, .bz2 | Delta table |
| Parquet | .snappy, .gzip, .lz4, .zstd | Delta table |
| JSON (.json, .jsonl, .ndjson) | .gz, .bz2 | Delta table |

**You say:**
> "CSV, Parquet, JSON—including compressed files. It all becomes Delta. And it works with Azure Blob, ADLS, S3, Google Cloud, SharePoint, OneDrive, Dataverse. Anywhere your data lives."

#### Demo 4.6: Important Limitations (Be Honest)

**You say:**
> "Now, fair warning—this is in preview. A few things to know:"

**Show or mention:**
- Files must share the same schema (no schema drift yet)
- Read-only—you can't MERGE INTO or DELETE from these tables
- Polls every 2 minutes (not real-time)
- Only in Lakehouse items, not Warehouse

**You say:**
> "For most scenarios? This is perfect. If you need more control, you still have pipelines and Dataflows. But for 'supplier sends a file'? This is the answer."

---

### ACT 5: "Internal Shortcuts" (3 minutes)

**You say:**
> "Quick bonus: shortcuts also work INSIDE Fabric. What if another team has data I need?"

#### Demo 5.1: Create an Internal Shortcut (Brief)

**Do:**
1. Click **Get data** → **New shortcut**
2. Select **Microsoft OneLake** (internal)
3. Browse to another Lakehouse or Warehouse
4. Select a table
5. Create shortcut

**You say:**
> "This isn't a copy—it's a reference. If they update their data, I see it. One copy of data, many consumers. This is how you break down data silos without duplicating everything."

---

### ACT 6: "Query with SQL" (8 minutes)

**You say:**
> "Okay, I have my data in the Lakehouse. But I'm a SQL person. I don't want to learn Spark. Good news..."

#### Demo 5.1: Open the SQL Analytics Endpoint

**Do:**
1. From the workspace, notice there are TWO items for the Lakehouse:
   - `SalesLakehouse` (Lakehouse)
   - `SalesLakehouse` (SQL analytics endpoint)
2. Click on the SQL analytics endpoint

**You say:**
> "Every Lakehouse automatically gets a SQL analytics endpoint. It's read-only, but it lets you query your Delta tables with T-SQL. No Spark required."

#### Demo 5.2: Write a SQL Query

**Do:**
1. Open a new query window
2. Write a simple query:
```sql
SELECT TOP 100 
    p.ProductName,
    p.Category,
    p.UnitCost AS BudgetedCost,
    s.SupplierCost AS ActualCost,
    s.SupplierCost - p.UnitCost AS CostVariance,
    s.SupplierName,
    s.LeadTimeDays
FROM Products p
INNER JOIN SupplierCosts s ON p.ProductID = s.ProductID
ORDER BY CostVariance DESC
```
3. Run it and show results

**You say:**
> "Look at that. I just joined our Products table with the new SupplierCosts data. And I can see where our cost estimates were off—some suppliers are cheaper than we thought, some more expensive. This is the analysis the VP wanted."

#### Demo 5.3: The Realization

**You say:**
> "Now here's the thing. I can write this SQL query all day, but my semantic model doesn't have this calculation. The SupplierCosts table has costs. The Products table has prices. But MARGIN? That requires combining them.
>
> I COULD create a SQL view here... but views in Direct Lake fall back to DirectQuery—slower queries. What I really want is a MATERIALIZED table with these calculations baked in.
>
> That's exactly what Dataflows Gen2 are for. We'll tackle that in Section 04."

---

### ACT 7: "Lakehouse vs. Warehouse" (5 minutes)

**You say:**
> "Quick question I get all the time: When do I use a Lakehouse vs. a Warehouse?"

#### Demo 6.1: Decision Matrix

**Show this table:**

| Scenario | Use Lakehouse | Use Warehouse |
|----------|---------------|---------------|
| Mix of structured + unstructured data | ✅ | ❌ |
| Need Spark for data engineering | ✅ | ❌ |
| Pure T-SQL development | ⚠️ Read-only | ✅ Full DML |
| ETL with stored procedures | ❌ | ✅ |
| Data science / ML workflows | ✅ | ❌ |
| Traditional star schema | ✅ Supported | ✅ Optimized |

**You say:**
> "The short answer: 
> - **Lakehouse** = Data engineering + flexible schema
> - **Warehouse** = Pure SQL + full transactional control
> 
> But here's the secret: they both store data in Delta format in OneLake. You can even create shortcuts between them. It's not either/or—it's what fits your workflow."

---

### ACT 8: "Add to the Semantic Model" (8 minutes)

**You say:**
> "We have the supplier data in OneLake. Now let's make it available for reporting."

#### Demo 8.1: Add SupplierCosts to the Existing Semantic Model

**You say:**
> "Remember the Sales Analytics semantic model we've been using? I'm going to add our new supplier cost data to it."

**Do:**
1. Open the **Sales Analytics** semantic model (the one created in Section 02)
2. Go to **Model view** or **Manage relationships**
3. Click **Edit tables** or use the **Add tables** option
4. Select from the Lakehouse:
   - `SupplierCosts` table
5. Add it to the model

**You say:**
> "Now my existing model has the supplier cost data. Same model the team is already using—just enhanced with new data."

#### Demo 8.2: Create the Relationship

**Do:**
1. Create a relationship:
   - `SupplierCosts[ProductID]` → `Products[ProductID]`
2. Show the relationship in the diagram

**You say:**
> "One relationship connects the supplier costs to our product dimension. Now everything is linked."

#### Demo 8.3: Show the Gap

**You say:**
> "Let's try to build that margin analysis Finance wants..."

**Do:**
1. Click **New report** from the semantic model
2. Try to create a visual showing margins:
   - Drag ProductName
   - Drag SupplierCost from SupplierCosts
   - Drag UnitPrice from Products

**You say:**
> "I can show the cost and the price side by side. But where's my MARGIN column? Where's the variance calculation?
>
> The data is in TWO tables. SupplierCosts has the cost. Products has the price. To get margin, I need to COMBINE them—merge the tables, calculate the difference, and output a new table.
>
> I COULD do this with DAX measures... but that calculates at query time. For a table Finance will hammer every Tuesday before the board meeting? I want that calculation PRE-COMPUTED.
>
> That's exactly what Dataflows Gen2 are for."

#### Demo 8.4: The Handoff

**You say:**
> "So here's where we are: The supplier data is in OneLake. It's connected to our model. But to get the margin analysis Finance actually needs, we need to:
> 1. Merge SupplierCosts with Products
> 2. Calculate ActualMargin and MarginPercent
> 3. Output a new table: `ProductMarginAnalysis`
> 4. Automate it weekly when the supplier sends new data
>
> That's Section 4—Dataflows and Pipelines."

---

### Wrap-Up (2 minutes)

**You say:**
> "Let's recap what we did:
> 1. Uploaded a CSV, converted it to a Delta table
> 2. Created a shortcut to external data—auto-syncing, no ETL
> 3. Queried with T-SQL—no Spark needed
> 4. Added supplier data to our existing semantic model
> 5. Identified the gap: we need to COMBINE data to calculate margins
>
> The data is centralized. It's accessible. But to deliver what Finance really needs—pre-calculated margins, automated weekly—we need Dataflows. That's next."

---

## Key Talking Points to Hit

1. **"OneLake = OneDrive for data"** - One lake, one copy, governed by default
2. **"Shortcuts eliminate copies"** - No more export/import/sync nightmares
3. **"Delta format is the foundation"** - Parquet + transaction log = time travel, ACID, open format
4. **"SQL analytics endpoint = instant SQL access"** - No Spark required for SQL folks
5. **"Lakehouse ≠ replacing Warehouse"** - They serve different needs, but share the same storage
6. **"Centralized ≠ ready for reporting"** - Sometimes you need to transform/combine data (that's Dataflows)

---

## Sample Artifacts to Create

### SupplierCosts.csv (already created in 00-shared/data/)

The supplier file includes additional data beyond what's in Products.csv:
- `SupplierID` - Supplier identifier
- `SupplierName` - Company name (Mountain Gear Co, Urban Footwear Inc, etc.)
- `SupplierCost` - Updated costs from supplier (may differ from our internal UnitCost)
- `LeadTimeDays` - Days to receive order
- `MinOrderQty` - Minimum order quantity
- `LastUpdated` - When supplier last updated pricing

**Story angle:** "Our Products table has cost data, but it's OLD. The supplier just sent updated costs AND their lead times. We need to add this new data."

This makes the demo more realistic—it's not just about adding cost data (we already have it), it's about adding SUPPLIER data that enables new analysis (lead times, supplier performance, cost variance from our estimates).

---

## Backup Plans

| If this happens... | Do this... |
|-------------------|------------|
| File upload is slow | Have a pre-uploaded Lakehouse ready |
| SQL endpoint takes time to sync | Explain it can take 1-2 minutes for new tables |
| **Shortcut Transform fails** | Have a pre-created table shortcut ready; show the result instead of creation |
| **Anonymous blob auth blocked** | Use SAS token or have internal shortcut as backup |
| Internal shortcut fails | Demo internal shortcut to same Lakehouse instead |
| OneLake File Explorer not installed | Skip that demo, show portal only |

---

## Timing Summary

| Segment | Time |
|---------|------|
| Act 1: The Request | 2 min |
| Act 2: Meet OneLake | 5 min |
| Act 3: Upload Data | 8 min |
| Act 4: Shortcut Transformations (⭐ the wow moment) | 12 min |
| Act 5: Internal Shortcuts | 3 min |
| Act 6: SQL Queries | 6 min |
| Act 7: Lakehouse vs Warehouse | 5 min |
| Act 8: Add to Semantic Model & Show the Gap | 8 min |
| Wrap-up | 2 min |
| **Total** | **~51 min** |

---

## Post-Demo: What Slides Should Cover

After the demo, slides should reinforce:
1. OneLake architecture diagram
2. Lakehouse vs Warehouse decision matrix
3. Shortcut types and use cases
4. SQL analytics endpoint capabilities & limitations
5. Connection to Direct Lake (preview of Section 05)

---

## Connection to Other Sections

| Section | How This Connects |
|---------|-------------------|
| **Section 02** | Data is now version-controlled in Git |
| **Section 04** | Next: Use Dataflows to merge Products + SupplierCosts → ProductMarginAnalysis table |
| **Section 05** | Direct Lake will query the Lakehouse tables directly |
