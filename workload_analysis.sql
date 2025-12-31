-- =====================================================
-- SECTION 1: OCT–NOV 2025 WORKLOAD OVERVIEW
-- =====================================================

--Total combined weighted training volume in lbs across Oct-Nov 2025
SELECT 
	SUM(w.volume) AS total_volume_lbs
FROM workout_sets w 
WHERE w.date >= '2025-10-01' 
	AND w.date < '2025-12-01'
	AND w.weight_lbs > 0;

--Total weighted training volume in lbs by month for Oct-Nov 2025
SELECT 
	strftime('%Y-%m', w.date) AS month,
	SUM(w.volume) AS total_volume_lbs
FROM workout_sets w
WHERE w.date >= '2025-10-01'
	AND w.date < '2025-12-01'
	AND w.weight_lbs > 0
GROUP BY month
ORDER BY month;

--Total training days per month (Oct vs Nov 2025)
SELECT 
	strftime('%Y-%m', date(w.date)) AS month,
	COUNT(DISTINCT date(w.date)) AS training_days
FROM workout_sets w
WHERE w.date >= '2025-10-01'
	AND w.date < '2025-12-01'
GROUP BY month
ORDER BY month;

--Average daily weighted volume in lbs by month for Oct-Nov 2025
WITH daily AS (
	SELECT 
		date(w.date) AS day,
		SUM(w.volume) AS daily_volume_lbs
	FROM workout_sets w
	WHERE w.weight_lbs > 0
		AND w.date >= '2025-10-01'
		AND w.date < '2025-12-01'
	GROUP BY day
)
SELECT 
	strftime('%Y-%m', day) AS month,
	round(AVG(daily_volume_lbs)) AS average_daily_volume_lbs
FROM daily
GROUP BY month
ORDER BY month;

-- =====================================================
-- SECTION 2: NOVEMBER 2025 DEEP DIVE
-- =====================================================

--Total logged weighted volume by primary muscle for Nov 2025
SELECT 
	e.primary_muscle,
	SUM(w.volume) AS primary_muscle_volume_lbs 
FROM workout_sets w
JOIN exercise_muscle_map e
	ON w.exercise_title = e.exercise_title
WHERE w.date >= '2025-11-01'
	AND w.date < '2025-12-01'
	AND w.weight_lbs > 0
GROUP BY e.primary_muscle
ORDER BY primary_muscle_volume_lbs DESC;

--Nov 2025 hypertrophy-relevant set weighted volume by exercise (working + dropsets only), ranked in descending order
SELECT
	w.exercise_title,
	SUM(w.volume) AS volume_per_exercise_lbs
FROM workout_sets w
WHERE w.set_type IN ('working', 'dropset')
	AND w.weight_lbs > 0
	AND w.date >= '2025-11-01'
	AND w.date < '2025-12-01'
GROUP BY w.exercise_title
ORDER BY volume_per_exercise_lbs DESC;

--Nov 2025 exercise workload by primary muscle (including bodyweight), ranked by total reps
SELECT
	e.primary_muscle,
	w.exercise_title,
	COUNT(*) AS total_sets,
	SUM(w.reps) AS total_reps
FROM workout_sets w
JOIN exercise_muscle_map e 
	ON w.exercise_title = e.exercise_title
WHERE w.date >= '2025-11-01'
	AND w.date < '2025-12-01'
GROUP BY 
	e.primary_muscle,
	w.exercise_title
ORDER BY
	e.primary_muscle,
	total_reps DESC;
	
--Nov 2025 exercise workload per body region (including bodyweight), ranked by total reps
SELECT
	m.body_region,
	COUNT(*) AS total_sets,
	SUM(w.reps) AS total_reps
FROM workout_sets w
JOIN exercise_muscle_map e
	ON w.exercise_title = e.exercise_title
JOIN muscle_region_map m 
	ON e.primary_muscle = m.primary_muscle
WHERE w.date >= '2025-11-01'
	AND w.date < '2025-12-01'
GROUP BY m.body_region
ORDER BY total_reps DESC;