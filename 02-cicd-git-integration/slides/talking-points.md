# Section 02: CI/CD & Git Integration - Talking Points Reference

---

## OPENING & CONTEXT (5 minutes)

---

### Slide 1: Section Title

"Welcome back. We've talked about *why* Fabric—now let's get practical with version control and Git integration.

This is where Fabric starts feeling like a *real* platform, not just a bigger Power BI. And honestly? It's the feature that changes how we work."

---

### Slide 2: The Story - Friday Afternoon Disaster

"Let me tell you about Alex.

Alex is a report developer. It's Friday, 4 PM. The VP calls: 'The sales dashboard is wrong. Western region numbers are off. Fix it before Monday's board meeting.'

Alex makes some changes. Deploys. Goes home.

Monday morning at 9 AM: 'Alex, now the Eastern region is broken. What did you change?'

Alex: 'Ummm... I'm not sure exactly. I made a few fixes Friday...'

*(pause)*

Ever been Alex? I have. And for years in Power BI, we didn't have a good answer to that question.

There's a better way. That's what we're covering today."

---

### Slide 3: Have You Been Alex?

"*(pause for effect)*

That story? It's real. And if you've been developing Power BI content for a few years, you've probably *been* Alex at least once.

The good news: there's a better way.

What we're about to show you is how Fabric solves this problem with Git integration. Every change tracked. Everything recoverable. In seconds."

---

## GIT FUNDAMENTALS (5 minutes)

---

### Slide 4: What is Git?

"Quick level-set on what Git actually is.

Git is version control for code. Developers have used it for decades. Think of it like Track Changes in Word—but for code, and way more powerful.

Here's how it works:

- **Every save = a commit** - You're creating a snapshot: 'Here's what everything looked like at this exact moment'
- **You can go back to any commit** - Undo any change, instantly
- **You can branch** - Work on something without affecting the main version
- **You can merge** - Bring changes back together

The key insight: You never lose work. And you always know what changed."

---

### Slide 5: Git Terminology

"A few terms you'll hear throughout this demo:

- **Repository (Repo)**: Where your files live. Think of it as a project folder with superpowers.
- **Commit**: A snapshot. 'Here's what everything looked like at this moment'
- **Branch**: A parallel universe—work on something without affecting the main version
- **Merge**: Bring changes from one branch into another
- **Push**: Send your commits to the remote repository
- **Pull**: Get changes from the remote repository

Don't worry about memorizing these. You'll learn by doing in the next few minutes."

---

### Slide 6: Git Providers

"Fabric supports multiple Git providers. Here's the landscape:

- **GitHub**: What we're using today. It's free, easy to set up, and owned by Microsoft. Great for most teams.
- **Azure DevOps**: If your organization already uses Azure DevOps, this is your natural choice.
- **Bitbucket**: Atlassian's offering. If you're a Jira shop, you might prefer this.

The good news? They all work identically with Fabric. Pick what your organization already uses. If you don't have anything, GitHub is the easiest entry point."

---

## DEMO PREVIEW

---

### Slide 7: What We'll Cover

"Here's exactly what's going to happen in the next 30 minutes:

Act 1: Connect our Fabric workspace to Git—takes about 2 minutes

Act 2: Make a change, commit it—experience what version control feels like

Act 3: Break something intentionally—simulate Alex's Friday disaster

Act 4: Recover using Git history—fix the problem in 30 seconds

By the end, you'll see why this changes everything. And you'll have the confidence to do this in your own environment."

---

## DEMO EXECUTION

---

### Slide 8: Live Demo - Git Integration in Action

"Alright, this is where the magic happens.

We're going to do four things in the next 30 minutes:

1. **Connect a workspace to Git** - You'll see how straightforward this is. Just authorize GitHub and select a repo.

2. **Make a change and commit it** - Edit something in a semantic model, and commit it with a message. Just like saving, but with perfect history.

3. **Break something intentionally** - I'm going to make a change that breaks the report. This simulates Alex's Friday afternoon disaster.

4. **Fix it using Git history** - And then we'll show you the power move: revert to the previous commit in 30 seconds. Problem solved.

Watch closely. This is the moment where Fabric clicks for a lot of people."

---

### Slide 9: What We Just Did

"Let's recap exactly what happened:

✅ Connecte10 our Fabric workspace to GitHub—took about 2 minutes

✅ Made changes and committed them—it's like saving, but with perfect historical tracking

✅ Broke something intentionally, then rolled back—Friday disaster averted in seconds

The key insight here: **This isn't extra work. It's protection.**

Every change is tracked. Nothing is lost. 

Alex's Friday disaster—the one that would have taken hours to figure out and fix? In Fabric with Git, it's fixed in 30 seconds. 'Show me what changed. Roll it back.'"

---

## UNDERSTANDING GIT + FABRIC

---

### Slide 9: The Workflow

"Here's the workflow we just saw in action:

You make changes in your Fabric workspace. Those changes automatically sync to your Git repository. Every commit creates a perfect snapshot of what your content looked like at that moment.

If something goes wrong, you can revert to any previous commit instantly.

And if you're working with a team, you can see exactly who changed what, when they changed it, and why—because everyone writes commit messages.

One workspace connects to one Git branch. So your dev workspace syncs to the main branch, your test workspace syncs to a test branch, and so on."

---

### Slide 10: The Workflow

"*(Visual reference)*

This diagram shows the complete flow:

On the left, your Fabric workspace. On the right, your GitHub repository.

As you make changes in Fabric, they sync to GitHub. You see the history, who changed what, when.

If something breaks, you can revert instantly to any previous state.

And if you're working with a team, everyone sees the same history and can collaborate seamlessly.

One workspace = One branch. Simple, clean, accountable."

---

### Slide 11: What Syncs to Git

"Not everything in Fabric syncs to Git, and that's by design.

**What DOES sync:**
- Semantic models (the whole thing)
- Reports (the .pbir file)
- Paginated reports
- Notebooks
- Spark job definitions
- Data pipelines
- Lakehouses
- Warehouses
- KQL databases

**What DOESN'T sync:**
- Dashboards (not yet—they're coming)
- Dataflows Gen1
- Datamarts
- Real-time dashboards

Here's the critical one: **Lakehouse *definitions* sync to Git. Lakehouse *data* doesn't.**

That's the key insight. Git is for **code**, not **data**. Your data stays in OneLake. Your definitions—the structure, transformations, schemas—that's what Git tracks."

---

### Slide 12: Git vs Deployment Pipelines

"I know what you're thinking: 'Don't we already have deployment pipelines?'

Yes. And they're still useful. But they're different tools for different jobs.

**Deployment Pipelines:**
- Move content between environments (Dev → Test → Prod)
- Easy, visual, no coding required
- No code review process

**Git Integration:**
- Version control and history
- Branching and merging
- Code review through pull requests
- Collaboration at the source level

The good news? **You can use BOTH.**

Think of Git as the foundation. It's where your code lives, where you collaborate, where you review changes. Deployment pipelines are one way to promote from that foundation into production.

Many serious teams use Git for development and code review, then use pipelines to automatically promote to production after approval."

---

### Slide 13: Using Both Together

"Here's what a mature setup looks like:

Your team works in Git. You create branches, make changes, create pull requests for code review. Once approved, you merge to main.

From main, you deploy to your Test workspace via pipeline. Test it, make sure everything works.

Once Test is good, deploy to Production via the same pipeline.

You get the best of both worlds: Git gives you history, collaboration, and code review. Pipelines give you safe, controlled promotion between environments.

It's professional development workflow, adapted for Fabric."

---

## GOTCHAS & BEST PRACTICES

---

### Slide 14: Key Gotchas

"A few things to watch out for when you use Git:

**One branch per workspace:** You can't connect one workspace to multiple branches. So if you want dev, test, and prod, you need three separate workspaces. Plan your workspace strategy accordingly.

**Merge conflicts happen:** If two people edit the same item, Git will flag it. Last commit wins unless you resolve it manually. This is normal. Just be aware.

**All or nothing:** You can't sync just part of a semantic model. When you commit, the entire item commits. Choose your granularity carefully.

**Workspace is the source of truth:** On first sync, Fabric pushes TO Git, not from Git. Your workspace is authoritative until you establish a code review process.

**Data doesn't sync:** Seriously. Your Lakehouse data stays in OneLake. Only definitions sync."

---

### Slide 15: Recovery Options

"When things go wrong—and they will—here are your options:

**Saved but not committed yet:** Use the Undo button in Fabric Source Control. Simple.

**Already committed:** Go to GitHub, revert the commit, come back to Fabric, and hit Update. Takes 30 seconds.

**Want to experiment safely:** Create a branch first. That's what branches are for. Experiment, and if it doesn't work, just don't merge.

**Golden rule:** Commit often. Write clear commit messages. Your future self will thank you."

---

### Slide 16: Getting Started

"Here's what I want you to do after this workshop:

1. Create a GitHub account if you don't have one. It's free.
2. Create an empty repository—call it anything you want.
3. Find one of your dev workspaces, or create a new one for testing.
4. Connect that workspace to Git. It takes about 2 minutes.
5. Make one small change—edit a measure, change a color, anything.
6. Commit it with a message: 'Test commit'
7. Go to GitHub and look at your commit. See your change.

That's it. You've now used Git. And I promise you, once you do it once, you'll see why this is so powerful."

---

## TRANSITION

---

"Alright, we've got version control locked down. Our development workflow is protected. Every change is tracked.

But here's the thing—none of that matters if our *data* isn't in the right place.

Next up: Data Centralization. We're going to build a Lakehouse and bring all our data into OneLake. That's where the real power of Fabric starts.

Quick stretch break, and then we'll dive in."
