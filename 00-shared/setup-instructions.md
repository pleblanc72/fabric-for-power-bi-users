# Shared Resources & Setup Instructions

This folder contains resources used across multiple workshop sections.

---

## Folder Structure

```
00-shared/
├── data/               # Sample datasets
├── images/             # Shared diagrams and screenshots
└── setup-instructions.md  # This file
```

---

## Sample Data

We use a simplified retail sales dataset throughout the workshop. This keeps the focus on Fabric concepts rather than data complexity.

### Dataset: Regional Retail Sales

| Table | Description | Rows (approx) |
|-------|-------------|---------------|
| `Sales` | Transaction-level sales data | 100,000 (configurable) |
| `Products` | Product catalog (outdoor/sporting goods) | 65 |
| `Stores` | Store locations (Pacific Northwest) | 12 |
| `Calendar` | Date dimension (2023-2025) | 1,096 |
| `Targets` | Monthly revenue targets by store | ~432 |
| `SupplierCosts` | Actual supplier invoice costs | 65 |

### File Formats Provided

- **CSV** - Static dimension data (Products, Stores, Calendar, Targets, SupplierCosts)
- **Notebook** - `01-Generate-Sales-Data.ipynb` generates Sales transactions in Lakehouse
- **TMDL** - Semantic model definition in `models/Sales Analytics.SemanticModel/`

---

## Quick Start Setup

If you're joining a section mid-workshop (or using a section standalone), run this setup to create the required Fabric items:

### Step 1: Create Lakehouse

1. Create a Lakehouse named `SalesLakehouse` in your workspace

### Step 2: Generate Sales Data

1. Import `notebooks/01-Generate-Sales-Data.ipynb` into your workspace
2. Attach the notebook to your Lakehouse
3. Run all cells
4. This creates: Products, Stores, Calendar, Targets, and Sales tables

### Step 3: Upload Supplier Costs (for Sections 03+)

1. Upload `data/SupplierCosts.csv` to the Lakehouse Files section
2. Load as a Delta table (or use Shortcut Transformation in demo)

---

## Cross-Section Dependencies

| If you're starting at... | You need these items from previous sections |
|-------------------------|---------------------------------------------|
| Section 01 (Strategic) | None |
| Section 02 (CI/CD) | Lakehouse + Semantic Model (run quick start) |
| Section 03 (Data Centralization) | None (creates Lakehouse in demo) |
| Section 04 (Dataflows) | Lakehouse with SupplierCosts (from Section 3) |
| Section 05 (Direct Lake) | Lakehouse with data (from Section 3-4) |
| Section 06 (Security) | Direct Lake model (from Section 5) |
| Section 07 (Copilot) | Any semantic model or report |

---

## Shared Diagrams

The `images/` folder is reserved for diagrams used across multiple sections. See `images/README.md` for planned diagrams.

> **Note:** Diagrams are a future addition. The workshop content works without them.

---

## Resetting Your Environment

If something goes wrong and you need to start fresh:

1. Delete all items in your workshop workspace
2. Run the quick start setup notebook
3. You should be back to a clean state

---

## Data Attribution

The sample data is based on the Contoso dataset, modified and simplified for workshop purposes.
