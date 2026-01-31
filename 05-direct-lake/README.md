# Section 5: Direct Lake

**Large Dataset Handling & Performance Optimization**

---

| [← Previous: Dataflows & Pipelines](../04-dataflows-pipelines/README.md) | [🏠 Home](../README.md) | [Next: Security →](../06-security/README.md) |
|:--|:--:|--:|

---

## Workshop Sections

| # | Section | Duration | |
|---|---------|----------|--|
| 01 | [Strategic Context](../01-strategic-context/README.md) | 45 min | |
| 02 | [CI/CD & Git Integration](../02-cicd-git-integration/README.md) | 45 min | |
| 03 | [Data Centralization](../03-data-centralization/README.md) | 60 min | |
| 04 | [Dataflows & Pipelines](../04-dataflows-pipelines/README.md) | 60 min | |
| **05** | **Direct Lake** | **45 min** | ⬅️ You are here |
| 06 | [Security](../06-security/README.md) | 40 min | |
| 07 | [Copilot](../07-copilot/README.md) | 45 min | |

---

## 📂 Section Contents

| Resource | Description |
|----------|-------------|
| [📝 Slide Content](./slides/slides-content.md) | Key concepts from the presentation |
| [🎬 Demo Design](./demos/demo-design.md) | Demo script & setup |
| [🧪 Lab: Direct Lake Model](./lab/direct-lake-model.md) | Hands-on exercise |

---

## Overview

| | |
|---|---|
| **Duration** | 45 minutes |
| **Level** | Intermediate-Advanced |
| **Prerequisites** | Lakehouse with data from Section 3-4 (or run quick start) |
| **Hands-on** | Medium |

---

## Learning Objectives

By the end of this section, you will be able to:

- ✅ Explain the differences between Import, DirectQuery, and Direct Lake
- ✅ Understand how Direct Lake reads data from Parquet files
- ✅ Create a Direct Lake semantic model
- ✅ Identify Direct Lake fallback scenarios
- ✅ Understand model size limits across Pro and Fabric SKUs

---

## Topics Covered

### 1. Storage Modes Comparison

| Mode | Data Location | Performance | Refresh Needed? |
|------|---------------|-------------|-----------------|
| **Import** | In-memory (model) | Fastest queries | Yes |
| **DirectQuery** | Source system | Variable | No |
| **Direct Lake** | OneLake (Parquet) | Near-import speed | No* |

*Direct Lake automatically loads data into memory as needed

### 2. How Direct Lake Works
- Data stored as Delta Parquet in Lakehouse/Warehouse
- No ETL into the model—reads directly from storage
- Memory-mapped file access
- Automatic caching and eviction
- "Best of both worlds": DirectQuery freshness + Import performance

### 3. The Magic Behind Direct Lake
```
┌─────────────────────────────────────────────────────────────┐
│                      User Query                              │
│                           ↓                                  │
│              ┌───────────────────────┐                      │
│              │   Semantic Model      │                      │
│              │   (Direct Lake mode)  │                      │
│              └───────────────────────┘                      │
│                           ↓                                  │
│              ┌───────────────────────┐                      │
│              │   Memory Mapping      │                      │
│              │   (VertiPaq engine)   │                      │
│              └───────────────────────┘                      │
│                           ↓                                  │
│              ┌───────────────────────┐                      │
│              │   OneLake Storage     │                      │
│              │   (Delta Parquet)     │                      │
│              └───────────────────────┘                      │
└─────────────────────────────────────────────────────────────┘
```

### 4. Direct Lake Fallback
- When does Direct Lake "fall back" to DirectQuery?
- Common fallback triggers:
  - Unsupported DAX functions
  - Too many columns/tables
  - Calculated columns (some scenarios)
- How to monitor fallback
- Impact on performance

### 5. Model Size Limits

| License/SKU | Max Model Size |
|-------------|----------------|
| **Power BI Pro** | 1 GB |
| **Fabric F2** | 3 GB |
| **Fabric F4** | 6 GB |
| **Fabric F8** | 12 GB |
| **Fabric F16** | 24 GB |
| **Fabric F32** | 48 GB |
| **Fabric F64+** | 100+ GB |

### 6. Breaking the 1GB Barrier
- Why model size matters for growing organizations
- Strategies before Fabric (aggregations, DirectQuery)
- Direct Lake as the modern solution
- ROI of moving to Fabric for large models

### 7. Hybrid Tables and Incremental Refresh
- What are hybrid tables?
- Combining import and DirectQuery partitions
- Use case: Historical data (import) + recent data (live)
- Incremental refresh + Direct Lake = powerful combination

---

## Demo Ideas

### Demo 1: Create a Direct Lake Semantic Model
- From Lakehouse, create new semantic model
- Show automatic Direct Lake mode
- Build a simple report
- Verify no refresh scheduled

### Demo 2: Performance Comparison
- Same data, same report
- Compare: Import model vs DirectQuery vs Direct Lake
- Show query times
- Discuss tradeoffs

### Demo 3: Monitor Fallback Behavior
- Create query that triggers fallback
- Use Profiler/Monitoring tools
- Show DirectQuery fallback indicator
- Fix the issue and verify

---

## Lab Exercise

**Duration:** 20 minutes

### Hands-on: Direct Lake Semantic Model

1. Open your Lakehouse from previous sections
2. Create a new semantic model (Direct Lake mode)
3. Add relationships between tables
4. Create a few measures
5. Build a test report
6. Use Performance Analyzer to examine query behavior

See [lab/direct-lake-model.md](./lab/direct-lake-model.md) for step-by-step instructions.

---

## Key Takeaways

1. **Direct Lake is not DirectQuery** - It's fundamentally different
2. **No refresh scheduling** - Data is always "live" from Lakehouse
3. **Fallback is important to understand** - Monitor and optimize
4. **Model size limits are SKU-dependent** - Plan capacity accordingly
5. **This is THE killer feature** - For large datasets, Direct Lake changes everything

---

## Power BI User Perspective

| What you know (Power BI Pro) | What's new (Fabric Direct Lake) |
|------------------------------|----------------------------------|
| Import mode, schedule refresh | No refresh, reads from Lakehouse |
| 1 GB model limit | SKU-dependent, up to 100+ GB |
| DirectQuery for live data | Direct Lake: live + fast |
| ETL in Power Query | ETL in Lakehouse/Dataflows, model just reads |

---

## Common Gotchas

⚠️ **Not all DAX triggers fallback** - Test your specific measures

⚠️ **Calculated columns can cause issues** - Prefer Lakehouse transformations

⚠️ **Framing matters** - Tables need proper framing to avoid fallback

⚠️ **V-Order optimization helps** - Ensure data is V-Order compressed

---

## Resources

- [Direct Lake Overview](https://learn.microsoft.com/fabric/get-started/direct-lake-overview)
- [Direct Lake Fallback](https://learn.microsoft.com/power-bi/enterprise/directlake-overview#fallback)
- [Capacity SKU Limits](https://learn.microsoft.com/fabric/enterprise/licenses)
- [Best Practices for Direct Lake](https://learn.microsoft.com/fabric/get-started/direct-lake-best-practices)

---

## Standalone Usage

This section is excellent for organizations hitting model size limits or frustrated with refresh times.

**Standalone prerequisites:**
- Fabric workspace with Lakehouse
- Data loaded in Lakehouse
- Basic semantic modeling knowledge

**Standalone title suggestion:** "Direct Lake Deep Dive: Fast Queries on Large Data Without Refresh"

---

## Folder Contents

```
05-direct-lake/
├── README.md           # This file
├── slides/             # Presentation slides
├── demos/              # Demo scripts and comparison tests
└── lab/                # Direct Lake model creation exercise
```

---

| [← Previous: Dataflows & Pipelines](../04-dataflows-pipelines/README.md) | [🏠 Home](../README.md) | [Next: Security →](../06-security/README.md) |
|:--|:--:|--:|
