# Section 6: Security

**OneLake Security, RLS & Column-Level Security**

---

| [← Previous: Direct Lake](../05-direct-lake/README.md) | [🏠 Home](../README.md) | [Next: Copilot →](../07-copilot/README.md) |
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
| **06** | **Security** | **40 min** | ⬅️ You are here |
| 07 | [Copilot](../07-copilot/README.md) | 45 min | |

---

## 📂 Section Contents

| Resource | Description |
|----------|-------------|
| [🎬 Demo Design](./demos/demo-design.md) | Demo script & setup |
| [🧪 Lab: Security Implementation](./lab/security-implementation.md) | Hands-on exercise |

---

## Overview

| | |
|---|---|
| **Duration** | 40 minutes |
| **Level** | Intermediate |
| **Prerequisites** | Direct Lake semantic model from Section 5 |
| **Hands-on** | Medium |

---

## Learning Objectives

By the end of this section, you will be able to:

- ✅ Implement Row-Level Security (RLS) in semantic models
- ✅ Enable OneLake Security on a Lakehouse
- ✅ Create data access roles with table-level restrictions
- ✅ Configure row-level and column-level security in OneLake
- ✅ Understand the "define once, enforce everywhere" paradigm

---

## Topics Covered

### 1. The "Multiple Doors" Problem
- Semantic model RLS only protects one access point
- SQL endpoint, notebooks, and APIs bypass semantic model security
- Why data-layer security matters

### 2. Semantic Model Security (Review)
- Row-Level Security (RLS) with DAX filters
- Object-Level Security (OLS) for hiding columns/tables
- Limitations: Only enforced through reports

### 3. OneLake Security
- Enable security at the data layer
- Data access roles
- Table-level restrictions
- "Define once, enforce everywhere"

### 4. Row-Level Security in OneLake
- SQL predicates for row filtering
- Dynamic security based on user context
- Applies across all compute engines

### 5. Column-Level Security
- Hide sensitive columns from specific roles
- Protecting confidential data (costs, salaries, etc.)
- Combining with RLS for comprehensive protection

---

## Demo Ideas

### Demo 1: The Security Gap
- Show RLS working in a report
- Query via SQL endpoint - bypass RLS!
- Demonstrate the problem

### Demo 2: Enable OneLake Security
- Enable security on Lakehouse
- Create data access roles
- Restrict table access

### Demo 3: Row and Column Level Security
- Add row-level filters (region-based)
- Hide sensitive columns
- Test across multiple access points

---

## Lab Exercise

**Duration:** 15 minutes

### Hands-on: Implementing Security

1. Enable OneLake Security on your Lakehouse
2. Create a role that restricts access to SupplierCosts table
3. Add row-level filtering for region
4. Test security via SQL endpoint
5. Verify column restrictions

See [lab/security-implementation.md](./lab/security-implementation.md) for step-by-step instructions.

---

## Key Takeaways

1. **"Multiple doors problem"** - Semantic model RLS only secures reports
2. **OneLake Security** - Define security at the data layer
3. **Enforced everywhere** - SQL, Spark, Power BI, APIs all respect it
4. **Three levels** - Table, row, and column security
5. **Preview but powerful** - Start using it now for comprehensive protection

---

## Security Comparison

| Security Type | Where Defined | Enforced In |
|---------------|---------------|-------------|
| Semantic Model RLS | Semantic model | Reports only |
| Semantic Model OLS | Semantic model | Reports only |
| OneLake Security | Lakehouse | ALL access points |

---

## Power BI User Perspective

| What you know (Power BI Pro) | What's new (Fabric) |
|------------------------------|---------------------|
| RLS in semantic models | OneLake Security at data layer |
| Object-level security | Column-level security in OneLake |
| Manage per model | Define once, apply everywhere |
| Report-only enforcement | All compute engines respect security |

---

## Common Gotchas

⚠️ **Can't disable once enabled** - OneLake Security is a one-way change

⚠️ **5-minute propagation** - Security changes aren't instant

⚠️ **Preview limitations** - Some features still evolving

⚠️ **DefaultReader role** - Preserves existing access; modify for restrictions

---

## Resources

- [OneLake Security Overview](https://learn.microsoft.com/fabric/onelake/security/onelake-security-overview)
- [Row-Level Security in Fabric](https://learn.microsoft.com/fabric/onelake/security/row-level-security)
- [Column-Level Security](https://learn.microsoft.com/fabric/onelake/security/column-level-security)

---

## Folder Contents

```
06-security/
├── README.md           # This file
├── slides/             # Presentation slides
├── demos/              # Demo scripts
└── lab/                # Security implementation exercise
```

---

| [← Previous: Direct Lake](../05-direct-lake/README.md) | [🏠 Home](../README.md) | [Next: Copilot →](../07-copilot/README.md) |
|:--|:--:|--:|
