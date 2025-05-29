# Workforce Downsizing Analysis — SQL-Driven Insight into Global Layoffs (2020–2023)

Welcome to my project!

This analysis explores global layoff trends from 2020 to 2023 — a period shaped by the COVID-19 aftermath, economic shifts, and changing investor sentiment. It focuses on real-world company layoffs across industries, countries, and funding stages using SQL for all cleaning, transformation, and analysis.

---

## Why This Project?

As a data enthusiast and accounting professional, I wanted to challenge myself with a realistic dataset that reflects both economic trends and business dynamics. This project sharpened my ability to:
- Clean and manage messy data
- Write advanced SQL queries
- Derive real-world insights through structured analysis

---

## Tech Stack

- SQL Server Management Studio (SSMS) – Data cleaning, querying, and analysis
- Microsoft Excel – Preliminary data inspection
- Kaggle – Source of the dataset (Layoffs 2020–2023)

---

## Dataset Snapshot

The dataset includes:
- company: Name of organization
- location: City/region of the layoff
- industry: Business sector
- total_laid_off: Number of affected employees
- percentage_laid_off: Proportion of workforce laid off
- date: Date of layoff event
- stage: Funding stage (e.g., Seed, Series A, Post-IPO)
- country: Country of occurrence
- funds_raised_millions: Capital raised before layoff

---

## Project Breakdown

### Phase 1: Data Cleaning

Table used: layoff_demo (duplicate of raw data for safe editing)

Cleaning steps:
- Removed duplicates using ROW_NUMBER() partitioning
- Standardized text fields (TRIM, fix country and industry values)
- Normalized inconsistent entries (e.g., "Crypto" vs "Cryptocurrency")
- Corrected country label issues (e.g., "United States." → "United States")
- Reformatted data types for consistency (especially date and percentage_laid_off)
- Inferred missing industry values using known company data
- Removed records with missing critical data (total_laid_off, percentage_laid_off)
- Converted percentage values to proper decimals

> Final cleaned data used for analysis was saved in layoff_demo.

---

### Phase 2: Exploratory Data Analysis (EDA)

#### A. Temporal Trends
- Total layoffs by year (2022 was the peak)
- Average percentage laid off per year (highest in 2023)
- Comparison between Seed vs Post-IPO companies

#### B. Industry Insights
- Top 5 industries by total layoffs and average severity
- Year-over-year industry layoff patterns
- Sectors with persistent layoffs (e.g., Tech, Consumer, Education)

#### C. Country Analysis
- Countries with highest layoffs (U.S., India, Canada)
- Countries with highest average % laid off (Singapore, Sweden)
- Cross-analysis of industry × country distribution

#### D. Company Stage Breakdown
- Layoffs by funding stage
- Startups vs mature companies — how each category responded to economic pressure

---

## Key Highlights

- Full-cycle SQL project: From raw data → insights
- No Python, BI tools, or external libraries used
- Advanced SQL techniques including:
  - CTEs
  - Window functions
  - Aggregations
  - Conditional updates and inference logic
- Tackles messy, real-world data head-on

---

## Known Limitations

- Static dataset (snapshot, not auto-updated)
- Layoff reporting may be biased toward larger firms
- Missing baseline employee counts limit true severity calculations
- Varying definitions of startup stages across regions

---

## File Structure

| File | Description |
|------|-------------|
| layoffs - Raw Data | Raw dataset from Kaggle |
| Data_cleaning_&_Exploration_With_SQL | SQL script for data cleaning |
| Full_Analysis_of_Global_Layoffs | Full Analysis of the SQL script |
| Global_Layoff_Analysis | Power BI Dashboard |
| README.md | Project documentation (this file!) |

---

## Final Thoughts

This project is more than a technical exercise — it's a story of economic disruption told through data. It pushed me to:
- Approach analysis with structure and logic
- Translate numbers into narratives
- Showcase how SQL alone can power end-to-end data projects

Prepared by:  
Otun Oluwapelumi Ayodele (AAT)  

---

## Let’s Connect

Have feedback, collaboration ideas, or job leads?  
Feel free to open an issue or reach out via X: @FiscalMindAcct, LinkedIn: www.linkedin.com/in/oluwapelumiotun, or ayodeleotunfm@gmail.com

---

> ⭐ Star this repo if you find it insightful!
