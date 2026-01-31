# Fabric for the Power BI User - Workshop Brainstorm

**Event:** [Fabric February Pre-Con](https://www.fabricfebruary.com/precon/analyst/)  
**Duration:** 6.5 hours  
**Deadline:** ~10 days to develop content  
**Goal:** Help Power BI developers evaluate valid technical and non-technical reasons to migrate (or not) to Microsoft Fabric

> **Important Context:** Power BI Premium is no longer sold as a standalone SKU—it has been consolidated into Microsoft Fabric. Throughout this workshop, comparisons are between **Power BI Pro** (per-user licensing) and **Microsoft Fabric** (capacity-based, includes former Premium features).

---

## Deliverables Checklist

- [ ] Slides (shareable as handouts)
- [ ] Demos (follow-along lab format)
- [ ] Prerequisites document

---

## Proposed Sections

### 1. Strategic Context: When and Why Fabric Makes Sense
**Estimated Time:** 45 min

**Topics:**
- What problem does Fabric solve?
- Power BI Pro vs Fabric licensing & costs
- The Premium → Fabric transition (what happened)
- When Power BI Pro is sufficient
- When Fabric is overkill
- Decision framework for migration

**Demo Ideas:**
- Capacity metrics comparison
- Cost calculator walkthrough

---

### 2. CI/CD & Git Integration
**Estimated Time:** 45 min

**Topics:**
- Git integration in Fabric workspaces
- Deployment pipelines
- Version control for semantic models
- Comparing to Power BI deployment pipelines

**Demo Ideas:**
- Connect workspace to Git repo
- Make a change, commit, deploy
- Rollback scenario

---

### 3. Data Centralization: OneLake, Lakehouse & Warehouse
**Estimated Time:** 60 min

**Topics:**
- OneLake as the unified storage layer
- Lakehouse vs Warehouse - when to use which
- Shortcuts - connecting to external data without copying
- Delta Lake format fundamentals
- What happens to existing datasets?

**Demo Ideas:**
- Create a Lakehouse
- Add data via shortcut
- Query with SQL endpoint
- Compare to traditional Power BI data sources

---

### 4. Dataflows Gen2 & Pipelines
**Estimated Time:** 60 min

**Topics:**
- Dataflows Gen1 vs Gen2 differences
- When to use Dataflows vs Pipelines vs Notebooks
- Orchestration patterns
- Incremental refresh in Dataflows Gen2

**Demo Ideas:**
- Build a Dataflow Gen2 from scratch
- Create a Pipeline to orchestrate multiple activities
- Show monitoring and troubleshooting

---

### 5. Large Dataset Handling & Direct Lake
**Estimated Time:** 45 min

**Topics:**
- Import vs DirectQuery vs Direct Lake
- How Direct Lake works (memory mapping from Parquet)
- Fallback to DirectQuery scenarios
- Hybrid tables and incremental refresh
- Model size limits: Pro (1GB) vs Fabric SKUs
- Breaking the 1GB barrier—why Fabric matters for large models

**Demo Ideas:**
- Create a Direct Lake semantic model
- Show performance comparison
- Monitor fallback behavior

---

### 6. Semantic Link
**Estimated Time:** 30 min

**Topics:**
- What is Semantic Link?
- Reading semantic models from notebooks
- Using DAX/evaluate from Python
- Use cases: ML on top of semantic models

**Demo Ideas:**
- Connect to semantic model from notebook
- Run DAX query, get pandas DataFrame
- Simple ML/analysis example *(optional)*

---

### 7. Copilot: AI-Assisted Development
**Estimated Time:** 30 min

**Topics:**
- Copilot in Power BI reports
- Copilot in notebooks
- Copilot for DAX
- Limitations and gotchas
- Data residency and compliance considerations

**Demo Ideas:**
- Generate a report page with Copilot
- DAX measure suggestions
- Notebook code generation *(optional)*

---

### Buffer / Lab Time
**Estimated Time:** 75 min

- Catch-up time
- Extended hands-on lab work
- Q&A

---

## Additional Topics to Consider

| Topic | Priority | Notes |
|-------|----------|-------|
| Security & Governance (Purview) | Medium | May be too deep for this audience |
| Migration Path / Coexistence | High | What happens to existing reports? |
| Compute Separation | Medium | Underlying architecture benefit |
| Real-time Intelligence | Low | Might be out of scope |
| Power BI Embedded differences | Low | Niche audience |

---

## Prerequisites (Draft)

- [ ] Fabric trial or capacity access
- [ ] Power BI Desktop (latest version)
- [ ] Azure subscription (for some demos?)
- [ ] Sample dataset(s) - need to define
- [ ] GitHub account (for CI/CD section)

---

## Open Questions

1. What sample dataset should we use throughout? (AdventureWorks? Contoso? Custom?)
2. Do attendees need their own Fabric capacity or will you provide a shared workspace?
3. Should slides be PowerPoint or Markdown-based?
4. Any specific customer scenarios/pain points to address?

---

## Daily Development Plan (10 days)

| Day | Focus |
|-----|-------|
| 1-2 | Strategic Context + Prerequisites finalized |
| 3-4 | CI/CD & Git section + demo |
| 5-6 | Data Centralization section + demo |
| 7 | Dataflows Gen2 & Pipelines |
| 8 | Direct Lake + Model Size |
| 9 | Semantic Link + Copilot |
| 10 | Review, polish, dry run |

---

## Notes & Ideas

*Add random thoughts here as they come up...*

- 
- 
- 
