# Workshop Development Progress

> **Project ID:** `WKSHP-FABRIC-PBI-2026`  
> **Last Updated:** 2026-01-22T16:22:00  
> **Session ID:** `SES-001`  
> **Workshop:** Fabric for Power BI Users (Full-Day Workshop)

---

## Session Log

| Session ID | Date | Focus Area | Notes |
|------------|------|------------|-------|
| `SES-001` | 2026-01-22 | Initial setup, all sections | Created progress tracking |
| `SES-001` | 2026-01-22 | Section 06 Security Lab | Created security-implementation.md |
| `SES-001` | 2026-01-22 | Speaker notes to PPTX | Added talking points to all 7 PowerPoints |
| `SES-001` | 2026-01-22 | Lab enhancements | Updated labs 02-07 for better demo alignment |
| `SES-001` | 2026-01-22 | Font scaling | Scaled fonts in all decks (25% increase) |
| `SES-001` | 2026-01-22 | Section 02 slides refresh | Regenerated with narrative details from talking points |
| `SES-001` | 2026-01-22 | Section 02 structure refinement | Fixed slide alignment - created Slide 3 & Slide 8 as proper slides |

---

## Quick Status Summary

| Section | Slides | Talking Points | Demo Design | Lab | Status |
|---------|--------|----------------|-------------|-----|--------|
| 00-shared | N/A | N/A | N/A | ✅ Setup | ✅ Complete |
| 01-strategic-context | ✅ | ✅ | ❌ | ✅ | ✅ Complete |
| 02-cicd-git-integration | ✅ | ✅ | ✅ | ✅ | ✅ Complete |
| 03-data-centralization | ✅ | ✅ | ✅ | ✅ | ✅ Complete |
| 04-dataflows-pipelines | ✅ | ✅ | ✅ | ✅ | ✅ Complete |
| 05-direct-lake | ✅ | ✅ | ✅ | ✅ | ✅ Complete |
| 06-security | ✅ | ✅ | ✅ | ✅ | ✅ Complete |
| 07-copilot | ✅ | ✅ | ✅ | ✅ | ✅ Complete |
| 08-semantic-link-optional | ❌ | ❌ | ❌ | ✅ | 🔶 Optional Section |

**Legend:** ✅ Complete | 🔶 In Progress/Partial | ❌ Not Started/Missing

---

## Current Session Focus

**Section ID:** `SEC-02-COMPLETE`

**Last completed work:**
- ✅ Fixed slides-gamma.md structure: 16 slides total (added Slide 3 "Have You Been Alex?" and Slide 8 "Live Demo")
- ✅ Regenerated talking-points.md with 16 comprehensive speaker notes aligned to all slides
- ✅ Added all 16 talking points to PowerPoint speaker notes

**Current file state:**
- `02-cicd-git-integration/slides/slides-gamma.md` - 16 slides, properly labeled
- `02-cicd-git-integration/slides/talking-points.md` - 16 speaker notes, all aligned
- `02-cicd-git-integration.pptx` - Has speaker notes embedded for slides 1-16

**Next steps for Section 02 (when returning):**
1. Regenerate Section 02 PowerPoint via Gamma API with the updated slides-gamma.md (now includes Slide 3 and Slide 8 properly)
2. Track Gamma API credits used
3. Re-add talking points to the newly generated PPTX
4. Move on to regenerating remaining sections (01, 03, 06, 07)

**Gamma API Status:**
- Current credit balance: 3,559 credits (down from 3,643 at last check)
- Estimated remaining work: ~290 credits for sections 01, 03, 06, 07 regeneration

**Next recommended actions:**
1. Regenerate Section 02 via Gamma (updated content with Slide 3 & 8)
2. Regenerate remaining sections via Gamma API
3. Create lab for Section 06 (Security) - ALREADY DONE (security-implementation.md created)
4. Complete Section 08 (Semantic Link) slides and demo design if including
5. Review and finalize all sections
6. Generate presenter guide and materials

---

## Detailed Section Status

### 00-shared (Supporting Materials)
- [x] Scenario document (`scenario.md`)
- [x] Setup instructions (`setup-instructions.md`)
- [x] Sample data files (CSV files in `data/`)
- [x] Semantic model (TMDL files in `models/`)
- [x] Data generation notebook
- [x] Gamma scripts for slide generation

### 01-strategic-context (45 min)
- [x] `slides/slides-gamma.md` - Gamma-formatted slides
- [x] `slides/talking-points.md` - Presenter talking points
- [x] `lab/scenario-assessment.md` - Assessment activity
- [ ] `demos/demo-design.md` - No live demo (strategy focused)

### 02-cicd-git-integration (45 min)
- [x] `slides/slides-gamma.md` - Gamma-formatted slides
- [x] `slides/talking-points.md` - Presenter talking points
- [x] `demos/demo-design.md` - Git integration demo
- [x] `lab/git-workflow.md` - Hands-on lab

### 03-data-centralization (45 min)
- [x] `slides/slides-gamma.md` - Gamma-formatted slides
- [x] `slides/talking-points.md` - Presenter talking points
- [x] `demos/demo-design.md` - Lakehouse demo
- [x] `lab/lakehouse-basics.md` - Hands-on lab

### 04-dataflows-pipelines (45 min)
- [x] `slides/slides-gamma.md` - Gamma-formatted slides
- [x] `slides/talking-points.md` - Presenter talking points
- [x] `demos/demo-design.md` - Dataflow Gen2 demo
- [x] `lab/dataflow-pipeline.md` - Hands-on lab

### 05-direct-lake (45 min)
- [x] `slides/slides-gamma.md` - Gamma-formatted slides
- [x] `slides/talking-points.md` - Presenter talking points
- [x] `demos/demo-design.md` - Direct Lake mode demo
- [x] `lab/direct-lake-model.md` - Hands-on lab

### 06-security (45 min)
- [x] `slides/slides-gamma.md` - Gamma-formatted slides
- [x] `slides/talking-points.md` - Presenter talking points
- [x] `demos/demo-design.md` - Security demo
- [x] `lab/security-implementation.md` - Hands-on lab ✅ *Added SES-001*

### 07-copilot (45 min)
- [x] `slides/slides-gamma.md` - Gamma-formatted slides
- [x] `slides/talking-points.md` - Presenter talking points
- [x] `demos/demo-design.md` - Copilot demo
- [x] `lab/copilot-exploration.md` - Hands-on lab

### 08-semantic-link-optional (Optional/Bonus)
- [ ] `slides/` - Slides not created
- [ ] `demos/` - Demo design not created
- [x] `lab/semantic-link-basics.md` - Lab exists
- **Note:** This is an optional advanced section

---

## Outstanding Tasks

### High Priority
- [x] `TASK-001` ~~Create security lab for Section 06~~ ✅ *Completed: 2026-01-22*
- [ ] `TASK-002` Final review pass on all talking points *(Added: 2026-01-22)*
- [ ] `TASK-003` Test all demo flows end-to-end *(Added: 2026-01-22)*

### Medium Priority
- [ ] `TASK-004` Generate presenter guide *(Added: 2026-01-22)*
- [ ] `TASK-005` Create backup/recovery plans for demos *(Added: 2026-01-22)*
- [ ] `TASK-006` Generate FAQ document *(Added: 2026-01-22)*
- [ ] `TASK-007` Create prerequisites checklist for attendees *(Added: 2026-01-22)*

### Low Priority / Optional
- [ ] `TASK-008` Complete Section 08 (Semantic Link) if time permits *(Added: 2026-01-22)*
- [ ] `TASK-009` Create follow-up email templates *(Added: 2026-01-22)*
- [ ] `TASK-010` Generate social media posts for promotion *(Added: 2026-01-22)*

---

## Completed Tasks

| Task ID | Description | Completed | Session |
|---------|-------------|-----------|---------|
| `TASK-001` | Create security lab for Section 06 | 2026-01-22 | `SES-001` |
| `TASK-011` | Add speaker notes to all PowerPoints | 2026-01-22 | `SES-001` |
| `TASK-012` | Enhance Section 03 lab (Shortcut Transformations) | 2026-01-22 | `SES-001` |
| `TASK-013` | Expand Section 07 lab (Prep Data for AI) | 2026-01-22 | `SES-001` |
| `TASK-014` | Add recovery exercise to Section 02 lab | 2026-01-22 | `SES-001` |
| `TASK-015` | Add Copilot option to Section 04 lab | 2026-01-22 | `SES-001` |
| `TASK-016` | Add live data test to Section 05 lab | 2026-01-22 | `SES-001` |

---

## Notes & Decisions

- `DEC-001` **Story-driven approach:** Using Marcus (IT Manager), Sofia (Power BI Developer), and Jordan (Business Analyst) as recurring characters *(2026-01-22)*
- `DEC-002` **Contoso Retail scenario:** All sections use consistent retail analytics scenario *(2026-01-22)*
- `DEC-003` **Security section:** Intentionally lighter on lab - concepts are demo-heavy *(2026-01-22)*

---

## How to Resume Work

1. Open this file to see current status
2. Check "Current Session Focus" for where we left off
3. Review "Outstanding Tasks" for next steps
4. Use workshop-builder MCP tools to generate remaining content

### Useful Commands
```
# Generate a lab
mcp_workshop-buil_generate_exercise

# Generate presenter guide
mcp_workshop-buil_generate_presenter_guide

# Generate FAQ
mcp_workshop-buil_generate_faq
```

---

*Update this file after each work session to maintain accurate progress tracking.*

---

## ID Reference Guide

### Naming Conventions
- **Project ID:** `WKSHP-[NAME]-[YEAR]` - Unique project identifier
- **Session ID:** `SES-###` - Increments each work session
- **Task ID:** `TASK-###` - Unique task reference (never reuse)
- **Decision ID:** `DEC-###` - For tracking key decisions

### Next Available IDs
- Next Session: `SES-002`
- Next Task: `TASK-017`
- Next Decision: `DEC-004`
