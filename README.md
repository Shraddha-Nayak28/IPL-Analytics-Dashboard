# IPL Analytics Dashboard
### A Business Intelligence & SQL Data Analysis Project

---

## Overview

This project analyzes **Indian Premier League (IPL) cricket data from 2008 to 2024** using SQL for data exploration and Power BI for interactive dashboards. It was built as a self-initiated learning project to demonstrate end-to-end BI skills — from raw CSV data to actionable insights.

---

## Dataset

**Source:** [Kaggle — IPL Complete Dataset (2008–2024)](https://www.kaggle.com/datasets/patrickb1912/ipl-complete-dataset-20082020)

**Files used:**
| File | Description |
|------|-------------|
| `matches.csv` | One row per match — teams, venue, toss, result, winner |
| `deliveries.csv` | Ball-by-ball data — batsman, bowler, runs, dismissals |

---

## Tools Used

- **SQL (SQLite / DB Browser)** — Data exploration and query-based analysis
- **Power BI Desktop** — Dashboard creation and visualization
- **Microsoft Excel** — Initial data inspection and cleaning

---

## Project Structure

```
ipl_analytics_portfolio/
│
├── matches.csv                    ← Raw dataset (from Kaggle)
├── deliveries.csv                 ← Raw dataset (from Kaggle)
│
├── ipl_analysis_queries.sql       ← All SQL queries used for analysis
├── IPL_Analytics_Dashboard.pbix   ← Power BI dashboard file
│
├── portfolio.html                 ← Portfolio summary page
└── README.md                      ← This file
```

---

## Dashboard Pages (Power BI)

The `.pbix` file contains **4 report pages**:

1. **Overview** — Season-wise match count, total runs, title winners
2. **Team Performance** — Win rates, head-to-head records, toss impact
3. **Batting Analysis** — Top run scorers, strike rates, powerplay vs death over scoring
4. **Bowling & Venues** — Top wicket takers, venue-wise stats, home vs away trends

**Slicers available:** Season, Team, Venue, Batting/Bowling first

---

## Key Findings

- Teams that win the toss and choose to **field first** win approximately **52%** of the time — a slight but consistent edge.
- **Mumbai Indians** has the highest overall win count across all IPL seasons.
- **Death overs (16–20)** produce significantly higher run rates than powerplay overs on average.
- **Wankhede Stadium (Mumbai)** and **Chinnaswamy Stadium (Bangalore)** are the highest-scoring venues.
- The average runs per match has **increased over seasons**, reflecting faster batting trends.

---

## How to Run the SQL Queries

1. Download `matches.csv` and `deliveries.csv` from the Kaggle link above
2. Open [DB Browser for SQLite](https://sqlitebrowser.org/) (free tool)
3. Create a new database and import both CSV files as tables named `matches` and `deliveries`
4. Open `ipl_analysis_queries.sql` and run each query block

---

## How to Open the Power BI Dashboard

1. Install [Power BI Desktop](https://powerbi.microsoft.com/desktop/) (free)
2. Open `IPL_Analytics_Dashboard.pbix`
3. If prompted about data source, point it to the local CSV files
4. Use the slicers on each page to filter by season, team, or venue

---

## Skills Demonstrated

- Writing SQL aggregation queries (GROUP BY, JOINs, CASE WHEN, subqueries)
- Data cleaning and transformation
- Building relationships between tables in Power BI
- Creating DAX measures for custom KPIs
- Designing multi-page interactive dashboards
- Extracting business insights from raw sports data

---

## About

Built by an engineering graduate as a self-learning project to explore BI tools and data analytics workflows. All data is publicly available via Kaggle under open license.

---

*Last updated: June 2026*
