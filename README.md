# Gym Training Workload Analysis (SQLite)

This project analyzes personal gym training data from October and November 2025, exported as a CSV from the Hevy app and stored in a SQLite database. The goal of the analysis was to practice SQL-based data modeling and aggregation, as well as to examine patterns in training and drawing conclusions from real-world data.

## Data
- Raw workout data exported from Hevy as .csv
- Custom SQLite schema designed from scratch
- Mapping tables created to relate exercises to muscles and body regions

## Analysis Focus
The SQL analysis examines:
- Total and monthly weighted training volume
- Training frequency (days trained per month)
- Average daily weighted training volume
- Distribution of workload by exercise, primary muscle, and body region
- Differences between October and November 2025 training patterns

## Key Insight
Although November was initially assumed to be the more intense month in terms of total volume and training frequency, the analysis showed that October contained more training days and higher total volume. November workouts were fewer in number but higher in average volume per session.

## Tools
- SQLite
- DB Browser for SQLite
- VS Code