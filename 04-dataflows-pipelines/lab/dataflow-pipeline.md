# Lab: End-to-End Data Pipeline

**Duration:** 25 minutes

---

## Objectives

By the end of this lab, you will have:
- Created a Dataflow Gen2 with transformations
- Configured output to a Lakehouse table
- Built a Pipeline to orchestrate the dataflow
- Scheduled the pipeline to run automatically

---

## Prerequisites

- [ ] Fabric workspace
- [ ] Lakehouse from Section 3 (or create new one)
- [ ] Sample data URL (provided below)

---

## Part 1: Create a Dataflow Gen2 (10 minutes)

### Step 1: Create New Dataflow

1. In your workspace, click **+ New** → **Dataflow Gen2**
2. The Power Query editor opens
3. Name your dataflow by clicking on the name and typing: `Sales Data Refresh`

### Step 2: Connect to Data Source

We'll use a public CSV for this lab:

1. Click **Get data** (or **New source**)
2. Choose **Web**
3. URL: `https://raw.githubusercontent.com/microsoft/powerbi-desktop-samples/main/DAX/Adventure%20Works%20DW%202020.csv`
   
   > If that URL doesn't work, use any public CSV or upload a file to your Lakehouse Files section and connect to that.

4. Click **Next** or **Connect**
5. Preview the data

### Step 3: Apply Transformations

Apply these common transformations:

1. **Promote headers** (if needed)
   - Transform → Use first row as headers

2. **Remove unnecessary columns**
   - Select columns you don't need
   - Right-click → Remove columns

3. **Filter rows**
   - Click filter dropdown on a column
   - Remove blanks/nulls
   - Or filter to specific values

4. **Rename columns**
   - Double-click column header
   - Give it a clean name (e.g., `OrderDate` instead of `Order Date`)

5. **Change data types**
   - Click the data type icon on column header
   - Set appropriate types (Date, Number, Text)

6. **Add a calculated column**
   - Add column → Custom column
   - Name: `LoadDate`
   - Formula: `DateTime.LocalNow()`

### Step 3b: Try Copilot for Transformations (Optional)

If Copilot is available in Dataflows:

1. Look for the **Copilot** button in the Power Query ribbon
2. Try prompts like:
   ```
   Remove all columns except ProductID, ProductName, and Price
   ```
   ```
   Filter to only include rows where Amount > 0
   ```
   ```
   Add a column that calculates profit as Amount minus Cost
   ```
3. Review what Copilot generates
4. Accept or modify as needed

> 💡 **Why this matters:** Copilot can accelerate Power Query authoring, especially for less common M functions.

### Step 4: Configure Data Destination

1. In the Queries pane, select your query
2. At the bottom right, find **Data destination**
3. Click **+** → **Lakehouse**
4. Select your workspace and `sales_lakehouse`
5. Table name: `stg_sales_data`
6. Update method: **Replace** (for this lab)
7. Click **Save settings**

### Step 5: Publish the Dataflow

1. Click **Publish** (bottom right)
2. Wait for publishing to complete
3. The dataflow will automatically run once

### Step 6: Verify Data

1. Go to your Lakehouse
2. Find the `stg_sales_data` table
3. Click to preview - your transformed data should be there!

---

## Part 2: Create an Orchestration Pipeline (10 minutes)

### Step 7: Create New Pipeline

1. In workspace, click **+ New** → **Data pipeline**
2. Name: `Daily Sales Pipeline`

### Step 8: Add Dataflow Activity

1. In the Activities ribbon, find **Dataflow**
2. Drag it onto the canvas
3. Configure:
   - **Name:** `Refresh Sales Data`
   - **Settings tab:** Select your `Sales Data Refresh` dataflow

### Step 9: Add Success Notification (Variable)

Let's add a simple indicator of success:

1. Drag a **Set variable** activity onto the canvas
2. Connect from Dataflow (drag the green checkmark → Set variable)
3. Configure Set variable:
   - **Name:** `Set Success Flag`
   - **Variables tab:** Click **+ New**
   - **Name:** `PipelineStatus`
   - **Type:** String
   - **Default value:** `Pending`
4. In the activity settings:
   - **Variable name:** `PipelineStatus`
   - **Value:** `Success`

### Step 10: Add Failure Path (Optional)

1. Drag another **Set variable** activity
2. Connect from Dataflow with **red X** (On Failure)
3. Configure:
   - **Name:** `Set Failure Flag`
   - **Variable name:** `PipelineStatus`
   - **Value:** `Failed`

Your pipeline should look like:
```
[Dataflow] --✓--> [Set Success Flag]
    |
    └--✗--> [Set Failure Flag]
```

### Step 11: Test the Pipeline

1. Click **Run** in the toolbar
2. Watch the execution in the Output pane
3. Each activity should turn green (or red if failed)
4. Verify data updated in Lakehouse

---

## Part 3: Schedule the Pipeline (5 minutes)

### Step 12: Add a Schedule

1. In the Pipeline, click **Schedule** (in the toolbar)
2. Configure:
   - **Scheduled run:** On
   - **Repeat:** Daily
   - **Time:** Choose a time (e.g., 6:00 AM)
   - **Start date:** Today
   - **End date:** Leave blank (runs indefinitely)
   - **Time zone:** Your time zone
3. Click **Apply**

### Step 13: Verify Schedule

1. Go back to your workspace
2. Find your Pipeline
3. Hover over it - you should see a schedule indicator
4. Or open Pipeline → Schedule to confirm

---

## Bonus Challenges

### Challenge 1: Add a Notebook Activity

If you have a notebook:
1. Add a **Notebook** activity after the Dataflow
2. Connect it in series
3. Use it for additional transformations or logging

### Challenge 2: Parameterize the Pipeline

1. Add a Parameter to the pipeline (Parameters tab)
2. Use it in a dataflow or activity
3. Pass different values for different runs

### Challenge 3: Add Error Handling

1. Add a **Web** activity on the failure path
2. Configure it to call a webhook (Slack, Teams, etc.)
3. Now failures trigger notifications!

---

## Reflection Questions

1. How does this compare to building ETL in Power Query Desktop?
2. What scheduling options did you have before Fabric?
3. When would you use a Pipeline vs. just scheduling a Dataflow?

---

## Clean Up

Keep these items - they demonstrate a complete data pipeline!

To clean up later:
1. Turn off the schedule (set to Off)
2. Delete the Pipeline
3. Delete the Dataflow
4. Delete the Lakehouse table

---

## Troubleshooting

**"Dataflow publish failed"**
- Check for transformation errors (red X in steps)
- Verify data destination is correctly configured
- Ensure Lakehouse exists

**"Pipeline run failed"**
- Click into the failed activity
- Read the error message
- Common issues: Dataflow not found, permissions, capacity

**"Schedule not triggering"**
- Verify schedule is turned On
- Check time zone settings
- Note: May take a few minutes after scheduled time
