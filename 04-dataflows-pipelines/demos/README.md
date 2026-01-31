# Demos: Dataflows Gen2 & Pipelines

## Demo 1: Build a Dataflow Gen2

### Setup Required
- Fabric workspace
- Lakehouse (from Section 3)
- Sample data source (CSV URL, API, or uploaded file)

### Demo Script

1. **Create new Dataflow Gen2**
   - In workspace, click **+ New** → **Dataflow Gen2**
   - The familiar Power Query editor opens

2. **Connect to data source**
   - Click **Get data**
   - Choose a source (e.g., Web for a public CSV)
   - Example URL: `https://raw.githubusercontent.com/...sample.csv`
   - Connect and preview

3. **Apply transformations**
   - Filter rows (remove nulls)
   - Rename columns (proper casing)
   - Change data types
   - Add a calculated column
   - "This is the same Power Query you know!"

4. **Configure data destination**
   - Click on the table in the Queries pane
   - At the bottom, click **+** next to "Data destination"
   - Select **Lakehouse**
   - Choose your `sales_lakehouse`
   - Configure table name
   - Choose append vs replace

5. **Publish and run**
   - Click **Publish**
   - Watch the refresh run
   - Go to Lakehouse and verify data

### Key Points to Highlight
- Same Power Query interface
- Native output to Lakehouse tables
- No intermediate staging (unless you want it)

---

## Demo 2: Create an Orchestration Pipeline

### Setup Required
- Dataflow Gen2 from Demo 1
- Lakehouse

### Demo Script

1. **Create new Pipeline**
   - In workspace, click **+ New** → **Data pipeline**
   - Name: `Daily Sales Pipeline`

2. **Add Dataflow activity**
   - From Activities, drag **Dataflow** onto canvas
   - Configure:
     - Name: "Refresh Sales Data"
     - Select your Dataflow Gen2

3. **Add a second activity**
   - Add **Notebook** activity (if you have one) OR
   - Add **Set variable** activity to demonstrate flow

4. **Connect activities**
   - Drag the green arrow from Dataflow to next activity
   - This creates "On Success" dependency
   - Show how to add "On Failure" path

5. **Add conditional logic (if time)**
   - Add **If Condition** activity
   - Configure expression
   - Show branching paths

6. **Run the pipeline**
   - Click **Run**
   - Watch the execution
   - Show the monitoring view

### Key Points to Highlight
- Visual orchestration
- Same as Azure Data Factory
- Can mix different activity types

---

## Demo 3: Monitoring and Troubleshooting

### Setup Required
- Pipeline from Demo 2 (preferably with some history)

### Demo Script

1. **View run history**
   - Open the Pipeline
   - Click **View run history** (or monitor from workspace)
   - Show completed/failed runs

2. **Drill into a run**
   - Click on a specific run
   - Show activity-level status
   - Show duration per activity

3. **Find error details**
   - If you have a failed run, click into it
   - Show the error message
   - Show input/output details

4. **Lineage view**
   - Show the lineage view
   - "Where does data come from, where does it go?"
   - Demonstrate data traceability

### Key Points to Highlight
- Full visibility into what happened
- Error messages help debugging
- Lineage for governance

---

## Demo Tips

- Pre-run the pipeline once so you have history to show
- Have a "known failure" scenario ready (e.g., bad data)
- Keep transformations simple for clarity
