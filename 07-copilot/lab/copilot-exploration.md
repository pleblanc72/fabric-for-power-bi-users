# Lab: Copilot & Preparing Your Model for AI

[← Back to Section 7: Copilot](../README.md)

**Duration:** 25 minutes

---

## ⚠️ Important Prerequisite

This lab requires Copilot to be enabled on your Fabric capacity. If Copilot is not available, Parts 1-2 become **observation** sections—follow along with the concepts and complete Part 3 (model preparation) which works without Copilot.

**To check if Copilot is available:**
1. Open a report in edit mode
2. Look for the Copilot icon in the ribbon
3. If you don't see it, Copilot is not enabled for your tenant/capacity

---

## Objectives

By the end of this lab, you will have:
- Experienced Copilot's limitations with unprepared models
- Prepared a semantic model for AI using "Prep Data for AI"
- Improved naming conventions and added descriptions
- Configured AI Instructions for business context
- Seen the difference Copilot produces with a prepared model

---

## The Key Insight

> **"The model IS the prompt."**  
> Copilot reads your semantic model metadata—table names, column names, measure names, and descriptions. If that metadata is generic or missing, Copilot has nothing to work with.

---

## Part 1: Copilot Without Preparation (5 minutes)

### Step 1: Open a Report

1. Open an existing report OR create a new one connected to your semantic model
2. Ensure you're in **Edit mode**

### Step 2: Open Copilot Pane

1. Click the **Copilot** button in the ribbon
2. The Copilot pane opens on the right

### Step 3: Try Prompts (Experience the Limitations)

Try these prompts and **observe the results**:

**Prompt 1:** (vague business term)
```
Show me margin analysis by supplier
```

**Prompt 2:** (proprietary terminology)
```
Create a visual for our profitability metric
```

**Prompt 3:** (assumes business context)
```
Compare this quarter's performance to target
```

### Step 4: Document the Issues

| Prompt | What Copilot Did | What Was Wrong |
|--------|------------------|----------------|
| 1 | | |
| 2 | | |
| 3 | | |

**Why did this happen?** Copilot doesn't know:
- What "margin" means in your business
- Which columns contain cost data
- Your company's terminology
- What "profitability metric" refers to

---

## Part 2: Prep Data for AI (10 minutes)

### Step 5: Open Prep Data for AI

**In Power BI Service:**
1. Go to your semantic model
2. Click **Prep data for AI** (in the toolbar)

**In Power BI Desktop:**
1. Open your model
2. Home ribbon → **Prep data for AI**

### Step 6: Simplify the Data Schema (AI Data Schema)

The first tab lets you control what Copilot "sees."

1. Click the **Simplify data schema** tab
2. Review the list of tables and columns
3. **Deselect** items Copilot shouldn't reason over:
   - Internal ID columns (`ProductID`, `CustomerID`)
   - System columns (`ModifiedDate`, `RowVersion`)
   - Deprecated or unused fields
4. **Keep selected** the business-meaningful fields:
   - `ProductName`, `Category`, `Region`
   - `SalesAmount`, `Quantity`, `Cost`
   - Your measures
5. Click **Apply** or **Save**

> 💡 **Why this matters:** If Copilot sees 200 columns but only 50 are relevant for reports, it might pick the wrong ones. Simplify to improve accuracy.

### Step 7: Improve Naming Conventions

Good names help Copilot understand your data:

| Before (Bad) | After (Good) |
|--------------|--------------|
| `ProdID` | `ProductID` |
| `CustNo` | `CustomerNumber` |
| `SupCost` | `SupplierCost` |
| `Amt` | `SalesAmount` |
| `Qty` | `Quantity` |

**To rename columns/tables:**
1. Open your semantic model in edit mode
2. Right-click a column → **Rename**
3. Use clear, descriptive names
4. Avoid abbreviations

### Step 8: Add Descriptions to Measures

This is **critical** for Copilot to understand your calculations.

1. In the model, select a measure (e.g., `Total Sales`)
2. In the Properties pane, find **Description**
3. Add a clear description:

**Example descriptions:**

| Measure | Description |
|---------|-------------|
| `Total Sales` | Sum of all sales revenue in dollars. Use for total revenue KPIs. |
| `Gross Margin %` | (Revenue - Cost) / Revenue. Our standard profitability metric. |
| `YoY Growth %` | Year-over-year percentage change in sales. Compares to same period last year. |
| `Customer Count` | Distinct count of customers who made purchases. |

4. Repeat for all important measures

### Step 9: Configure AI Instructions

This is where you give Copilot **business context**.

1. In Prep Data for AI, click the **AI Instructions** tab
2. Add instructions that help Copilot understand your business:

**Example AI Instructions:**
```
Business Context:
- We are a regional retail company selling outdoor and sporting goods
- Our fiscal year runs January to December
- "Margin" always means Gross Margin (Revenue - Cost) / Revenue
- Regional managers are responsible for stores in their region
- Target comparisons should use the Targets table

Terminology:
- "Profitability" = Gross Margin %
- "Performance" = Sales vs Target %
- "Top performers" = Highest revenue stores or products

Preferences:
- Default currency is USD
- Show percentages with 1 decimal place
- Use fiscal calendar for time-based analysis
```

3. Click **Save**

### Step 10: Create Verified Answers (Optional)

Verified Answers are pre-approved responses to specific questions.

1. Click the **Verified answers** tab
2. Click **+ Add verified answer**
3. Configure:
   - **Question:** "What is our total revenue?"
   - **Answer:** Point to your `Total Sales` measure
4. Add more verified answers for common questions

---

## Part 3: Test Copilot Again (5 minutes)

### Step 11: Return to Report Copilot

1. Go back to your report in edit mode
2. Open the Copilot pane

### Step 12: Retry Your Prompts

Try the same prompts from Part 1:

**Prompt 1:**
```
Show me margin analysis by supplier
```

**Prompt 2:**
```
Create a visual for our profitability metric
```

**Prompt 3:**
```
Compare this quarter's performance to target
```

### Step 13: Compare Results

| Prompt | Before Prep | After Prep | Improvement |
|--------|-------------|------------|-------------|
| 1 | | | |
| 2 | | | |
| 3 | | | |

### Step 14: Try Advanced Prompts

Now that Copilot understands your model, try more complex requests:

```
Create a line chart showing monthly sales trend with YoY comparison
```

```
Build a table showing top 10 products by gross margin percentage
```

```
Add a card showing revenue performance vs target with conditional formatting
```

---

## Part 4: DAX Assistance (5 minutes)

### Step 15: Request a Measure

In the semantic model (or formula bar), use Copilot for DAX:

**Request 1:**
```
Create a measure for rolling 3-month average sales
```

**Request 2:**
```
Write a measure that calculates the percentage of total sales by category
```

### Step 16: Review and Validate

For each generated measure:
1. ✅ Read the DAX code carefully
2. ✅ Verify column references are correct
3. ✅ Check the logic matches your expectation
4. ✅ Test by adding to a report visual
5. ⚠️ **Never deploy without validation!**

### Step 17: Ask for Explanations

If you have complex existing measures:
```
Explain this DAX measure: [paste measure]
```

---

## Observations Worksheet

| Aspect | Rating (1-5) | Notes |
|--------|--------------|-------|
| Visual generation accuracy | | |
| DAX generation accuracy | | |
| Understanding of business terms | | |
| Speed vs manual work | | |
| Trust level (would you use in production?) | | |

---

## Discussion Questions

1. **Before vs After:** How much did "Prep Data for AI" improve Copilot's output?

2. **Investment:** Is the time spent preparing the model worth the Copilot improvements?

3. **Governance:** Who should own the AI Instructions and Verified Answers?

4. **Trust:** At what point would you use Copilot-generated content without review?

5. **Future:** How might better model preparation benefit other users (not just Copilot)?

---

## Key Takeaways

1. **"The model IS the prompt"** - Copilot's quality depends on your metadata quality
2. **Prep Data for AI** - Simplify schema, add descriptions, write AI instructions
3. **Naming matters** - Clear names help both Copilot AND human users
4. **Descriptions are critical** - Especially for measures with business logic
5. **AI Instructions = Business context** - Tell Copilot about your company
6. **Verify everything** - Copilot accelerates, but doesn't replace expertise

---

## If Copilot is Not Available

Complete Part 2 anyway! Good model preparation benefits:
- Future Copilot adoption
- Self-service users understanding your model
- Documentation for your team
- Q&A features in Power BI
- Any AI feature Microsoft adds later

---

## Troubleshooting

**"Copilot button not visible"**
- Not enabled for your tenant/capacity
- Contact your Fabric admin
- Complete Part 2-3 for preparation practice

**"Prep Data for AI not showing"**
- Ensure you're on a Fabric/Premium capacity
- Check you have edit permissions on the model

**"Descriptions won't save"**
- Ensure you're in edit mode
- Check for unsaved changes elsewhere
- Try refreshing the browser

**"Copilot still gives poor results after prep"**
- Give it more specific prompts
- Add more detailed AI instructions
- Check that descriptions actually saved
- Copilot improves over time—try again later

---

## Clean Up

Keep your prepared model! The improvements benefit:
- All Copilot users
- Self-service report builders
- Future AI features
- Your own documentation
