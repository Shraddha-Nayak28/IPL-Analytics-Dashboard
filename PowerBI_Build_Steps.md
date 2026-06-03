# Power BI Dashboard — Step-by-Step Build Guide
## IPL Analytics Dashboard (2008–2024)

---

## STEP 1: Get the Dataset from Kaggle

1. Go to: https://www.kaggle.com/datasets/patrickb1912/ipl-complete-dataset-20082020
2. Click **Download** (Kaggle)
3. Extract the ZIP — you will get:
   - `matches.csv`
   - `deliveries.csv`
4. Save both files in a folder like `C:\IPL_Project\`

---

## STEP 2: Open Power BI Desktop

- Download free from: https://powerbi.microsoft.com/desktop/
- Open Power BI Desktop

---

## STEP 3: Load the Data

1. Click **Home → Get Data → Text/CSV**
2. Select `matches.csv` → Click **Load**
3. Repeat for `deliveries.csv` → Click **Load**

You should now see both tables in the **Fields** panel on the right.

---

## STEP 4: Create a Relationship Between Tables

1. Click the **Model** icon on the left sidebar (looks like 3 connected boxes)
2. You will see `matches` and `deliveries` tables
3. Drag `matches[id]` and connect it to `deliveries[match_id]`
4. Set cardinality: **One to Many** (1 match → many deliveries)
5. Click **OK**

---

## STEP 5: Create DAX Measures

Click on the `matches` table in Fields panel. Then go to **Home → New Measure** and add these one by one:

**Total Matches:**
```
Total Matches = COUNTROWS(matches)
```

**Total Runs:**
```
Total Runs = SUM(deliveries[total_runs])
```

**Win % (Batting First):**
```
Win % Bat First = 
DIVIDE(
    CALCULATE(COUNTROWS(matches), matches[result] = "runs"),
    COUNTROWS(matches)
) * 100
```

**Toss Win & Match Win:**
```
Toss + Match Win = 
CALCULATE(
    COUNTROWS(matches),
    matches[toss_winner] = matches[winner]
)
```

---

## STEP 6: Build Page 1 — Overview

1. Right-click the page tab at the bottom → **Rename** → type `Overview`
2. Add these visuals:

**Card visual — Total Matches**
- Insert → Card
- Drag `Total Matches` measure into Values

**Card visual — Total Runs**
- Insert → Card
- Drag `Total Runs` into Values

**Bar Chart — Wins per Team**
- Insert → Clustered Bar Chart
- X-axis: `matches[winner]`
- Y-axis: Count of rows (or `Total Matches`)
- Sort descending

**Line Chart — Matches per Season**
- Insert → Line Chart
- X-axis: `matches[season]`
- Y-axis: Count of `matches[id]`

**Slicer — Season**
- Insert → Slicer
- Field: `matches[season]`
- Format as dropdown

---

## STEP 7: Build Page 2 — Team Performance

1. Add a new page → rename to `Team Performance`

**Stacked Bar — Win Rate by Team**
- Use the Win % measure grouped by team

**Donut Chart — Toss Decision (Bat vs Field)**
- Values: Count
- Legend: `matches[toss_decision]`

**Table — Head to Head**
- Columns: `team1`, `team2`, `winner`, `season`

**Slicer — Team**
- Field: `matches[team1]` (rename label to "Select Team")

---

## STEP 8: Build Page 3 — Batting Analysis

1. Add new page → rename to `Batting Analysis`

**Bar Chart — Top 10 Run Scorers**
- X-axis: `deliveries[batsman]`
- Y-axis: SUM of `deliveries[batsman_runs]`
- Filter: Top N = 10 (use Visual-level filter)

**Clustered Column — Runs by Phase**
- Create a calculated column in deliveries table:
```
Over Phase = 
IF(deliveries[over] <= 5, "Powerplay",
IF(deliveries[over] <= 14, "Middle", "Death"))
```
- X-axis: Over Phase
- Y-axis: SUM batsman_runs

**Line Chart — Average Score per Season**

---

## STEP 9: Build Page 4 — Venues & Bowling

1. Add new page → rename to `Venues & Bowling`

**Map or Bar Chart — Matches per City**
- Field: `matches[city]`
- Values: Count

**Bar Chart — Top Wicket Takers**
- Filter `deliveries` where `dismissal_kind` is not null and not "run out"
- X-axis: `deliveries[bowler]`
- Y-axis: Count of dismissals
- Top 10 filter

---

## STEP 10: Final Formatting

1. Go to **View → Themes** → pick a clean dark or light theme
2. Add your name/title as a Text Box on each page
3. Align all visuals using **Format → Align**
4. Save file as `IPL_Analytics_Dashboard.pbix`

---

## STEP 11: Upload to Google Drive

1. Save the `.pbix` file
2. Upload to Google Drive
3. Right-click → **Share** → **Anyone with the link can view**
4. Copy the link and paste it in the internship application form

---

## Tips

- If columns are not found, open **Transform Data** and check exact column names in your CSV
- Use **Format Pane** (paint roller icon) to change chart colors, font sizes, and titles
- Add a company logo or IPL logo image as decoration using Insert → Image

---

*This guide is specific to Power BI Desktop (free version). All steps work without a Power BI Pro subscription.*
