---
description: Generate a detailed jobs graph below Core Job level for a segment
---

# Jobs Graph Generation

Work according to the Advanced Jobs To Be Done methodology.

Describe the jobs graph below the level of Core Job for a segment.

## Input Required

Please provide:
1. **Segment description**: {segment description from segment generation prompt}
2. **Product description**: {product description with link to website}
3. **Core Job**: {Core Job description from segment generation prompt work}

## Jobs Graph Structure

A jobs graph shows all jobs at a lower level than the segment's Core Jobs that a person performs to complete the Core Job. Describe the complete sequence of jobs with the following details:

### For Each Job:

**When:**
- Context: {the context in which the person performs this job}
- Trigger: {what happened that triggered this job}
- Emotions at point A: {emotional state before the job is done}

**Want to get the expected result:**
- {what result the person wants to achieve}

**Success criteria:**
- {criteria by which the person will evaluate that they achieved the result well enough}

**Problems [if any]:**
- {problems encountered while performing this job}
- Problem strength on a 10-point scale: {1-10}

---

## Example Format

**Job 1: Choose the right product category**

When:
- Context: browsing the website, not familiar with the product range
- Trigger: opened the homepage
- Emotions at point A: uncertainty, slight anxiety about making the wrong choice

Want: quickly understand which category suits my needs

Success criteria:
- categories are clearly named
- I can see examples of products in each category
- takes less than 30 seconds to decide

Problems:
- Category names are too abstract
- No visual examples
Problem strength: 7/10

---

## Instructions

1. Start from the earliest job in the sequence (often awareness or trigger)
2. Progress chronologically through all jobs needed to complete the Core Job
3. Include all critical jobs - missing even one can break the entire sequence
4. For each job, be specific about context, triggers, and success criteria
5. Identify real problems with their severity (many jobs may have no problems)
6. Focus on jobs the user actually performs, not idealized flows

After generating the jobs graph, offer to:
1. Identify the biggest problems in the critical path
2. Suggest product improvements based on the graph
3. Create a landing page optimized for this job sequence
