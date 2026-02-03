# Section 4: Dataflows Gen2 & Pipelines

**Modern Data Integration**

---

| [← Previous: Data Centralization](../03-data-centralization/README.md) | [🏠 Home](../README.md) | [Next: Direct Lake →](../05-direct-lake/README.md) |
|:--|:--:|--:|

---

## Workshop Sections

| # | Section | Duration | |
|---|---------|----------|--|
| 01 | [Strategic Context](../01-strategic-context/README.md) | 45 min | |
| 02 | [CI/CD & Git Integration](../02-cicd-git-integration/README.md) | 45 min | |
| 03 | [Data Centralization](../03-data-centralization/README.md) | 60 min | |
| **04** | **Dataflows & Pipelines** | **60 min** | ⬅️ You are here |
| 05 | [Direct Lake](../05-direct-lake/README.md) | 45 min | |
| 06 | [Security](../06-security/README.md) | 40 min | |
| 07 | [Copilot](../07-copilot/README.md) | 45 min | |

---

## 📂 Section Contents

| Resource | Description |
|----------|-------------|
| [� Slides (PDF)](./pdf/04-dataflows-pipelines.pdf) | Presentation slides |
| [⬇️ Download PDF](https://github.com/pleblanc72/fabric-for-power-bi-users/raw/main/04-dataflows-pipelines/pdf/04-dataflows-pipelines.pdf) | 1.7 MB · Jan 2026 |

| [🧪 Lab: Dataflow & Pipeline](./lab/dataflow-pipeline.md) | Hands-on exercise |

---

## Overview

| | |
|---|---|
| **Duration** | 60 minutes |
| **Level** | Intermediate |
| **Prerequisites** | Lakehouse from Section 3 (or run quick start) |
| **Hands-on** | Heavy |

---

## Learning Objectives

By the end of this section, you will be able to:

- ✅ Understand the differences between Dataflows Gen1 and Gen2
- ✅ Build a Dataflow Gen2 with transformations
- ✅ Configure Dataflow output to Lakehouse tables
- ✅ Create Pipelines to orchestrate multiple activities
- ✅ Choose between Dataflows, Pipelines, and Notebooks

---

## Topics Covered

### 1. Dataflows Gen1 vs. Gen2

| Feature | Gen1 | Gen2 |
|---------|------|------|
| Output destinations | Power BI, Dataverse, Azure Data Lake | Lakehouse, Warehouse, KQL Database |
| Compute engine | Mashup engine | Mashup + enhanced compute |
| Incremental refresh | Limited | Full support with native query folding |
| Staging | Optional Azure storage | Built-in staging lakehouse |
| Monitoring | Basic | Enhanced monitoring and lineage |

### 2. Building Dataflows Gen2
- Power Query Online interface (familiar!)
- Connecting to sources
- Transformations and best practices
- Data destination configuration

### 3. When to Use What

| Scenario | Recommended Tool |
|----------|------------------|
| Simple ETL, Power Query skills | Dataflows Gen2 |
| Complex orchestration, multiple steps | Pipelines |
| Advanced transformations, ML prep | Notebooks |
| Low-code, business user | Dataflows Gen2 |
| Code-first, data engineer | Notebooks |

### 4. Pipelines: Orchestration Layer
- What is a Pipeline?
- Activities and data flow
- Control flow (If, ForEach, Until)
- Scheduling and triggers
- Comparison to Azure Data Factory (it's the same engine!)

### 5. Orchestration Patterns
- Pattern 1: Dataflow → Pipeline refresh
- Pattern 2: Ingest → Transform → Load (multi-step)
- Pattern 3: Pipeline calling notebooks
- Pattern 4: Cross-workspace dependencies

### 6. Incremental Refresh in Dataflows Gen2
- How it works differently from Gen1
- Native query folding requirements
- Configuration steps
- Monitoring incremental runs

---

## Demo Ideas

### Demo 1: Build a Dataflow Gen2
- Start from blank
- Connect to sample CSV/API
- Apply transformations
- Configure output to Lakehouse table
- Run and verify

### Demo 2: Create an Orchestration Pipeline
- Create pipeline with multiple activities
- Add Dataflow activity
- Add Notebook activity (if time)
- Add conditional logic
- Run and monitor

### Demo 3: Monitoring and Troubleshooting
- View run history
- Examine activity details
- Find error messages
- Show lineage view

---

## Lab Exercise

**Duration:** 25 minutes

### Hands-on: End-to-End Data Pipeline

1. Create a Dataflow Gen2 that:
   - Reads from sample CSV
   - Applies basic transformations (filter, rename, add column)
   - Outputs to a Lakehouse table

2. Create a Pipeline that:
   - Runs the Dataflow
   - Has a success/failure notification (using variables)

3. Schedule the Pipeline to run daily

See [lab/dataflow-pipeline.md](./lab/dataflow-pipeline.md) for step-by-step instructions.

---

## Key Takeaways

1. **Gen2 is not just a version bump** - It's architecturally different
2. **Dataflows are for transformation** - Pipelines are for orchestration
3. **Your Power Query skills transfer** - The UI is the same
4. **Notebooks are for when you need code** - Not a replacement for Dataflows
5. **Pipelines = Azure Data Factory** - Same engine, integrated experience

---

## Power BI User Perspective

| What you know (Power BI) | What's new (Fabric) |
|--------------------------|---------------------|
| Power Query in Desktop | Power Query in Dataflow Gen2 (same!) |
| Dataflows Gen1 | Dataflows Gen2 (better destinations) |
| Scheduled refresh | Pipelines with triggers |
| Manual refresh dependencies | Pipeline orchestration |

---

## Common Gotchas

⚠️ **Gen2 requires Fabric capacity** - Gen1 works on Pro, Gen2 does not

⚠️ **Staging lakehouse is automatic** - Don't be confused by the extra lakehouse

⚠️ **Incremental refresh needs query folding** - Not all sources support it

⚠️ **Pipelines consume CU** - Factor into capacity planning

---

## Resources

- [Dataflows Gen2 Overview](https://learn.microsoft.com/fabric/data-factory/dataflows-gen2-overview)
- [Data Pipelines Overview](https://learn.microsoft.com/fabric/data-factory/data-factory-overview)
- [Dataflow Gen1 vs Gen2](https://learn.microsoft.com/fabric/data-factory/compare-dataflow-gen1-gen2)
- [Pipeline Activities](https://learn.microsoft.com/fabric/data-factory/activity-overview)

---

## Standalone Usage

This section works well for Power BI users who already do ETL with Power Query and want to understand the Fabric options.

**Standalone prerequisites:**
- Fabric workspace access
- Lakehouse (or create one at start of session)
- Power Query familiarity

**Standalone title suggestion:** "From Power Query to Pipelines: Modern ETL in Microsoft Fabric"

---

## Folder Contents

```
04-dataflows-pipelines/
├── README.md           # This file
├── pdf/                # Presentation slides (PDF)
└── lab/                # Dataflow and Pipeline exercise
```

---

| [← Previous: Data Centralization](../03-data-centralization/README.md) | [🏠 Home](../README.md) | [Next: Direct Lake →](../05-direct-lake/README.md) |
|:--|:--:|--:|
