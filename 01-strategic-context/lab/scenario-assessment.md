# Lab: Scenario Assessment Exercise

**Duration:** 15 minutes

---

## Instructions

Review the three company scenarios below. For each one, determine whether they should:

- **A)** Stay with Power BI Pro
- **B)** Move to Microsoft Fabric
- **C)** Use a hybrid approach (Pro + Fabric)

Be prepared to explain your reasoning.

---

## Scenario 1: Boutique Marketing Agency

**Company Profile:**
- 15 employees
- 8 people use Power BI reports
- Data sources: Google Analytics, Salesforce, Excel files
- Largest dataset: 50MB
- Budget: Limited, cost-conscious
- IT resources: None (everyone does their own thing)

**Current Pain Points:**
- Refresh sometimes fails
- Want to share reports with clients

**Your Recommendation:**

```
[ ] A) Stay with Power BI Pro
[ ] B) Move to Microsoft Fabric  
[ ] C) Hybrid approach

Reasoning:
_________________________________________________
_________________________________________________
_________________________________________________
```

---

## Scenario 2: Regional Healthcare System

**Company Profile:**
- 2,000 employees
- 200 Power BI users across departments
- Data sources: Epic EHR, SQL Server data warehouse, Excel
- Largest dataset: 15GB (and growing)
- Budget: Available for right solution
- IT resources: 3-person BI team, no data engineers

**Current Pain Points:**
- Hitting 1GB model limit constantly
- Using aggregations and DirectQuery workarounds
- Want better governance and lineage
- Need to integrate with Azure data lake

**Your Recommendation:**

```
[ ] A) Stay with Power BI Pro
[ ] B) Move to Microsoft Fabric  
[ ] C) Hybrid approach

Reasoning:
_________________________________________________
_________________________________________________
_________________________________________________
```

---

## Scenario 3: E-commerce Startup

**Company Profile:**
- 50 employees
- 12 Power BI users
- Data sources: Shopify, Stripe, PostgreSQL, BigQuery
- Largest dataset: 500MB
- Budget: Moderate, growing
- IT resources: 1 data engineer, 2 analysts

**Current Pain Points:**
- Data engineer spends 60% of time on ETL
- Multiple copies of data everywhere
- Want real-time inventory dashboards
- Growing fast, expect 10x data in 2 years

**Your Recommendation:**

```
[ ] A) Stay with Power BI Pro
[ ] B) Move to Microsoft Fabric  
[ ] C) Hybrid approach

Reasoning:
_________________________________________________
_________________________________________________
_________________________________________________
```

---

## Discussion

After completing your assessments, be prepared to discuss:

1. What was the most important factor in each decision?
2. Did budget or technical needs drive the decision more?
3. How would your recommendation change if [variable] was different?

---

## Suggested Answers

*(Facilitator reference - don't peek!)*

<details>
<summary>Click to reveal suggested answers</summary>

### Scenario 1: Boutique Marketing Agency
**Recommendation: A) Stay with Power BI Pro**

Rationale:
- Small data volumes (50MB) well under Pro limits
- Limited IT resources to manage Fabric complexity
- Cost-conscious budget
- Client sharing can be done with Pro and "publish to web" or guest users
- Fabric would be overkill and add unnecessary complexity

### Scenario 2: Regional Healthcare System
**Recommendation: B) Move to Microsoft Fabric**

Rationale:
- 15GB dataset clearly exceeds Pro limits
- Already struggling with workarounds
- Budget available for proper solution
- Azure data lake integration is native in Fabric
- Governance and lineage features address stated needs
- BI team can learn Fabric (it's still Power BI at the report layer)

### Scenario 3: E-commerce Startup
**Recommendation: C) Hybrid approach (start now, expand later)**

Rationale:
- Current data (500MB) fits in Pro
- BUT: Data engineer time wasted on ETL → Fabric Pipelines could help
- Real-time dashboards → DirectQuery or Direct Lake
- 10x growth expected → will need Fabric eventually
- Recommendation: Start Fabric trial now, migrate ETL first, move BI later

</details>
