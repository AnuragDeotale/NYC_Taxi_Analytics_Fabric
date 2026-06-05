
/* ============================================
   NYC Taxi Analytics Project
   Gold Layer Dashboard Queries
   ============================================ */

/* MAIN PAGE KPI QUERIES */

SELECT COUNT(*) AS Total_Trips
FROM anurag_gold_fact_trips;

SELECT SUM(totalAmount) AS Total_Revenue
FROM anurag_gold_fact_trips;

SELECT SUM(fareAmount) AS Total_Fare
FROM anurag_gold_fact_trips;

SELECT SUM(tripDistance) AS Total_Distance
FROM anurag_gold_fact_trips;

SELECT
    CASE
        WHEN SUM(totalAmount) = 0 THEN 0
        ELSE SUM(totalAmount) * 1.0 / SUM(tripDistance)
    END AS Revenue_Per_Mile
FROM anurag_gold_fact_trips;

SELECT AVG(totalAmount) AS Average_Revenue
FROM anurag_gold_fact_trips;

SELECT AVG(fareAmount) AS Average_Fare
FROM anurag_gold_fact_trips;

SELECT AVG(tripDistance) AS Average_Distance
FROM anurag_gold_fact_trips;

/* PAGE 1 - PEAK ANALYSIS */

SELECT TOP 1
    PickUpDate,
    COUNT(*) AS Total_Trips
FROM anurag_gold_fact_trips
GROUP BY PickUpDate
ORDER BY Total_Trips DESC;

SELECT MAX(Total_Trips) AS Peak_Date_Trips
FROM (
    SELECT PickUpDate, COUNT(*) AS Total_Trips
    FROM anurag_gold_fact_trips
    GROUP BY PickUpDate
) AS TripCounts;

WITH DateWiseTrips AS (
    SELECT PickUpDate, COUNT(*) AS Total_Trips
    FROM anurag_gold_fact_trips
    GROUP BY PickUpDate
),
PeakDate AS (
    SELECT TOP 1 PickUpDate, Total_Trips
    FROM DateWiseTrips
    ORDER BY Total_Trips DESC
)
SELECT CAST(
    Total_Trips * 100.0 /
    (SELECT COUNT(*) FROM anurag_gold_fact_trips)
    AS DECIMAL(10,2)
) AS Peak_Date_Trips_Share_Percent
FROM PeakDate;

WITH HourlyTrips AS (
    SELECT DATEPART(HOUR, PickUpTime) AS Peak_Hour,
           COUNT_BIG(*) AS Total_Trips
    FROM anurag_gold_fact_trips
    GROUP BY DATEPART(HOUR, PickUpTime)
)
SELECT Peak_Hour,
       Total_Trips,
       ROUND(
           (Total_Trips * 100.0) /
           (SELECT COUNT_BIG(*) FROM anurag_gold_fact_trips),
           2
       ) AS Peak_Hour_Share_Percent
FROM HourlyTrips
ORDER BY Total_Trips DESC;

SELECT MAX(Total_Trips) AS Peak_Hour_Trips
FROM (
    SELECT DATEPART(HOUR, PickUpTime) AS Pickup_Hour,
           COUNT(*) AS Total_Trips
    FROM anurag_gold_fact_trips
    GROUP BY DATEPART(HOUR, PickUpTime)
) AS HourTrips;

WITH HourWiseTrips AS (
    SELECT DATEPART(HOUR, PickUpTime) AS Pickup_Hour,
           COUNT(*) AS Total_Trips
    FROM anurag_gold_fact_trips
    GROUP BY DATEPART(HOUR, PickUpTime)
),
PeakHour AS (
    SELECT TOP 1 Pickup_Hour, Total_Trips
    FROM HourWiseTrips
    ORDER BY Total_Trips DESC
)
SELECT CAST(
    Total_Trips * 100.0 /
    (SELECT COUNT(*) FROM anurag_gold_fact_trips)
    AS DECIMAL(10,2)
) AS Peak_Hour_Trips_Share_Percent
FROM PeakHour;

/* PAGE 2 - TREND ANALYSIS */

SELECT
    DATENAME(WEEKDAY, PickUpDate) AS Weekday_Name,
    DATEPART(HOUR, PickUpTime) AS Trip_Hour,
    COUNT_BIG(*) AS Total_Trips
FROM anurag_gold_fact_trips
GROUP BY
    DATENAME(WEEKDAY, PickUpDate),
    DATEPART(HOUR, PickUpTime)
ORDER BY Weekday_Name, Trip_Hour;

WITH DayWiseTrips AS (
    SELECT DAY(PickUpDate) AS Day_Number,
           COUNT_BIG(*) AS Total_Trips
    FROM anurag_gold_fact_trips
    GROUP BY DAY(PickUpDate)
)
SELECT Day_Number,
       Total_Trips,
       CAST(
           Total_Trips * 100.0 / SUM(Total_Trips) OVER()
           AS DECIMAL(10,2)
       ) AS Trips_Share_Percent
FROM DayWiseTrips
ORDER BY Day_Number;

WITH HourWiseTrips AS (
    SELECT DATEPART(HOUR, PickUpTime) AS Pickup_Hour,
           COUNT_BIG(*) AS Total_Trips
    FROM anurag_gold_fact_trips
    GROUP BY DATEPART(HOUR, PickUpTime)
)
SELECT Pickup_Hour,
       Total_Trips,
       CAST(
           Total_Trips * 100.0 / SUM(Total_Trips) OVER()
           AS DECIMAL(10,2)
       ) AS Trips_Share_Percent
FROM HourWiseTrips
ORDER BY Pickup_Hour;

WITH WeekdayTrips AS (
    SELECT DATENAME(WEEKDAY, PickUpDate) AS Week_Day,
           COUNT_BIG(*) AS Total_Trips
    FROM anurag_gold_fact_trips
    GROUP BY DATENAME(WEEKDAY, PickUpDate)
)
SELECT Week_Day,
       Total_Trips,
       CAST(
           Total_Trips * 100.0 / SUM(Total_Trips) OVER()
           AS DECIMAL(10,2)
       ) AS Trips_Share_Percent
FROM WeekdayTrips
ORDER BY Total_Trips DESC;
