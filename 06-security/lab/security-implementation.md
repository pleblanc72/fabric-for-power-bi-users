# Lab: Implementing Security in Microsoft Fabric

[← Back to Section 6: Security](../README.md)

**Duration:** 25 minutes

---

## Objectives

By the end of this lab, you will have:
- Implemented Row-Level Security (RLS) in a semantic model
- Enabled OneLake Security on a Lakehouse
- Created data access roles with table-level restrictions
- Configured row-level and column-level security in OneLake
- Tested security across different access points

---

## Prerequisites

- [ ] Direct Lake semantic model from Section 05
- [ ] Lakehouse with Sales, Products, Stores tables
- [ ] Fabric workspace with Contributor access or higher

---

## The Scenario

The VP has asked you to secure the analytics environment:

> *"Regional managers should only see their own region's data. And nobody outside Finance should see the supplier costs. Can you lock this down?"*

You'll implement security at two levels:
1. **Semantic model RLS** - For backward compatibility with reports
2. **OneLake Security** - For comprehensive data-layer protection

---

## Part 1: Semantic Model Row-Level Security (8 minutes)

### Step 1: Open Your Semantic Model

1. Go to your Fabric workspace
2. Find your Direct Lake semantic model (`Sales Analytics Model` or similar)
3. Click to open it in the web modeling experience

### Step 2: Create a Security Role

1. In the model view, click **Manage roles** (in the toolbar)
2. Click **New** to create a role
3. Configure the role:
   - **Name:** `Pacific Northwest Manager`
   - Click the **Stores** table
   - Enter this DAX filter expression:
     ```dax
     [Region] = "Pacific Northwest"
     ```
4. Click **Save**

### Step 3: Create a Second Role

1. Click **New** again
2. Configure:
   - **Name:** `Mountain Region Manager`
   - Table: **Stores**
   - DAX filter:
     ```dax
     [Region] = "Mountain"
     ```
3. Click **Save**

### Step 4: Test with "View As" Role

1. In the modeling toolbar, click **View as**
2. Check the box for **Pacific Northwest Manager**
3. Click **OK**
4. Observe: The data preview now shows only Pacific Northwest stores
5. Try a measure—it calculates only for filtered data
6. Click **Stop viewing** when done

### Step 5: Add Object-Level Security via TMDL (Hide Columns)

> **Important:** OLS cannot be configured in the Power BI web UI. You must use TMDL (via Git) or Tabular Editor.

1. Open VS Code with your Git-synced workspace
2. Navigate to your semantic model folder:
   ```
   Sales Analytics.SemanticModel/
   ├── definition/
   │   ├── roles/
   │   │   └── Pacific Northwest Manager.tmdl
   ```
3. Open (or create) the role file: `Pacific Northwest Manager.tmdl`
4. Add OLS configuration to hide sensitive columns:

   ```tmdl
   role 'Pacific Northwest Manager'
       modelPermission: read

       /// RLS: Filter to Pacific Northwest only
       tablePermission Stores
           filterExpression: [Region] = "Pacific Northwest"

       /// OLS: Hide sensitive cost columns from this role
       tablePermission ProductMarginAnalysis
           columnPermission SupplierCost
               metadataPermission: none
           columnPermission ActualMargin
               metadataPermission: none
           columnPermission CostVariance
               metadataPermission: none
   ```

5. Save the file
6. Commit and sync to Fabric:
   ```
   git add .
   git commit -m "Add OLS to hide cost columns from regional managers"
   git push
   ```
7. In Fabric, verify the sync completed

> 💡 **Tip:** The `metadataPermission: none` setting hides the column completely—it won't appear in the field list for users in this role.

**✅ Checkpoint:** You now have RLS AND OLS in your semantic model. But remember—this only protects report access!

---

## Part 2: Enable OneLake Security (5 minutes)

### Step 6: Navigate to Your Lakehouse

1. Go to your Fabric workspace
2. Open your Lakehouse (`SalesLakehouse` or similar)
3. Make sure you can see your tables in the Tables section

### Step 7: Enable OneLake Security

1. In the Lakehouse toolbar, click **Manage OneLake security** 
   - (Or find it under the **...** menu)
2. Read the preview acknowledgment
3. Click **Enable**

> ⚠️ **Note:** Once enabled, OneLake Security cannot be disabled. This is a one-way change.

### Step 8: Understand the Default Role

1. After enabling, you'll see a **DefaultReader** role
2. This role gives all existing users with ReadAll permission full access
3. This preserves backward compatibility—nothing breaks initially

**✅ Checkpoint:** OneLake Security is now active. Time to create restrictive roles!

---

## Part 3: Create OneLake Data Access Roles (7 minutes)

### Step 9: Create a Table-Restricted Role

1. In the OneLake Security panel, click **+ New**
2. Configure the role:
   - **Name:** `Sales Analyst - No Costs`
   - **Permission:** Read
   - **Data access:** Selected data
3. In the table picker, select:
   - ✅ `Sales`
   - ✅ `Products`
   - ✅ `Stores`
   - ✅ `Calendar`
   - ❌ `SupplierCosts` (leave unchecked!)
4. Click **Create**

### Step 10: Add Row-Level Security

1. Find the role you just created
2. Click the **...** menu → **Edit**
3. Click on the `Stores` table
4. Click **Add row filter** (or similar option)
5. Enter the predicate:
   ```sql
   Region = 'Pacific Northwest'
   ```
6. Click **Save**

### Step 11: Add Column-Level Security (OneLake CLS)

> **Note:** This is OneLake column-level security (different from semantic model OLS). OneLake CLS is configured in the Lakehouse security panel and enforces across ALL access points.

1. Still editing the role in OneLake Security panel
2. Click on a table (e.g., `ProductMarginAnalysis`)
3. Look for **Column permissions** or **Manage columns** option
4. If available, hide these columns:
   - `SupplierCost`
   - `ActualMargin` (if sensitive)
5. Click **Save**

> ⚠️ **Preview Note:** OneLake column-level security UI may have limited availability. If the option isn't visible, OneLake CLS may require API/SDK configuration. Table-level and row-level security are the most commonly available features.

### Step 12: Assign Users (Optional)

1. In the role settings, find **Members**
2. Add test users or note the users who should have this role
3. For now, you can add yourself to test

> 💡 **Tip:** In production, use Azure AD groups for easier management

**✅ Checkpoint:** You've created a comprehensive OneLake Security role with table, row, AND column restrictions!

---

## Part 4: Test Security Across Access Points (5 minutes)

### Step 13: Test via SQL Endpoint

1. Go to your workspace
2. Open the **SQL analytics endpoint** for your Lakehouse
3. Run this query:
   ```sql
   SELECT TOP 10 * FROM SupplierCosts
   ```
4. **If using DefaultReader:** You'll see data
5. **If restricted role:** You should see an access denied error

### Step 14: Test via Semantic Model

1. Open a report connected to your Direct Lake model
2. If RLS is active, verify you only see filtered data
3. Check that hidden columns don't appear in the field list

### Step 15: Verify SQL Row Filtering

1. Back in SQL endpoint, run:
   ```sql
   SELECT DISTINCT Region FROM Stores
   ```
2. **Full access:** See all regions
3. **With RLS:** Should only see 'Pacific Northwest'

### Step 16: Document What You Observe

| Access Point | Without Security | With OneLake Security |
|--------------|------------------|----------------------|
| Report (Semantic Model) | All data | Filtered by role |
| SQL Endpoint | All data | Filtered by role |
| Notebook (Spark) | All data | Filtered by role |

---

## Reflection Questions

1. Why is OneLake Security called "define once, enforce everywhere"?

2. What happens if someone tries to query SupplierCosts through a Spark notebook after you've restricted it?

3. In what scenario would you still use semantic model RLS instead of (or in addition to) OneLake Security?

4. How does OneLake Security help with compliance requirements like GDPR or SOC 2?

---

## Key Observations

| Security Type | Where Defined | Enforced In |
|---------------|---------------|-------------|
| Semantic Model RLS | Model settings | Reports only |
| Semantic Model OLS | Model settings | Reports only |
| OneLake Security | Lakehouse | ALL access points |

### The Paradigm Shift

```
OLD WAY:                          NEW WAY (OneLake Security):
┌─────────────┐                   ┌─────────────┐
│  Report RLS │ ✅                │  OneLake    │
└─────────────┘                   │  Security   │
┌─────────────┐                   └──────┬──────┘
│  SQL Perms  │ ❓ (separate)            │
└─────────────┘                   ┌──────┴──────┐
┌─────────────┐                   ▼      ▼      ▼
│  Spark ?    │ ❌              Report  SQL  Spark
└─────────────┘                   ✅     ✅     ✅
```

---

## Troubleshooting

**"OneLake Security option not showing"**
- Ensure you're in a Lakehouse (not Warehouse)
- Check that your Fabric capacity supports preview features
- Verify you have Admin permissions on the Lakehouse

**"Security changes not taking effect"**
- OneLake Security has a ~5 minute propagation delay
- Wait and retry your test query
- Clear any cached connections/sessions

**"Can't see the role I created"**
- Refresh the OneLake Security panel
- Ensure you clicked Save after creating the role

**"RLS predicate syntax error"**
- Use SQL syntax for OneLake Security predicates (not DAX)
- Example: `Region = 'Pacific Northwest'` (single quotes for strings)
- For semantic model RLS, use DAX: `[Region] = "Pacific Northwest"`

**"User still sees all data"**
- Check if they're in the DefaultReader role (gives full access)
- Remove them from DefaultReader if using custom roles
- Verify role membership is saved

---

## Bonus Challenge

### Create a Dynamic RLS Role

Instead of hardcoding `'Pacific Northwest'`, create a role that filters based on the user's email or department:

```sql
-- Example: Filter by user's region assignment from a mapping table
StoreID IN (
    SELECT StoreID 
    FROM UserStoreMapping 
    WHERE UserEmail = USER_NAME()
)
```

This requires a `UserStoreMapping` table in your Lakehouse with user-to-store assignments.

---

## Clean Up

**Keep these security configurations!** They demonstrate:
- Defense in depth (multiple security layers)
- The difference between semantic model and OneLake security
- How Fabric secures data across all access points

> ⚠️ **Note:** You cannot disable OneLake Security once enabled. In production, test thoroughly before enabling.

---

## Summary

You've implemented a comprehensive security solution:

| Layer | What You Did | What It Protects |
|-------|--------------|------------------|
| Semantic Model RLS | Region-based filtering | Report consumers |
| Semantic Model OLS | Hidden cost columns | Report consumers |
| OneLake Table Security | No access to SupplierCosts | ALL users |
| OneLake RLS | Region filtering in Stores | ALL users |
| OneLake CLS | Hidden sensitive columns | ALL users |

**Key takeaway:** OneLake Security provides "define once, enforce everywhere" protection that follows the data regardless of how it's accessed.
