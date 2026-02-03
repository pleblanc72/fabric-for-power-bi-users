# Section 07: Copilot - Demo Design

[← Back to Section 7: Copilot](../README.md)

## The Story: "The Board Wants What?"

**Continuing from Section 06:** Security is locked down. OneLake Security protects the data across all access points. The VP is satisfied. The solution is complete. Then Friday afternoon happens...

**Scenario:** The CFO sends an email: *"Board meeting Monday. I need 12 new visuals for my presentation. YoY comparisons, regional breakdowns, trend analysis. Can you have these ready?"*

Alex stares at the screen. 12 visuals. 48 hours. After spending weeks building pipelines, security, and Direct Lake. Now this?

**The twist:** Alex tries Copilot... and the results are disappointing. Generic visuals. Wrong measures. Copilot doesn't understand the business context. Why?

**The lesson:** Copilot is only as good as your data preparation. You need to "Prep Your Data for AI" before Copilot can truly help.

**The challenge:**
- Last-minute requests are the norm, not the exception
- Copilot can accelerate—but only if your model is ready
- Naming conventions, descriptions, and AI instructions matter
- **How do you prepare your semantic model to work well with Copilot?**
- **Enter: Prep Data for AI**

---

## The Narrative Arc

| Act | What Happens | Emotion | Lesson |
|-----|--------------|---------|--------|
| 1 | The Friday afternoon email | Dread | "We've all been here" |
| 2 | Copilot fails (unprepared model) | Frustration | "Why isn't this working?" |
| 3 | Prep Data for AI introduction | Hope | "There's a way to fix this" |
| 4 | Naming conventions & descriptions | Understanding | "The model IS the prompt" |
| 5 | AI Instructions & Verified Answers | Confidence | "I can guide Copilot" |
| 6 | Copilot succeeds (prepared model) | Relief | "Now it understands my business" |
| 7 | The Monday morning result | Satisfaction | "AI accelerates, humans validate" |

---

## Characters (Continuing from Previous Sections)

- **Alex** - The report developer (you, demoing)
- **The CFO** - Needs 12 visuals by Monday
- **The Board** - Wants polished, accurate data
- **Past Alex** - Wrote DAX 6 months ago that current Alex doesn't remember
- **Copilot** - Helpful assistant that needs context to succeed

---

## Pre-Demo Setup Checklist

### Already Done (from Previous Sections)
- [x] Lakehouse: `SalesLakehouse` with Sales, Products, Stores, SupplierCosts
- [x] Direct Lake semantic model connected
- [x] OneLake Security configured
- [x] Working reports with existing visuals

### New for This Section
- [ ] **Power BI Desktop** installed (latest version)
- [ ] Copilot enabled on your Fabric capacity (tenant admin setting)
- [ ] A report with some existing visuals (to add to)
- [ ] A semantic model with:
  - [ ] Some poorly named columns (for "before" demo)
  - [ ] Some existing measures (including one complex DAX)
  - [ ] Missing descriptions on measures
- [ ] Prep Data for AI features accessible

### Apps / Tabs Ready
1. **Power BI Desktop** (connected to semantic model)
2. Power BI report in edit mode (with Copilot pane)
3. Prep Data for AI dialog (in Desktop: Home → Prep data for AI)

### Sample Prompts Ready
Keep these in a text file for quick copy/paste:
```
Visual generation:
- "Create a line chart showing monthly sales trend for the last 12 months"
- "Show YoY revenue growth by region as a bar chart"
- "Create a card showing total revenue with comparison to last year"

DAX generation:
- "Create a measure for year-over-year sales growth percentage"
- "Write a measure that shows the rolling 3-month average of sales"
- "Create a measure for sales contribution percentage by product category"

Explanation:
- "Explain this DAX measure"
- "What does this calculation do?"

Intentional fail (unprepared model):
- "Show me the margin analysis by supplier" (if columns are poorly named)
- "Create a measure for our proprietary profitability metric"
```

---

## DEMO SCRIPT

---

### ACT 1: "The Friday Afternoon Email" (3 minutes)

**You say:**
> "It's Friday at 4 PM. You've just finished configuring OneLake Security. The solution is complete. You're about to close your laptop when..."

**Show the scenario (narrate):**
> *"Alex, board meeting Monday. I need a few more visuals for my presentation. YoY comparisons, regional breakdowns, trend analysis. Nothing fancy—just 12 new visuals. Can you have these ready by Sunday night?"*

**You say:**
> "Twelve visuals. Forty-eight hours. After building pipelines, security, Direct Lake. This is the part of Power BI work that never changes—the last-minute requests."

**Pause, then:**
> "But here's the thing. It's January 2026. We have Copilot. Let's try it."

---

### ACT 2: "Copilot Fails" (5 minutes)

**You say:**
> "I'll just ask Copilot to create a visual. Simple, right?"

**DEMO STEPS:**

1. **Open report in edit mode**
   - Navigate to your report
   - Click Edit

2. **Open Copilot pane**
   - Click the Copilot icon in the ribbon
   
3. **Enter a prompt that won't work well:**
   ```
   Show me margin analysis by supplier
   ```

4. **Show the underwhelming result**
   - Copilot might pick wrong fields
   - Or say it can't find relevant data
   - Or create something generic that misses the point

**You say:**
> "Hmm. That's not what I wanted. Let me try again..."

5. **Try another prompt:**
   ```
   Create a measure for our proprietary profitability metric
   ```

6. **Show Copilot's confusion**
   - It doesn't know your business terminology
   - It can't read your mind

**You say:**
> "Copilot isn't broken. It's just... uninformed. It doesn't know what 'margin' means in our business. It doesn't know which table has supplier costs. It doesn't know our terminology."

**Key teaching moment:**
> "Here's the truth: Copilot reads your semantic model metadata—table names, column names, measure names, descriptions. If that metadata is generic or missing, Copilot has nothing to work with. The model IS the prompt."

---

### ACT 3: "Prep Data for AI" (8 minutes)

**You say:**
> "Microsoft knew this would be a problem. That's why they built 'Prep Data for AI.' Let me show you."

**DEMO STEPS:**

1. **Open Prep Data for AI in Power BI Desktop**
   - Home ribbon → **Prep data for AI** button
   - (Also available in Service: Semantic model → "Prep data for AI")

2. **Show the three tabs:**
   - **Simplify data schema** (AI Data Schema)
   - **Add AI instructions**
   - **Verified answers**

3. **Explain AI Data Schema:**
   > "This lets me tell Copilot which fields to focus on. I can hide confusing columns, internal IDs, fields that shouldn't be in reports. Copilot will only reason over what I select."

4. **Show selecting/deselecting fields:**
   - Deselect internal ID columns
   - Deselect deprecated fields
   - Keep the important business fields

**You say:**
> "Think of this as decluttering. If Copilot can see 200 columns but only 50 are relevant, it might pick the wrong ones. Narrow the focus."

---

### ACT 4: "Naming Conventions & Descriptions" (8 minutes)

**You say:**
> "But the schema is only part of it. The names and descriptions matter just as much—maybe more."

**DEMO STEPS:**

1. **Show a poorly named column:**
   - Example: `ProdID`, `CustNo`, `SupCost`

2. **Explain the problem:**
   > "Copilot sees 'SupCost' and has no idea that means Supplier Cost. It's not going to guess. We need to rename this."

3. **Show the best practice naming:**

   | Bad Name | Good Name |
   |----------|-----------|
   | ProdID | Product ID |
   | CustNo | Customer Number |
   | SupCost | Supplier Cost |
   | AvgRating | Average Customer Rating |
   | YoY% | Year Over Year Growth Percentage |

4. **Show measure descriptions:**
   - Navigate to a measure in Model view
   - Show the Description property (empty)

5. **Use Copilot to generate a description:**
   - Click "Create with Copilot" button
   - Show the generated description
   - Click "Keep it"

**You say:**
> "Copilot can write descriptions for you! And those descriptions help Copilot understand what the measure does. It's a virtuous cycle."

**Key points:**
- First 200 characters of descriptions are used by Copilot
- Be specific: "Year-over-year difference in Orders. Use with Date[Year] column."
- Include usage guidance in descriptions

6. **Show table naming:**
   > "For fact tables, be explicit: FactSales, FactTransactions. For dimensions: DimProduct, DimCustomer. Copilot understands these patterns."

---

### ACT 5: "AI Instructions & Verified Answers" (10 minutes)

**You say:**
> "Now the powerful part. AI Instructions let you give Copilot business context it could never figure out on its own."

**DEMO STEPS:**

1. **Open AI Instructions tab in Prep Data for AI**

2. **Add sample instructions:**
   ```
   Business Context:
   - We are a regional retail company with stores in Pacific Northwest and California
   - "Margin" always refers to Gross Margin calculated as (Revenue - Supplier Cost) / Revenue
   - Busy season is October through February
   
   Analysis Rules:
   - Always analyze sales on a quarterly basis unless specified otherwise
   - For regional comparisons, use the Store[Region] column
   - The primary sales measure is [Total Sales] in the FactSales table
   
   Terminology:
   - "Top customers" means the top 10 by revenue
   - "YoY" means year-over-year comparison
   - "Supplier costs" are confidential - don't include in consumer-facing reports
   ```

3. **Click Apply**

**You say:**
> "Now Copilot knows our business. It knows what 'margin' means. It knows our busy season. It knows our terminology. This is prompt engineering, but at the model level."

4. **Show Verified Answers:**
   - Select a visual in the report
   - Click "Set up a verified answer" from the visual menu
   - Add trigger phrases:
     - "Show me sales trends"
     - "Monthly sales over time"
     - "Revenue by month"

**You say:**
> "Verified answers are human-approved responses. When someone asks 'Show me sales trends,' Copilot returns THIS visual—not a guess. It's curated, reliable, consistent."

**Key points about Verified Answers:**
- Up to 250 verified answers per model
- 15 trigger phrases per answer
- Supports semantic matching (synonyms work)
- Filters can be made available to users

---

### ACT 6: "Copilot Succeeds" (8 minutes)

**You say:**
> "Now let's try Copilot again with our prepared model."

**DEMO STEPS:**

1. **Close and reopen the Copilot pane** (to pick up changes)

2. **Try the same prompt that failed before:**
   ```
   Show me margin analysis by supplier
   ```

3. **Show the improved result:**
   - Copilot now understands "margin" = Gross Margin
   - It uses the right tables and columns
   - The visual makes sense

4. **Generate a new visual:**
   ```
   Create a line chart showing monthly sales trend for the last 12 months
   ```

5. **Show the result:**
   - Review the visual
   - Make a small adjustment: "Make the line blue and add data labels"

6. **Ask for a DAX measure:**
   ```
   Create a measure for year-over-year sales growth percentage
   ```

7. **Review and verify the DAX:**
   - Check the logic
   - Verify divide-by-zero handling
   - Test with a visual

**You say:**
> "Same Copilot. Same prompts. Dramatically better results. The difference? We prepared our data for AI."

---

### ACT 7: "The Monday Morning Result" (3 minutes)

**You say:**
> "So here we are. It's Sunday night. The CFO needed 12 visuals."

**Show the summary:**
- Visuals generated: 12
- Time spent: ~4 hours instead of ~12
- Setup time for Prep Data for AI: ~1 hour (one-time investment)
- Human review: Every single one
- Fixes needed: A few refinements
- Result: Board presentation ready

**You say:**
> "That one hour setting up AI instructions and verified answers? It pays off every time someone uses Copilot on this model. It's not just for me—it's for everyone who builds reports on this data."

**The key message:**
> "AI accelerates. Humans validate. But AI only accelerates if you prepare for it. The model IS the prompt."

---

## Recovery Scenarios

### "Copilot isn't available"
- Show screenshots of what it looks like
- Discuss: "This requires your tenant admin to enable Copilot"
- Explain the licensing: Copilot requires F2+ capacity or P1+ Premium

### "Copilot generates wrong DAX"
- Perfect teaching moment
- Show how to identify the error
- Demonstrate fixing it
- "This is exactly why human review matters"

### "Copilot is slow/times out"
- Normal during high-demand periods
- Retry usually works
- Discuss rate limits

### "Prep Data for AI not visible"
- Q&A must be enabled on the model
- Check tenant settings
- May need Desktop version

---

## Talking Points: Prep Data for AI

### The Three Pillars

| Feature | What It Does | When to Use |
|---------|--------------|-------------|
| **AI Data Schema** | Limits which fields Copilot sees | Always—declutter your model |
| **AI Instructions** | Business context in natural language | When Copilot needs to understand terminology |
| **Verified Answers** | Curated visual responses | For common questions with known-good answers |

### Semantic Model Best Practices for Copilot

| Category | Best Practice | Example |
|----------|---------------|---------|
| **Measures** | Descriptive names | `Average Customer Rating` not `AvgRating` |
| **Measures** | Add descriptions (200 char limit used) | "Sum of all sales amounts in USD" |
| **Tables** | Name fact tables explicitly | `FactSales`, `FactTransactions` |
| **Tables** | Name dimension tables clearly | `DimProduct`, `DimCustomer` |
| **Columns** | Unambiguous labels | `Product Name` not `ProdID` |
| **Columns** | Correct data types | Date as Date, not Text |
| **Hierarchies** | Logical groupings | Year > Quarter > Month > Day |
| **Relationships** | Clearly defined | All relationships active and logical |

### AI Instructions Best Practices

| Tip | Why |
|-----|-----|
| Be explicit and specific | Copilot doesn't know your business |
| Group related instructions | Easier for LLM to understand |
| Use examples | "Top customers = top 10 by revenue" |
| Define terminology | "Margin = Gross Margin = (Revenue - Cost) / Revenue" |
| Specify analysis rules | "Always analyze sales quarterly" |
| Limit to 10,000 characters | That's the max |

### Copilot Capabilities Summary

| Task | Copilot Strength | Notes |
|------|------------------|-------|
| Generate starter visuals | ⭐⭐⭐⭐⭐ | Works well with good schema |
| Write common DAX patterns | ⭐⭐⭐⭐ | Verify the output |
| Explain existing code | ⭐⭐⭐⭐⭐ | Great for documentation |
| Generate measure descriptions | ⭐⭐⭐⭐⭐ | Use the button! |
| Understand business context | ⭐⭐ → ⭐⭐⭐⭐⭐ | Depends entirely on AI Instructions |

### Limitations to Know

| Limitation | Workaround |
|------------|------------|
| Q&A must be enabled | Enable in model settings |
| Custom visuals not supported | Use standard visuals |
| Styling changes not supported | Manual formatting |
| 200 char description limit | Front-load important info |
| 10,000 char AI instructions limit | Be concise, prioritize |
| No real-time streaming models | Use other model types |

---

## Wrap-Up Points

### The Workshop Journey Recap

| Section | What We Built |
|---------|---------------|
| 02 - Git | Version control, deployment pipelines |
| 03 - OneLake | Centralized data, shortcuts, Delta format |
| 04 - Dataflows | Automated data refresh, orchestration |
| 05 - Direct Lake | Real-time reports, no refresh wait |
| 06 - Security | OneLake Security, RLS everywhere |
| 07 - Copilot | AI-assisted development with prepared data |

**The complete picture:**
> "You now have version-controlled reports, centralized data in OneLake, automated pipelines, real-time Direct Lake reports, comprehensive security, and AI assistance that actually understands your business. This is what 'Fabric for the Power BI User' looks like in 2026."

### Call to Action
1. **Enable Copilot** in your test environment
2. **Audit your model** - naming conventions, descriptions
3. **Set up Prep Data for AI** - even if just AI instructions
4. **Create 5-10 verified answers** for common questions
5. **Train your team** on when to use and when to verify

---

## Timing Summary

| Act | Duration |
|-----|----------|
| Act 1: Friday email | 3 min |
| Act 2: Copilot fails | 5 min |
| Act 3: Prep Data for AI intro | 8 min |
| Act 4: Naming & descriptions | 8 min |
| Act 5: AI Instructions & Verified Answers | 10 min |
| Act 6: Copilot succeeds | 8 min |
| Act 7: Wrap-up | 3 min |
| **Total demo** | **~45 min** |

Buffer for questions: ~5 min
**Section total: ~50 min**

---

## Post-Demo: Workshop Conclusion

After the Copilot demo, transition to workshop wrap-up:
- Recap the full journey (all 7 sections)
- Q&A
- Resources and next steps
- Thank participants

This is the finale—end on a high note showing that AI assistance is powerful WHEN your data is prepared. The message: "The model IS the prompt."
