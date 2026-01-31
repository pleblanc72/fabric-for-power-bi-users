# Git Integration: Version Control for Fabric

> These are the key concepts from the presentation. Use this as a reference guide.

*"The safety net you didn't know you needed"*

---

## The Story: Friday Afternoon Disaster

**Alex's Story:**

It's Friday, 4 PM.

VP: *"The sales dashboard is wrong. Western region numbers are off. Fix it before Monday's board meeting."*

Alex makes changes. Deploys. Goes home.

Monday, 9 AM:

VP: *"Now Eastern region is broken. What did you change?"*

Alex: *"Ummm... I'm not sure exactly. I made a few fixes Friday..."*

**Have you been Alex? There's a better way.**

---

## What is Git?

Think of Git like **Track Changes in Word**—but for code.

- **Every save = a commit** (snapshot of everything at that moment)
- **You can go back to any commit** (undo any change)
- **You can branch** (work on something without affecting the main version)
- **You can merge** (bring changes back together)

**Key insight: You never lose work. You always know what changed.**

---

## Git Terminology

| Term | Meaning |
|------|---------|
| **Repository (Repo)** | Where your files live (project folder + superpowers) |
| **Commit** | A snapshot: "Here's what everything looked like at this moment" |
| **Branch** | A parallel universe—work without affecting main version |
| **Merge** | Bring changes from one branch into another |
| **Push** | Send your commits to the remote repository |
| **Pull** | Get changes from the remote repository |

Don't memorize—you'll learn by doing.

---

## Git Providers

| | GitHub | Azure DevOps |
|---|--------|--------------|
| **Free tier** | Unlimited private repos | 5 users free, then paid |
| **Best for** | Startups, most teams | Enterprises on Azure |

**Both work identically with Fabric.**

Pick what your organization already uses.

---

## The Key Insight

**This isn't extra work. It's protection.**

- Connected workspace to GitHub (2 minutes)
- Made changes, committed them (tracked history)
- Broke something, rolled back (30 seconds to fix)

**Every change is tracked. Nothing is lost.**

*"Alex's Friday disaster? Fixed in 30 seconds. Show what changed. Roll it back."*

---

## Git Integration Flow

```
Fabric Workspace ←→ GitHub Repository
     ↓                    ↓
  Save changes      View history
     ↓                    ↓
  Commit to Git     Code review (PRs)
     ↓                    ↓
  Push/Pull         Revert if needed
```

**One workspace = One branch**

---

## What Syncs to Git

| ✅ Syncs to Git | ❌ Does NOT Sync |
|-----------------|------------------|
| Semantic models | Dashboards |
| Reports (.pbir) | Dataflows Gen1 |
| Paginated reports | Datamarts |
| Notebooks | Real-time dashboards |
| Spark job definitions | |
| Data pipelines | |
| Lakehouses | |
| Warehouses | |
| KQL databases | |

**Important:** Lakehouse *definitions* sync. Lakehouse *data* doesn't.

Git is for **code**, not **data**.

---

## Git vs Deployment Pipelines

| Aspect | Git Integration | Deployment Pipelines |
|--------|-----------------|---------------------|
| **Purpose** | Version control & history | Environment promotion |
| **Workflow** | Branch → PR → Merge | Dev → Test → Prod stages |
| **Code review** | ✅ Yes (PRs) | ❌ No |
| **Cross-tenant** | ✅ Yes | ❌ No (same tenant) |
| **Rollback** | Revert any commit | Redeploy previous stage |
| **Setup** | Requires GitHub/Azure DevOps | Built into Fabric |

**You can use BOTH.**

---

## Using Both Together

```
GitHub/Azure DevOps          Fabric
───────────────────          ──────
                    ┌─────────────┐
main branch ◄─────► │ Dev Workspace │
                    └──────┬──────┘
                           │ Deploy
                    ┌──────▼──────┐
                    │Test Workspace│
                    └──────┬──────┘
                           │ Deploy  
                    ┌──────▼──────┐
                    │Prod Workspace│
                    └─────────────┘
```

**Git = Source control | Pipelines = Promotion**

Use Git for history & code review. Use Pipelines to promote between environments.

---

## Key Gotchas

| Limitation | What It Means |
|------------|---------------|
| **One branch per workspace** | Create separate workspaces for dev/test/prod |
| **Merge conflicts** | Fabric can't auto-resolve; last commit wins |
| **All or nothing** | Can't sync partial items; entire item syncs |
| **Workspace = source of truth** | First sync pushes TO Git, not from |

**Start simple. Add complexity as needed.**

---

## Recovery Options

| Situation | Solution |
|-----------|----------|
| Saved but not committed | **Undo** in Fabric Source Control (discards local changes) |
| Already committed | Use `git revert` in GitHub, then **Update** workspace |
| Need to experiment | Create a **branch** first |

**Fabric has no "Revert" button—you revert in Git, then Update.**

---

## Getting Started

1. Create a GitHub repo (empty, private)
2. Connect your dev workspace
3. Make one change, commit it
4. View the diff in GitHub

**That's it. You're using Git.**
