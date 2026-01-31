# Dataflows Gen2 & Pipelines: Modern Data Integration

[← Back to Section 4: Dataflows & Pipelines](../README.md)

> These are the key concepts from the presentation. Use this as a reference guide.

*"Power Query you know. Destinations you need."*

---

## The Story Continues

**The Supplier Wants More:**

> *"We're updating pricing weekly now. We added new columns. And we need confirmation when you've loaded the data."*

**New requirements:**
- Transform the data (add calculations, clean values)
- Orchestrate (schedules, error handling)
- Notify (success/failure alerts)

**Shortcut Transformations** = just land the data

**Dataflows + Pipelines** = transform, orchestrate, notify

---

## You Already Know This

**Dataflows Gen2 = Power Query in the Cloud**

| Power BI Desktop | Dataflow Gen2 |
|------------------|---------------|
| Power Query Editor | Same interface |
| M code | Same language |
| Transformations | Same 300+ operations |
| Connectors | Same + more |
| Output → .pbix | Output → **Lakehouse, Warehouse, SQL, KQL** |

**Your skills transfer. The destinations upgrade.**

---

## Copilot in Dataflows

**Natural Language → M Code**

Your prompt:
> "Add a new column called Margin Potential that calculates UnitPrice minus SupplierCost"

Copilot writes:
```m
Table.AddColumn(#"Previous Step", "Margin Potential", each [UnitPrice] - [SupplierCost])
```

| What Copilot Does | What You Still Do |
|-------------------|-------------------|
| Writes M code | Review the output |
| Suggests transformations | Verify the logic |
| Speeds up authoring | Know the manual way |

**It's not magic. It's faster typing.**

---

## Gen1 vs Gen2

| Feature | Gen1 | Gen2 |
|---------|------|------|
| **Output** | Internal storage only | Lakehouse, Warehouse, SQL, KQL |
| **Access data** | Dataflow connector | Direct table access |
| **AutoSave** | ❌ | ✅ |
| **Pipeline integration** | Limited | Full |
| **Compute** | Mashup engine | Enhanced (faster) |
| **Monitoring** | Basic | Monitoring Hub |
| **Requires** | Pro or Premium | Fabric capacity |

**Gen2 is not a version bump. It's an architecture change.**

---

## Data Destinations

```
                    Dataflow Gen2
                         │
         ┌───────────────┼───────────────┐
         ▼               ▼               ▼
    ┌─────────┐    ┌─────────┐    ┌─────────┐
    │Lakehouse│    │Warehouse│    │Azure SQL│
    │ Tables  │    │ Tables  │    │Database │
    └─────────┘    └─────────┘    └─────────┘
```

**Transform once. Land where you need it.**

---

## Pipelines = Orchestration

| Dataflows | Pipelines |
|-----------|-----------|
| Transform data | Coordinate activities |
| Single task | Multiple steps |
| Run manually or scheduled | Run on triggers, schedules, events |
| No logic | If/ForEach/Until |
| No notifications | Email, Teams, webhooks |

**Dataflows do the work. Pipelines run the show.**

---

## Pipeline Flow

```
┌─────────────────┐     Success     ┌─────────────────┐
│   Dataflow:     │────────────────▶│  Email: Success │
│ Transform Data  │                 └─────────────────┘
└────────┬────────┘
         │ Failure
         ▼
┌─────────────────┐
│  Email: Failure │
│  + IT Alert     │
└─────────────────┘
```

- **Green arrows:** On success
- **Red arrows:** On failure
- **No code.** Just drag, connect, configure.

---

## Same Engine as Azure Data Factory

| Capability | Fabric Pipelines |
|------------|------------------|
| Activities | 30+ built-in |
| Triggers | Schedule, event, on-demand |
| Control flow | If, ForEach, Until, Switch |
| Parameters | ✅ Dynamic values |
| Monitoring | Full run history |
| Lineage | Data lineage tracking |

**This is Azure Data Factory, integrated into Fabric.**

---

## When to Use What

| Scenario | Recommended Tool |
|----------|------------------|
| Simple ETL, know Power Query | **Dataflows Gen2** |
| Complex orchestration | **Pipelines** |
| Advanced transforms, ML prep | **Notebooks** |
| Just land external files | **Shortcut Transformations** |
| Low-code, business user | **Dataflows Gen2** |
| Code-first, data engineer | **Notebooks** |

**Not either/or. Combine them.**

---

## What About Notebooks?

| Use Dataflows Gen2 When... | Consider Notebooks When... |
|----------------------------|----------------------------|
| You know Power Query | You know Python/Spark |
| Standard transformations | Complex logic, loops |
| Business user friendly | Data engineer/scientist work |
| Low-code preferred | Code-first preferred |
| Quick wins | ML feature engineering |

**Notebooks aren't "better." They're different.**

If you're a Power BI user:
- Start with **Dataflows Gen2** (your skills transfer)
- Graduate to **Notebooks** when you hit limits

---

## Key Gotchas

| Gotcha | What to Know |
|--------|--------------|
| **Gen2 requires Fabric capacity** | Gen1 works on Pro, Gen2 does not |
| **Staging Lakehouse is automatic** | Don't delete the DataflowsStaging items |
| **Pipeline ≠ Dataflow** | Pipelines orchestrate, Dataflows transform |
| **Email activities need connection** | Set up Office 365 connection first |
| **First publish creates staging items** | Normal behavior, not an error |

---

## Getting Started

1. ✅ Create a Dataflow Gen2
2. ✅ Apply transformations (use your Power Query skills)
3. ✅ Output to Lakehouse table
4. ✅ Wrap it in a Pipeline
5. ✅ Add notifications and schedule

**Key insight:** Transform with Dataflows. Orchestrate with Pipelines.
