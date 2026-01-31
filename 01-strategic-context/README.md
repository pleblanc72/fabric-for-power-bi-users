# Section 1: Strategic Context

**When and Why Fabric Makes Sense**

---

| [🏠 Home](../README.md) | [Next: CI/CD & Git Integration →](../02-cicd-git-integration/README.md) |
|:--|--:|

---

## Workshop Sections

| # | Section | Duration | |
|---|---------|----------|--|
| **01** | **Strategic Context** | **45 min** | ⬅️ You are here |
| 02 | [CI/CD & Git Integration](../02-cicd-git-integration/README.md) | 45 min | |
| 03 | [Data Centralization](../03-data-centralization/README.md) | 60 min | |
| 04 | [Dataflows & Pipelines](../04-dataflows-pipelines/README.md) | 60 min | |
| 05 | [Direct Lake](../05-direct-lake/README.md) | 45 min | |
| 06 | [Security](../06-security/README.md) | 40 min | |
| 07 | [Copilot](../07-copilot/README.md) | 45 min | |

---

## 📂 Section Contents

| Resource | Description |
|----------|-------------|
| [📊 Slides (PDF)](./pdf/01-Strategic%20Context.pdf) | Presentation slides |
| [📝 Slide Content](./slides/slides-content.md) | Key concepts from the presentation |
| [🧪 Lab: Scenario Assessment](./lab/scenario-assessment.md) | Hands-on exercise |

---

## Overview

| | |
|---|---|
| **Duration** | 45 minutes |
| **Level** | Beginner-Intermediate |
| **Prerequisites** | None |
| **Hands-on** | Light (mostly discussion and exploration) |

---

## Learning Objectives

By the end of this section, you will be able to:

- ✅ Explain what problems Microsoft Fabric solves
- ✅ Compare Power BI Pro vs. Fabric licensing models
- ✅ Identify scenarios where Fabric adds value
- ✅ Recognize when Fabric is overkill for your needs
- ✅ Use a decision framework to evaluate migration

---

## Section Outline

| Block | Time | Content |
|-------|------|---------|
| **Opening Hook** | 5 min | Engage + Future Stakes |
| **Key Messages 1-3** | 10 min | Plant strategic seeds (conversational) |
| **Pro vs Fabric Reality Check** | 10 min | Comparison table + honest trade-offs |
| **Key Messages 4-5** | 5 min | Migration framing |
| **Decision Framework** | 5 min | Simple flowchart or matrix |
| **Scenario Discussion** | 8 min | Quick group/neighbor discussion |
| **Wrap + Foreshadow** | 2 min | Connect to rest of day |

**Total: 45 minutes**

---

## Opening Hook

*Goal: Get participation, establish relevance, set emotional stakes*

### Part 1: Engage
> "Before we dive in, I'm curious about this room. Quick show of hands—
> 
> Who's here because someone above you said 'we need to look into Fabric'? *(hands)*
> 
> Who's here because you've hit a wall—model too big, refresh too slow, something's not working? *(hands)*
> 
> And who's here because you're worried that if you don't learn this, you'll be left behind? *(hands)*
> 
> Yeah. All valid reasons to be here. And honestly? I've felt all three of those at different points."

### Part 2: Future Stakes
> "So here's what I want for you. Picture yourself six months from now. You've made a call—Fabric or not Fabric.
> 
> In one version, you're drowning. Half-migrated, team frustrated, wondering why you rushed into something you didn't fully understand.
> 
> In another version, you made a *deliberate* choice. Your team is bought in. And whether you moved or stayed, it was the **right call for your situation.**
> 
> *(pause)*
> 
> That second version? That's what today is about. Not 'Fabric is amazing, go use it.' But giving you the clarity to make a decision you won't regret—and the skills to execute on it."

---

## Key Messages

These five messages form the narrative backbone of this section. Each weaves together technical and human considerations—because real decisions involve both.

### 1. "Fabric is not a Power BI upgrade—it's a platform decision"

Fabric changes how you think about data AND how your teams work together. It's not just adding features—it's consolidating tools, breaking down silos between analysts and engineers, and betting on where Microsoft is investing.

> **Human angle:** Team collaboration, organizational change, tool consolidation

---

### 2. "Power BI Pro is still the right answer for many organizations"

Pro isn't "lesser"—it's right-sized. If your reports work, your team is productive, and you don't have bandwidth for another change initiative, **that's a valid strategic choice**. Don't let FOMO drive a migration you don't need.

> **Human angle:** Change management burden, organizational bandwidth, "if it ain't broke"

---

### 3. "The 1GB limit is a symptom—ask what's really driving the conversation"

Yes, model size is real. But when someone says "we need Fabric," dig deeper. Is it actually about data volume? Or is it about talent retention, governance pressure, executive expectations, or wanting to modernize? The technical pain is often the excuse to address something bigger.

> **Human angle:** Real motivations, career/talent concerns, executive pressure, future-proofing

---

### 4. "Migration isn't all-or-nothing—match the pace to your people"

You can coexist and evolve. But the timeline shouldn't just be about technical readiness—it's about your team's capacity to learn, your organization's appetite for change, and your budget cycles. A 6-month technical migration with 0% adoption is a failure.

> **Human angle:** Learning curves, adoption, realistic pacing, budget cycles

---

### 5. "Make the decision before it's made for you"

Evaluate now, while you have time. The worst migrations happen when you hit a wall—model too big, audit failed, your best analyst quit for a company using modern tools. Proactive decisions are better than reactive ones.

> **Human angle:** Future-proofing, talent retention, avoiding crisis-mode decisions

---

## Topics Covered

### 1. What Problem Does Fabric Solve?
- The data platform fragmentation problem
- Why Microsoft consolidated services
- The "one lake, many engines" concept

### 2. Power BI Pro vs. Fabric Licensing
- Pro: Per-user licensing model
- Fabric: Capacity-based licensing model
- Cost comparison scenarios
- The Premium → Fabric transition (historical context)

### 3. When Power BI Pro is Sufficient
- Small team scenarios
- Report-centric workloads
- Limited data volumes (<1GB models)
- No need for advanced data engineering

### 4. When Fabric is Overkill
- Startups with small data
- Purely visualization needs
- Teams without data engineering skills
- Budget-constrained organizations

### 5. Decision Framework for Migration
- Assessment questions to ask
- Red flags and green lights
- Hybrid approaches (Pro + Fabric)
- Migration timeline considerations

---

## Demo Ideas

### Demo 1: Capacity Metrics Comparison
- Show Fabric capacity metrics app
- Explain CU consumption
- Compare to Pro license costs

### Demo 2: Cost Calculator Walkthrough
- Use Azure pricing calculator
- Model different scenarios
- Break-even analysis

---

## Lab Exercise

**Duration:** 15 minutes

### Scenario Assessment Exercise

Given three fictional company scenarios, determine whether each should:
- Stay with Power BI Pro
- Move to Fabric
- Use a hybrid approach

See [lab/scenario-assessment.md](./lab/scenario-assessment.md) for the exercise.

---

## Key Takeaways

Reinforce the five key messages:

1. **Fabric is a platform decision, not an upgrade** - It changes how teams work together
2. **Pro is still valid** - Right-sized for many organizations
3. **Dig deeper than the technical pain** - Understand the real drivers
4. **Match the pace to your people** - Technical readiness ≠ organizational readiness
5. **Decide proactively** - Before a crisis forces your hand

---

## Discussion Questions

- What data challenges does your organization face today?
- How much time do you spend moving data between systems?
- Do you have team members who could benefit from notebooks/data engineering?
- What's your current model size, and is it growing?

---

## Resources

- [Microsoft Fabric Pricing](https://azure.microsoft.com/pricing/details/microsoft-fabric/)
- [Fabric Capacity Planning](https://learn.microsoft.com/fabric/enterprise/plan-capacity)
- [Pro vs Premium vs Fabric Comparison](https://learn.microsoft.com/power-bi/fundamentals/service-features-license-type)

---

| [🏠 Home](../README.md) | [Next: CI/CD & Git Integration →](../02-cicd-git-integration/README.md) |
|:--|--:|

---

## Standalone Usage

This section can be delivered as a standalone 45-minute talk with no technical prerequisites. It works well as an executive briefing or decision-maker overview.

**Standalone title suggestion:** "Should You Move to Microsoft Fabric? A Decision Framework"

---

## Folder Contents

```
01-strategic-context/
├── README.md           # This file
├── slides/             # Presentation slides
├── demos/              # Demo scripts and notes
└── lab/                # Scenario assessment exercise
```
