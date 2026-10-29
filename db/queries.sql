-- 1. Последние 10 записей показаний (десять отдельных строк, а не десять циклов)
SELECT id,n,t_s,sensor,value FROM readings ORDER BY n DESC,id DESC LIMIT 10;
-- 2. Минимум, среднее и максимум каждого датчика
SELECT sensor,MIN(value) AS minimum,ROUND(AVG(value),2) AS average,MAX(value) AS maximum
FROM readings GROUP BY sensor ORDER BY sensor;
-- 3. Все события по порядку
SELECT id,n,t_s,type,message FROM events ORDER BY n,id;
