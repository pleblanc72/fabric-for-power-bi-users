# Section 02: CI/CD & Git Integration - Demo Design

[← Back to Section 2: CI/CD & Git Integration](../README.md)

## The Story: "The Friday Afternoon Disaster"

**Why this works:** Every Power BI developer has lived this nightmare. We're turning their pain into a teaching moment.

**Scenario:** You are the Senior BI Analyst at a regional retail company with 12 store locations across the Pacific Northwest. You maintain sales dashboards for leadership.

---

## The Narrative Arc

| Act | What Happens | Emotion | Lesson |
|-----|--------------|---------|--------|
| 1 | Meet the team, see the "old way" | Recognition | "That's me!" |
| 2 | Connect to Git, feel the safety | Relief | "This is easy" |
| 3 | Friday disaster strikes | Tension | "Oh no..." |
| 4 | Git saves the day | Triumph | "I need this!" |
| 5 | Level up: branching & collaboration | Aspiration | "What else can I do?" |

---

## Characters (Relatable Personas)

- **Alex** - The report developer (you, demoing)
- **Sam** - A colleague who also edits reports (simulated via GitHub)
- **The VP** - Requests an "urgent" change on Friday at 4pm
- **Monday Morning You** - Discovers the mess

---

## Pre-Demo Setup Checklist

> 📋 **Detailed Setup Guide:** See [TECHNICAL-SETUP.md](./TECHNICAL-SETUP.md) for complete step-by-step instructions to build the semantic model and report.

### Data Setup (run once before workshop)
- [ ] Create a Lakehouse in Fabric: `SalesLakehouse`
- [ ] Upload and run notebook: `00-shared/notebooks/01-Generate-Sales-Data.ipynb`
- [ ] Verify tables created: Products, Stores, Calendar, Targets, Sales

### GitHub Setup
- [ ] Create repository: `sales-analytics-reports`
- [ ] Keep empty (no README, no .gitignore)
- [ ] Create a Personal Access Token (PAT) - see instructions below
- [ ] Have GitHub open in a browser tab

#### Creating a GitHub Personal Access Token (PAT)

Fabric requires a Personal Access Token to authenticate with GitHub. This is more secure than password authentication and gives you granular control over permissions.

**Why a PAT instead of OAuth?**
- **Fine-grained permissions**: You control exactly what Fabric can access
- **Revocable**: If compromised, revoke just the token, not your entire account
- **Auditable**: Tokens show up in your GitHub security log
- **Expiration**: Set an expiry date for added security

**Best Practice**: Use a **Fine-grained Personal Access Token** (newer, more secure) rather than a Classic token when possible.

**Steps to create a PAT:**
1. Go to GitHub → Click your profile picture → **Settings**
2. Scroll down to **Developer settings** (bottom of left sidebar)
3. Click **Personal access tokens** → **Fine-grained tokens** (recommended)
4. Click **Generate new token**
5. Configure:
   - **Token name**: `Fabric Workshop` (or descriptive name)
   - **Expiration**: 30 days (or your organization's policy)
   - **Repository access**: Select "Only select repositories" → choose your workshop repo
   - **Permissions** (under Repository permissions):
     - **Contents**: Read and write (required for sync)
     - **Metadata**: Read-only (auto-selected)
6. Click **Generate token**
7. **COPY THE TOKEN IMMEDIATELY** - you won't see it again!
8. Store it securely (password manager recommended)

> ⚠️ **Security Note**: Treat your PAT like a password. Never commit it to a repository or share it in chat/email.

### Fabric Setup
- [ ] Workspace: `Workshop-Dev` (Development)
- [ ] Workspace: `Workshop-Prod` (Production) - optional for advanced demo
- [ ] Lakehouse: `SalesLakehouse` with generated data
- [ ] Simple semantic model: "Sales Analytics" pointing to Lakehouse with:
  - Sales, Products, Stores, Calendar, Targets tables
  - 3-4 measures (Total Revenue, Total Quantity, Gross Margin %)
- [ ] Simple report: "Executive Dashboard" with a few visuals

### Browser Tabs Ready
1. Fabric portal (workspace)
2. GitHub repository
3. (Optional) Second browser/incognito for "Sam"

---

## DEMO SCRIPT

---

### ACT 1: "The Old Way" (3 minutes)

**[Don't connect Git yet - show the pain first]**

**You say:**
> "Let me show you what most of us are doing today. We have our workspace, our reports, everything's working fine..."

**Do:**
1. Open the workspace, show the semantic model and report
2. (Optional) Show Version History exists: Right-click semantic model → Version history
3. Point out: "5 versions max, 14 days, and can you see what changed? No diffs."

**You say:**
> "Now, Fabric does have Version History—up to 5 versions for 14 days. That's better than nothing. But can you see exactly what changed? Can you do code review before a colleague's change goes live? Can you branch and experiment safely? That's where Git changes everything."

**You say:**
> "Quick question - raise your hand if you've ever:
> - Made a change you couldn't undo?
> - Wondered 'wait, what did I change last week?'
> - Had two people editing the same report and someone's work got lost?
> 
> Yeah. Me too. Every single one of those."

**You say:**
> "Here's what happened to me. Friday, 4pm. VP asks for a 'quick change.' I make it. I go home. Monday morning... disaster. And I couldn't remember what I'd changed."

---

### ACT 2: "The Setup" (7 minutes)

**You say:**
> "Let's fix this. Forever. And it takes about 5 minutes."

#### Demo 2.1: Create the GitHub Repository

**Do:**
1. Go to GitHub → New repository
2. Name: `contoso-sales-reports`
3. Description: "Fabric workspace for Contoso Sales team"
4. **Private** repository
5. **NO** README, .gitignore, or license (keep empty)
6. Create repository

**You say:**
> "Empty repo. That's important - Fabric wants to be the source of truth initially."

#### Demo 2.2: Connect Workspace to Git

**Do:**
1. Go to Fabric workspace
2. Workspace settings → Git integration
3. Click "Connect"
4. Select **GitHub** as the Git provider
5. Click **Add account** (if not already connected)
6. When prompted, enter your **Personal Access Token**
   - Paste the PAT you created earlier
   - Fabric will validate and store it securely
7. Select your repository from the dropdown
8. Branch: `main`
9. Folder: `/` (root)
10. Click **Connect**

**You say:**
> "Notice we're using a Personal Access Token here, not just signing in with GitHub. This gives us fine-grained control—Fabric only gets access to the specific repositories we allow, and we can revoke it anytime without affecting our GitHub account."

**You say:**
> "Watch what happens... Fabric is now pushing all our items to Git."

**Do:**
1. Wait for sync (show the progress)
2. Point out the Git status icons appearing on items
3. Show "Synced" status

#### Demo 2.3: Explore What Just Happened

**Do:**
1. Go to GitHub, refresh
2. Show the folder structure that appeared:
   - `Contoso Sales.SemanticModel/`
   - `Contoso Sales Report.Report/`
3. Click into the semantic model folder
4. Open `model.tmdl`

**You say:**
> "Look at this. This is TMDL - Tabular Model Definition Language. It's human-readable. This isn't some binary blob - you can actually READ your model definition."

**Do:**
1. Scroll through, point out tables, measures
2. Show a measure definition - it's just DAX in a text file

**You say:**
> "This means code review. This means diffs. This means you can see exactly what changed. Let me show you."

---

### ACT 3: "The Friday Disaster" (10 minutes)

**You say:**
> "Okay, it's Friday. 4pm. The VP sends a message..."

#### Demo 3.1: The Urgent Request

**You say (acting it out):**
> "'Hey, can you quickly add a measure showing each store's percentage of company revenue? Need it for the board meeting Monday.'"

**Do:**
1. Open the semantic model in Fabric
2. Add a new measure - here's what it SHOULD be:
   ```dax
   % of Company Revenue = DIVIDE([Total Revenue], CALCULATE([Total Revenue], ALL(Stores)))
   ```
   **But you're rushing and forget the ALL() function!** Make it wrong on purpose:
   ```dax
   % of Company Revenue = DIVIDE([Total Revenue], [Total Revenue])
   ```
3. Save

**You say:**
> "There's the problem. I'm rushing. I forget to use ALL() to remove the filter context. But it calculates. It doesn't error. Every store shows 100%. I don't notice because I'm in a hurry. I commit it..."

**Do:**
1. Go to Source Control panel
2. Show the uncommitted change
3. Commit with message: "Add % of Company Revenue for VP - Friday 4pm"
4. Push

**You say:**
> "I go home. Weekend happens. Monday morning..."

#### Demo 3.2: Monday Morning Discovery

**Do:**
1. "Refresh" the page (dramatic effect)
2. Open the report
3. Add the % of Company Revenue measure to a visual by Store
4. Show that EVERY store shows 100%

**You say:**
> "The VP is presenting this to the board RIGHT NOW. And... wait. Every single store is 100% of company revenue? That's mathematically impossible. What did I do??"

#### Demo 3.3: Git to the Rescue

**You say:**
> "In the old world, I'd be panicking. What did I change? What was it before? Now watch this."

**Do:**
1. Go to GitHub
2. Click on "Commits"
3. Find "Add % of Company Revenue for VP - Friday 4pm"
4. Click into it
5. Show the DIFF - exactly what changed

**You say:**
> "There it is. I can see exactly what I did. DIVIDE([Total Revenue], [Total Revenue]) - I forgot the ALL() function! The denominator needs to ignore the Store filter. Now I can fix it - or even better, I can revert."

#### Demo 3.4: The Rollback

**You say:**
> "Now here's the magic. I have TWO ways to fix this."

##### Option A: Undo in Fabric (for uncommitted changes)

**Do:**
1. In Fabric, click **Source control** button in workspace header
2. Show the Source control panel with three tabs:
   - "Commit to Git"
   - "Commit to standalone branch" 
   - **"Undo saved change"** ← Click this one
3. Select the items to undo (the semantic model with the broken % of Company Revenue measure)
4. Click **Undo**
5. Confirm the action

**You say:**
> "This reverts my workspace back to match what's in Git. The broken measure I saved? Gone. It's like it never happened - at least in Fabric."

**Note:** This works for changes you've saved to Fabric but NOT yet committed to Git. The Source control panel shows a count of uncommitted changes - that's your warning signal.

##### Option B: Fix Forward with Git History (for committed changes)

**You say:**
> "But what if I already committed? Like I did Friday afternoon. Here's the power of Git - I can see EXACTLY what I did wrong, and fix it."

**Do:**
1. Go to GitHub repository
2. Click **Commits** (or the commit count)
3. Find the bad commit: "Add % of Company Revenue for VP - Friday 4pm"
4. Click into it to see the DIFF

**You say:**
> "Look at this. I can see the exact DAX I wrote. `DIVIDE([Total Revenue], [Total Revenue])` - there's my mistake! I forgot the `ALL()` function. Now I know exactly what to fix."

**Do:**
1. Go back to Fabric workspace
2. Open the semantic model
3. Fix the measure:
   ```dax
   % of Company Revenue = DIVIDE([Total Revenue], CALCULATE([Total Revenue], ALL(Stores)))
   ```
4. Save
5. Go to Source control → Commit with message: "Fix % of Company Revenue - add ALL() for correct filter context"
6. Push

**You say:**
> "Fixed. And look at my commit history - I have a complete audit trail. The original mistake, AND the fix. If the VP asks 'what happened?' I can show them exactly: here's what was wrong, here's when I fixed it. Compliance teams love this."

##### Option C: Restore from a Known-Good Commit (nuclear option)

**You say:**
> "What if the change was really bad and I need to completely restore to a previous state? Git has you covered."

**Do:**
1. In GitHub, find the commit BEFORE the bad change
2. Click the **`<>`** button to "Browse repository at this point"
3. Download or copy the TMDL file content from that commit
4. Manually restore in Fabric, or use Git command line:
   ```bash
   git checkout <good-commit-hash> -- "Sales Analytics.SemanticModel/"
   git commit -m "Restore semantic model to pre-Friday state"
   git push
   ```
5. In Fabric: Source control → Update all

**You say:**
> "This is the nuclear option - completely restore to a previous point in time. You probably won't need this often, but it's there when you do."

##### Which Method to Use?

| Situation | Use This |
|-----------|----------|
| Made changes but haven't committed yet | **Undo** in Fabric (Option A) |
| Already committed - know what's wrong | **Fix forward** with a new commit (Option B) |
| Already committed - need full restore | **Restore** from previous commit (Option C) |

**You say:**
> "The key insight: Git gives you visibility AND recoverability. You can always see what changed, and you can always get back to a working state. No more 'I broke it and can't remember what I changed.'"

---

### ACT 4: "Level Up - Collaboration" (8 minutes)

**You say:**
> "But here's where it gets really powerful. What if I want to try something risky without affecting the main workspace?"

#### Demo 4.1: Branching for Experimentation

**Do:**
1. In GitHub, create new branch: `feature/new-dashboard`
2. In Fabric, show how to switch branches (Workspace settings → Git)
3. OR create a second workspace connected to the feature branch

**You say:**
> "Now I have a safe place to experiment. Break things. Try new ideas. The main branch - and production - is untouched."

#### Demo 4.2: Simulating Team Collaboration

**You say:**
> "What about when Sam on my team wants to make changes too?"

**Do:**
1. Show that Sam could:
   - Clone the repo
   - Create their own branch
   - Make changes
   - Create a Pull Request
2. Show a PR in GitHub (pre-create one if time is tight)
3. Show the TMDL diff in the PR
4. Show how you can comment, review, approve

**You say:**
> "Code review for your semantic models. Think about that. No more 'Sam changed something and now it's broken.' You review it BEFORE it merges."

#### Demo 4.3: The Full Picture

**Do:**
Show a diagram or explain:
```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│  Dev Workspace  │────▶│  Pull Request   │────▶│ Prod Workspace  │
│  (main branch)  │     │  (Code Review)  │     │ (main branch)   │
└─────────────────┘     └─────────────────┘     └─────────────────┘
        ▲
        │
┌───────┴───────┐
│ Feature Branch │
│ (experiment)   │
└────────────────┘
```

**You say:**
> "This is what 'platform decision' looks like in practice. You're not just using Power BI anymore. You're running a proper development workflow."

---

### ACT 5: "Your Turn" (5 minutes if doing hands-on)

**For attendees following along:**

1. Create a GitHub repository
2. Connect your workshop workspace
3. Make a change
4. Commit
5. View in GitHub

**Provide:**
- Step-by-step handout
- Troubleshooting tips
- "I'll walk around and help"

---

## Backup Plans

| If this happens... | Do this... |
|-------------------|------------|
| GitHub auth fails | Have a backup workspace already connected |
| Sync takes forever | Pre-synced backup workspace to switch to |
| Fabric portal is slow | Keep talking about concepts, show GitHub side |
| Attendees get stuck | Have TAs or pair people up |

---

## Key Talking Points to Hit

1. **"Git isn't just for developers anymore"** - It's for anyone who wants a safety net
2. **"TMDL is the game-changer"** - Human-readable = reviewable
3. **"One workspace = one branch"** - This is how Fabric thinks about it
4. **"Start simple"** - Connect, commit, iterate. Don't overcomplicate day one.
5. **"This is what 'platform decision' means"** - Real DevOps for BI

---

## Sample Artifacts to Create

All sample artifacts are in `00-shared/`:

### Data (via Fabric Notebook)
Run `00-shared/notebooks/01-Generate-Sales-Data.ipynb` in your Lakehouse to create:
- **Products** - 65 outdoor/sporting goods products
- **Stores** - 12 retail locations (Pacific Northwest & Mountain regions)
- **Calendar** - Date dimension 2023-2025
- **Targets** - Monthly targets by store
- **Sales** - ~100K transactions

### Semantic Model: "Sales Analytics"
See `00-shared/models/Sales Analytics.SemanticModel/` for TMDL definitions.

**Key Measures:**
```dax
Total Revenue = SUM(Sales[TotalAmount])
Total Quantity = SUM(Sales[Quantity])
Gross Margin % = DIVIDE([Gross Profit], [Total Revenue])
Revenue YoY % = 
    VAR CurrentPeriod = [Total Revenue]
    VAR PriorPeriod = CALCULATE([Total Revenue], SAMEPERIODLASTYEAR(Calendar[Date]))
    RETURN DIVIDE(CurrentPeriod - PriorPeriod, PriorPeriod)
```

### Report: "Executive Dashboard"

**Page 1: Sales Overview**
- Card: Total Revenue
- Card: Gross Margin %
- Bar chart: Revenue by Store
- Line chart: Revenue over Time

---

## 🎯 Demo Enhancement: Live Data Addition

During the demo, you can use the notebook to add new transactions:

1. Open `01-Generate-Sales-Data.ipynb` in Fabric
2. Scroll to "Demo: Add Incremental Data" section  
3. Uncomment and run to add 1,000 new transactions
4. Show how the semantic model now has "uncommitted changes"
5. Commit the data refresh

This makes the demo more dynamic and shows real data flowing through!

---

## Timing Summary

| Segment | Time |
|---------|------|
| Act 1: The Old Way | 3 min |
| Act 2: The Setup | 7 min |
| Act 3: Friday Disaster | 10 min |
| Act 4: Level Up | 8 min |
| Act 5: Hands-on (optional) | 5 min |
| **Total** | **28-33 min** |

Leaves time for Q&A and transition to slides/wrap-up.

---

## Post-Demo: What Slides Should Cover

After the demo, slides should reinforce:
1. Recap the workflow (diagram)
2. Limitations / gotchas to know
3. When to use branching vs. deployment pipelines
4. Resources to learn more

---

## Files to Provide Attendees

1. `setup-guide.md` - How to replicate this in their own tenant *(see BACKLOG.md)*
2. Semantic model TMDL - See `00-shared/models/Sales Analytics.SemanticModel/`
3. `cheat-sheet.md` - Common Git commands / Fabric Git workflows *(see BACKLOG.md)*
