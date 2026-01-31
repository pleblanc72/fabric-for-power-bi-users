# Lab: Your First Fabric Git Workflow

**Duration:** 25 minutes

---

## Prerequisites

- [ ] Fabric workspace access
- [ ] GitHub account (create free at github.com if needed)
- [ ] GitHub Personal Access Token (PAT) - see Step 1.5 below
- [ ] Admin or Contributor role on your workspace

---

## Part 1: Setup (5 minutes)

### Step 1: Create a GitHub Repository

1. Go to [github.com](https://github.com) and sign in
2. Click the **+** icon → **New repository**
3. Configure:
   - **Name:** `fabric-git-lab`
   - **Visibility:** Private (recommended)
   - **Initialize:** Leave empty (no README, no .gitignore)
4. Click **Create repository**
5. Keep this tab open - you'll need the repo URL

### Step 1.5: Create a Personal Access Token (PAT)

Fabric uses Personal Access Tokens to connect to GitHub. This is more secure than password authentication.

> 💡 **Why PAT instead of OAuth?**
> - **Fine-grained control**: Limit access to specific repositories only
> - **Revocable**: Disable the token without affecting your GitHub account
> - **Auditable**: Token usage appears in your GitHub security log
> - **Time-limited**: Set an expiration date for better security

**Create your token:**

1. In GitHub, click your **profile picture** → **Settings**
2. Scroll to **Developer settings** (bottom of left sidebar)
3. Click **Personal access tokens** → **Fine-grained tokens**
4. Click **Generate new token**
5. Configure:
   - **Token name:** `Fabric Git Lab`
   - **Expiration:** 7 days (sufficient for this lab)
   - **Repository access:** Select **Only select repositories** → choose `fabric-git-lab`
   - **Permissions** (expand "Repository permissions"):
     - **Contents:** Read and write ✅
     - **Metadata:** Read-only (auto-selected) ✅
6. Click **Generate token**
7. **⚠️ COPY THE TOKEN NOW** - you won't see it again!
8. Paste it somewhere safe (Notepad, password manager)

> 🔐 **Security Best Practice**: Use Fine-grained tokens over Classic tokens. They follow the principle of least privilege—Fabric only gets access to what it needs.

> ⚠️ **Alternative: Classic Token** (if Fine-grained isn't available)
> If your organization hasn't enabled Fine-grained tokens:
> 1. Go to **Personal access tokens** → **Tokens (classic)**
> 2. Generate new token with scope: `repo` (full control of private repositories)
> 3. Note: Classic tokens grant broader access—Fine-grained is preferred when available

### Step 2: Create a Fabric Workspace

1. Go to [app.fabric.microsoft.com](https://app.fabric.microsoft.com)
2. Click **Workspaces** → **+ New workspace**
3. Name: `Git Lab - [YourName]`
4. Click **Apply**

---

## Part 2: Connect to Git (5 minutes)

### Step 3: Enable Git Integration

1. In your new workspace, click **Workspace settings** (gear icon)
2. Select **Git integration**
3. Click **Connect**
4. Choose **GitHub** as the provider
5. Click **Add account** to connect your GitHub
6. When prompted for authentication:
   - Enter your **Personal Access Token** (the one you created in Step 1.5)
   - Click **Connect** or **Save**
7. Select your **fabric-git-lab** repository from the dropdown
8. Branch: `main`
9. Folder: leave as `/` (root)
10. Click **Connect and sync**

> 💡 **What just happened?** Fabric securely stored your PAT and will use it for all Git operations with this repository. Your token is encrypted and not visible to other workspace users.

### Step 4: Verify Connection

1. Look for the Git status indicator in the workspace header
2. It should show "Synced" or similar
3. Check GitHub - you should see some initial files

---

## Part 3: Create and Commit (5 minutes)

### Step 5: Create a Semantic Model

1. In your workspace, click **+ New** → **Semantic model**
2. Choose **Manually enter data** (or connect to any available source)
3. Create a simple table:
   ```
   Product    | Sales
   Widget A   | 100
   Widget B   | 200
   Widget C   | 150
   ```
4. Name the model: `Lab Sales Model`
5. Save

### Step 6: Commit to Git

1. Notice the **uncommitted changes** indicator (should appear automatically)
2. Click the **Source control** icon in the workspace
3. Review the changes (your new model should be listed)
4. Enter commit message: `Add initial sales model`
5. Click **Commit**

### Step 7: Verify in GitHub

1. Go to your GitHub repository
2. You should see new folders/files
3. Navigate into the semantic model folder
4. Open a `.tmdl` file - notice it's readable text!

---

## Part 4: Modify and Diff (5 minutes)

### Step 8: Add a Measure

1. Open your semantic model in Fabric
2. Add a new measure:
   ```dax
   Total Sales = SUM('Table'[Sales])
   ```
3. Save

### Step 9: View and Commit the Change

1. Open the Source control panel
2. Notice the modified item
3. Click to see the diff (what changed)
4. Commit with message: `Add Total Sales measure`

### Step 10: View History in GitHub

1. Go to GitHub → your repository
2. Click **Commits** (or the commit count)
3. You should see two commits
4. Click into the second commit
5. View the diff - you can see exactly what TMDL changed

---

## Part 5: The Recovery Exercise (5 minutes)

This is the "Friday Disaster" moment—experience why Git is your safety net!

### Step 11: Break Something (Intentionally!)

1. Open your semantic model
2. **Make a breaking change** - add a measure with a common DAX mistake:
   ```dax
   % of Company Revenue = DIVIDE([Total Revenue], [Total Revenue])
   ```
   *(This is wrong! We forgot `ALL()` to remove filter context - every store will show 100%)*
3. Save the model
4. **Commit** with message: `Add % of Company Revenue - Friday 4pm`

### Step 12: Realize the Mistake

Imagine it's Monday morning. The VP says "Every store shows 100% of company revenue - that's impossible!"

### Step 13: Recover Using Git

**Option A: Undo Before Committing (if you haven't committed yet)**
1. Go to Source control in Fabric
2. Find the changed item
3. Click **Undo** (reverts to last committed state)

**Option B: Use Git History to Identify and Fix (recommended for this exercise)**
1. Go to GitHub → your repository → **Commits**
2. Find your "Add % of Company Revenue - Friday 4pm" commit
3. Click into the commit to view the diff
4. **See exactly what you did wrong:** `DIVIDE([Total Revenue], [Total Revenue])`
5. Now you know the fix - go back to Fabric
6. Edit the measure with the correct DAX:
   ```dax
   % of Company Revenue = DIVIDE([Total Revenue], CALCULATE([Total Revenue], ALL(Stores)))
   ```
7. Save and commit: `Fix % of Company Revenue - add ALL() for correct filter context`

> 💡 **Key Learning:** Git doesn't just let you undo - it shows you **exactly what changed**, so you understand the problem and can fix it properly.

**Option C: Restore from Previous Commit (nuclear option)**
1. In GitHub, find the commit BEFORE your Friday change
2. Click **`<>`** to browse the repository at that point
3. Copy the correct TMDL content
4. Restore manually in Fabric, or use Git CLI to checkout and push

### Step 14: Verify Recovery

1. Open your semantic model
2. Test the measure in a visual - stores should now show different percentages
3. Check your commit history - you have a full audit trail!

> 🎉 **Congratulations!** You just survived a "Friday Disaster" using Git. You saw exactly what went wrong and fixed it with confidence.

---

## Bonus Challenge: Conflict Resolution

If you have extra time:

1. Make a change in Fabric (don't commit yet)
2. In GitHub, edit a file directly (different part of the model)
3. Try to commit from Fabric
4. Observe the conflict warning
5. Resolve by pulling first, then committing

---

## Reflection Questions

After completing the lab, consider:

1. How does this compare to your current version control (if any) for Power BI?
2. What would code review look like for semantic model changes?
3. How might you structure branches for Dev/Test/Prod?

---

## Troubleshooting

**"I can't see the Git integration option"**
- Ensure your workspace is on a Fabric capacity
- Check that Git integration is enabled for your tenant

**"Authentication failed"**
- Verify your PAT hasn't expired (check GitHub → Settings → Developer settings → Personal access tokens)
- Ensure the PAT has the correct permissions (Contents: Read and write)
- If using Fine-grained tokens, confirm the specific repository is selected
- Try generating a new token and reconnecting

**"Repository not showing in dropdown"**
- Your PAT may not have access to that repository
- For Fine-grained tokens: Edit the token and add the repository under "Repository access"
- For Classic tokens: Ensure the `repo` scope is selected

**"Sync is taking forever"**
- Large models take longer
- Check network connectivity
- Try refreshing the page

**"Token expired"**
- Generate a new PAT in GitHub
- In Fabric: Workspace settings → Git integration → Update credentials

---

## Clean Up

When finished:
1. You can delete the workspace (won't affect GitHub)
2. You can delete the GitHub repo if desired
3. Or keep them for future reference!
