---Cleaning the Data

CREATE OR REPLACE TABLE bike-sharing-508008.cyclistic_data.clean_trips AS
SELECT
ride_id,
rideable_type,
started_at,
ended_at,
-- Compute ride duraton in minutes
TIMESTAMP_DIFF(ended_at, started_at, MINUTE) AS ride_length_minutes,
-- Calender and time features
EXTRACT(DAYOFWEEK FROM started_at) AS day_of_week,
FORMAT_DATE('%A', DATE(started_at)) AS day_name,
EXTRACT(HOUR FROM started_at) AS start_hour,
FORMAT_DATE('%B', DATE(started_at)) AS month_name,
EXTRACT(MONTH FROM started_at) AS month_num,
-- stations and coordinates
start_station_name,
end_station_name,
start_lat,
start_lng,
end_lat,
end_lng,
member_casual
FROM
bike-sharing-508008.cyclistic_data.combined_trips
WHERE
-- 1.Discard false starts/accidental unlocks(<60 seconds)
TIMESTAMP_DIFF(ended_at,started_at,SECOND)>=60
--2.Discard lost or stolen rides (>24 hours)
AND TIMESTAMP_DIFF(ended_at,started_at,HOUR)<=24
--3.Remove maintanence/ depot/ testing station records
AND (start_station_name NOT LIKE '%TEST%' OR start_station_name IS NULL)
AND(start_station_name NOT LIKE '%DIVVY%' OR start_station_name IS NULL)
--4. Exclude missing coordinate rows neededfor mapping
AND start_lat IS NOT NULL
AND end_lat IS NOT NULL

----Finding total number of clean rows

SELECT COUNT(*) AS total_clean_rows
FROM cyclistic_data.clean_trips;

-- Day of week and duration
SELECT 
    member_casual,
    day_of_week,
    day_name,
    COUNT(ride_id) AS total_rides,
    ROUND(AVG(ride_length_minutes), 2) AS avg_duration_mins
FROM `bike-sharing-508008.cyclists_data.clean_trips`
GROUP BY member_casual, day_of_week, day_name
ORDER BY member_casual, day_of_week;

--- Top 10 Casual Stations
SELECT 
    start_station_name,
    start_lat,
    start_lng,
    COUNT(ride_id) AS casual_rides
FROM `bike-sharing-508008.cyclistic_data.clean_trips`
WHERE member_casual = 'casual' AND start_station_name IS NOT NULL
GROUP BY start_station_name, start_lat, start_lng
ORDER BY casual_rides DESC
LIMIT 10;

--- Hourly Demand Spikes
SELECT 
    member_casual,
    start_hour,
    COUNT(ride_id) AS total_rides
FROM `bike-sharing-508008.cyclistic_data.clean_trips`
GROUP BY member_casual, start_hour
ORDER BY start_hour, member_casual;

----- Bike type preference
SELECT 
    member_casual,
    rideable_type,
    COUNT(ride_id) AS total_rides,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(PARTITION BY member_casual), 2) AS pct_of_rider_type
FROM `bike-sharing-508008.cyclists_data.clean_trips`
GROUP BY member_casual, rideable_type
ORDER BY member_casual, total_rides DESC;

