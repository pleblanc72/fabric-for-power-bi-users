# Copilot in Power BI: AI That Understands Your Business

[← Back to Section 7: Copilot](../README.md)

> These are the key concepts from the presentation. Use this as a reference guide.

*"The model IS the prompt."*

---

## The Story Continues

**The Board Wants What?**

> *"Alex, board meeting Monday. I need 12 new visuals. YoY comparisons, regional breakdowns, trend analysis. Can you have these ready by Sunday?"*

**Friday at 4 PM. 48 hours. 12 visuals.**

After weeks of building pipelines, security, and Direct Lake...

**Let's try Copilot.**

---

## The Problem

**Why Copilot Disappoints (Sometimes)**

```
Prompt: "Show me margin analysis by supplier"

Copilot: "I'm not sure which field represents margin..."
```

**Copilot reads your semantic model metadata:**
- Table names
- Column names
- Measure names
- Descriptions

**If that metadata is generic or missing, Copilot has nothing to work with.**

---

## The Insight

**The Model IS the Prompt**

| Poor Model | Copilot Result |
|------------|----------------|
| `ProdID`, `CustNo`, `SupCost` | Confusion |
| No descriptions | Generic guesses |
| 200 columns, 50 relevant | Wrong field selection |
| No business context | Misunderstood terminology |

**Copilot is only as good as your data preparation.**

---

## What is Copilot?

**AI-Powered Assistance in Power BI**

| Capability | What It Does |
|------------|--------------|
| **Create visuals** | Generate charts from natural language prompts |
| **Write DAX** | Generate measures and calculations |
| **Explain code** | Understand existing DAX formulas |
| **Summarize reports** | Create narrative summaries |
| **Answer questions** | Chat with your data |

**Powered by Azure OpenAI.** Reads your semantic model metadata to understand your data.

---

## What is "Prep Data for AI"?

**Making Your Model AI-Ready**

**The Problem:**
- Copilot only sees metadata (names, descriptions)
- It doesn't know your business terminology
- It can't read your mind

**The Solution:**
- Give Copilot context it needs
- Simplify what it sees
- Pre-approve answers to common questions

*"Think of it as onboarding Copilot to your organization."*

---

## The Three Prep Data for AI Features

| Feature | What It Is | Analogy |
|---------|------------|---------|
| **AI Data Schema** | Select which fields Copilot can see | "Here's the relevant data" |
| **AI Instructions** | Natural language business context | "Here's how we talk about things" |
| **Verified Answers** | Pre-approved visual responses | "Here's the trusted answer" |

**All three work together** to make Copilot smarter about YOUR data.

---

## AI Data Schema

**Declutter Your Model**

**The Problem:**
- Copilot sees ALL 200 columns
- Internal IDs, deprecated fields, technical columns
- More confusion = worse results

**The Solution:**
- Select only relevant fields
- Hide confusing columns from AI
- Narrow the focus

**Copilot only reasons over what you select.**

---

## AI Instructions

**Business Context in Natural Language**

AI Instructions are free-form text you write to help Copilot understand:

- **Business terminology** - "Margin means Gross Margin"
- **Analysis preferences** - "Always use quarterly analysis"
- **Data relationships** - "Top customers = top 10 by revenue"
- **Company context** - "Busy season is October-February"

**Stored on the semantic model.** Applied to everyone who uses Copilot with that model.

*Limit: 10,000 characters*

---

## AI Instructions Example

```
Business Context:
- We are a regional retail company in Pacific Northwest
- "Margin" = Gross Margin = (Revenue - Supplier Cost) / Revenue
- Busy season is October through February

Analysis Rules:
- Always analyze sales on a quarterly basis
- For regional comparisons, use Store[Region]
- Primary sales measure is [Total Sales]

Terminology:
- "Top customers" = top 10 by revenue
- "YoY" = year-over-year comparison
```

---

## Verified Answers

**Human-Approved Responses**

**How it works:**
1. You create a visual (the "answer")
2. You define trigger phrases ("Show me sales trends")
3. When users ask similar questions, Copilot returns YOUR visual

**Why use them:**
- Consistency across users
- Trusted, reviewed answers
- No AI guessing for important questions

*"When someone asks about sales, they ALL see the same trusted chart."*

---

## Naming Conventions Matter

| ❌ Bad Name | ✅ Good Name |
|------------|--------------|
| ProdID | Product ID |
| CustNo | Customer Number |
| SupCost | Supplier Cost |
| AvgRating | Average Customer Rating |
| YoY% | Year Over Year Growth Percentage |

**If Copilot can't understand the name, it can't use the field correctly.**

---

## Descriptions Are Critical

**First 200 Characters Used by AI**

**Bad description:** *(empty)*

**Good description:**
```
"Year-over-year difference in Orders. 
Use with Date[Year] column to show by years 
other than the latest year. Partial years 
compare to same period of prior year."
```

**Pro tip:** Use "Create with Copilot" button to auto-generate descriptions!

---

## Before and After

| Unprepared Model | Prepared Model |
|------------------|----------------|
| "I'm not sure which field..." | Correct visual generated |
| Wrong measures selected | Right measures used |
| Generic responses | Business-aware responses |
| "What is margin?" | "Margin = (Revenue - Cost)/Revenue" |
| Frustrated user | Productive user |

**The difference: 1 hour of Prep Data for AI setup.**

---

## Copilot Capabilities

| Task | Strength | Notes |
|------|----------|-------|
| Generate visuals | ⭐⭐⭐⭐⭐ | With good schema |
| Write DAX measures | ⭐⭐⭐⭐ | Always verify |
| Explain existing DAX | ⭐⭐⭐⭐⭐ | Great for docs |
| Generate descriptions | ⭐⭐⭐⭐⭐ | Use the button! |
| Understand business | Depends | On your AI Instructions |

---

## Copilot Limitations

| Limitation | Reality |
|------------|---------|
| Custom visuals | Not supported |
| Styling/formatting | Manual only |
| Real-time streaming models | Not supported |
| ML/predictive analytics | Outside DAX capabilities |
| Perfect accuracy | Always verify |
| Business-specific logic | Needs AI Instructions |

**It's a copilot, not an autopilot.**

---

## Requirements

| Requirement | Details |
|-------------|---------|
| **Capacity** | F2+ Fabric or P1+ Premium |
| **Admin setting** | Copilot enabled in tenant |
| **Q&A enabled** | Required for report creation |
| **Region** | Check Fabric region availability |
| **Model type** | Import, DirectQuery, Direct Lake, Composite |

**Not available on trial SKUs.**

---

## The Key Message

**AI Accelerates. Humans Validate.**

**Without preparation:**
- Copilot guesses
- Generic results
- Frustration

**With preparation:**
- Copilot understands
- Business-aware results
- Acceleration

*"I didn't work the weekend. Copilot helped me ship on time. But I still verified every visual."*

---

## Getting Started

1. ✅ **Audit your model** - naming conventions, descriptions
2. ✅ **Enable Prep Data for AI** - simplify schema
3. ✅ **Write AI Instructions** - business context
4. ✅ **Create 5-10 verified answers** - common questions
5. ✅ **Train your team** - when to use, when to verify

**Remember:** The model IS the prompt.
