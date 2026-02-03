# Section 05: Direct Lake Semantic Models - Demo Design

[← Back to Section 5: Direct Lake](../README.md)

## The Story: "The Report That Refreshes Itself"

**Continuing from Section 04:** Your Dataflow Gen2 pipeline is running weekly, transforming supplier data and landing it in the Lakehouse. The VP is thrilled—margins are accurate, automation is working. But then the CFO walks in...

**Scenario:** The CFO says: *"These reports are great, but I'm tired of waiting for refreshes. When the supplier data updates Monday morning, I want to see it immediately—not after lunch when the semantic model finally refreshes. And our dataset is getting big. Last refresh took 45 minutes."*

**The challenge:**
- Import mode: Fast queries, but slow refreshes and stale data
- DirectQuery: Real-time data, but slow queries
- **What if you could have BOTH?**
- **Enter: Direct Lake**

---

## The Narrative Arc

| Act | What Happens | Emotion | Lesson |
|-----|--------------|---------|--------|
| 1 | CFO's frustration | Recognition | "I've felt this pain too" |
| 2 | The storage mode trilemma | Clarity | "There's always been a tradeoff" |
| 3 | Create a Direct Lake model | Wonder | "Wait, this is automatic?" |
| 4 | See the magic happen | Amazement | "No refresh needed!" |
| 5 | Understand the mechanics | Confidence | "I know how this works" |

---

## Characters (Continuing from Previous Sections)

- **Alex** - The report developer (you, demoing)
- **The CFO** - Wants real-time data AND fast reports
- **The VP** - Still happy about margins, now wants speed
- **IT Manager** - Concerned about refresh windows and capacity

---

## Pre-Demo Setup Checklist

### Already Done (from Previous Sections)
- [x] Lakehouse: `SalesLakehouse` with Sales, Products, Stores, Calendar, Targets
- [x] SupplierCosts and SupplierCostsTransformed tables (Delta format)
- [x] Dataflow Gen2 pipeline running
- [x] Git integration connected

### New for This Section
- [ ] Ensure tables have enough rows to make the point (at least a few thousand)
- [ ] Have a way to add/modify data in Lakehouse (notebook with Spark SQL)
- [ ] Timer or stopwatch ready for comparing refresh times
- [ ] (Optional) Existing Import mode semantic model for comparison

### Browser Tabs Ready
1. Fabric portal (workspace)
2. Lakehouse open
3. Power BI report connected to Import model (for comparison)
4. Notebook attached to Lakehouse (for live data changes)

---

## DEMO SCRIPT

---

### ACT 1: "The CFO's Frustration" (3 minutes)

**You say:**
> "Our automation is humming. The pipeline runs every Monday at 6 AM, transforms supplier data, lands it in the Lakehouse. Life is good. But then the CFO walks in..."

**Narrate the scenario:**
> *"I love these margin reports. But it's Monday at 9 AM, I know the supplier sent new prices, and my report still shows last week's data. When does this thing refresh?"*

**You say:**
> "You explain: 'The semantic model refreshes at noon.' The CFO: 'Noon? I need this for my 10 AM meeting!' And here's the real kicker—that refresh takes 45 minutes because we're copying 50 million rows into the model."

**Pause for effect:**
> "This is the classic Power BI tradeoff. And until Fabric, there wasn't a great answer."

---

### ACT 2: "The Storage Mode Trilemma" (5 minutes)

**You say:**
> "Let me show you the problem we've been living with for years."

#### Demo 2.1: Show the Classic Options

**Draw or show this on screen:**

```
┌─────────────────────────────────────────────────────────────┐
│                  THE STORAGE MODE TRILEMMA                  │
├─────────────────┬─────────────────┬─────────────────────────┤
│    IMPORT       │  DIRECTQUERY    │      DIRECT LAKE        │
├─────────────────┼─────────────────┼─────────────────────────┤
│ ✅ Fast queries │ ❌ Slower queries│ ✅ Fast queries         │
│ ❌ Stale data   │ ✅ Real-time    │ ✅ Near real-time       │
│ ❌ Long refresh │ ✅ No refresh   │ ✅ Seconds to refresh   │
│ ❌ Data copied  │ ✅ No copy      │ ✅ No copy              │
└─────────────────┴─────────────────┴─────────────────────────┘
```

**You say:**
> "Import mode: We copy all the data into the model. Queries are blazing fast because everything is in memory. But the data is stale until we refresh, and large refreshes can take forever.
>
> DirectQuery: No copy. Every report click hits the database. Real-time data! But queries can be slow, and you're hammering your source system.
>
> For years, we've been choosing between these two. Fast OR fresh. Pick one."

**Pause:**
> "Direct Lake changes this equation."

---

### ACT 3: "Creating a Direct Lake Semantic Model" (12 minutes)

**You say:**
> "Here's the beautiful part: when you create a semantic model from a Lakehouse in Fabric, Direct Lake is the DEFAULT storage mode. Let me show you."

#### Demo 3.1: Create a Direct Lake Semantic Model

**Do:**
1. Go to your `SalesLakehouse`
2. Click **New semantic model** in the toolbar
3. Name it: `Sales Analytics`
4. Select the tables to include (Sales, Products, Stores, etc.)
5. Click **Confirm**

**You say:**
> "That's it. I selected my tables, clicked Confirm, and now I have a semantic model. Notice I didn't have to choose Import or DirectQuery—it's automatically Direct Lake."

#### Demo 3.2: Verify It's Direct Lake

**Do:**
1. Open the semantic model settings
2. Show the **storage mode** or **Direct Lake** indicator
3. Point out that tables are Direct Lake mode

**You say:**
> "Look here—every table is Direct Lake. Not Import. Not DirectQuery. Direct Lake. This means it reads directly from the Delta tables in OneLake."

#### Demo 3.3: The View Exception - Why the Swap Mattered

**You say:**
> "Remember in Section 04, we swapped the view for the Dataflow table? Let me show you exactly why that mattered."

**Do:**
1. Open the Sales Analytics semantic model
2. If the view is still there, show its storage mode: **DirectQuery**
3. Show the `SupplierCostsTransformed` table: **Direct Lake**

**You say:**
> "There it is. The view is DirectQuery, the table is Direct Lake. Same columns, same calculations—completely different performance characteristics."

**Show the comparison:**

| Object Type | Storage Mode | Performance |
|-------------|--------------|-------------|
| Delta Table | Direct Lake | ✅ Fast (VertiPaq engine) |
| Shortcut Table | Direct Lake | ✅ Fast (VertiPaq engine) |
| Dataflow Output Table | Direct Lake | ✅ Fast (VertiPaq engine) |
| SQL View | DirectQuery | ⚠️ Query-time compute |

**You say:**
> "Direct Lake reads directly from Delta Parquet files. A view isn't a file—it's a query that runs every time someone opens the report. No Parquet file, no Direct Lake.
>
> This is why we did the swap in Section 04. We started with a view to ship fast. Then we used a Dataflow to materialize those calculations as a table. Now Finance gets their variance report at VertiPaq speed.
>
> The lesson: Views are great for prototyping and real-time calculations. But when performance matters, materialize to a table."

#### Demo 3.4: Build a Quick Report

**Do:**
1. Click **New report** from the semantic model
2. Add a visual (e.g., total sales by store, or margin by product)
3. Show it renders fast

**You say:**
> "Let me build a quick report. Notice how fast the visuals render. This is VertiPaq—the same engine that powers Import mode. Same speed. But the data isn't copied into the model."

---

### ACT 4: "The Magic Moment" (10 minutes)

**You say:**
> "Now let's see why the CFO will love this. I'm going to change data in the Lakehouse and show you what happens."

#### Demo 4.1: Show Current Data

**Do:**
1. In your report, show a specific value (e.g., total sales = $1,234,567)
2. Or show a specific product's supplier cost
3. Note the current value

**You say:**
> "Right now, total sales shows $1,234,567. Let me go change the data in the Lakehouse."

#### Demo 4.2: Modify Data in the Lakehouse

**Do:**
1. Open a notebook attached to your Lakehouse
2. Run a Spark SQL UPDATE statement:
   ```python
   %%sql
   -- Update a supplier cost to simulate the weekly price change
   UPDATE SalesLakehouse.SupplierCosts 
   SET SupplierCost = SupplierCost + 0.50 
   WHERE ProductID = 1001;
   ```

> **Note:** UPDATE/DELETE operations on Delta tables require Spark SQL. The SQL analytics endpoint is read-only for data modification.

**You say:**
> "I just updated the supplier cost. In Import mode, this change would be invisible until the next scheduled refresh—maybe tonight, maybe tomorrow."

#### Demo 4.3: Refresh the Report

**Do:**
1. Go back to the report
2. Click **Refresh** on the visual (or refresh the page)
3. Show the updated value

**You say:**
> "Now watch... [click refresh] ...and there it is! The new data is already visible. No semantic model refresh. No waiting. The report reads directly from the Delta table."

#### Demo 4.4: Explain What Happened

**You say:**
> "What just happened? Direct Lake doesn't store data—it reads metadata about where the data lives. When the Delta table changed, the semantic model saw the new Parquet files and loaded the new values on demand.
>
> This is called **transcoding**—loading columns into memory when they're needed. And **framing**—pointing to the latest version of the Delta tables.
>
> The CFO's Monday morning problem? Solved. Data updates at 6 AM, reports show it by 6:01 AM."

---

### ACT 5: "Understanding the Mechanics" (8 minutes)

**You say:**
> "Let's dig a little deeper so you understand what's happening under the hood."

#### Demo 5.1: Framing vs Refresh

**Show this diagram:**

```
Traditional Import Mode:
┌──────────┐    Copy all data    ┌──────────────┐
│  Source  │ ─────────────────▶  │ Semantic     │  ⏱️ 45 minutes
│  Data    │    (scheduled)      │ Model        │
└──────────┘                     └──────────────┘

Direct Lake Mode:
┌──────────┐    Read metadata    ┌──────────────┐
│  Delta   │ ─────────────────▶  │ Semantic     │  ⏱️ Seconds
│  Tables  │    (on demand)      │ Model        │
└──────────┘                     └──────────────┘
```

**You say:**
> "Import mode copies every row. Direct Lake copies only metadata—a few kilobytes about where the Parquet files live. That's why 'refresh' takes seconds, not minutes."

#### Demo 5.2: Show Automatic Updates Setting

**Do:**
1. Go to semantic model settings
2. Find the **"Keep your Direct Lake data up to date"** setting (or similar)
3. Show it's enabled by default

**You say:**
> "By default, Direct Lake has automatic updates enabled. When Delta tables change, the model automatically picks up the new data. You can disable this if you need point-in-time consistency—like during an ETL window."

#### Demo 5.3: Capacity Guardrails (Brief)

**You say:**
> "Direct Lake does have limits based on your Fabric SKU. For example, F64 supports tables up to 5 billion rows and 1,500 columns per table. If you exceed these guardrails, queries fall back to DirectQuery mode—still works, just slower.
>
> For most workloads, you'll never hit these limits. And if you do, you just need a bigger SKU."

**Show the guardrails table briefly** (or reference it):

| SKU | Max rows per table | Max columns per table |
|-----|-------------------|----------------------|
| F2-F8 | 1 billion | 300 |
| F16-F32 | 1 billion | 300-1,500 |
| F64+ | 5 billion | 1,500 |

#### Demo 5.4: What Doesn't Work (Gotchas)

**You say:**
> "A few things to know:
> 1. **Calculated columns** defined in the semantic model aren't supported on Direct Lake tables—do your calculations in the Lakehouse instead
> 2. **Complex data types** like binary or GUID need to be converted to strings
> 3. **RLS on the SQL endpoint** can cause DirectQuery fallback—define RLS in the semantic model instead
>
> But for most Power BI use cases? Direct Lake just works."

---

### Wrap-Up (2 minutes)

**You say:**
> "Let's bring it back to the CFO's problem:
> - **Before Direct Lake:** 45-minute refresh, stale data until noon, frustrated executives
> - **After Direct Lake:** Seconds to refresh, near real-time data, happy CFO
>
> You get Import-mode speed with DirectQuery-style freshness. That's Direct Lake.
>
> And the best part? Creating one is simple—just click 'New semantic model' from your Lakehouse and select your tables. Direct Lake is automatic."

---

## Key Talking Points to Hit

1. **"Best of both worlds"** - Import speed + DirectQuery freshness
2. **"It's automatic"** - Create from Lakehouse, Direct Lake is the default mode
3. **"Framing, not refreshing"** - Metadata only, seconds not hours
4. **"Your data stays in OneLake"** - No duplication, single source of truth
5. **"Same VertiPaq engine"** - Your DAX skills transfer perfectly

---

## Backup Plans

| If this happens... | Do this... |
|-------------------|------------|

| Data change doesn't appear | Check automatic updates setting, or manually refresh the semantic model |
| Query seems slow | Might be DirectQuery fallback—check for unsupported features |
| Notebook won't run Spark SQL | Ensure notebook is attached to Lakehouse; check capacity is running |

---

## Timing Summary

| Segment | Time |
|---------|------|
| Act 1: CFO's Frustration | 3 min |
| Act 2: Storage Mode Trilemma | 5 min |
| Act 3: Create Direct Lake Model | 12 min |
| Act 4: The Magic Moment | 10 min |
| Act 5: Understanding Mechanics | 8 min |
| Wrap-up | 2 min |
| **Total** | **~40 min** |

---

## Connection to Other Sections

| Section | How This Connects |
|---------|-------------------|
| **Section 03** | Direct Lake reads the Lakehouse tables we created |
| **Section 04** | Dataflow output tables work perfectly with Direct Lake |
| **Section 06** | Semantic Link lets notebooks query this semantic model |
| **Section 07** | Copilot can help write DAX for Direct Lake reports |

---

## Import vs Direct Lake Quick Reference (for slides)

| Aspect | Import Mode | Direct Lake |
|--------|-------------|-------------|
| **Data location** | Copied into model | Stays in OneLake |
| **Refresh time** | Minutes to hours | Seconds (framing) |
| **Query engine** | VertiPaq | VertiPaq |
| **Query speed** | ⚡ Fast | ⚡ Fast |
| **Data freshness** | Stale until refresh | Near real-time |
| **Calculated columns** | ✅ Supported | ❌ Do in Lakehouse |
| **Capacity required** | Pro or Premium | Fabric capacity |
| **Default mode** | No | Yes (when created from Lakehouse) |

---

## Terminology Cheat Sheet

| Term | Meaning |
|------|---------|
| **Framing** | The lightweight "refresh" that updates metadata pointers to Delta tables |
| **Transcoding** | Loading column data into memory on-demand when queries need it |
| **Automatic updates** | Setting that keeps Direct Lake synced with Delta table changes |
| **DirectQuery fallback** | When Direct Lake can't load data directly and falls back to querying SQL endpoint |
| **Guardrails** | Capacity limits (rows, columns, parquet files) based on Fabric SKU |
