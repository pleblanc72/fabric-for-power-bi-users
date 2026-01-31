# Workshop Backlog: Supplemental Items

> **Purpose:** Track nice-to-have items that aren't essential for the workshop but add value if time permits. Review this list after completing all core sections.

---

## How to Use This File

- ✅ **Add items** as they come up during development
- 🏷️ **Tag priority:** `[HIGH]` `[MEDIUM]` `[LOW]`
- 📍 **Note the section** so context isn't lost
- ⏱️ **Estimate effort** when possible
- ✔️ **Check off** when completed

---

## Section 01: Strategic Context

- [ ] `[MEDIUM]` **"Step-by-step guides"** - Referenced in slides ("replicate later with our step-by-step guides") but not created (~45 min)
  - Post-workshop guide to set up Fabric trial
  - How to create first Lakehouse
  - How to create first semantic model
  - *Note: Could be one consolidated "Getting Started with Fabric" guide*

- [ ] `[LOW]` **Cost calculator spreadsheet** - Interactive Excel/Sheets for attendees to estimate their own costs (~30 min)
  - Input: # of users, data volume, refresh frequency
  - Output: Pro vs PPU vs Fabric comparison
  - *Note: Slides have comparison table, this would be interactive version*

---

## Section 02: CI/CD & Git Integration

- [ ] `[MEDIUM]` **cheat-sheet.md** - Quick reference for Git terminology + Fabric workflows (~30 min)
  - Git terms: commit, push, pull, branch, merge, revert
  - Fabric actions: connect, commit, update, undo
  - Common scenarios table
  - *Note: Slides 6, 7, 9 already cover most of this*

- [ ] `[LOW]` **setup-guide.md** - Step-by-step to replicate demo in attendee's tenant (~20 min)
  - Pre-reqs checklist
  - GitHub account setup
  - Fabric workspace setup
  - Connect to Git walkthrough
  - *Note: demo-design.md has setup checklist already*

- [ ] `[LOW]` **Fix sample-model reference** - Update demo-design.md to point to `00-shared/models/` (~2 min)

---

## Section 03: Data Centralization

- [x] ~~**Shortcut Transformations demo**~~ - **MOVED TO MAIN DEMO** (Act 4)
  - CSV on public blob → Auto-convert to Delta table
  - User delivered this at Microsoft Ignite keynote - audience loved it!
  - Docs: https://learn.microsoft.com/en-us/fabric/onelake/shortcuts-file-transformations/transformations

- [ ] `[LOW]` **OneLake File Explorer video/screenshots** - For attendees without Windows (~15 min)
  - Screenshots of navigation
  - Short screen recording of drag-drop
  - *Note: Can skip if all attendees have Windows*

- [ ] `[MEDIUM]` **Medallion architecture slide** - Bronze/Silver/Gold pattern (~20 min)
  - When to use medallion vs flat structure
  - Not covered in current demo but valuable for larger implementations
  - *Note: Could be advanced topic if time permits*

- [ ] `[LOW]` **Delta Lake deep dive handout** - Time travel, vacuum, optimize commands (~30 min)
  - For attendees who want to go deeper on Delta
  - *Note: Links to MS Learn may suffice*

---

## Section 04: Dataflows & Pipelines

- [ ] `[MEDIUM]` **Copilot for Dataflows demo** - Natural language to Power Query (~15 min)
  - "Only keep suppliers with lead time under 14 days"
  - "Add a column that calculates margin percentage"
  - *Note: Requires Copilot enabled in tenant*

- [ ] `[LOW]` **Gen1 to Gen2 migration guide** - Step-by-step for existing dataflows (~20 min)
  - Export/import PQT template
  - Copy/paste queries
  - Save As feature
  - *Note: Only relevant if attendees have existing Gen1 dataflows*

- [ ] `[LOW]` **Advanced pipeline patterns handout** - For attendees who want more (~30 min)
  - ForEach loops
  - Conditional branching (If)
  - Calling notebooks from pipelines
  - Cross-workspace dependencies
  - *Note: Beyond scope of this workshop, good follow-up material*

---

## Section 05: Direct Lake

- [ ] `[MEDIUM]` **Performance comparison demo** - Side-by-side Import vs Direct Lake refresh (~20 min)
  - Same data, same model structure
  - Time the refresh for each
  - Show the dramatic difference
  - *Note: Requires two semantic models set up*

- [ ] `[LOW]` **DirectQuery fallback troubleshooting guide** - When and why it happens (~15 min)
  - Common causes: SQL views, RLS, guardrail exceeded
  - How to detect fallback
  - How to fix it
  - *Note: Linked from demo as "gotcha" section*

- [ ] `[LOW]` **Delta table optimization handout** - OPTIMIZE, VACUUM commands (~20 min)
  - Reduce parquet file count
  - Stay under guardrails
  - Best practices for Direct Lake performance
  - *Note: Advanced topic for data engineers*

---

## Section 06: Security

- [ ] `[MEDIUM]` **Performance impact demo** - Show query timing with/without OneLake security (~15 min)
  - Same query, measure latency
  - Discuss optimization strategies
  - *Note: Preview may have different performance characteristics*

- [ ] `[LOW]` **Security audit handout** - Checklist for reviewing Fabric security (~20 min)
  - Workspace role review
  - OneLake Security role inventory
  - Semantic model RLS review
  - *Note: Good for IT admins*

---

## Section 07: Copilot

*To be identified during Section 07 development*

---

## OPTIONAL: Semantic Link [MOVED FROM SECTION 06]

> **Note:** Moved to optional due to time constraints and audience fit. Semantic Link is more relevant for data scientists using Python/notebooks than for Power BI report developers.

- [ ] `[LOW]` **Semantic Link demo** - Python/notebooks querying semantic models (~30 min)
  - SemPy library overview
  - Query semantic model from notebook
  - Write back to Lakehouse
  - *Note: Advanced topic for data scientists, not core Power BI audience*

- [ ] `[LOW]` **Semantic Link cheat sheet** - SemPy code snippets (~15 min)
  - read_table() examples
  - evaluate_measure() examples
  - Common patterns
  - *Note: Only if Semantic Link demo is included*

---

## Cross-Section / General

- [ ] `[MEDIUM]` **Attendee pre-work email template** - What to set up before arriving
- [ ] `[LOW]` **Post-workshop resource list** - Curated links to MS Learn, community, blogs
- [ ] `[LOW]` **Feedback survey questions** - To improve for next delivery

---

## Completed Items

*Move items here when done*

---

## Priority Guide

| Tag | Meaning | When to Build |
|-----|---------|---------------|
| `[HIGH]` | Significantly improves workshop | Build if any time remains |
| `[MEDIUM]` | Nice polish, adds value | Build if 2+ hours remain |
| `[LOW]` | Optional extras | Build only if everything else done |

---

*Last updated: 2026-01-21*
