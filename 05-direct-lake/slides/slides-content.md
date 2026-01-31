# Direct Lake: The Best of Both Worlds

[← Back to Section 5: Direct Lake](../README.md)

> These are the key concepts from the presentation. Use this as a reference guide.

*"Import speed. DirectQuery freshness. No compromise."*

---

## The Story Continues

**The CFO's Frustration:**

> *"It's Monday 9 AM. I know the supplier sent new prices. Why does my report show last week's data?"*

**The conversation:**
- "When does this refresh?" → *"Noon."*
- "Noon?! I need this at 10 AM!"
- "Well, the refresh takes 45 minutes..."

**The classic Power BI tradeoff.** Until now.

---

## The Trilemma (Before Direct Lake)

**Pick Two. You Can't Have All Three.**

```
                    ⚡ Fast Queries
                         /\
                        /  \
                       /    \
                      /      \
                     /        \
                    /__________\
           🔄 Fresh Data    💾 No Data Copy
```

| Mode | Fast Queries | Fresh Data | No Copy |
|------|--------------|------------|---------|
| **Import** | ✅ | ❌ | ❌ |
| **DirectQuery** | ❌ | ✅ | ✅ |
| **Direct Lake** | ✅ | ✅ | ✅ |

---

## What Is Direct Lake?

**A New Storage Mode**

| Aspect | How It Works |
|--------|--------------|
| **Reads from** | Delta tables in OneLake |
| **Query engine** | VertiPaq (same as Import) |
| **Refresh** | Metadata only (seconds) |
| **Data copy** | None—stays in OneLake |

**Same query speed as Import. Same freshness as DirectQuery.**

---

## How Direct Lake Works

**Framing, Not Refreshing**

```
IMPORT MODE:
┌──────────┐     Copy ALL data      ┌──────────────┐
│  Source  │ ──────────────────────▶│ Semantic     │
│   Data   │      (45 minutes)      │ Model        │
└──────────┘                        └──────────────┘

DIRECT LAKE:
┌──────────┐     Read metadata      ┌──────────────┐
│  Delta   │ ──────────────────────▶│ Semantic     │
│  Tables  │      (3 seconds)       │ Model        │
└──────────┘                        └──────────────┘
```

**Framing** = updating pointers to Parquet files

**Transcoding** = loading columns on-demand when queried

---

## It's the Default!

**You Might Already Have It**

When you create a **Lakehouse** in Fabric:

1. Fabric creates a **default semantic model**
2. That model is **Direct Lake** automatically
3. Tables point to Delta tables in OneLake
4. No configuration required

**Check your workspace.** Look for `[LakehouseName]` semantic model.

---

## The Magic Moment

| Step | What Happens |
|------|--------------|
| 1 | Report shows: Total Sales = $1,234,567 |
| 2 | You add $5,000 in sales via SQL endpoint |
| 3 | Refresh the report visual |
| 4 | Report shows: Total Sales = $1,239,567 |

**No semantic model refresh scheduled.**
**No waiting for data pipelines.**
**Just... updated.**

---

## Import vs Direct Lake

| Aspect | Import Mode | Direct Lake |
|--------|-------------|-------------|
| Data location | Copied into model | Stays in OneLake |
| Refresh time | Minutes to hours | Seconds |
| Query engine | VertiPaq | VertiPaq |
| Query speed | ⚡ Fast | ⚡ Fast |
| Data freshness | Stale until refresh | Near real-time |
| Calculated columns | ✅ Supported | ❌ Do in Lakehouse |
| Requires | Pro or Premium | Fabric capacity |

---

## Capacity Guardrails

| SKU | Max Rows/Table | Max Columns/Table | Max Parquet Files |
|-----|----------------|-------------------|-------------------|
| F2-F8 | 1 billion | 300 | 1,000 |
| F16-F32 | 1 billion | 300-1,500 | 1,000 |
| F64+ | 5 billion | 1,500 | 5,000-10,000 |

**If exceeded:** Queries fall back to DirectQuery mode (slower but still works)

**Pro tip:** Optimize your Delta tables to stay within guardrails

---

## Key Gotchas

| Gotcha | What to Know |
|--------|--------------|
| **No calculated columns** | Define them in Lakehouse/Dataflow instead |
| **Complex data types** | Binary, GUID must be strings |
| **SQL endpoint RLS** | Can trigger DirectQuery fallback |
| **Cross-region** | Lakehouse and semantic model must be same region |
| **Fabric capacity required** | Won't work on Pro-only |

---

## When to Use What

| Scenario | Recommended |
|----------|-------------|
| Large data, need freshness | **Direct Lake** |
| Self-service, quick prototyping | **Import** |
| Must hit source system directly | **DirectQuery** |
| Data already in Lakehouse | **Direct Lake** |
| Need calculated columns in model | **Import** (or calc in Lakehouse) |
| Composite model needed | **Mix them** |

---

## The CFO's Problem, Solved

| Before (Import) | After (Direct Lake) |
|-----------------|---------------------|
| Refresh at noon | Data ready by 6:01 AM |
| 45-minute refresh | 3-second framing |
| Stale data in meetings | Real-time insights |
| Frustrated CFO | Happy CFO |

*"When the data updates, the report updates. That's Direct Lake."*

---

## Getting Started

1. ✅ Check your Lakehouse for the default semantic model
2. ✅ Verify it's Direct Lake (check storage mode)
3. ✅ Build a report and test query speed
4. ✅ Modify data in Lakehouse, watch it appear
5. ✅ Move calculated columns to Lakehouse if needed

**Key insight:** You get Import-speed queries without Import-time refreshes.
