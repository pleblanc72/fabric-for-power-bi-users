# Workshop Prerequisites

Complete these steps **before** the workshop to ensure you can follow along with all demos and labs.

---

## Required Access

### 1. Microsoft Fabric Capacity

You need access to a Fabric capacity (trial or paid). Choose one option:

**Option A: Fabric Trial (Recommended for individuals)**
1. Go to [https://app.fabric.microsoft.com](https://app.fabric.microsoft.com)
2. Sign in with your work or school account
3. Click your profile icon → "Start trial"
4. The trial provides 60 days of Fabric capacity

**Option B: Organizational Fabric Capacity**
- If your organization has Fabric capacity, ensure you have Contributor access to a workspace on that capacity

> ⚠️ **Important:** Power BI Pro licenses alone are NOT sufficient for this workshop. You need Fabric capacity for Lakehouse, Warehouse, Notebooks, and Direct Lake features.

### 2. Power BI Desktop

Download and install the latest version:
- [Download Power BI Desktop](https://powerbi.microsoft.com/desktop/)
- Version required: December 2025 or later

**Enable TMDL View (required for Section 06):**
1. Open Power BI Desktop
2. File → Options and settings → Options
3. Preview features → ✅ **TMDL View**
4. Click OK and restart Desktop

### 3. GitHub Account

Required for the CI/CD & Git Integration section:
- [Create a free GitHub account](https://github.com/signup) if you don't have one
- You'll need to create a repository during the lab

### 4. Web Browser

- Microsoft Edge or Google Chrome (latest version)
- Firefox works but some Fabric features render better in Chromium browsers

---

## Recommended (Optional)

### Azure Data Studio or VS Code
Useful for exploring SQL endpoints:
- [Download Azure Data Studio](https://docs.microsoft.com/sql/azure-data-studio/download)
- [Download VS Code](https://code.visualstudio.com/)

### Python Environment
For the Semantic Link section, having a local Python environment helps for testing:
- Python 3.10 or later
- Libraries: `semantic-link`, `pandas`

> Note: We'll primarily use Fabric Notebooks in the workshop, so local Python is optional.

---

## Pre-Workshop Setup Checklist

Complete these tasks before arriving:

- [ ] **Fabric access confirmed** - Can you open [app.fabric.microsoft.com](https://app.fabric.microsoft.com) and see a workspace?
- [ ] **Create a workshop workspace** - Create a new workspace named `Fabric Workshop - [YourName]`
- [ ] **Power BI Desktop installed** - Open it and sign in with your Fabric account
- [ ] **GitHub account ready** - Can you log in to [github.com](https://github.com)?
- [ ] **Download sample data** - See [00-shared/data/](./00-shared/data/) for files to download

---

## Verifying Your Setup

### Test 1: Fabric Workspace
1. Go to [app.fabric.microsoft.com](https://app.fabric.microsoft.com)
2. Create a new workspace (or use an existing one)
3. In the workspace, click **+ New** → You should see options for Lakehouse, Warehouse, Notebook, etc.
4. If you only see Power BI items (Report, Dashboard, Dataset), you don't have Fabric capacity access

### Test 2: Create a Lakehouse
1. In your workspace, click **+ New** → **Lakehouse**
2. Name it `test_lakehouse`
3. If it creates successfully, you're ready!
4. You can delete it after testing

### Test 3: GitHub Connectivity
1. Log in to [github.com](https://github.com)
2. Create a new empty repository named `fabric-workshop-test`
3. You can delete it after testing

---

## Troubleshooting

### "I don't see Lakehouse/Warehouse options"
- Your workspace is not on Fabric capacity
- Ask your admin to assign the workspace to a Fabric capacity, OR
- Start a personal Fabric trial

### "My trial won't start"
- Trials require a work/school account (not personal @outlook.com)
- Your organization may have disabled trials—contact your admin

### "I can't connect to GitHub from Fabric"
- Check if your organization blocks GitHub integration
- You may need to use Azure DevOps instead (we'll provide alternative instructions)

---

## Section-Specific Prerequisites

Some sections have additional requirements:

| Section | Additional Prereqs |
|---------|-------------------|
| 02 - CI/CD & Git | GitHub account (or Azure DevOps) |
| 05 - Direct Lake | Notebook for data modifications (Spark SQL) |
| 06 - Security | Power BI Desktop with **TMDL View** enabled; **XMLA read/write** on workspace |
| 07 - Copilot | Power BI Desktop; Copilot enabled on your Fabric capacity |

> **Note on Copilot:** Some organizations disable Copilot features. If Copilot isn't available, you can still observe the demos but won't be able to do the hands-on labs for that section.

---

## Questions?

If you have setup issues before the workshop, contact: [Add contact info]
