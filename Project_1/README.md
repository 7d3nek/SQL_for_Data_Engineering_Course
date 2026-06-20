# Exploratory Data Analysis w/ SQL: Job Market Analysis

![Project Overview](images/1_1_Project1_EDA.png)

A SQL project analyzing the data engineering job market using real world job posting data. It demonstrates my ability to **write production-quality analytical SQL, design efficient queries, and turn business questions into data-driven insights.**

## 📋 Executive Summary

This project explores the remote Data Engineer job market to answer three core questions: which skills are most in-demand at top-tier tech companies (FAANG), which skills command the highest pay, and which skills offer the best balance of demand and compensation. The analysis combines aggregation, joins across a normalized job-postings schema, window functions, and ranking logic to move from raw postings to actionable career insights.

Key takeaways:
- 🐍 **Python and SQL** are the non-negotiable core skills for remote Data Engineer roles at FAANG companies.
- 💰 **Terraform, Kubernetes, and Airflow** command the highest median salaries among frequently requested skills.
- ⚡ **Spark, Airflow, and AWS** emerge as the highest-leverage skills overall — they balance strong market demand with above-average pay.

## 🧩 Problem & Context

Job seekers and career switchers in data engineering are often faced with an overwhelming list of tools and technologies to learn, with limited time to prioritize. Simply chasing the highest-paying skill can mean investing in a niche, low-demand tool, while chasing the most in-demand skill can mean settling for a lower salary ceiling.

This project analyzes a **data warehouse** built using a star schema design. The warehouse structure consists of:
![Data Warehouse](images/1_2_Data_Warehouse.png)

- **Fact Table:** `job_postings_fact` - Central table containing job posting details (job titles, locations, salaries, dates, etc.)
- **Dimension Tables:**
`company_dim` - Company information linked to job postings
`skills_dim` - Skills catalog with skill names and types
- **Bridge Table:** `skills_job_dim` - Resolves the many-to-many relationship between job postings and skills

By querying across these interconnected tables, I extracted insights about skill demand, salary patterns, and optimal skill combinations for data engineering roles.

## 🛠️ Tech Stack

🐤 **Query Engine:** DuckDB for fast OLAP-style analytical queries
🧮 **Language:** SQL (ANSI-style with analytical functions)
📊 **Data Model:** Star schema with fact + dimension + bridge tables
🛠️ **Development:** VS Code for SQL editing + Terminal for DuckDB CLI
📦 **Version Control:** Git/GitHub for versioned SQL scripts

## 🔎 Analysis Overview

The project is structured around three sequential SQL queries, each building on the previous one's insights:

[01_top_demanded_skills.sql]()

[02_top_paying_skills.sql]()

[03_optimal_skills.sql]()

1. [**🚀 Most In-Demand Skills at FAANG (Remote Data Engineer Roles)**]()
   Joins job postings to company and skills tables, filters to remote Data Engineer roles at Facebook/Meta, Apple, Amazon, Netflix, and Google, then counts skill frequency to surface the top 10 most requested skills.

2. [**💵 Highest-Paying Skills for Data Engineers**]()
   Calculates the **median** salary (to reduce the influence of outliers) for each skill across remote, salary-specified Data Engineer postings, while also tracking how frequently each skill appears — pairing pay with demand context.

3. [**⚖️ Most Optimal Skills (Demand + Salary Combined)**]()
   Uses window functions (`RANK()`) to rank skills independently by demand and by median salary, then averages the two ranks to produce a single composite score that identifies the best overall skills to learn.

### 🏆 Key Findings

[**🚀 Top in-demand skills at FAANG (remote):**]() Python and SQL lead (52 postings each), followed by Java, Scala, and Spark — reflecting data engineering's roots in JVM-based big data tooling, with Python/SQL as the universal baseline.

[**💵 Top-paying skills:**]() Terraform ($184K median) tops the list, followed by Kubernetes ($150.5K) and Airflow ($150K, 386 postings) — Airflow stands out for combining high pay with high demand. Python, despite having the highest demand overall (1,133 postings), pays closer to the median ($135K), since it's a baseline expectation rather than a differentiator.

[**⚖️ Best overall skills (demand + salary combined):**]() Spark ranks #1 overall by balancing strong demand with a high median salary. Airflow and AWS tie for second, representing two distinct strategies — Airflow leans on salary, AWS leans on demand. Python and SQL round out the top tier on sheer demand volume alone.

## 🧠 SQL Skills Demonstrated

- 🔗 **Multi-table joins** — `INNER JOIN` across four normalized tables (fact + dimension schema)
- 🧮 **Aggregate functions** — `COUNT()`, `MEDIAN()`, `ROUND()`
- 🔍 **Filtering** — `WHERE`, `HAVING` (post-aggregation filtering to remove noisy/niche skills)
- 📚 **Grouping & sorting** — `GROUP BY`, multi-column `ORDER BY`
- 🪟 **Window functions** — `RANK() OVER (ORDER BY ...)` for independent demand and salary rankings
- 🗂️ **Subqueries / derived tables** — wrapping a ranked CTE-style subquery to compute a composite score
- 💡 **Business-driven query design** — translating open-ended questions ("what should I learn?") into precise, well-justified SQL logic
- 📈 **Outlier-aware analysis** — choosing median over average to avoid salary outliers skewing results
