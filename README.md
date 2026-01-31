# Fabric for the Power BI User

**A hands-on workshop helping Power BI developers evaluate Microsoft Fabric**

[![Event](https://img.shields.io/badge/Event-Fabric%20February%202026-blue)](https://www.fabricfebruary.com/precon/analyst/)
[![Duration](https://img.shields.io/badge/Duration-6.5%20hours-green)]()
[![Level](https://img.shields.io/badge/Level-Intermediate-yellow)]()

---

## Workshop Overview

This workshop helps Power BI developers make informed decisions about migrating to Microsoft Fabric. We explore both **technical capabilities** and **business considerations**, giving you a balanced view of when Fabric makes sense—and when it doesn't.

> **Key Context:** Power BI Premium is no longer sold as a standalone SKU. Throughout this workshop, we compare **Power BI Pro** (per-user licensing) against **Microsoft Fabric** (capacity-based licensing that includes former Premium features).

---

## Learning Objectives

By the end of this workshop, you will be able to:

- ✅ Articulate when Fabric adds value vs. when Pro is sufficient
- ✅ Set up Git integration and deployment pipelines for Fabric workspaces
- ✅ Create and query Lakehouses and Warehouses in OneLake
- ✅ Build data pipelines using Dataflows Gen2 and Pipelines
- ✅ Implement Direct Lake semantic models for large datasets
- ✅ Use Semantic Link to query semantic models from Python
- ✅ Leverage Copilot for report and DAX development

---

## Workshop Themes

This workshop is built on five key messages that weave technical and human considerations together:

| # | Message | The Point |
|---|---------|----------|
| 1 | **Fabric is not a Power BI upgrade—it's a platform decision** | It changes how teams work, not just what tools they use |
| 2 | **Power BI Pro is still right for many organizations** | Don't let FOMO drive a migration you don't need |
| 3 | **The 1GB limit is a symptom—ask what's really driving it** | Technical pain is often the excuse to address something bigger |
| 4 | **Migration isn't all-or-nothing—match pace to your people** | A 6-month technical migration with 0% adoption is a failure |
| 5 | **Make the decision before it's made for you** | Proactive beats reactive |

*See [Section 1: Strategic Context](./01-strategic-context/) for the full narrative.*

---

## Workshop Sections

| # | Section | Duration | Slides | Description |
|---|---------|----------|--------|-------------|
| 1 | [Strategic Context](./01-strategic-context/) | 45 min | 19 | When and why Fabric makes sense |
| 2 | [CI/CD & Git Integration](./02-cicd-git-integration/) | 45 min | 16 | Version control and deployment automation |
| 3 | [Data Centralization](./03-data-centralization/) | 60 min | 15 | OneLake, Lakehouse, and Warehouse |
| 4 | [Dataflows Gen2 & Pipelines](./04-dataflows-pipelines/) | 60 min | 15 | Modern data integration |
| 5 | [Direct Lake](./05-direct-lake/) | 45 min | 16 | Large dataset handling and performance |
| 6 | [Security](./06-security/) | 40 min | 19 | OneLake Security and RLS |
| 7 | [Copilot](./07-copilot/) | 45 min | 27 | AI-assisted development + workshop recap |
| — | Buffer / Lab Time | 75 min | — | Catch-up, extended labs, Q&A |

**Total: 6.5 hours | 127 slides**

---

## Prerequisites

See [PREREQUISITES.md](./PREREQUISITES.md) for complete setup instructions.

**Quick checklist:**
- [ ] Microsoft Fabric trial or capacity access
- [ ] Power BI Desktop (latest version)
- [ ] GitHub account
- [ ] Web browser (Edge or Chrome recommended)

---

## Shared Resources

The [00-shared](./00-shared/) folder contains:
- Sample datasets used across all sections
- Common images and diagrams
- Environment setup scripts

---

## Using This Content

### As a Full Workshop
Follow sections 1-7 in order. Each section builds on concepts (and sometimes artifacts) from previous sections.

### As Standalone Sessions
Each section folder contains its own README with:
- Standalone prerequisites
- Section-specific setup instructions
- Self-contained demos and labs

---

## Narrative Arc

```
┌─────────────────────────────────────────────────────────────────────────────┐
│  "Should I move to Fabric?"                                                  │
│                                                                              │
│  Section 1: Understand the WHY (strategic, licensing, decision framework)   │
│       ↓                                                                      │
│  Section 2: See the DEV EXPERIENCE (Git, CI/CD - familiar but better)       │
│       ↓                                                                      │
│  Section 3-4: Explore DATA CAPABILITIES (Lakehouse, Warehouse, Pipelines)   │
│       ↓                                                                      │
│  Section 5: Solve the BIG DATA problem (Direct Lake, model size)            │
│       ↓                                                                      │
│  Section 6-7: Discover NEW POSSIBILITIES (Semantic Link, Copilot)           │
│       ↓                                                                      │
│  "Now I can make an informed decision for MY organization"                  │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Contributing

This content was developed for Fabric February 2026. Feedback and contributions are welcome!

---

## License

[Add your license here]

---

## Contact

[Add presenter contact info]
