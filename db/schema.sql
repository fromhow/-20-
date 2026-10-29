-- Variant 20. Prepared schema; replace only after reconciling with teacher's schema.
PRAGMA foreign_keys = ON;
CREATE TABLE IF NOT EXISTS readings (
 id INTEGER PRIMARY KEY AUTOINCREMENT,
 n INTEGER NOT NULL CHECK(n>0),
 t_s INTEGER NOT NULL CHECK(t_s>=0),
 sensor TEXT NOT NULL CHECK(sensor IN ('s1','s2','s3')),
 value REAL NOT NULL,
 UNIQUE(n,sensor)
);
CREATE TABLE IF NOT EXISTS events (
 id INTEGER PRIMARY KEY AUTOINCREMENT,
 n INTEGER NOT NULL CHECK(n>0),
 t_s INTEGER NOT NULL CHECK(t_s>=0),
 type TEXT NOT NULL CHECK(type IN ('THRESHOLD','NORMAL','FAULT')),
 message TEXT NOT NULL DEFAULT ''
);
CREATE INDEX IF NOT EXISTS idx_readings_sensor_time ON readings(sensor,t_s);
CREATE INDEX IF NOT EXISTS idx_events_time ON events(t_s,id);
