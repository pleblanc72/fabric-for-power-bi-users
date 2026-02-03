# Section 06: Security in Fabric - Demo Design

[← Back to Section 6: Security](../README.md)

## The Story: "Who Can See Our ACTUAL Costs?"

**Continuing from Section 05:** Direct Lake is working beautifully. The CFO sees real-time variance data. But then the VP pulls you aside with a concerned look...

**Scenario:** The VP says: *"This variance analysis is powerful—maybe too powerful. The ACTUAL supplier costs are confidential. If competitors knew what we're really paying, they could undercut us. And I don't want store managers seeing the cost overruns—that's executive information only. Can you lock this down?"*

**The challenge:**
- **Budgeted costs** (Products.UnitCost) = OK for everyone to see
- **Actual supplier costs** (SupplierCosts.SupplierCost) = Executives only
- **Variance data** = Finance and executives only
- Regional managers should only see their own stores
- Different people access data through different tools (reports, SQL, notebooks)
- **How do you secure SOME columns but not others, consistently across ALL access points?**
- **Enter: OneLake Security with Column-Level Security (CLS)**

---

## The Narrative Arc

| Act | What Happens | Emotion | Lesson |
|-----|--------------|---------|--------|
| 1 | VP's security concern | Recognition | "I've worried about this too" |
| 2 | Semantic model RLS (familiar) | Comfort | "I know how to do this" |
| 3 | The "multiple doors" problem | Concern | "Wait, there are gaps?" |
| 4 | OneLake Security introduction | Relief | "Define once, enforce everywhere" |
| 5 | RLS + CLS in OneLake | Confidence | "Now I can truly secure data" |

---

## Characters (Continuing from Previous Sections)

- **Alex** - The report developer (you, demoing)
- **The VP** - Concerned about who can see actual supplier costs
- **Regional Managers** - Should only see their own region's data (and only budgeted costs)
- **Finance Team** - Can see variance data but not raw supplier costs
- **Executives** - Full access to actual costs and variance
- **IT Manager** - Wants one place to manage security

---

## Pre-Demo Setup Checklist

### Already Done (from Previous Sections)
- [x] Lakehouse: `SalesLakehouse` with Sales, Products, Stores, SupplierCosts
- [x] Direct Lake semantic model connected
- [x] Sample data with multiple regions/stores

### New for This Section
- [ ] **Power BI Desktop** installed (latest version)
- [ ] **TMDL View preview feature enabled** in Desktop:
  - File → Options → Preview features → ✅ TMDL View
- [ ] **XMLA read/write enabled** on workspace (for connecting to remote models)
- [ ] Enable OneLake Security preview on your Lakehouse
- [ ] Create test users or use yourself with different scenarios
- [ ] Have a column that should be hidden (e.g., SupplierCost)
- [ ] Have a column for filtering (e.g., Region, StoreID)

### Browser Tabs / Apps Ready
1. **Power BI Desktop** (connected to semantic model)
2. Fabric portal (workspace)
3. Lakehouse with OneLake Security panel
4. SQL analytics endpoint (to test security)

---

## DEMO SCRIPT

---

### ACT 1: "The VP's Concern" (3 minutes)

**You say:**
> "Our Direct Lake reports are humming. The CFO loves the variance analysis—they can see exactly where we're over budget on supplier costs. But then the VP corners me after a meeting..."

**Narrate the scenario:**
> *"Alex, this variance analysis is powerful—maybe too powerful. The ACTUAL supplier costs are confidential. We negotiated those rates, and if competitors found out what we're really paying, they could undercut us. Store managers should see the BUDGETED costs—that's fine—but not the actual invoiced costs. And definitely not the variance. Can you lock this down?"*

**You say:**
> "This is THE question every organization eventually asks. You've built amazing analytics. Now you need to secure them—but selectively. Budgeted costs are fine for everyone. Actual costs? Executives only. Let me show you how Fabric handles this."

---

### ACT 2: "What You Already Know - Semantic Model RLS" (8 minutes)

**You say:**
> "If you've done security in Power BI before, you probably know Row-Level Security in the semantic model. Let me quickly show you what that looks like."

#### Demo 2.1: Show Semantic Model RLS (Brief Review)

**Do:**
1. Open your Direct Lake semantic model
2. Go to **Model view** or **Security** settings
3. Show or create a role:
   - Role name: `Regional Manager - Pacific Northwest`
   - DAX filter: `[Region] = "Pacific Northwest"`

**You say:**
> "This is familiar. I create a role, write a DAX filter, and assign users. When Sarah from the Pacific Northwest region views a report, she only sees Pacific Northwest data. Classic RLS."

#### Demo 2.2: Show OLS (Object-Level Security) via TMDL in Power BI Desktop

**You say:**
> "RLS filters rows. But what about hiding entire columns? That's Object-Level Security—OLS. Here's the catch: you can't configure OLS in the Power BI web UI. You need to use TMDL."

**Do:**
1. Open **Power BI Desktop**
2. Connect to your semantic model:
   - Home → **Power BI semantic models** (or use OneLake data hub)
   - Select your **Sales Analytics** model
   - Click **Connect**
3. Go to **Model view**
4. Click the **TMDL view** tab (bottom of screen)
5. In the TMDL explorer, navigate to **Roles** → expand your role
6. Show the TMDL structure and add OLS:

```tmdl
role 'Regional Manager - Pacific Northwest'
    modelPermission: read

    /// RLS: Filter to Pacific Northwest only
    tablePermission Stores
        filterExpression: [Region] = "Pacific Northwest"

    /// OLS: Hide sensitive cost columns
    tablePermission ProductMarginAnalysis
        columnPermission SupplierCost
            metadataPermission: none
        columnPermission ActualMargin
            metadataPermission: none
        columnPermission CostVariance
            metadataPermission: none
```

7. **Save** (Ctrl+S) — changes sync directly to the service

**You say:**
> "The `metadataPermission: none` setting hides the column completely—it won't even appear in the field list. The intern can see sales data but not our confidential supplier costs. The column simply doesn't exist for them.
>
> Power BI Desktop's TMDL view lets us edit the model definition directly—including security configurations that aren't available in the regular UI."

#### Demo 2.3: The Limitation

**You say:**
> "This works great... for reports. But here's the problem..."

**Show this scenario:**

```
┌─────────────────────────────────────────────────────────────┐
│                    THE MULTIPLE DOORS PROBLEM               │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│    ┌─────────────┐   RLS defined here                       │
│    │  Semantic   │ ─────────────────▶ ✅ Secured            │
│    │   Model     │                                          │
│    └─────────────┘                                          │
│                                                             │
│    ┌─────────────┐   No RLS here!                          │
│    │    SQL      │ ─────────────────▶ ❌ Full access        │
│    │  Endpoint   │                                          │
│    └─────────────┘                                          │
│                                                             │
│    ┌─────────────┐   No RLS here!                          │
│    │  Notebook   │ ─────────────────▶ ❌ Full access        │
│    │  (Spark)    │                                          │
│    └─────────────┘                                          │
│                                                             │
│    ┌─────────────┐   No RLS here!                          │
│    │  OneLake    │ ─────────────────▶ ❌ Full access        │
│    │   APIs      │                                          │
│    └─────────────┘                                          │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

**You say:**
> "If a user knows how to write SQL, they can query the SQL analytics endpoint directly—and bypass your RLS. If they use a Spark notebook, same thing. If they use the OneLake APIs or file explorer—full access to the Parquet files.
>
> Your semantic model RLS is like locking the front door but leaving the back door, garage, and windows open."

**Pause for effect:**
> "This is why OneLake Security matters."

---

### ACT 3: "The Problem - Multiple Access Points" (5 minutes)

**You say:**
> "Let me prove this isn't hypothetical. Watch what happens when I query the data through different tools."

#### Demo 3.1: Query via Report (Secured)

**Do:**
1. Open a report connected to the semantic model with RLS
2. Show it filters correctly for the assigned role/user

**You say:**
> "Through the report—secured. I only see Pacific Northwest data."

#### Demo 3.2: Query via SQL Endpoint (Exposed!)

**Do:**
1. Open the SQL analytics endpoint
2. Run: `SELECT * FROM SupplierCosts`
3. Show ALL data appears—no filtering

**You say:**
> "Through SQL? I see everything. Every region. Every supplier cost. The semantic model RLS doesn't apply here."

#### Demo 3.3: The IT Manager's Nightmare

**You say:**
> "Now imagine managing security across dozens of semantic models, each with their own RLS definitions. And separately managing SQL endpoint permissions. And notebook access. It's a nightmare.
>
> What if you could define security ONCE and have it enforced EVERYWHERE?"

---

### ACT 4: "OneLake Security - Define Once, Enforce Everywhere" (15 minutes)

**You say:**
> "OneLake Security is the answer. Instead of securing at the compute layer—semantic models, SQL, notebooks—you secure at the DATA layer. The security travels with the data."

#### Demo 4.1: Enable OneLake Security (Preview)

**Do:**
1. Go to your Lakehouse
2. Click **Manage OneLake security (preview)**
3. Acknowledge the preview dialog
4. Show the security panel opens

**You say:**
> "OneLake Security is in preview, but it's available now. Once enabled, you can create data access roles that apply to everyone accessing this Lakehouse—regardless of what tool they use."

#### Demo 4.2: Understanding the Default Role

**Do:**
1. Show the **DefaultReader** role that was auto-created
2. Explain it grants all users with ReadAll permission full access

**You say:**
> "When you enable OneLake Security, Fabric creates a DefaultReader role. This preserves existing access—anyone who could see data before can still see it. To start restricting, we'll either modify this role or delete it and create custom roles."

#### Demo 4.3: Create a Table-Level Security Role

**Do:**
1. Click **New** to create a role
2. Name it: `Sales Only - No Costs`
3. Permission: **Read**
4. Select **Selected data** (not all data)
5. Browse Lakehouse → Select only:
   - `Sales` table
   - `Products` table
   - `Stores` table
   - (Do NOT select `SupplierCosts`)
6. Add a test user or yourself
7. Save the role

**You say:**
> "I've created a role that can see Sales, Products, and Stores—but NOT SupplierCosts. The intern gets this role. They can build reports on sales data but can't see our confidential supplier costs."

#### Demo 4.4: Test the Security

**Do:**
1. If possible, switch to the test user context (or show what they'd see)
2. Try to query `SupplierCosts` via SQL endpoint
3. Show access is denied

**You say:**
> "Now watch. The same user who could see everything before... tries to query SupplierCosts... ACCESS DENIED. And this applies whether they try through SQL, Spark, Power BI, or the OneLake API. One definition. Enforced everywhere."

#### Demo 4.5: Show the Architecture

**Show this diagram:**

```
┌─────────────────────────────────────────────────────────────┐
│              ONELAKE SECURITY - ONE DEFINITION              │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│                    ┌─────────────────┐                      │
│                    │    OneLake      │                      │
│                    │    Security     │                      │
│                    │    Roles        │                      │
│                    └────────┬────────┘                      │
│                             │                               │
│              ┌──────────────┼──────────────┐                │
│              │              │              │                │
│              ▼              ▼              ▼                │
│    ┌─────────────┐ ┌─────────────┐ ┌─────────────┐         │
│    │  Semantic   │ │    SQL      │ │  Notebook   │         │
│    │   Model     │ │  Endpoint   │ │  (Spark)    │         │
│    │    ✅       │ │     ✅      │ │     ✅      │         │
│    └─────────────┘ └─────────────┘ └─────────────┘         │
│                                                             │
│              Same security. Every access point.             │
└─────────────────────────────────────────────────────────────┘
```

**You say:**
> "This is the paradigm shift. Security at the DATA layer, not the compute layer. Define it once in OneLake, and every tool respects it."

---

### ACT 5: "Row and Column Level Security in OneLake" (7 minutes)

**You say:**
> "Table-level security is great, but what about filtering rows or hiding specific columns? OneLake Security supports that too."

#### Demo 5.1: Add Row-Level Security

**Do:**
1. Edit an existing role or create a new one: `Pacific Northwest Manager`
2. Select the `Sales` table
3. Click the **...** menu → **Row-level security**
4. Add a predicate:
   ```sql
   Region = 'Pacific Northwest'
   ```
5. Save

**You say:**
> "Now this role can only see rows where Region equals Pacific Northwest. When they query through ANY tool—SQL, Spark, Power BI—they only see their region's data."

#### Demo 5.2: Add Column-Level Security

**Do:**
1. On the same role, click **...** → **Column-level security**
2. Hide the `SupplierCost` column
3. Save

**You say:**
> "And I can hide specific columns. The regional manager can see sales data but not the supplier costs column. It simply doesn't exist for them."

#### Demo 5.3: The Combined Power

**You say:**
> "Now I have:
> - **Table-level:** They can only access Sales, Products, Stores
> - **Row-level:** They only see Pacific Northwest rows
> - **Column-level:** They can't see SupplierCost
>
> All defined in ONE place. All enforced EVERYWHERE."

---

### Wrap-Up: Security Strategy (2 minutes)

**You say:**
> "Let's bring it back to the VP's question: 'Who can see our margins?'
>
> **Before OneLake Security:**
> - RLS in the semantic model (but only for reports)
> - Separate SQL permissions (maybe)
> - Notebooks? Good luck.
> - Multiple places to manage. Easy to miss something.
>
> **After OneLake Security:**
> - Define security at the DATA layer
> - Enforced across ALL compute engines
> - Single source of truth
> - No bypass possible
>
> My recommendation: Start using OneLake Security now, even in preview. It's the future of Fabric security, and it solves problems that were impossible to solve before."

---

## Key Talking Points to Hit

1. **"Multiple doors problem"** - Semantic model RLS only secures one access point
2. **"Define once, enforce everywhere"** - OneLake Security's key value
3. **"Data layer, not compute layer"** - Paradigm shift
4. **"Table, Row, Column"** - Three levels of granularity
5. **"Preview but production-ready"** - Encourage adoption now

---

## Backup Plans

| If this happens... | Do this... |
|-------------------|------------|
| OneLake Security not enabled | Enable it live (takes seconds) |
| Can't create test users | Use your own account and explain what users would see |
| RLS predicate errors | Have a simple predicate ready to paste |
| Security not applying immediately | Mention 5-minute propagation delay |

---

## Timing Summary

| Segment | Time |
|---------|------|
| Act 1: VP's Concern | 3 min |
| Act 2: Semantic Model RLS | 8 min |
| Act 3: Multiple Doors Problem | 5 min |
| Act 4: OneLake Security | 15 min |
| Act 5: RLS + CLS in OneLake | 7 min |
| Wrap-up | 2 min |
| **Total** | **~40 min** |

---

## Connection to Other Sections

| Section | How This Connects |
|---------|-------------------|
| **Section 03** | OneLake Security protects shortcuts too! |
| **Section 04** | Dataflow output tables can be secured |
| **Section 05** | Direct Lake respects OneLake Security |
| **Section 07** | Copilot respects security (won't show hidden data) |

---

## Security Comparison Quick Reference (for slides)

| Security Type | Where Defined | Where Enforced | Best For |
|---------------|---------------|----------------|----------|
| Semantic Model RLS | Semantic model | Reports only | Report consumers |
| Semantic Model OLS | Semantic model | Reports only | Hiding columns/tables |
| SQL Endpoint Security | SQL endpoint | SQL queries only | SQL users |
| **OneLake Security** | **Lakehouse** | **ALL access points** | **Everything** |

---

## Terminology Cheat Sheet

| Term | Meaning |
|------|---------|
| **OneLake Security** | Data-layer security with roles, RLS, CLS |
| **Data Access Role** | A role that grants access to specific tables/folders |
| **DefaultReader** | Auto-created role giving ReadAll users full access |
| **Table-level security** | Granting access to specific tables |
| **Row-level security (RLS)** | Filtering rows based on predicates |
| **Column-level security (CLS)** | Hiding columns from users |
| **Virtual members** | Dynamic membership based on permissions |

---

## Preview Limitations to Mention

| Limitation | Impact |
|------------|--------|
| 5-minute propagation | Changes aren't instant |
| 250 roles max | Usually enough, but plan accordingly |
| Can't turn off once enabled | Commit before enabling |
| Some engines not supported yet | Eventhouse, Warehouse external tables planned |
| Distribution lists in SQL | May not resolve correctly |
