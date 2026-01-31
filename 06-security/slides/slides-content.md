# Security in Fabric: Define Once, Enforce Everywhere

[← Back to Section 6: Security](../README.md)

> These are the key concepts from the presentation. Use this as a reference guide.

*"Your data is only as secure as your weakest access point."*

---

## The Story Continues

**Who Can See Our Margins?**

> *"Alex, these margin reports are great. But who else can see this? The supplier costs are confidential. Can you lock this down?"*

**The VP's concerns:**
- Supplier costs are negotiated rates—confidential
- Regional managers shouldn't see each other's data
- The intern just got Fabric access...

**The question every organization asks. Eventually.**

---

## What You Already Know

**Semantic Model RLS & OLS**

| Security Type | What It Does |
|---------------|--------------|
| **Row-Level Security (RLS)** | Filter rows by user identity |
| **Object-Level Security (OLS)** | Hide columns or tables |

**Example RLS:**
```dax
[Region] = USERPRINCIPALNAME()
```

**You've done this before.** It works great... for reports.

---

## The Multiple Doors Problem

**One Lock. Four Doors.**

```
                    ┌──────────────────┐
                    │ Your Lakehouse   │
                    │     Data         │
                    └────────┬─────────┘
                             │
         ┌───────────────────┼───────────────────┐
         │           │              │            │
         ▼           ▼              ▼            ▼
    ┌─────────┐ ┌─────────┐  ┌─────────┐  ┌─────────┐
    │ Report  │ │   SQL   │  │Notebook │  │ OneLake │
    │   ✅    │ │   ❌    │  │   ❌    │  │   ❌    │
    │ Secured │ │  OPEN   │  │  OPEN   │  │  OPEN   │
    └─────────┘ └─────────┘  └─────────┘  └─────────┘
```

**Semantic model RLS only locks ONE door.**

---

## The Real Risk

**How Users Bypass RLS**

| Access Method | Semantic Model RLS |
|---------------|-------------------|
| Power BI Report | ✅ Enforced |
| SQL Analytics Endpoint | ❌ **Full access** |
| Spark Notebook | ❌ **Full access** |
| OneLake APIs/Explorer | ❌ **Full access** |
| Excel via XMLA | ❌ **Full access** |

*"I'll just query the SQL endpoint directly..."*

**If they know the door exists, they can walk through it.**

---

## The Solution: OneLake Security

**Security at the DATA layer, not the compute layer.**

| Aspect | How It Works |
|--------|--------------|
| **Where defined** | Lakehouse (data item) |
| **Where enforced** | ALL access points |
| **What it secures** | Tables, rows, columns |
| **Who it applies to** | Everyone accessing the data |

**Define once. Enforced everywhere.**

---

## How OneLake Security Works

**One Definition. Every Door.**

```
                    ┌──────────────────┐
                    │  OneLake Security │
                    │     Roles         │
                    └────────┬─────────┘
                             │
         ┌───────────────────┼───────────────────┐
         │           │              │            │
         ▼           ▼              ▼            ▼
    ┌─────────┐ ┌─────────┐  ┌─────────┐  ┌─────────┐
    │ Report  │ │   SQL   │  │Notebook │  │ OneLake │
    │   ✅    │ │   ✅    │  │   ✅    │  │   ✅    │
    │ Secured │ │ Secured │  │ Secured │  │ Secured │
    └─────────┘ └─────────┘  └─────────┘  └─────────┘
```

**Same security definition. Every access point.**

---

## OneLake Security vs Alternatives

| Approach | Scope | Best For |
|----------|-------|----------|
| **OneLake Security** | All access to Lakehouse | Production data, multi-tool access |
| **Semantic Model RLS** | Reports only | Quick setup, report-specific logic |
| **Workspace Roles** | Entire workspace | Coarse access control (dev/test/prod) |
| **Source System Security** | External sources | Data that stays external (shortcuts) |

**Strategy:**
- Workspace roles = who can *administer*
- OneLake Security = who can *read what data*
- Semantic Model RLS = additional *report-specific* filtering

---

## Three Levels of Security

**Table → Row → Column**

| Level | What It Controls | Example |
|-------|------------------|---------|
| **Table** | Which tables users can see | Sales ✅, SupplierCosts ❌ |
| **Row (RLS)** | Which rows within a table | `Region = 'Pacific Northwest'` |
| **Column (CLS)** | Which columns within a table | Hide `SupplierCost` column |

**Combine them for precise control.**

---

## Creating a Data Access Role

1. Open Lakehouse → **Manage OneLake security**
2. Click **New** role
3. Name it (e.g., `Regional Manager - Pacific NW`)
4. Choose **Read** permission
5. Select specific tables/folders
6. (Optional) Add RLS predicates
7. (Optional) Hide columns (CLS)
8. Add members
9. **Save**

**Takes 2 minutes. Secures everything.**

---

## RLS Predicate Examples

| Scenario | Predicate |
|----------|-----------|
| Region filter | `Region = 'Pacific Northwest'` |
| User's own data | `OwnerEmail = @User` |
| Manager sees team | `ManagerID = @UserID` |
| Date range | `OrderDate >= '2025-01-01'` |

**Same SQL WHERE clause syntax you know.**

---

## Key Gotchas

| Gotcha | What to Know |
|--------|--------------|
| **5-minute delay** | Role changes take time to propagate |
| **Can't disable once enabled** | Preview limitation—commit before enabling |
| **DefaultReader role** | Gives everyone full access initially—modify or delete it |
| **250 roles max** | Plan your role strategy |
| **Preview status** | Production-ready, but check latest docs |

---

## When to Use What

| Scenario | Recommended Approach |
|----------|---------------------|
| Report-only consumers | Semantic model RLS (simple) |
| Multiple access points | **OneLake Security** (comprehensive) |
| Hiding sensitive columns | OneLake CLS + Semantic model OLS |
| Quick prototyping | Semantic model RLS (faster) |
| Production security | **OneLake Security** (no bypass) |
| IT-managed data | **OneLake Security** (centralized) |

---

## The VP's Question, Answered

| Before | After |
|--------|-------|
| RLS in semantic model only | Security at data layer |
| Multiple places to manage | Single definition |
| Gaps in coverage | All access points secured |
| Easy to bypass | No bypass possible |
| Worried VP | Confident VP |

*"Who can see our margins? Only the people you explicitly grant access to. Period."*

---

## Getting Started

1. ✅ Enable OneLake Security on your Lakehouse
2. ✅ Review the DefaultReader role
3. ✅ Create your first custom role
4. ✅ Test access via SQL endpoint (verify it works!)
5. ✅ Plan your production role strategy

**Key insight:** Define security at the data layer. Enforce everywhere.
