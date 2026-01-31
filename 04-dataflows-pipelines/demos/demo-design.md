# Section 04: Dataflows Gen2 & Pipelines - Demo Design

## The Story: "The Weekly Variance Report"

**Continuing from Section 03:** You've centralized the actual supplier costs in OneLake. Finance can finally see the variance between budgeted and actual costs. The CFO is thrilled—they spotted $50K in unexpected cost overruns. But now there's a new challenge...

**Scenario:** The CFO calls: *"This variance analysis is gold. But I need it WEEKLY. The supplier is sending updated invoice data every Monday. Can you automate this? And I need to know immediately if the data doesn't arrive—the board meeting is every Tuesday."*

**The challenge:** 
- Supplier sends weekly cost updates (actual invoiced costs)
- You need to transform the data (calculate variance, flag anomalies)
- You need to orchestrate (run on schedule, handle failures)
- You need to notify (alert Finance if data is missing or variance is high)
- **Enter: Dataflows Gen2 and Pipelines**

---

## The Narrative Arc

| Act | What Happens | Emotion | Lesson |
|-----|--------------|---------|--------|
| 1 | CFO wants weekly variance automation | Recognition | "This is real life" |
| 2 | Build a Dataflow Gen2 with variance calc | Comfort | "I know Power Query!" |
| 3 | Output to Lakehouse | Satisfaction | "It just works" |
| 4 | Create a Pipeline with alerts | Control | "Now I can orchestrate" |
| 5 | Monitor & troubleshoot | Confidence | "I can see what happened" |

---

## Characters (Continuing from Previous Sections)

- **Alex** - The report developer (you, demoing)
- **The CFO** - Wants weekly variance reports for Tuesday board meetings
- **The Supplier** - Sending weekly updated invoice costs
- **Finance Team** - Needs alerts when variance exceeds threshold
- **IT Manager** - Wants to know when things fail

---

## Pre-Demo Setup Checklist

### Already Done (from Previous Sections)
- [x] Lakehouse: `SalesLakehouse` with Sales, Products, Stores, Calendar, Targets
- [x] SupplierCosts table (via Shortcut Transformation or upload)
- [x] Git integration connected

### New for This Section
- [ ] Sample CSV for transformation: `SupplierCostsV2.csv` with new columns
- [ ] (Optional) Second data source to combine (e.g., `ExchangeRates.csv`)
- [ ] Know your email for pipeline notifications
- [ ] **TEST COPILOT PROMPT** - Run the exact prompt 3+ times to ensure consistent results:
  ```
  Add a new column called Margin Potential that calculates UnitPrice minus SupplierCost
  ```

### Browser Tabs Ready
1. Fabric portal (workspace)
2. Lakehouse open
3. (Optional) Email client to show notifications

---

## DEMO SCRIPT

---

### ACT 1: "The New Requirements" (3 minutes)

**You say:**
> "Remember how we brought in the actual supplier costs? Finance loved seeing the variance between budgeted and actual. They found $50K in cost overruns we didn't know about. Now the CFO wants this weekly..."

**Narrate the scenario:**
> *"I need this variance report every Tuesday for the board. The supplier sends updated costs Monday morning. Can you automate this? And if the variance on any product exceeds 10%, I want an alert."*

**You say:**
> "Now I have three problems:
> 1. I need to **transform** the data—calculate variance between budgeted and actual, flag anomalies
> 2. I need to **orchestrate**—run this every Monday after the supplier file arrives
> 3. I need to **notify**—alert the CFO if variance exceeds threshold or data is missing
>
> The Shortcut Transformation is great for 'just land the data.' But when I need logic and alerts? That's where Dataflows Gen2 and Pipelines come in."

---

### ACT 2: "Power Query in the Cloud" (12 minutes)

**You say:**
> "If you know Power Query, you already know Dataflows Gen2. It's the same experience—just in the cloud, with better destinations."

#### Demo 2.1: Create a Dataflow Gen2

**Do:**
1. Go to your workspace
2. Click **+ New item** → **Dataflow Gen2**
3. Name it: `Transform Supplier Costs`

**You say:**
> "First thing you'll notice—this looks exactly like Power Query in Power BI Desktop. Same interface. Same transformations. Same M code under the hood."

#### Demo 2.2: Get Data

**Do:**
1. Click **Get data** → **More...**
2. Show the connector list—hundreds of sources!
3. Select **Lakehouse** (or **Text/CSV** for external file)
4. Connect to your `SalesLakehouse`
5. Select the `SupplierCosts` table (or upload new CSV)

**You say:**
> "I can connect to anything—databases, APIs, files, Lakehouse, Warehouse. Same connectors you know from Power BI."

#### Demo 2.3: Apply Transformations (with Copilot!)

**You say:**
> "Remember that view we created in Section 03? It calculates cost variance and margins. But views are DirectQuery—every report click recalculates. Let's use Copilot to add those same columns to a TABLE, so we get Direct Lake performance."

##### Step 1: Use Copilot to Add Cost Variance Columns

**Do:**
1. Click the **Copilot** button in the Dataflow editor (top ribbon)
2. In the Copilot pane, type this prompt:

   ```
   Add columns for cost variance. Calculate the difference between SupplierCost and UnitCost as CostVariance, and the percentage variance as CostVariancePct.
   ```

3. Press Enter and watch Copilot generate the transformation
4. Review the result in the preview
5. Show the **Applied Steps** pane—Copilot added real steps!

**You say:**
> "Look at that. Natural language to Power Query. And notice—it's not magic. It wrote real M code."

##### Step 2: Use Copilot to Add Margin Columns

**Do:**
1. Type another prompt:

   ```
   Add columns for actual margin. Calculate UnitPrice minus SupplierCost as ActualMargin, and the margin as a percentage of UnitPrice as ActualMarginPct.
   ```

2. Show the new columns in the preview

**You say:**
> "Now we have the same calculated columns that were in our view—CostVariance, CostVariancePct, ActualMargin, ActualMarginPct. But these will be MATERIALIZED in a table, not computed at query time."

##### Fallback: If Copilot Doesn't Cooperate

> **Presenter note:** Test these exact prompts 3+ times before the workshop. If Copilot is unavailable or gives unexpected results during the live demo:

**You say:**
> "Looks like Copilot is being shy today. No problem—this is why we always know the manual way."

**Do (manual fallback):**
1. Go to **Add Column** → **Custom Column**
2. Add each column:
   - `CostVariance` = `[SupplierCost] - [UnitCost]`
   - `CostVariancePct` = `([SupplierCost] - [UnitCost]) / [UnitCost]`
   - `ActualMargin` = `[UnitPrice] - [SupplierCost]`
   - `ActualMarginPct` = `([UnitPrice] - [SupplierCost]) / [UnitPrice]`

**You say:**
> "Same result. Copilot is a productivity boost, not a crutch. Always know how to do it yourself."

---

##### Step 2: Additional Transformations (Manual)

**Do:**
1. Filter rows (e.g., only active suppliers):
   - Click filter on a column
   - Show the familiar filter UI

2. Rename columns for clarity:
   - Right-click column → Rename

3. Show the **Applied Steps** pane:
   - "Every transformation is recorded"
   - "You can go back and modify any step"

**You say:**
> "Everything you do in Power Query Desktop, you can do here. Filter, merge, pivot, unpivot, add columns, change types. And now—Copilot can help write it."

#### Demo 2.4: The Gen2 Difference—Data Destinations

**You say:**
> "Here's where Gen2 is different from Gen1. Watch this."

**Do:**
1. In the bottom-right of the query, click **Data destination**
2. Select **Lakehouse**
3. Choose your `SalesLakehouse`
4. Select or create table: `SupplierCostsTransformed`
5. Configure:
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

#### Demo 2.5: Publish the Dataflow

**Do:**
1. Click **Publish** (bottom right)
2. Show the publishing progress
3. Wait for completion

**You say:**
> "Publish saves and validates. It also runs in the background—I don't have to wait. When it's done, my data is in the Lakehouse."

---

### ACT 3: "Verify the Output & The Swap" (8 minutes)

#### Demo 3.1: Verify the Transformed Table

**Do:**
1. Go to your Lakehouse
2. Open the **Tables** section
3. Find `SupplierCostsTransformed`
4. Click to preview the data
5. Show the new calculated columns: CostVariance, CostVariancePct, ActualMargin, ActualMarginPct

**You say:**
> "There it is. Same calculations as our view, but now they're materialized in a Delta table. This data is ready for Direct Lake."

#### Demo 3.2: The Swap - View to Table

**You say:**
> "Remember our variance report from Section 03? It's using the view, which means DirectQuery. Let's swap it for our new table and get Direct Lake performance."

**Do:**
1. Open the **Sales Analytics** semantic model
2. Go to Model view
3. Show that `vw_ProductMargins` is currently **DirectQuery** mode
4. Click **Edit tables** or **Manage tables**
5. Add the new `SupplierCostsTransformed` table
6. Show that it's **Direct Lake** mode

**You say:**
> "See the difference? The view is DirectQuery. The table is Direct Lake. Same columns, same calculations—but the table is pre-computed."

#### Demo 3.3: Update the Report

**Do:**
1. Open the variance report
2. Update visuals to use columns from `SupplierCostsTransformed` instead of `vw_ProductMargins`
3. (Optional) Hide or remove the view from the model

**You say:**
> "Same report. Same visuals. Same numbers. But now it's running on Direct Lake instead of DirectQuery.
>
> The CFO won't notice the difference visually—but they WILL notice the report loads faster, especially as data grows."

#### Demo 3.4: Show the Three Options

**Show this comparison:**

| Approach | Where Calculation Happens | Storage Mode | When to Use |
|----------|---------------------------|--------------|-------------|
| SQL View | Query time (every click) | DirectQuery | Real-time calcs, quick prototypes |
| Dataflow Gen2 | ETL time (scheduled) | Direct Lake | Performance-critical reports |
| Python/Spark | Notebook execution | Direct Lake | Complex transformations |

**You say:**
> "Three ways to add calculated columns. All valid. Pick based on your needs:
> - **View**: Fast to create, real-time, but slower queries
> - **Dataflow**: Low-code, scheduled, Direct Lake performance
> - **Python/Spark**: Full control, complex logic, requires coding
>
> We started with a view because Finance needed the report NOW. Then we optimized with a Dataflow. This is how real projects work—ship fast, improve later."

---

### ACT 4: "Orchestration with Pipelines" (15 minutes)

**You say:**
> "The Dataflow works. But I need to run it on a schedule, handle errors, and notify people. That's what Pipelines are for."

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
   - Select your `Transform Supplier Costs` dataflow
4. Show the activity settings

**You say:**
> "I've added my Dataflow as an activity. When this pipeline runs, it triggers the Dataflow refresh."

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
> 1. **Dataflows Gen2** = Power Query in the cloud, outputs to Lakehouse/Warehouse
> 2. **Pipelines** = Orchestration—schedules, notifications, error handling
> 3. **Monitoring Hub** = See everything that happened
>
> Your Power Query skills transfer directly. The difference is where the data goes and how you automate it."

---

## Key Talking Points to Hit

1. **"You already know this"** - Power Query is Power Query
2. **"Gen2 outputs anywhere"** - Not stuck in internal storage
3. **"Copilot writes real M code"** - Not magic, just faster typing
4. **"Pipelines = Orchestration"** - Dataflows transform, Pipelines coordinate
5. **"Same engine as Azure Data Factory"** - Enterprise-grade, not a toy
6. **"Always know the manual way"** - Copilot is a boost, not a crutch

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
| Act 1: New Requirements | 3 min |
| Act 2: Dataflow Gen2 | 12 min |
| Act 3: Verify Output | 3 min |
| Act 4: Pipelines | 15 min |
| Act 5: Monitoring | 7 min |
| Wrap-up | 2 min |
| **Total** | **~42 min** |

Leaves time for Q&A and hands-on.

---

## Sample Artifacts to Create

### SupplierCostsV2.csv (if needed for demo)

Add new columns to existing SupplierCosts:
- `LeadTimeDays` - Days to receive order
- `MinOrderQty` - Minimum order quantity
- `ContractExpires` - Date contract ends

Already exists in `00-shared/data/SupplierCosts.csv` with these columns.

---

## Connection to Other Sections

| Section | How This Connects |
|---------|-------------------|
| **Section 02** | Dataflows and Pipelines sync to Git! |
| **Section 03** | Dataflows output to Lakehouse tables we created |
| **Section 05** | Direct Lake will read these tables directly |
| **Section 07** | Copilot can help write Power Query transformations |

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
