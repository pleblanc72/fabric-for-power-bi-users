# Section 04: Dataflows Gen2 & Pipelines - Demo Design

[← Back to Section 4: Dataflows & Pipelines](../README.md)

## The Story: "The Weekly Margin Report"

**Continuing from Section 03:** You've centralized the actual supplier costs in OneLake. The data is there—but it's in TWO tables. SupplierCosts has the actual costs. Products has the prices. To calculate margins, you need to COMBINE them. And the CFO wants this weekly...

**Scenario:** The CFO calls: *"I love that we finally have the supplier cost data. But I need to see MARGINS—what we sell for minus what we pay. And I need it WEEKLY. The supplier sends updated costs every Monday. Can you build me a margin analysis table that's ready for the Tuesday board meeting?"*

**The challenge:** 
- SupplierCosts has actual costs (from supplier)
- Products has prices (our data)
- You need to MERGE them and calculate margins
- You need to orchestrate (run on schedule, handle failures)
- You need to notify (alert Finance if data is missing)
- **Enter: Dataflows Gen2 and Pipelines**

---

## The Narrative Arc

| Act | What Happens | Emotion | Lesson |
|-----|--------------|---------|--------|
| 1 | CFO wants weekly margin analysis | Recognition | "This is real life" |
| 2 | Build a Dataflow Gen2 that merges tables | Comfort | "I know Power Query!" |
| 3 | Output to Lakehouse as new table | Satisfaction | "It just works" |
| 4 | Add to semantic model, build report | Payoff | "Now Finance has their margins!" |
| 5 | Create a Pipeline with alerts | Control | "Now I can orchestrate" |
| 6 | Monitor & troubleshoot | Confidence | "I can see what happened" |

---

## Characters (Continuing from Previous Sections)

- **Alex** - The report developer (you, demoing)
- **The CFO** - Wants weekly margin analysis for Tuesday board meetings
- **The Supplier** - Sending weekly updated invoice costs
- **Finance Team** - Needs the ProductMarginAnalysis table for reporting
- **IT Manager** - Wants to know when things fail

---

## Pre-Demo Setup Checklist

### Already Done (from Previous Sections)
- [x] Lakehouse: `SalesLakehouse` with Sales, Products, Stores, Calendar, Targets
- [x] SupplierCosts table (via Shortcut Transformation or upload)
- [x] Semantic model with SupplierCosts added (but no margin calculations yet)
- [x] Git integration connected

### New for This Section
- [ ] Know your email for pipeline notifications
- [ ] **TEST COPILOT PROMPT** - Run the exact prompt 3+ times to ensure consistent results:
  ```
  Merge the Products table with this query on ProductID, keeping all columns from both
  ```

### Browser Tabs Ready
1. Fabric portal (workspace)
2. Lakehouse open
3. (Optional) Email client to show notifications

---

## DEMO SCRIPT

---

### ACT 1: "The Gap We Left Behind" (3 minutes)

**You say:**
> "Remember where we left off in Section 03? We centralized the supplier cost data in OneLake. It's connected to our semantic model. But we hit a wall..."

**Narrate the scenario:**
> *"The CFO asked: 'Great, I can see the supplier costs. But where's my MARGIN? I need to know what we MAKE on each product—sale price minus actual cost. And I need this every week for the board meeting.'"*

**You say:**
> "Here's the problem: the data is in TWO tables.
> - **SupplierCosts** has the actual cost from the supplier
> - **Products** has our sale price (UnitPrice)
> - **Margin** = UnitPrice - SupplierCost
>
> To calculate margins, I need to MERGE these tables. That's exactly what Dataflows Gen2 are for."

---

### ACT 2: "Power Query in the Cloud" (12 minutes)

**You say:**
> "If you know Power Query, you already know Dataflows Gen2. It's the same experience—just in the cloud, with better destinations."

#### Demo 2.1: Create a Dataflow Gen2

**Do:**
1. Go to your workspace
2. Click **+ New item** → **Dataflow Gen2**
3. Name it: `Build Product Margin Analysis`

**You say:**
> "First thing you'll notice—this looks exactly like Power Query in Power BI Desktop. Same interface. Same transformations. Same M code under the hood."

#### Demo 2.2: Get Data - SupplierCosts

**Do:**
1. Click **Get data** → **More...**
2. Show the connector list—hundreds of sources!
3. Select **Lakehouse**
4. Connect to your `SalesLakehouse`
5. Select the `SupplierCosts` table
6. Click **Create**

**You say:**
> "I can connect to anything—databases, APIs, files, Lakehouse, Warehouse. Same connectors you know from Power BI."

#### Demo 2.3: Get Data - Products

**Do:**
1. Click **Get data** again
2. Select **Lakehouse** → `SalesLakehouse`
3. Select the `Products` table
4. Click **Create**

**You say:**
> "Now I have both tables in my Dataflow. SupplierCosts and Products. Time to merge them."

#### Demo 2.4: Merge the Tables (The Key Step!)

**You say:**
> "This is the magic moment. We're going to JOIN these two tables on ProductID—just like a SQL join, but in Power Query."

**Do:**
1. Select the `SupplierCosts` query
2. Go to **Home** → **Merge queries** → **Merge queries as new**
3. Configure the merge:
   - Left table: `SupplierCosts`
   - Right table: `Products`
   - Join column: `ProductID` (click on it in both tables)
   - Join kind: **Left outer** (all from SupplierCosts, matching from Products)
4. Click **OK**
5. Name the new query: `ProductMarginAnalysis`

**You say:**
> "I just joined two tables. Every supplier cost record now has access to the product's price, category, and other attributes."

#### Demo 2.5: Expand the Products Columns

**Do:**
1. In the new merged query, find the `Products` column (it shows "Table")
2. Click the expand button (two arrows)
3. Select columns to keep:
   - `UnitPrice` (what we sell for)
   - `UnitCost` (budgeted cost)
4. Uncheck "Use original column name as prefix"
5. Click **OK**

**You say:**
> "I'm only bringing over UnitPrice and UnitCost—the columns I need for calculations. Why not ProductName and Category? Because we'll JOIN back to the Products table in the semantic model. No need to duplicate data."

#### Demo 2.6: Add Margin Columns (with Copilot!)

**You say:**
> "Let's use Copilot to add the margin calculations."

**Do:**
1. Click the **Copilot** button in the Dataflow editor (top ribbon)
2. In the Copilot pane, type this prompt:

   ```
   Add a column called ActualMargin that calculates UnitPrice minus SupplierCost
   ```

3. Press Enter and watch Copilot generate the transformation
4. Review the result in the preview

**You say:**
> "There's our margin. Now let's add the percentage."

**Do:**
1. Type another prompt:

   ```
   Add a column called ActualMarginPct that calculates ActualMargin divided by UnitPrice
   ```

2. Show the new column in the preview

**You say:**
> "And for good measure, let's see the variance between our budgeted cost and actual supplier cost."

**Do:**
1. Type:
   ```
   Add a column called CostVariance that calculates SupplierCost minus UnitCost
   ```

##### Fallback: If Copilot Doesn't Cooperate

> **Presenter note:** Test these exact prompts 3+ times before the workshop. If Copilot is unavailable or gives unexpected results during the live demo:

**You say:**
> "Looks like Copilot is being shy today. No problem—this is why we always know the manual way."

**Do (manual fallback):**
1. Go to **Add Column** → **Custom Column**
2. Add each column:
   - `ActualMargin` = `[UnitPrice] - [SupplierCost]`
   - `ActualMarginPct` = `[ActualMargin] / [UnitPrice]`
   - `CostVariance` = `[SupplierCost] - [UnitCost]`

**You say:**
> "Same result. Copilot is a productivity boost, not a crutch. Always know how to do it yourself."

#### Demo 2.7: The Gen2 Difference—Data Destinations

**You say:**
> "Here's where Gen2 is different from Gen1. Watch this."

**Do:**
1. Select the `ProductMarginAnalysis` query
2. In the bottom-right, click **Data destination**
3. Select **Lakehouse**
4. Choose your `SalesLakehouse`
5. Create new table: `ProductMarginAnalysis`
6. Configure:
   - **Update method:** Replace (or Append)
   - **Column mapping:** Auto-mapped

**You say:**
> "In Gen1, data went to internal storage—you accessed it through the Dataflow connector. In Gen2, I can send data directly to:
> - Lakehouse tables
> - Warehouse tables
> - Azure SQL
> - KQL databases
> - And more.
>
> The data lands exactly where I need it."

#### Demo 2.8: Publish the Dataflow

**Do:**
1. Click **Publish** (bottom right)
2. Show the publishing progress
3. Wait for completion

**You say:**
> "Publish saves and validates. It also runs in the background—I don't have to wait. When it's done, my data is in the Lakehouse."

---

### ACT 3: "Verify & Add to Semantic Model" (8 minutes)

#### Demo 3.1: Verify the New Table

**Do:**
1. Go to your Lakehouse
2. Open the **Tables** section
3. Find `ProductMarginAnalysis`
4. Click to preview the data
5. Show the columns: ProductID, SupplierName, SupplierCost, UnitPrice, UnitCost, ActualMargin, ActualMarginPct, CostVariance

**You say:**
> "There it is. Supplier costs merged with pricing data, plus our calculated margins. All materialized as a Delta table—ready for Direct Lake."

#### Demo 3.2: Add to the Semantic Model

**Do:**
1. Open the **Sales Analytics** semantic model
2. Click **Edit tables** or **Manage tables**
3. Add the new `ProductMarginAnalysis` table
4. Show that it's in **Direct Lake** mode

**You say:**
> "Now my semantic model has the margin analysis table. Let's connect it to our star schema."

#### Demo 3.3: Create Relationship

**Do:**
1. Create a relationship:
   - `ProductMarginAnalysis[ProductID]` → `Products[ProductID]`
2. Show the relationship in the diagram

**You say:**
> "The margin table connects to Products. Now I can slice margins by any product attribute, and join to Sales if needed."

#### Demo 3.4: Build the CFO's Margin Report

**Do:**
1. Click **New report** from the semantic model
2. Create visuals:
   - **Card**: Average margin percentage
   - **Table**: ProductName, SupplierCost, UnitPrice, ActualMargin, ActualMarginPct
   - **Bar chart**: Top 10 products by margin (or bottom 10 for problems)
   - **Column chart**: Margin by Category
3. Highlight a problem product (low margin)

**You say:**
> "There it is. The CFO's margin analysis. 'Trail Runner Pro has a 23% margin, but Summit Hiking Boot is only 8%—we might be underpricing it.'
>
> This is exactly what Finance needed. Pre-calculated margins, Direct Lake performance, and it updates automatically when the Dataflow runs."

#### Demo 3.5: The Comparison

**Show this comparison:**

| Approach | Where Calculation Happens | Storage Mode | When to Use |
|----------|---------------------------|--------------|-------------|
| DAX Measures | Query time (every click) | Depends on source | Simple calcs, real-time |
| SQL View | Query time (every click) | DirectQuery | Quick prototypes |
| Dataflow Gen2 | ETL time (scheduled) | Direct Lake | Performance-critical, merged data |
| Python/Spark | Notebook execution | Direct Lake | Complex transformations |

**You say:**
> "We chose Dataflow because we needed to MERGE two tables and pre-compute the results. The calculation happens once at ETL time, not every time someone opens the report."

---

### ACT 4: "Orchestration with Pipelines" (15 minutes)

**You say:**
> "The Dataflow works. The report is built. But the CFO wants this WEEKLY—fresh data every Monday morning for the Tuesday board meeting. That's what Pipelines are for."

#### Demo 4.1: Create a Pipeline

**Do:**
1. Go to your workspace
2. Click **+ New item** → **Data pipeline**
3. Name it: `Weekly Supplier Cost Refresh`

**You say:**
> "Pipelines are the orchestration layer. Think of them as workflows that coordinate multiple activities."

#### Demo 4.2: Add the Dataflow Activity

**Do:**
1. In the pipeline canvas, go to **Activities**
2. Drag **Dataflow** activity onto the canvas
3. Configure it:
   - Select your `Build Product Margin Analysis` dataflow
4. Show the activity settings

**You say:**
> "I've added my Dataflow as an activity. When this pipeline runs, it triggers the Dataflow—which merges the tables and updates ProductMarginAnalysis."

#### Demo 4.3: Add a Notification (Office 365 Outlook or Teams)

**Do:**
1. Drag **Office 365 Outlook** activity (or **Teams**) onto canvas
2. Connect from Dataflow → Success → Outlook
3. Configure the email:
   - To: your email
   - Subject: `Supplier Cost Refresh Complete`
   - Body: `The weekly supplier cost data has been refreshed successfully.`

4. Add another connection: Dataflow → Failure → Outlook
5. Configure failure email:
   - Subject: `⚠️ Supplier Cost Refresh FAILED`
   - Body: `Please check the pipeline run for errors.`

**You say:**
> "Now I have notifications. Success? Email the team. Failure? Alert the IT manager. This is real production-grade orchestration."

#### Demo 4.4: Show Pipeline Flow

**Do:**
1. Zoom out to show the full pipeline
2. Point out the connections:
   - Green arrow = On Success
   - Red arrow = On Failure

**Show diagram:**
```
┌─────────────────┐     Success     ┌─────────────────┐
│   Dataflow:     │────────────────▶│  Email: Success │
│ Transform Data  │                 └─────────────────┘
└────────┬────────┘
         │ Failure
         ▼
┌─────────────────┐
│  Email: Failure │
└─────────────────┘
```

**You say:**
> "This is visual orchestration. No code. Just drag, connect, configure."

#### Demo 4.5: Run the Pipeline

**Do:**
1. Click **Run** (or **Validate** first)
2. Show the run starting
3. Watch the activities execute
4. Show the success notification arriving (if email is fast)

**You say:**
> "It's running. The Dataflow executes, and when it completes, the notification fires. Let's check the monitoring."

---

### ACT 5: "Monitoring & Troubleshooting" (7 minutes)

**You say:**
> "When something goes wrong—and it will—you need to know what happened. Fabric gives you full visibility."

#### Demo 5.1: Pipeline Run History

**Do:**
1. From the pipeline, click **View run history** (or go to Monitoring Hub)
2. Show the list of runs
3. Click into a run
4. Show:
   - Overall status
   - Duration
   - Each activity's status

**You say:**
> "Every run is logged. I can see when it ran, how long each activity took, and whether it succeeded or failed."

#### Demo 5.2: Activity Details

**Do:**
1. Click on the Dataflow activity
2. Show the details:
   - Input/Output
   - Duration
   - Error message (if failed)

**You say:**
> "If something fails, I can drill in and see exactly what went wrong. Was it a connection timeout? Bad data? Schema mismatch? It's all here."

#### Demo 5.3: Monitoring Hub

**Do:**
1. Go to **Monitoring Hub** (from left nav)
2. Show all pipeline and dataflow runs across the workspace
3. Filter by status, time, item name

**You say:**
> "The Monitoring Hub is your central view. All pipelines, all dataflows, all runs. This is where IT goes when something breaks."

#### Demo 5.4: Schedule the Pipeline

**Do:**
1. Go back to the pipeline
2. Click **Schedule**
3. Configure:
   - Frequency: Weekly
   - Day: Monday
   - Time: 6:00 AM
4. Save the schedule

**You say:**
> "Now it runs automatically every Monday morning. By the time the team arrives, fresh supplier data is waiting."

---

### Wrap-Up (2 minutes)

**You say:**
> "Let's recap:
> 1. **The Problem**: Data in two tables, needed to merge and calculate margins
> 2. **Dataflows Gen2** = Power Query in the cloud—merge, transform, output to Lakehouse
> 3. **The Result**: ProductMarginAnalysis table with pre-calculated margins (Direct Lake)
> 4. **Pipelines** = Orchestration—schedules, notifications, error handling
> 5. **Monitoring Hub** = See everything that happened
>
> Your Power Query skills transfer directly. The difference is where the data goes and how you automate it."

---

## Key Talking Points to Hit

1. **"You already know this"** - Power Query is Power Query
2. **"Merge queries = SQL JOIN"** - Combine tables visually
3. **"Gen2 outputs anywhere"** - Not stuck in internal storage
4. **"Copilot writes real M code"** - Not magic, just faster typing
5. **"Pipelines = Orchestration"** - Dataflows transform, Pipelines coordinate
6. **"Same engine as Azure Data Factory"** - Enterprise-grade, not a toy
7. **"Always know the manual way"** - Copilot is a boost, not a crutch

---

## Backup Plans

| If this happens... | Do this... |
|-------------------|------------|
| Dataflow takes too long to publish | Have a pre-built dataflow ready |
| Email notification is slow | Explain it's async, show in monitoring instead |
| Pipeline fails | Great! Show troubleshooting flow |
| Copilot unavailable or gives wrong result | Perfect teaching moment! Say "This is why we always know manual" and demo Add Column → Custom Column |
| Copilot button not visible | Check capacity has Copilot enabled; fallback to manual |

---

## Timing Summary

| Segment | Time |
|---------|------|
| Act 1: The Gap We Left Behind | 3 min |
| Act 2: Dataflow Gen2 (merge + calculate) | 15 min |
| Act 3: Verify & Add to Semantic Model | 8 min |
| Act 4: Pipelines | 12 min |
| Act 5: Monitoring | 7 min |
| Wrap-up | 2 min |
| **Total** | **~47 min** |

Leaves time for Q&A and hands-on.

---

## Sample Artifacts to Create

### ProductMarginAnalysis Table (output of Dataflow)

Columns:
- `ProductID` - From SupplierCosts (used for join to Products)
- `SupplierID` - From SupplierCosts  
- `SupplierName` - From SupplierCosts
- `SupplierCost` - From SupplierCosts (actual cost)
- `LeadTimeDays` - From SupplierCosts
- `MinOrderQty` - From SupplierCosts
- `LastUpdated` - From SupplierCosts
- `UnitPrice` - From Products (merged, for margin calc)
- `UnitCost` - From Products (merged, budgeted cost)
- `ActualMargin` - Calculated: UnitPrice - SupplierCost
- `ActualMarginPct` - Calculated: ActualMargin / UnitPrice
- `CostVariance` - Calculated: SupplierCost - UnitCost

**Note:** ProductName, Category, SubCategory come from the Products table via relationship in the semantic model—no need to duplicate here.

---

## Connection to Other Sections

| Section | How This Connects |
|---------|-------------------|
| **Section 02** | Dataflows and Pipelines sync to Git! |
| **Section 03** | We merged SupplierCosts + Products from the Lakehouse |
| **Section 05** | Direct Lake reads ProductMarginAnalysis directly—no import needed |
| **Section 07** | Copilot helped write Power Query transformations |

---

## Gen1 vs Gen2 Quick Reference (for slides)

| Feature | Gen1 | Gen2 |
|---------|------|------|
| **Output** | Internal storage only | Lakehouse, Warehouse, SQL, KQL, etc. |
| **Compute** | Mashup engine | Enhanced compute (faster) |
| **AutoSave** | No | Yes |
| **Pipeline integration** | Limited | Full integration |
| **Incremental refresh** | Basic | Full with query folding |
| **Monitoring** | Basic | Enhanced with Monitoring Hub |
| **Requires** | Pro or Premium | Fabric capacity |
