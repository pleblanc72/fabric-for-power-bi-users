# Demos: Copilot

[← Back to Section 7: Copilot](../README.md)

---

## Important Note

Copilot availability depends on:
- Tenant admin settings
- Capacity settings  
- Geographic availability
- Feature rollout status

**Have backup screenshots/recordings** in case Copilot isn't available during your session!

---

## Demo 1: Generate a Report Page with Copilot

### Setup Required
- Semantic model with data
- Report edit access
- Copilot enabled

### Demo Script

1. **Open a report in edit mode**
   - Create new report or edit existing
   - Ensure you're connected to a semantic model with data

2. **Open the Copilot pane**
   - Look for the Copilot button in the ribbon
   - Or find it in the View menu
   - The Copilot pane opens on the right

3. **Generate a page**
   - Type: "Create an executive summary page with key KPIs"
   - Submit and wait
   - Copilot generates visuals and layout

4. **Review and refine**
   - Look at what was generated
   - It might not be perfect!
   - Ask for modifications: "Make the chart a bar chart instead"

5. **Try specific requests**
   - "Add a line chart showing sales trend over time"
   - "Create a map showing sales by region"
   - "Add a table with top 10 customers"

### Key Points to Highlight
- Copilot understands your model schema
- Results are a starting point, not finished product
- Iterate with follow-up prompts

---

## Demo 2: DAX Measure Suggestions

### Setup Required
- Semantic model in edit mode
- Copilot enabled

### Demo Script

1. **Open semantic model**
   - Go to your semantic model
   - Enter edit/modeling mode

2. **Access Copilot for DAX**
   - Find the Copilot option in the model view
   - Or use the formula bar's Copilot feature

3. **Request a measure**
   - Type: "Create a measure for year-over-year sales growth"
   - Review the generated DAX:
   ```dax
   YoY Growth = 
   VAR CurrentYear = [Total Sales]
   VAR PreviousYear = CALCULATE([Total Sales], SAMEPERIODLASTYEAR('Date'[Date]))
   RETURN DIVIDE(CurrentYear - PreviousYear, PreviousYear)
   ```

4. **Verify and test**
   - Read through the DAX
   - Check it references correct columns
   - Test in a report visual

5. **Ask for explanation**
   - "Explain this measure"
   - Copilot describes what each part does

### Key Points to Highlight
- Generated DAX needs verification
- Good for common patterns (YoY, running total, etc.)
- Use explanation to learn DAX

---

## Demo 3: Notebook Code Generation *(optional)*

### Setup Required
- Fabric notebook
- Copilot enabled for notebooks

### Demo Script

1. **Open a notebook**
   - Create new or open existing
   - Copilot appears as a chat interface

2. **Request code**
   - Type: "Load the Products table from my sales_lakehouse and show the top 10 by price"
   - Copilot generates Python code:
   ```python
   # Load data from Lakehouse
   df = spark.sql("SELECT * FROM sales_lakehouse.Products ORDER BY Price DESC LIMIT 10")
   display(df)
   ```

3. **Execute and verify**
   - Run the generated code
   - Check if it works
   - Note any errors

4. **Ask for modifications**
   - "Add a bar chart of this data"
   - "Group by category and sum the prices"

### Key Points to Highlight
- Copilot knows about your Lakehouse tables
- Code may need adjustments
- Good for scaffolding, not production code

---

## Sample Prompts to Demo

### Report Generation
- "Create a sales overview page with monthly trends"
- "Add a card showing total revenue"
- "Make a comparison visual for this year vs last year"
- "Create a decomposition tree for sales"

### DAX Generation
- "Calculate running total of sales"
- "Create a measure for profit margin percentage"
- "Write DAX for same period last year comparison"
- "Create a measure that ranks products by sales"

### Explanation Requests
- "What does this visual show?"
- "Explain this DAX measure"
- "Why is this calculation returning blank?"

---

## Handling Copilot Failures

Copilot might:
- Not be available (show screenshots)
- Generate incorrect results (use as teaching moment)
- Refuse certain requests (explain data policies)

**Backup plan:** 
- Pre-recorded video of Copilot in action
- Screenshots of successful generations
- Manual walk-through of what Copilot would do

---

## Demo Tips

- Test Copilot before the session (features change!)
- Have backup screenshots/video
- Be honest about limitations
- Show both success and failure cases
- Use Copilot errors as learning opportunities
