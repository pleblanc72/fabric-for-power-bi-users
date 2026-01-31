# Section 01: Strategic Context - Talking Points Reference

---

## OPENING HOOK (5 minutes)

---

### Slide 1: Title Slide

- Brief intro of yourself
- "Before we get into any technology, I want to understand who's in the room"

---

### Slide 2: Agenda

"Here's our roadmap for today.

We're starting with strategy—not technology. I want you to understand *why* before we get into *how*.

Then we'll go hands-on. Git integration, Lakehouses, Dataflows, Direct Lake, and we'll finish with Semantic Link and Copilot.

By the end, you'll have built something real—and you'll know whether Fabric belongs in your organization."

---

### Slide 3: Prerequisites

"If you want to follow along hands-on today, here's what you'll need.

First, a Fabric workspace—a free 60-day trial works perfectly. Just go to app.fabric.microsoft.com and click 'Start trial.' Important note: a Power BI Pro license alone isn't enough. You need actual Fabric capacity for the Lakehouse, notebooks, and Direct Lake features we'll be using.

Second, a GitHub account for the Git integration section. Free accounts work fine.

Third, Power BI Desktop—latest version, December 2025 or later.

Don't have access yet? That's fine. Watch today, take notes, and use our guides to replicate everything later. The materials will be available."

---

### Slide 4: Why Are You Here?

"Quick show of hands—

Who's here because someone above you said 'we need to look into Fabric'? *(pause for hands)*

Who's here because you've hit a wall—model too big, refresh too slow, something's not working? *(pause for hands)*

And who's here because you're worried that if you don't learn this, you'll be left behind? *(pause for hands)*

Yeah. All valid reasons to be here. And honestly? I've felt all three of those at different points."

---

### Slide 5: Six Months From Now

"Picture yourself six months from now. You've made a call—Fabric or not Fabric.

In one version, you're drowning. Half-migrated, team frustrated, wondering why you rushed into something you didn't fully understand.

In another version, you made a *deliberate* choice. Your team is bought in. And whether you moved or stayed, it was the **right call for your situation.**

*(pause)*

That second version? That's what today is about. Not 'Fabric is amazing, go use it.' But giving you the clarity to make a decision you won't regret—and the skills to execute on it."

---

## KEY MESSAGES 1-3 (10 minutes)

---

### Slide 6: Key Message 1

"First thing to understand: Fabric isn't just Power BI with more features. It's a fundamentally different architecture.

When you move to Fabric, you're not upgrading a tool. You're:
- Consolidating your data platform
- Breaking down silos between analysts and engineers  
- Betting on where Microsoft is investing

This is an organizational change, not just a technical one. Your teams will work differently. Your data will live differently.

If you're thinking 'I just want bigger datasets'—that's valid, but it's not the whole picture."

---

### Slide 7: Key Message 2

"I want to give you permission right now: It's okay to stay on Pro.

Pro isn't 'lesser.' It's right-sized. If:
- Your reports work
- Your team is productive
- You don't have bandwidth for another change initiative

...that's a valid strategic choice. Don't let FOMO drive a migration you don't need.

One of the worst things you can do is move to Fabric because it's new, and then spend six months dealing with problems you didn't have before."

---

### Slide 8: Key Message 3

"Yes, the 1GB model limit in Pro is real. And yes, Fabric solves it.

But when someone in your organization says 'we need Fabric,' I want you to dig deeper. Ask:

- Is it actually about data volume? Or...
- Talent retention? Your best people want modern tools.
- Governance pressure? Auditors asking hard questions.
- Executive expectations? 'Why aren't we on the latest?'
- Future-proofing? Positioning for where things are going.

The technical pain is often the *excuse* to address something bigger. Understanding the real driver helps you make a better decision—and build a better business case."

---

## PRO VS FABRIC REALITY CHECK (10 minutes)

---

### Slide 9: Pro vs Fabric Comparison

"Alright, this is the slide you'll want to take a photo of. Let me walk you through what's actually different.

**Model size**—yes, Pro caps at 1GB. Fabric? 400GB+. If this is your only pain point, that's valid. But keep listening.

**Storage**—Pro gives you Import and DirectQuery. Fabric adds Direct Lake—which is a game-changer we'll demo later. It reads directly from OneLake, so your data is as fresh as your source—and query performance rivals Import mode without copying the data.

**Git and CI/CD**—this is where 'platform decision' becomes real. Pro has basic deployment pipelines. Fabric has native Git integration—version control, branching, the works. If you're serious about DevOps, this matters.

**Security scope**—here's one people miss. Pro secures your *model*—RLS, OLS. Fabric secures your *data* at the lake level, before it even hits a model. For regulated industries, this is huge.

**Copilot**—not available in Pro. Requires Fabric capacity. Now, you might say 'I don't need AI'—fair. But watch where Microsoft is investing. This is their direction.

**Cost model**—Pro is $10/user/month. Simple. Fabric is capacity-based—you buy compute, everyone shares it. At scale, Fabric often wins. At small scale, Pro is simpler.

**Team skills**—this is the human angle. Pro is BI-focused. Your report builders know it. Fabric requires broader skills—SQL, Python, data engineering concepts. That's either an opportunity or a barrier, depending on your team.

**Data platform**—and here's the big one. Pro gives you Import, DirectQuery, Dataflows. Fabric gives you a full data stack: Lakehouses, Warehouses, Notebooks, Pipelines, Semantic Link. We'll dig into all of these today. For now, just know: this isn't Power BI with extras. It's a platform.

*(pause)*

So—quick gut check. Raise your hand if looking at this, you're thinking 'yeah, we probably need to look at Fabric.' *(pause)* And raise your hand if you're thinking 'actually, Pro might be fine for us.' *(pause)*

Both are valid. That's the point."

---

## KEY MESSAGES 4-5 (5 minutes)

---

### Slide 10: Key Message 4

"Here's the good news: You don't have to move everything to Fabric on day one.

Pro reports can connect to Fabric data. You can migrate incrementally. Start with one use case, prove value, expand.

But here's what most people miss: The timeline shouldn't just be about technical readiness.

It's about:
- Your team's capacity to learn
- Your organization's appetite for change
- Your budget cycles

A 6-month technical migration with 0% adoption is a failure. Match the pace to your people, not just your data."

---

### Slide 11: Key Message 5

"The best time to evaluate Fabric is now—while you have time, while you have options.

The worst migrations happen when you hit a wall:
- Model too big, everything's slow
- Audit failed, scrambling for governance
- Your best analyst quit for a company using modern tools

Those are reactive decisions. Crisis-mode decisions.

Today, you're being proactive. You're evaluating before you're forced to. That's a strategic advantage.

So let's give you a simple framework to make this decision..."

---

## DECISION FRAMEWORK (5 minutes)

---

### Slide 12: Decision Framework

"Here's a simple decision tree. Take a photo—use this with your team.

Start at the top: **Is your data hitting the 1GB limit?**

If YES—ask yourself: do you need large datasets with fast query performance? Direct Lake in Fabric lets you query huge datasets directly from OneLake without importing—it's as fresh as your source data. If your team is ready for new skills—go full platform. If your team needs time—start hybrid. Pro reports, Fabric data.

If NO—you're not hitting limits—ask: **Are you being pushed on DevOps?** Auditors asking about version control? Leadership wants CI/CD? That's a legitimate reason to evaluate Fabric for Git integration alone.

If that's not the driver either—ask: **Does leadership expect you to be on a 'modern platform'?** Sometimes the pressure isn't technical. It's strategic. Future-proofing is valid—just be honest that's what's driving it.

And if none of those apply? **Stay on Pro.** Seriously. You're fine. Put a reminder in your calendar to revisit in 12 months.

*(pause)*

Notice there's no wrong answer here. Every path is valid. The wrong answer is *not deciding*—drifting into Fabric because it's new, or avoiding it because change is hard."

---

## SCENARIO DISCUSSION (8 minutes)

---

### Slide 13: Scenario Discussion

"I want you to apply what we just discussed. Turn to your neighbor—or your table if you're in groups.

Pick one of these scenarios. You have 5 minutes to discuss:
- Should they stay on Pro, move to Fabric, or do a hybrid?
- What's the deciding factor?
- What would YOU ask them before making a recommendation?

Go."

*[Let discussion happen for 5 minutes, then bring it back]*

"Okay, let's hear a couple. Anyone want to share their reasoning for Company A? ... Company B? ... Company C?"

*[Take 2-3 responses, ~3 minutes]*

---

### Slide 14: Scenario 1 Vote

"Scenario 1—the marketing agency. 15 people, tiny data, tight budget.

Who said Stay on Pro? *(count hands)* 
Fabric? *(count hands)*
Hybrid? *(count hands)*

Yeah, most of you said Pro. Why? *(take 1-2 quick answers)*"

---

### Slide 15: Scenario 2 Vote

"Scenario 2—healthcare. 2,000 people, 15 gigs, already hitting walls.

Stay on Pro? *(count hands—should be few)*
Fabric? *(count hands—should be most)*
Hybrid? *(count hands)*

This one's more clear-cut. What made it obvious? *(take 1-2 quick answers)*"

---

### Slide 16: Scenario 3 Vote

"Scenario 3—the startup. 500 megs today, but 10x growth coming.

Stay on Pro? *(count hands)*
Fabric? *(count hands)*
Hybrid? *(count hands)*

This one usually splits the room. Why? *(take 1-2 quick answers)*

The data fits today—but do you wait until it's painful, or get ahead of it?"

---

### Slide 17: The Expert Take

"Here's what I'd recommend—and more importantly, why.

**Agency:** Stay on Pro. They have no pain point. Fabric would add complexity they don't need and can't support.

**Healthcare:** Move to Fabric. 15GB is already past Pro's limits. They have budget. Stop fighting workarounds.

**Startup:** This is the interesting one. The data fits today. But they have a data engineer wasting time on ETL, and 10x growth coming. I'd say: *evaluate now, start hybrid, be ready*.

Notice—in every case, the answer isn't just about data size. It's about team, budget, pain, and trajectory."

---

## WRAP + FORESHADOW (2 minutes)

---

### Slide 18: What's Coming Today

"So we've talked strategy. Now let's see what Fabric actually does.

Today you'll:
- Set up Git integration—see what 'platform decision' looks like in practice
- Build Lakehouses—understand where your data lives in this new world
- Create Dataflows and Pipelines—this is where learning curves hit, so we'll go hands-on
- Implement Direct Lake—the actual solution to that 1GB problem
- Explore Semantic Link and Copilot—where Microsoft is investing

By the end of today, you won't just understand Fabric. You'll know if it's right for your organization—and you'll have the skills to start if you decide to move."

---

### Slide 19: Break / Transition Slide

"Let's take a quick break, and then we'll dive into Git integration."

---

# END OF SECTION 01 TALKING POINTS
