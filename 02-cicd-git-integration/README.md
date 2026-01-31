# Section 2: CI/CD & Git Integration

**Version Control and Deployment Automation**

---

## Overview

| | |
|---|---|
| **Duration** | 45 minutes |
| **Level** | Intermediate |
| **Prerequisites** | GitHub account (or Azure DevOps) |
| **Hands-on** | Heavy |

---

## Learning Objectives

By the end of this section, you will be able to:

- ✅ Connect a Fabric workspace to a Git repository
- ✅ Commit and sync changes between Fabric and Git
- ✅ Understand the TMDL format for semantic models
- ✅ Set up deployment pipelines across environments
- ✅ Compare Fabric Git integration to Power BI deployment pipelines

---

## Topics Covered

### 1. Git Integration in Fabric Workspaces
- What gets versioned (and what doesn't)
- Supported item types
- Workspace-to-repo relationship
- Branch strategies

### 2. The Commit/Sync Workflow
- Making changes in Fabric
- Committing to Git
- Pulling changes from Git
- Conflict resolution

### 3. Semantic Model Versioning with TMDL
- What is TMDL (Tabular Model Definition Language)?
- File structure in Git
- Reading and understanding TMDL files
- Manual edits vs. Fabric-generated changes

### 4. Deployment Pipelines
- Development → Test → Production workflow
- Pipeline stages and rules
- Comparing to Power BI deployment pipelines
- When to use Git vs. Deployment Pipelines

### 5. Comparing to Power BI Deployment Pipelines
- What's the same
- What's different
- Migration considerations

---

## Demo Ideas

### Demo 1: Connect Workspace to GitHub
- Create a new Fabric workspace
- Initialize Git integration
- Walk through the connection flow

### Demo 2: Make a Change, Commit, Deploy
- Modify a semantic model measure
- Commit the change
- Show the diff in GitHub
- Explain the TMDL structure

### Demo 3: Rollback Scenario
- Intentionally break something
- Use Git history to identify the issue
- Rollback to previous version

---

## Lab Exercise

**Duration:** 20 minutes

### Hands-on: Your First Fabric Git Workflow

1. Create a new workspace
2. Connect it to your GitHub repo
3. Create a simple semantic model
4. Make a change and commit
5. View the commit in GitHub
6. Make a conflicting change and resolve it

See [lab/git-workflow.md](./lab/git-workflow.md) for step-by-step instructions.

---

## Key Takeaways

1. **Git integration is workspace-level** - One repo per workspace
2. **TMDL is human-readable** - You can review PRs meaningfully
3. **Not everything is versioned** - Data, refresh history, etc. are not in Git
4. **Deployment pipelines still have a place** - Especially for data-included deployments

---

## Common Gotchas

⚠️ **Initial sync can be slow** - Large workspaces take time to serialize

⚠️ **Credentials aren't versioned** - You'll need to reconfigure data sources after cloning

⚠️ **Branch switching is destructive** - Uncommitted changes are lost

⚠️ **Some items don't support Git yet** - Check current documentation for supported types

---

## Resources

- [Git Integration in Fabric](https://learn.microsoft.com/fabric/cicd/git-integration/intro-to-git-integration)
- [TMDL Overview](https://learn.microsoft.com/analysis-services/tmdl/tmdl-overview)
- [Deployment Pipelines](https://learn.microsoft.com/fabric/cicd/deployment-pipelines/intro-to-deployment-pipelines)

---

## Standalone Usage

This section can be delivered as a standalone session for teams focused on DevOps practices.

**Standalone prerequisites:**
- Fabric workspace access
- GitHub or Azure DevOps account
- Basic understanding of Git concepts

**Standalone title suggestion:** "DevOps for Power BI: Git Integration and Deployment Automation in Fabric"

---

## Folder Contents

```
02-cicd-git-integration/
├── README.md           # This file
├── slides/             # Presentation slides
├── demos/              # Demo scripts and sample repo structure
└── lab/                # Hands-on Git workflow exercise
```
