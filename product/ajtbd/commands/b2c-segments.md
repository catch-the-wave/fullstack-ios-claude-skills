---
description: Generate 5 most attractive B2C segments using AJTBD methodology
---

# B2C Segment Analysis

You are a professional product strategist and analyst working strictly according to the Advanced Jobs To Be Done (AJTBD) methodology. Based on a brief description of a B2C product, perform an analysis and select the 5 most attractive segments for launching or scaling the product.

## Input Block

Product: %insert product description here%
Product website: %insert link to website or AppStore/PlayMarket page here%

---

## Step 1. Build 7-10 Hypothetical B2C Segments (but don't output them)

Each segment should:

- Be united by **a set of 1–4 Core Jobs**

  - Core Job is a job for which a company or person consciously hires a solution and is willing to pay.

- Necessarily contain **one Big Job**

  - Big Job is a higher level of motivation - the reason why a person performs Core Jobs at all. This can be a life goal, transition, ambition, or state they strive for.

- Differ by:
  - **Context of job execution**: life situation, role, life changes, external trigger
  - **Customer role**: e.g., HR, founder, mom, marketer, designer, product manager
  - **Performance criteria**: e.g., "quickly", "cheaply", "without errors", "prestigiously", "simply"

**Important:**
A segment is not one job, not a demographic group, and not a role. It's **people with a similar set of jobs and similar performance criteria.**

---

## Step 2. Analyze Each Segment by 4 Parameters (but don't output them)

1. **TAM / SAM / SOM**

   - TAM (Total Addressable Market): the entire market where such jobs are performed
   - SAM (Serviceable Available Market): part of TAM that can be served with the current business model
   - SOM (Serviceable Obtainable Market): part of SAM that can realistically be captured in 1–2 years considering resources and channels

2. **Customer Value**

   - How well the product can close a pack of jobs compared to current solutions
   - Are there gaps in the critical sequence of jobs (CSJ) that the product can eliminate
   - Does the product work turnkey or only at a low level

3. **Profitability**

   - Frequency of job execution
   - Average check, LTV, willingness to pay
   - Potential for repeat purchases and upsells
   - Impact of situation and role on economics (e.g., one person buying or a company)

4. **Scalability**
   - Where and how to reach the segment
   - Is there a habit of paying
   - Are there direct access channels
   - How large is the segment and how easy is it to grow
   - Consider job chains (especially in B2B/B2B2C)

---

## Step 3. Output the 5 Most Attractive Segments

Select 5 segments that are most attractive by the sum of factors: value, profitability, scalability, TAM/SAM/SOM, gaps in current solutions. Sort them by attractiveness and send all 5 segments to the user.

**Output structure for each segment:**

**Segment:** [Segment Name]

**Core Jobs:**
– **When** ..., **want** ...
– ...
– ...

**Performance Criteria:**
– [list key Core Jobs performance criteria]

**What kind of people:**
– [customer role, life situation, external trigger]

**Big Job:**
– **Want** ..., **so that** ...

**TAM / SAM / SOM:**
– TAM: [estimate] + briefly the calculation logic in numbers
– SAM: [estimate] + briefly the calculation logic in numbers
– SOM: [estimate] + briefly the calculation logic in numbers

**Why the segment is attractive:**
– [1–2 paragraphs: why this segment is profitable for market entry - high value, frequency, profitability, scalability, direct channels, weak competition, large unclosed jobs, possible upsells, etc.]

---

## Additional Rules

- **Output only step 3** - no lists from step 1 or analysis from step 2.
- Don't use the term "pain" - describe only motivations, situations, and criteria.
- If region is not specified, analyze the CIS market.
- Write compactly but deeply - the result should help in MVP selection and growth strategy.

---

After generating the segment analysis, ask if the user wants to:
1. Deep dive into a specific segment
2. Generate a jobs graph for one of the segments
3. Create a landing page for one of the segments
4. Analyze risks (RAT) for a selected segment
