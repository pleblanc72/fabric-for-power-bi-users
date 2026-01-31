# Data Centralization: OneLake, Lakehouse & Shortcuts

> These are the key concepts from the presentation. Use this as a reference guide.

*"One lake. One copy. Zero ETL."*

---

## Data Silos Are Expensive

| The Old Way | The Cost |
|-------------|----------|
| Sales data in one place | Storage × N copies |
| Finance data somewhere else | ETL pipelines to maintain |
| Supplier data on their blob | "Which version is right?" |
| Marketing data in yet another lake | Security applied N times |

**Every copy = cost, complexity, risk**

---

## OneLake = OneDrive for Data

| OneDrive | OneLake |
|----------|---------|
| Your files | Your data |
| One place for everything | One lake for all analytics |
| Share with anyone | Query from any engine |
| Automatic sync | Automatic governance |
| You already know how to use it | Same simplicity, enterprise scale |

**If you understand OneDrive, you understand OneLake.**

---

## Before Fabric vs With Fabric

| Before Fabric | With Fabric |
|---------------|-------------|
| CSV → Import to Power BI | CSV → Lakehouse → Direct Lake |
| Data stuck in .pbix file | Data in OneLake, shared across org |
| Refresh = full reload | Refresh = incremental Delta sync |
| 1GB model limit | No practical limit |
| "Where's the source file?" | Single source of truth |
| Build ETL pipelines | Table Shortcuts (zero code) |

**Same skills. Better architecture.**

---

## OneLake Architecture

```
┌─────────────────────────────────────────────────────────┐
│                       OneLake                           │
│         (One ADLS Gen2 account per tenant)              │
│                                                         │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐     │
│  │ Workspace A │  │ Workspace B │  │ Workspace C │     │
│  │ ┌─────────┐ │  │ ┌─────────┐ │  │ ┌─────────┐ │     │
│  │ │Lakehouse│ │  │ │Warehouse│ │  │ │Lakehouse│ │     │
│  │ └─────────┘ │  │ └─────────┘ │  │ └─────────┘ │     │
│  └─────────────┘  └─────────────┘  └─────────────┘     │
└─────────────────────────────────────────────────────────┘
```

**All data in Delta Parquet format. Open. Queryable. Governed.**

---

## What is Delta Lake?

Delta = Parquet + Superpowers

| Feature | What It Means |
|---------|---------------|
| **Parquet files** | Columnar, compressed, fast |
| **Transaction log** | ACID transactions, no corruption |
| **Time travel** | Query data as of any point in time |
| **Schema enforcement** | Catch bad data before it lands |
| **Open format** | Spark, SQL, Python, Power BI—all can read it |

**This is why everything in Fabric becomes Delta.**

---

## Shortcut Transformations: The Zero-ETL Solution

| Traditional ETL | Shortcut Transformation |
|-----------------|------------------------|
| Build a pipeline | Click "New Table Shortcut" |
| Schedule refreshes | Auto-syncs every 2 minutes |
| Handle errors | Built-in monitoring |
| Maintain forever | Just... works |

**Supported:** CSV, Parquet, JSON (+ compression)

**Sources:** Azure Blob, ADLS, S3, GCS, SharePoint, OneDrive, Dataverse

---

## The Magic: CSV → Delta in 60 Seconds

```
  External CSV         Table Shortcut          Delta Table           SQL Query
      📄          ────▶      🔗        ────▶       📊         ────▶      🔍
                                                                    
 Supplier's blob       1-click setup        Auto-converted        Instant access
 Any cloud storage     Configure once       ACID transactions     No Spark needed
                       2-min auto-sync      Schema enforced       Power BI ready
```

**No pipelines. No code. No maintenance.**

When the source changes, your table updates automatically.

---

## Shortcut Types

| Type | Use Case | Data Movement |
|------|----------|---------------|
| **Internal** | Reference another Lakehouse/Warehouse in Fabric | None—just a pointer |
| **External** | Connect to S3, ADLS, GCS, SharePoint, etc. | None—reads from source |
| **Table Shortcut** | CSV/JSON/Parquet → Delta table | Copies & converts (auto-refresh) |

**Internal & External:** Zero copy, live reference

**Table Shortcut:** Copies once, syncs changes automatically

---

## Lakehouse vs Warehouse

| Scenario | Lakehouse | Warehouse |
|----------|-----------|-----------|
| Mix of structured + unstructured | ✅ | ❌ |
| Data engineering with Spark | ✅ | ❌ |
| Pure T-SQL development | Read-only | ✅ Full DML |
| Stored procedures & ETL | ❌ | ✅ |
| Data science / ML | ✅ | ❌ |
| Traditional star schema | ✅ Supported | ✅ Optimized |

**Both store data in Delta format in OneLake. Not either/or.**

---

## SQL Analytics Endpoint

Every Lakehouse automatically gets a SQL analytics endpoint:

| Can Do | Can't Do |
|--------|----------|
| SELECT queries | INSERT, UPDATE, DELETE |
| CREATE VIEW | CREATE TABLE |
| Stored procedures (read-only) | Full DML transactions |
| Query Delta tables | Query raw files directly |

**Perfect for:** Power BI, SSMS, any SQL tool

**Need full T-SQL?** Use a Warehouse instead.

---

## Key Gotchas

| Limitation | What It Means |
|------------|---------------|
| **Shortcuts respect permissions** | No access to source = no access via shortcut |
| **Table shortcuts are read-only** | Can't MERGE INTO or DELETE |
| **Files must share schema** | No schema drift in table shortcuts (yet) |
| **SQL endpoint is read-only** | Use Warehouse for full DML |
| **2-minute sync** | Not real-time—close, but not instant |

---

## Connection to Direct Lake (Section 05)

```
    Lakehouse                    Semantic Model
  ┌───────────┐                ┌──────────────┐
  │ Delta     │  Direct Lake   │  Power BI    │
  │ Tables    │ ──────────────▶│  Report      │
  └───────────┘   (no import)  └──────────────┘
```

**Direct Lake:** Power BI reads directly from your Delta tables.

No import. No DirectQuery latency. Best of both worlds.

---

## Getting Started

1. Create a Lakehouse
2. Upload a file, convert to Delta
3. Try a Table Shortcut (CSV → Delta magic)
4. Query via SQL analytics endpoint

**Key insight:** Put data in OneLake ONCE. Access it everywhere.
