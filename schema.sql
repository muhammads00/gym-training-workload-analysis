BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "exercise_muscle_map" (
	"exercise_title"	TEXT,
	"primary_muscle"	TEXT
);
CREATE TABLE IF NOT EXISTS "muscle_region_map" (
	"primary_muscle"	TEXT,
	"body_region"	TEXT
);
CREATE TABLE IF NOT EXISTS "workout_sets" (
	"date"	TEXT,
	"exercise_title"	TEXT,
	"set_type"	TEXT,
	"weight_lbs"	INTEGER,
	"reps"	INTEGER,
	"volume"	INTEGER
);
COMMIT;
