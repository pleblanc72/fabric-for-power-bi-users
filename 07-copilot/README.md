# Section 7: Copilot

**AI-Assisted Development**

---

| [← Previous: Security](../06-security/README.md) | [🏠 Home](../README.md) | [Next: Semantic Link →](../08-semantic-link-optional/README.md) |
|:--|:--:|--:|

---

## Workshop Sections

| # | Section | Duration | |
|---|---------|----------|--|
| 01 | [Strategic Context](../01-strategic-context/README.md) | 45 min | |
| 02 | [CI/CD & Git Integration](../02-cicd-git-integration/README.md) | 45 min | |
| 03 | [Data Centralization](../03-data-centralization/README.md) | 60 min | |
| 04 | [Dataflows & Pipelines](../04-dataflows-pipelines/README.md) | 60 min | |
| 05 | [Direct Lake](../05-direct-lake/README.md) | 45 min | |
| 06 | [Security](../06-security/README.md) | 40 min | |
| **07** | **Copilot** | **45 min** | ⬅️ You are here |

---

## 📂 Section Contents

| Resource | Description |
|----------|-------------|
| [📝 Slide Content](./slides/slides-content.md) | Key concepts from the presentation |
| [🎬 Demo Design](./demos/demo-design.md) | Demo script & setup |
| [🧪 Lab: Copilot Exploration](./lab/copilot-exploration.md) | Hands-on exercise |

---

## Overview

| | |
|---|---|
| **Duration** | 30 minutes |
| **Level** | Beginner-Intermediate |
| **Prerequisites** | Copilot enabled on Fabric capacity; Semantic model or report |
| **Hands-on** | Medium (dependent on Copilot availability) |

---

## Learning Objectives

By the end of this section, you will be able to:

- ✅ Use Copilot to generate report pages and visuals
- ✅ Get DAX measure suggestions from Copilot
- ✅ Understand Copilot capabilities and limitations
- ✅ Consider data residency and compliance implications

---

## Topics Covered

### 1. Copilot in Power BI Reports
- Generating report pages from prompts
- Creating visuals with natural language
- Summarizing report content
- Q&A integration

### 2. Copilot in Fabric Notebooks *(optional)*
- Code generation from natural language
- Code explanation and debugging
- Schema-aware suggestions
- Integration with Lakehouse context

### 3. Copilot for DAX
- Measure suggestions based on model context
- Explaining existing DAX
- Optimization suggestions
- Quick calculations

### 4. Limitations and Gotchas
- Copilot doesn't know your business context (yet)
- Results need human review
- Complex DAX may not be accurate
- Rate limits and availability
- Feature availability varies by region

### 5. Data Residency and Compliance
- Where does your data go?
- Azure OpenAI processing
- Tenant admin controls
- Industry compliance considerations
- When to disable Copilot

---

## Demo Ideas

### Demo 1: Generate a Report Page with Copilot
- Open a report in edit mode
- Use Copilot to create a page
- Prompt: "Create a sales overview page with revenue trends and top products"
- Show generated result
- Discuss what worked and what needs refinement

### Demo 2: DAX Measure Suggestions
- Open a semantic model
- Ask Copilot to suggest measures
- "Create a measure for year-over-year growth"
- Review the generated DAX
- Discuss accuracy and best practices

### Demo 3: Notebook Code Generation *(optional)*
- Open a Fabric notebook
- Ask Copilot to generate code
- "Load the Products table from my Lakehouse and show top 10 by revenue"
- Review generated code
- Execute and verify

---

## Lab Exercise

**Duration:** 10 minutes

### Hands-on: Copilot Exploration

> ⚠️ **Note:** This lab depends on Copilot being enabled. If unavailable, this becomes a demo-only section.

1. Open an existing report in edit mode
2. Open the Copilot pane
3. Try generating a new visual: "Show monthly sales trend as a line chart"
4. Try generating a narrative: "Summarize this page"
5. Open the semantic model
6. Ask Copilot to create a YTD measure
7. Review the generated DAX

See [lab/copilot-exploration.md](./lab/copilot-exploration.md) for guided exercises.

---

## Key Takeaways

1. **Copilot accelerates, doesn't replace** - Still need human expertise
2. **Great for starting points** - Then refine manually
3. **DAX suggestions are helpful** - But verify the logic
4. **Compliance matters** - Know your organization's policies
5. **It's getting better rapidly** - Features evolve monthly

---

## Sample Copilot Prompts

### Report Generation
- "Create an executive summary page with KPIs for revenue, profit, and units sold"
- "Add a map visual showing sales by region"
- "Create a comparison of this year vs last year"

### DAX Measures
- "Create a measure for running total of sales"
- "Write DAX for year-over-year percentage change"
- "Create a measure that shows sales for the previous 12 months"

### Explanation
- "Explain this measure: [paste DAX]"
- "Why might this measure be slow?"
- "What does this visual show?"

---

## What Copilot Can and Can't Do

| ✅ Can Do | ❌ Can't Do (Yet) |
|-----------|-------------------|
| Generate basic visuals | Understand complex business rules |
| Suggest common DAX patterns | Write highly optimized DAX |
| Explain existing content | Access external documentation |
| Create narrative summaries | Know your specific terminology |
| Answer questions about data | Replace a trained analyst |

---

## Admin Considerations

### Enabling Copilot
- Tenant admin setting
- Capacity setting
- Workspace setting
- All three must allow Copilot

### Data Processing
- Prompts and data sent to Azure OpenAI
- Processed within your Azure geography (when available)
- Not used to train models
- Subject to Microsoft data protection commitments

---

## Power BI User Perspective

| What you know (Traditional) | What's new (Copilot) |
|-----------------------------|----------------------|
| Build visuals manually | Describe what you want |
| Write DAX from scratch | Get suggestions, refine |
| Read documentation | Ask questions in natural language |
| Format reports by hand | Generate summaries automatically |

---

## Common Gotchas

⚠️ **Copilot may not be available** - Check tenant/capacity settings

⚠️ **Results vary by prompt** - Be specific and iterate

⚠️ **Complex DAX often needs fixes** - Don't blindly trust

⚠️ **Not all features in all regions** - Geographic availability varies

⚠️ **Rate limits exist** - Heavy usage may be throttled

---

## Resources

- [Copilot in Power BI](https://learn.microsoft.com/power-bi/create-reports/copilot-introduction)
- [Copilot in Fabric Notebooks](https://learn.microsoft.com/fabric/data-science/copilot-notebooks-overview)
- [Copilot Admin Settings](https://learn.microsoft.com/power-bi/admin/service-admin-portal-copilot)
- [Data Security in Copilot](https://learn.microsoft.com/power-bi/enterprise/copilot-data-security-privacy)

---

## Standalone Usage

This section works as a brief intro to AI capabilities for Power BI users curious about Copilot.

**Standalone prerequisites:**
- Fabric capacity with Copilot enabled
- Existing report or semantic model
- Copilot must be permitted by admin

**Standalone title suggestion:** "Copilot for Power BI: AI-Assisted Report and DAX Development"

---

## Folder Contents

```
07-copilot/
├── README.md           # This file
├── slides/             # Presentation slides
├── demos/              # Demo scripts and prompt examples
└── lab/                # Copilot exploration exercise
```

---

| [← Previous: Security](../06-security/README.md) | [🏠 Home](../README.md) | |
|:--|:--:|--:|
