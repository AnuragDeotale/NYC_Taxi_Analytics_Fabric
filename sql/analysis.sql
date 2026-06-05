


/* ============================================
   TRIP DISTANCE DISTRIBUTION
   ============================================ */

SELECT
    CONCAT(
        FLOOR(tripDistance),
        ' - ',
        FLOOR(tripDistance) + 1
    ) AS DistanceRange,

    COUNT(*) AS TotalTrips,

    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER(),
        2
    ) AS PercentOfTotal

FROM dbo.anurag_gold_fact_trips

WHERE tripDistance IS NOT NULL

GROUP BY FLOOR(tripDistance)

ORDER BY FLOOR(tripDistance);


/* ============================================
   TRIPS BY MONTH
   ============================================ */

SELECT
    DATENAME(MONTH, PickUpDate) AS MonthName,
    MONTH(PickUpDate) AS MonthNumber,

    COUNT(*) AS TotalTrips,

    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER(),
        2
    ) AS PercentOfTotal

FROM dbo.anurag_gold_fact_trips

WHERE PickUpDate IS NOT NULL

GROUP BY
    DATENAME(MONTH, PickUpDate),
    MONTH(PickUpDate)

ORDER BY PercentOfTotal DESC;


/* ============================================
   TRIPS BY YEAR
   ============================================ */

SELECT
    YEAR(PickUpDate) AS YearNumber,

    COUNT(*) AS TotalTrips,

    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER(),
        2
    ) AS PercentOfTotal

FROM dbo.anurag_gold_fact_trips

WHERE PickUpDate IS NOT NULL

GROUP BY YEAR(PickUpDate)

ORDER BY YearNumber;
