-- ============================================================
--  IPL Analytics Project — SQL Queries
--  Dataset: Kaggle IPL Complete Dataset (2008–2024)
--  Tables used: matches, deliveries
-- ============================================================


-- ------------------------------------------------------------
-- 1. OVERALL WIN COUNT BY TEAM
-- ------------------------------------------------------------
SELECT
    winner,
    COUNT(*) AS total_wins
FROM matches
WHERE winner IS NOT NULL
GROUP BY winner
ORDER BY total_wins DESC;


-- ------------------------------------------------------------
-- 2. WIN RATE BY TEAM (wins vs total matches played)
-- ------------------------------------------------------------
SELECT
    team,
    SUM(wins) AS total_wins,
    SUM(played) AS total_played,
    ROUND(SUM(wins) * 100.0 / SUM(played), 2) AS win_rate_pct
FROM (
    SELECT team1 AS team, 0 AS wins, 1 AS played FROM matches
    UNION ALL
    SELECT team2 AS team, 0 AS wins, 1 AS played FROM matches
    UNION ALL
    SELECT winner AS team, 1 AS wins, 0 AS played FROM matches WHERE winner IS NOT NULL
) t
GROUP BY team
ORDER BY win_rate_pct DESC;


-- ------------------------------------------------------------
-- 3. TOSS DECISION IMPACT: Does winning the toss help?
-- ------------------------------------------------------------
SELECT
    toss_decision,
    COUNT(*) AS total_matches,
    SUM(CASE WHEN toss_winner = winner THEN 1 ELSE 0 END) AS toss_winner_also_won,
    ROUND(
        SUM(CASE WHEN toss_winner = winner THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2
    ) AS win_pct_after_toss
FROM matches
WHERE winner IS NOT NULL
GROUP BY toss_decision;


-- ------------------------------------------------------------
-- 4. IPL TITLE WINNERS (Season Champions)
-- ------------------------------------------------------------
SELECT
    season,
    winner AS ipl_champion
FROM matches
WHERE match_type = 'Final'
   OR id IN (
       SELECT MAX(id) FROM matches GROUP BY season
   )
ORDER BY season;


-- ------------------------------------------------------------
-- 5. TOP 10 RUN SCORERS (all time)
-- ------------------------------------------------------------
SELECT
    batsman,
    SUM(batsman_runs) AS total_runs,
    COUNT(DISTINCT match_id) AS matches_played,
    ROUND(SUM(batsman_runs) * 1.0 / COUNT(DISTINCT match_id), 2) AS avg_per_match
FROM deliveries
GROUP BY batsman
ORDER BY total_runs DESC
LIMIT 10;


-- ------------------------------------------------------------
-- 6. TOP 10 WICKET TAKERS (all time)
-- ------------------------------------------------------------
SELECT
    bowler,
    COUNT(*) AS total_wickets
FROM deliveries
WHERE dismissal_kind NOT IN ('run out', 'retired hurt', 'obstructing the field')
  AND dismissal_kind IS NOT NULL
GROUP BY bowler
ORDER BY total_wickets DESC
LIMIT 10;


-- ------------------------------------------------------------
-- 7. VENUE-WISE MATCH COUNT & HOME ADVANTAGE
-- ------------------------------------------------------------
SELECT
    venue,
    city,
    COUNT(*) AS total_matches
FROM matches
GROUP BY venue, city
ORDER BY total_matches DESC
LIMIT 15;


-- ------------------------------------------------------------
-- 8. SEASON-WISE AVERAGE RUNS PER MATCH
-- ------------------------------------------------------------
SELECT
    m.season,
    COUNT(DISTINCT d.match_id) AS matches,
    SUM(d.total_runs) AS total_runs_scored,
    ROUND(SUM(d.total_runs) * 1.0 / COUNT(DISTINCT d.match_id), 1) AS avg_runs_per_match
FROM deliveries d
JOIN matches m ON d.match_id = m.id
GROUP BY m.season
ORDER BY m.season;


-- ------------------------------------------------------------
-- 9. POWERPLAY (OVERS 1–6) vs DEATH OVER (17–20) SCORING
-- ------------------------------------------------------------
SELECT
    CASE
        WHEN over BETWEEN 0 AND 5 THEN 'Powerplay (1-6)'
        WHEN over BETWEEN 6 AND 14 THEN 'Middle Overs (7-15)'
        WHEN over >= 15 THEN 'Death Overs (16-20)'
    END AS phase,
    SUM(total_runs) AS runs_scored,
    COUNT(*) AS balls_bowled,
    ROUND(SUM(total_runs) * 6.0 / COUNT(*), 2) AS run_rate
FROM deliveries
GROUP BY phase
ORDER BY MIN(over);


-- ------------------------------------------------------------
-- 10. MATCHES WON BY BATTING FIRST vs CHASING
-- ------------------------------------------------------------
SELECT
    result,
    COUNT(*) AS matches
FROM matches
WHERE result IS NOT NULL
GROUP BY result;


-- ============================================================
-- NOTE: Adjust column names if your Kaggle CSV uses
-- slightly different headers (e.g., 'id' vs 'match_id').
-- Import CSVs into SQLite / MySQL before running these.
-- ============================================================
