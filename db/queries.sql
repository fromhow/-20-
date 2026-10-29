-- 1. Ten latest sensor rows (not ten groups of three).
SELECT id,n,t_s,sensor,value FROM readings ORDER BY n DESC,id DESC LIMIT 10;
-- 2. Minimum, average, maximum for each sensor.
SELECT sensor,MIN(value) AS minimum,AVG(value) AS average,MAX(value) AS maximum
FROM readings GROUP BY sensor ORDER BY sensor;
-- 3. All events in measurement order.
SELECT id,n,t_s,type,message FROM events ORDER BY n,id;
