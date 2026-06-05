----------------------  **************** TABLE QUERIES *********************  --------------------------------
-- FOR VERIFYING DATA
SELECT TOP 10 *
FROM anurag_bronze_trips; 

-- NO OF ROWS IN TABLE 
SELECT COUNT(*) FROM anurag_bronze_trips;

-- TOTAL COLUMNS IN TABLE
SELECT COUNT(*) AS TotalColumns
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'anurag_bronze_trips'
AND TABLE_SCHEMA = 'dbo';

-- COLUMN NAME AND DATA TYPE
SELECT 
    COLUMN_NAME AS ColumnName,
    DATA_TYPE AS DataType
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'anurag_bronze_trips'
AND TABLE_SCHEMA = 'dbo';



---------  *************** COLUMN QUERIES ************* ----------------------

--------------------------------------------------------------------
---------------------------- 1."vendorID" Column  -------------------
---------------------------------------------------------------------
-- VERIFYING DATA 
SELECT top 10 vendorID from dbo.anurag_bronze_trips;


-- COLUMN PROFILING QUERY
SELECT 'vendorID' AS ColumnName, 'int' AS DataType,
       COUNT(*) AS TotalRows,
       SUM(CASE WHEN vendorID IS NULL THEN 1 ELSE 0 END) AS NullCount,
       ROUND(100.0 * SUM(CASE WHEN vendorID IS NULL THEN 1 ELSE 0 END) / COUNT(*), 2) AS NullPercent,
       COUNT(DISTINCT vendorID) AS DistinctCount,
       ROUND(100.0 * COUNT(DISTINCT vendorID) / COUNT(*), 2) AS DistinctPercent
FROM dbo.anurag_bronze_trips;

-- NUMBER OF VENDORS 
SELECT DISTINCT(vendorID) from dbo.anurag_bronze_trips ;


-------------------------------------------------------------------------------
---------------------------- 2."lpepPickupDatetime" Column  -------------------
-------------------------------------------------------------------------------
-- VERIFYING DATA
SELECT  top 10 lpepPickupDatetime from dbo.anurag_bronze_trips;

-- COLUMN PROFILING QUERY
SELECT 'lpepPickupDatetime' AS ColumnName, 'datetime2' AS DataType,
       COUNT(*) AS TotalRows,
       SUM(CASE WHEN lpepPickupDatetime IS NULL THEN 1 ELSE 0 END) AS NullCount,
       ROUND(100.0 * SUM(CASE WHEN lpepPickupDatetime IS NULL THEN 1 ELSE 0 END) / COUNT(*), 2) AS NullPercent,
       COUNT(DISTINCT lpepPickupDatetime) AS DistinctCount,
       ROUND(100.0 * COUNT(DISTINCT lpepPickupDatetime) / COUNT(*), 2) AS DistinctPercent
FROM dbo.anurag_bronze_trips;


-- HOUR - WISE TAXI ENGAGEMENT PERCENT 
SELECT 
    DATEPART(HOUR, lpepPickupDatetime) AS PickupHour,
    COUNT(*) AS TotalTrips,
    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER(),
        2
    ) AS EngagementPercent
FROM dbo.anurag_bronze_trips
WHERE lpepPickupDatetime IS NOT NULL
GROUP BY DATEPART(HOUR, lpepPickupDatetime)
ORDER BY EngagementPercent DESC;


-- MIN AND MAX DATE 
SELECT 
    CAST(MIN(lpepPickupDatetime) AS DATE) AS MinPickupDate,
    CAST(MAX(lpepPickupDatetime) AS DATE) AS MaxPickupDate
FROM dbo.anurag_bronze_trips;


-- YEAR WISE COUNT OF DATA WITH PERCENTAGE OF TOTAL
SELECT 
    YEAR(lpepPickupDatetime) AS Year,
    COUNT(*) AS RecordCount,
    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER(),
        2
    ) AS PercentOfTotal
FROM dbo.anurag_bronze_trips
WHERE lpepPickupDatetime IS NOT NULL
GROUP BY YEAR(lpepPickupDatetime)
ORDER BY PercentOfTotal DESC;

-- MONTH-WISE COUNT AND PERCENTAGE OF TOTAL
SELECT 
    MONTH(lpepPickupDatetime) AS MonthNumber,
    DATENAME(MONTH, lpepPickupDatetime) AS MonthName,
    COUNT(*) AS RecordCount,
    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER(),
        2
    ) AS PercentOfTotal
FROM dbo.anurag_bronze_trips
WHERE lpepPickupDatetime IS NOT NULL
GROUP BY 
    MONTH(lpepPickupDatetime),
    DATENAME(MONTH, lpepPickupDatetime)
ORDER BY PercentOfTotal DESC ;


-- DAY-WISE COUNT AND PERCENTAGE OF TOTAL

SELECT 
    DAY(lpepPickupDatetime) AS DayNumber,
    COUNT(*) AS RecordCount,
    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER(),
        2
    ) AS PercentOfTotal
FROM dbo.anurag_bronze_trips
WHERE lpepPickupDatetime IS NOT NULL
GROUP BY DAY(lpepPickupDatetime)
ORDER BY PercentOfTotal DESC;

-- DAY NAME WISE COUNT AND PERCENTAGE OF TOTAL

SELECT 
    DATENAME(WEEKDAY, lpepPickupDatetime) AS DayName,
    COUNT(*) AS RecordCount,
    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER(),
        2
    ) AS PercentOfTotal
FROM dbo.anurag_bronze_trips
WHERE lpepPickupDatetime IS NOT NULL
GROUP BY DATENAME(WEEKDAY, lpepPickupDatetime)
ORDER BY PercentOfTotal DESC;

-------------------------------------------------------------------------------
---------------------------- 3."lpepDropoffDatetime" Column  -------------------
-------------------------------------------------------------------------------

-- VERIFYING DATA
SELECT top 10  lpepDropoffDatetime  from dbo.anurag_bronze_trips;


-- COLUMN PROFILING QUERY
SELECT 'lpepDropoffDatetime' AS ColumnName, 'datetime2' AS DataType,
       COUNT(*) AS TotalRows,
       SUM(CASE WHEN lpepDropoffDatetime IS NULL THEN 1 ELSE 0 END) AS NullCount,
       ROUND(100.0 * SUM(CASE WHEN lpepDropoffDatetime IS NULL THEN 1 ELSE 0 END) / COUNT(*), 2) AS NullPercent,
       COUNT(DISTINCT lpepDropoffDatetime) AS DistinctCount,
       ROUND(100.0 * COUNT(DISTINCT lpepDropoffDatetime) / COUNT(*), 2) AS DistinctPercent
FROM dbo.anurag_bronze_trips;


-- HOUR-WISE TAXI ENGAGEMENT PERCENT
SELECT 
    DATEPART(HOUR,lpepDropoffDatetime) AS DropHour,
    COUNT(*) AS TotalTrips,
    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER(),
        2
    ) AS DisengagedPercent
FROM dbo.anurag_bronze_trips
WHERE lpepDropoffDatetime IS NOT NULL
GROUP BY DATEPART(HOUR, lpepDropoffDatetime)
ORDER BY DisengagedPercent DESC;


-- MIN AND MAX DATE 
SELECT 
    CAST(MIN(lpepDropoffDatetime) AS DATE) AS MinDropDate,
    CAST(MAX(lpepDropoffDatetime) AS DATE) AS MaxDropDate
FROM dbo.anurag_bronze_trips;


-- YEAR WISE COUNT OF DATA WITH PERCENTAGE OF TOTAL
SELECT 
    YEAR(lpepDropoffDatetime) AS Year,
    COUNT(*) AS RecordCount,
    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER(),
        2
    ) AS PercentOfTotal
FROM dbo.anurag_bronze_trips
WHERE lpepDropoffDatetime IS NOT NULL
GROUP BY YEAR(lpepDropoffDatetime)
ORDER BY PercentOfTotal DESC;

-- MONTH-WISE COUNT AND PERCENTAGE OF TOTAL
SELECT 
    MONTH(lpepDropoffDatetime) AS MonthNumber,
    DATENAME(MONTH, lpepDropoffDatetime) AS MonthName,
    COUNT(*) AS RecordCount,
    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER(),
        2
    ) AS PercentOfTotal
FROM dbo.anurag_bronze_trips
WHERE lpepDropoffDatetime IS NOT NULL
GROUP BY 
    MONTH(lpepDropoffDatetime),
    DATENAME(MONTH, lpepDropoffDatetime)
ORDER BY PercentOfTotal DESC ;


-- DAY-WISE COUNT AND PERCENTAGE OF TOTAL

SELECT 
    DAY(lpepDropoffDatetime) AS DayNumber,
    COUNT(*) AS RecordCount,
    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER(),
        2
    ) AS PercentOfTotal
FROM dbo.anurag_bronze_trips
WHERE lpepDropoffDatetime IS NOT NULL
GROUP BY DAY(lpepDropoffDatetime)
ORDER BY PercentOfTotal DESC;

-- DAY NAME WISE COUNT AND PERCENTAGE OF TOTAL

SELECT 
    DATENAME(WEEKDAY, lpepDropoffDatetime) AS DayName,
    COUNT(*) AS RecordCount,
    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER(),
        2
    ) AS PercentOfTotal
FROM dbo.anurag_bronze_trips
WHERE lpepDropoffDatetime IS NOT NULL
GROUP BY DATENAME(WEEKDAY, lpepDropoffDatetime)
ORDER BY PercentOfTotal DESC;




-------------------------------------------------------------------------------
---------------------------- 4."passengerCount" Column  -----------------------
-------------------------------------------------------------------------------


-- VERIFYING DATA 
SELECT TOP 10 passengerCount from dbo.anurag_bronze_trips;

-- COLUMN PROFILING QUERY
SELECT 'passengerCount' AS ColumnName, 'int' AS DataType,
       COUNT(*) AS TotalRows,
       SUM(CASE WHEN passengerCount IS NULL THEN 1 ELSE 0 END) AS NullCount,
       ROUND(100.0 * SUM(CASE WHEN passengerCount IS NULL THEN 1 ELSE 0 END) / COUNT(*), 2) AS NullPercent,
       COUNT(DISTINCT passengerCount) AS DistinctCount,
       ROUND(100.0 * COUNT(DISTINCT passengerCount) / COUNT(*), 2) AS DistinctPercent
FROM dbo.anurag_bronze_trips;



-- DISTINCT NUMBER OF PASSENGERS
SELECT DISTINCT passengerCount FROM dbo.anurag_bronze_trips ORDER BY passengerCount;


-- PASSENGER COUNT WITH PERCENTAGE
SELECT 
    passengerCount,
    COUNT(*) AS TotalTrips,
    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER(),
        2
    ) AS PercentOfTotal
FROM dbo.anurag_bronze_trips
GROUP BY passengerCount
ORDER BY PercentOfTotal DESC;




-------------------------------------------------------------------------------
---------------------------- 5."tripDistance" Column  ------------------------
-------------------------------------------------------------------------------

-- VERIFYING DATA
SELECT TOP 10 tripDistance from dbo.anurag_bronze_trips;


-- COLUMN PROFILING QUERY
SELECT 'tripDistance' AS ColumnName, 'float' AS DataType,
       COUNT(*) AS TotalRows,
       SUM(CASE WHEN tripDistance IS NULL THEN 1 ELSE 0 END) AS NullCount,
       ROUND(100.0 * SUM(CASE WHEN tripDistance IS NULL THEN 1 ELSE 0 END) / COUNT(*), 2) AS NullPercent,
       COUNT(DISTINCT tripDistance) AS DistinctCount,
       ROUND(100.0 * COUNT(DISTINCT tripDistance) / COUNT(*), 2) AS DistinctPercent
FROM dbo.anurag_bronze_trips;

-- MIN AND MAX DISTANCE 
SELECT MIN(tripDistance)  as Minimum_Trip_Distance ,
        MAX(tripDistance) as Maximum_Trip_Distance 
From dbo.anurag_bronze_trips;


-- TRIP DISTANCE INTERVALS OF 1
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
FROM dbo.anurag_bronze_trips
WHERE tripDistance IS NOT NULL
GROUP BY FLOOR(tripDistance)
ORDER BY PercentOfTotal DESC;


-------------------------------------------------------------------------------
---------------------------- 6."puLocationId" Column  -------------------------
-------------------------------------------------------------------------------

-- VERIFYING DATA
SELECT TOP 10 puLocationId from dbo.anurag_bronze_trips;


-- COLUMN PROFILING QUERY
SELECT 
       'puLocationId' AS ColumnName,
       'varchar' AS DataType,
       COUNT(*) AS TotalRows,
       SUM(
           CASE 
               WHEN puLocationId IS NULL THEN 1 
               ELSE 0 
           END
       ) AS NullCount,
       ROUND(
           100.0 * SUM(
               CASE 
                   WHEN puLocationId IS NULL THEN 1 
                   ELSE 0 
               END
           ) / COUNT(*),
           2
       ) AS NullPercent,

       COUNT(DISTINCT puLocationId) AS DistinctCount,
       ROUND(
           100.0 * COUNT(DISTINCT puLocationId) / COUNT(*),
           2
       ) AS DistinctPercent
FROM dbo.anurag_bronze_trips;

-- UNIQUE puLocationId 
SELECT DISTINCT(puLocationId) from dbo.anurag_bronze_trips;





-------------------------------------------------------------------------------
---------------------------- 7."doLocationId" Column  -------------------------
-------------------------------------------------------------------------------


-- VERIFYING DATA 
SELECT TOP 10 doLocationId from dbo.anurag_bronze_trips;

-- COLUMN PROFILING 
SELECT 'doLocationId' AS ColumnName, 'varchar' AS DataType,
       COUNT(*) AS TotalRows,
       SUM(CASE WHEN doLocationId IS NULL THEN 1 ELSE 0 END) AS NullCount,
       ROUND(100.0 * SUM(CASE WHEN doLocationId IS NULL THEN 1 ELSE 0 END) / COUNT(*), 2) AS NullPercent,
       COUNT(DISTINCT doLocationId) AS DistinctCount,
       ROUND(100.0 * COUNT(DISTINCT doLocationId) / COUNT(*), 2) AS DistinctPercent
FROM dbo.anurag_bronze_trips;


-- UNIQUE puLocationId 
SELECT DISTINCT(doLocationId) from dbo.anurag_bronze_trips;



-------------------------------------------------------------------------------
---------------------------- 8."pickupLongitude" Column  ----------------------
-------------------------------------------------------------------------------

-- VERIFYING DATA 
SELECT TOP 10  pickupLongitude FROM   dbo.anurag_bronze_trips where pickupLongitude is NOT NULL ;

-- COLUMN PROFILING 
SELECT 'pickupLongitude' AS ColumnName, 'float' AS DataType,
       COUNT(*) AS TotalRows,
       SUM(CASE WHEN pickupLongitude IS NULL THEN 1 ELSE 0 END) AS NullCount,
       ROUND(100.0 * SUM(CASE WHEN pickupLongitude IS NULL THEN 1 ELSE 0 END) / COUNT(*), 2) AS NullPercent,
       COUNT(DISTINCT pickupLongitude) AS DistinctCount,
       ROUND(100.0 * COUNT(DISTINCT pickupLongitude) / COUNT(*), 2) AS DistinctPercent
FROM dbo.anurag_bronze_trips;



-------------------------------------------------------------------------------
---------------------------- 9."pickupLatitude" Column  -----------------------
-------------------------------------------------------------------------------

-- VERIFYING DATA 
SELECT TOP 10  pickupLatitude FROM   dbo.anurag_bronze_trips where pickupLatitude is NOT NULL ;


-- COLUMN PROFILING 
SELECT 'pickupLatitude' AS ColumnName, 'float' AS DataType,
       COUNT(*) AS TotalRows,
       SUM(CASE WHEN pickupLatitude IS NULL THEN 1 ELSE 0 END) AS NullCount,
       ROUND(100.0 * SUM(CASE WHEN pickupLatitude IS NULL THEN 1 ELSE 0 END) / COUNT(*), 2) AS NullPercent,
       COUNT(DISTINCT pickupLatitude) AS DistinctCount,
       ROUND(100.0 * COUNT(DISTINCT pickupLatitude) / COUNT(*), 2) AS DistinctPercent
FROM dbo.anurag_bronze_trips;



-------------------------------------------------------------------------------
---------------------------- 10 ."dropoffLongitude" Column  -------------------
-------------------------------------------------------------------------------



--- VERIFY DATA 
SELECT TOP 10 dropoffLongitude FROM dbo.anurag_bronze_trips where dropoffLongitude is NOT NULL ;

-- COLUMN PROFILING 
SELECT 'dropoffLongitude' AS ColumnName, 'float' AS DataType,
       COUNT(*) AS TotalRows,
       SUM(CASE WHEN dropoffLongitude IS NULL THEN 1 ELSE 0 END) AS NullCount,
       ROUND(100.0 * SUM(CASE WHEN dropoffLongitude IS NULL THEN 1 ELSE 0 END) / COUNT(*), 2) AS NullPercent,
       COUNT(DISTINCT dropoffLongitude) AS DistinctCount,
       ROUND(100.0 * COUNT(DISTINCT dropoffLongitude) / COUNT(*), 2) AS DistinctPercent
FROM dbo.anurag_bronze_trips;


-------------------------------------------------------------------------------
---------------------------- 11 ."dropoffLatitude" Column  -------------------
-------------------------------------------------------------------------------


--- VERIFY DATA 
SELECT TOP 10 dropoffLatitude FROM dbo.anurag_bronze_trips where dropoffLatitude is NOT NULL ;

-- COLUMN PROFILING 
SELECT 'dropoffLatitude' AS ColumnName, 'float' AS DataType,
       COUNT(*) AS TotalRows,
       SUM(CASE WHEN dropoffLatitude IS NULL THEN 1 ELSE 0 END) AS NullCount,
       ROUND(100.0 * SUM(CASE WHEN dropoffLatitude IS NULL THEN 1 ELSE 0 END) / COUNT(*), 2) AS NullPercent,
       COUNT(DISTINCT dropoffLatitude) AS DistinctCount,
       ROUND(100.0 * COUNT(DISTINCT dropoffLatitude) / COUNT(*), 2) AS DistinctPercent
FROM dbo.anurag_bronze_trips;


-------------------------------------------------------------------------------
---------------------------- 12 ."rateCodeID" Column  -------------------------
-------------------------------------------------------------------------------


--- VERIFY DATA 
SELECT TOP 10 rateCodeID FROM dbo.anurag_bronze_trips where rateCodeID is NOT NULL ;

-- COLUMN PROFILING 
SELECT 'rateCodeID' AS ColumnName, 'int' AS DataType,
       COUNT(*) AS TotalRows,
       SUM(CASE WHEN rateCodeID IS NULL THEN 1 ELSE 0 END) AS NullCount,
       ROUND(100.0 * SUM(CASE WHEN rateCodeID IS NULL THEN 1 ELSE 0 END) / COUNT(*), 2) AS NullPercent,
       COUNT(DISTINCT rateCodeID) AS DistinctCount,
       ROUND(100.0 * COUNT(DISTINCT rateCodeID) / COUNT(*), 2) AS DistinctPercent
FROM dbo.anurag_bronze_trips;

-- DISTINCT RATE CODE IDs
SELECT DISTINCT(rateCodeID) from dbo.anurag_bronze_trips;


-- RATE CODE ANALYSIS
SELECT 
    rateCodeID,
    COUNT(*) AS TotalTrips,
    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER(),
        2
    ) AS PercentOfTotal
FROM dbo.anurag_bronze_trips
GROUP BY rateCodeID
ORDER BY PercentOfTotal DESC;



-------------------------------------------------------------------------------
---------------------------- 13 ."storeAndFwdFlag" Column  --------------------
-------------------------------------------------------------------------------


--- VERIFY DATA 
SELECT TOP 10 storeAndFwdFlag FROM dbo.anurag_bronze_trips where storeAndFwdFlag is NOT NULL ;

-- COLUMN PROFILING 
SELECT 'storeAndFwdFlag' AS ColumnName, 'varchar' AS DataType,
       COUNT(*) AS TotalRows,
       SUM(CASE WHEN storeAndFwdFlag IS NULL THEN 1 ELSE 0 END) AS NullCount,
       ROUND(100.0 * SUM(CASE WHEN storeAndFwdFlag IS NULL THEN 1 ELSE 0 END) / COUNT(*), 2) AS NullPercent,
       COUNT(DISTINCT storeAndFwdFlag) AS DistinctCount,
       ROUND(100.0 * COUNT(DISTINCT storeAndFwdFlag) / COUNT(*), 2) AS DistinctPercent
FROM dbo.anurag_bronze_trips;


-- DISTINCT FLAGS
SELECT DISTINCT(storeAndFwdFlag) from dbo.anurag_bronze_trips;


-- PERCENT ANALYSIS
SELECT 
    storeAndFwdFlag,
    COUNT(*) AS TotalTrips,
    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER(),
        2
    ) AS PercentOfTotal
FROM dbo.anurag_bronze_trips
GROUP BY storeAndFwdFlag
ORDER BY PercentOfTotal DESC;


-------------------------------------------------------------------------------
---------------------------- 14 ."paymentType" Column  ------------------------
-------------------------------------------------------------------------------


--- VERIFY DATA 
SELECT TOP 10 paymentType FROM dbo.anurag_bronze_trips where paymentType is NOT NULL ;

-- COLUMN PROFILING 
SELECT 'paymentType' AS ColumnName, 'int' AS DataType,
       COUNT(*) AS TotalRows,
       SUM(CASE WHEN paymentType IS NULL THEN 1 ELSE 0 END) AS NullCount,
       ROUND(100.0 * SUM(CASE WHEN paymentType IS NULL THEN 1 ELSE 0 END) / COUNT(*), 2) AS NullPercent,
       COUNT(DISTINCT paymentType) AS DistinctCount,
       ROUND(100.0 * COUNT(DISTINCT paymentType) / COUNT(*), 2) AS DistinctPercent
FROM dbo.anurag_bronze_trips;

-- DISTINCT Payments
SELECT DISTINCT(paymentType) from dbo.anurag_bronze_trips;

-- PERCENT ANALYSIS
SELECT 
    paymentType,
    COUNT(*) AS TotalTrips,
    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER(),
        2
    ) AS PercentOfTotal
FROM dbo.anurag_bronze_trips
GROUP BY paymentType
ORDER BY PercentOfTotal DESC;


-------------------------------------------------------------------------------
---------------------------- 15."fareAmount" Column  --------------------------
-------------------------------------------------------------------------------


--- VERIFY DATA 
SELECT TOP 10 fareAmount FROM dbo.anurag_bronze_trips where fareAmount is NOT NULL ;

-- COLUMN PROFILING 
SELECT 'fareAmount' AS ColumnName, 'float' AS DataType,
       COUNT(*) AS TotalRows,
       SUM(CASE WHEN fareAmount IS NULL THEN 1 ELSE 0 END) AS NullCount,
       ROUND(100.0 * SUM(CASE WHEN fareAmount IS NULL THEN 1 ELSE 0 END) / COUNT(*), 2) AS NullPercent,
       COUNT(DISTINCT fareAmount) AS DistinctCount,
       ROUND(100.0 * COUNT(DISTINCT fareAmount) / COUNT(*), 2) AS DistinctPercent
FROM dbo.anurag_bronze_trips;


--- MIN AND MAX AMOUNT
SELECT MIN(fareAmount) as "Min Amount Paid" ,
        MAX(fareAmount) as "Max Amount Paid" 
        FROM dbo.anurag_bronze_trips;

-- MIN AMOUNT GREATER THAN 0
SELECT MIN(fareAmount) as "Min Amount Paid" 
 FROM dbo.anurag_bronze_trips where fareAmount > 0;

-- FAREAMOUNT LESS THAN  OR EQUAL TO 0 PERCENTAGE
SELECT 
    ROUND(
        (COUNT(*) * 100.0 / 
        (SELECT COUNT(*) FROM dbo.anurag_bronze_trips)),
        2
    ) AS PercentFareLessThanEqualZero
FROM dbo.anurag_bronze_trips
WHERE fareAmount <= 0;


-- PERCENT ANALYSIS
SELECT 
    CONCAT(
        FLOOR(fareAmount),
        ' - ',
        FLOOR(fareAmount) + 1
    ) AS FareRange,
    COUNT(*) AS TotalTrips,
    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER(),
        2
    ) AS PercentOfTotal
FROM dbo.anurag_bronze_trips
WHERE fareAmount IS NOT NULL
GROUP BY FLOOR(fareAmount)
ORDER BY PercentOfTotal DESC;

-- POSITIVE AND NEGATIVE FARE PERCENTAGE

SELECT 
    ROUND(
        100.0 * SUM(
            CASE 
                WHEN fareAmount > 0 THEN 1 
                ELSE 0 
            END
        ) / COUNT(*),
        2
    ) AS PositiveFarePercent,
    ROUND(
        100.0 * SUM(
            CASE 
                WHEN fareAmount < 0 THEN 1 
                ELSE 0 
            END
        ) / COUNT(*),
        2
    ) AS NegativeFarePercent
FROM dbo.anurag_bronze_trips;

-------------------------------------------------------------------------------
---------------------------- 16."extra" Column  -------------------------------
-------------------------------------------------------------------------------


--- VERIFY DATA 
SELECT TOP 10 extra FROM dbo.anurag_bronze_trips where extra is NOT NULL ;

-- COLUMN PROFILING 
SELECT 'extra' AS ColumnName, 'float' AS DataType,
       COUNT(*) AS TotalRows,
       SUM(CASE WHEN extra IS NULL THEN 1 ELSE 0 END) AS NullCount,
       ROUND(100.0 * SUM(CASE WHEN extra IS NULL THEN 1 ELSE 0 END) / COUNT(*), 2) AS NullPercent,
       COUNT(DISTINCT extra) AS DistinctCount,
       ROUND(100.0 * COUNT(DISTINCT extra) / COUNT(*), 2) AS DistinctPercent
FROM dbo.anurag_bronze_trips;

--- DISTINCT EXTRA 
SELECT DISTINCT(extra) from dbo.anurag_bronze_trips;


-- EXTRA CHARGE PERCENTAGE ANALYSIS
SELECT 
    extra,
    COUNT(*) AS TotalTrips,
    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER(),
        2
    ) AS PercentOfTotal
FROM dbo.anurag_bronze_trips
GROUP BY extra
ORDER BY PercentOfTotal DESC;

-- MIN AND MAX 
SELECT MIN(extra) , MAX(extra)   from dbo.anurag_bronze_trips;

-- COUNT FOR LESS THAN ZERO 
SELECT 
    ROUND(
        100.0 * COUNT(*) / 
        (SELECT COUNT(*) FROM dbo.anurag_bronze_trips),
        4
    ) AS PercentExtraLessThanZero
FROM dbo.anurag_bronze_trips
WHERE extra < 0



-------------------------------------------------------------------------------
---------------------------- 17."mtaTax" Column  -------------------------------
-------------------------------------------------------------------------------

-- VERIFYING DATA 
SELECT TOP 10 mtaTax  FROM dbo.anurag_bronze_trips;


-- COLUMN PROFILING QUERY
SELECT 
       'mtaTax' AS ColumnName,
       'float' AS DataType,
       COUNT(*) AS TotalRows,
       SUM(
           CASE 
               WHEN mtaTax IS NULL THEN 1 
               ELSE 0 
           END
       ) AS NullCount,
       ROUND(
           100.0 * SUM(
               CASE 
                   WHEN mtaTax IS NULL THEN 1 
                   ELSE 0 
               END
           ) / COUNT(*),
           2
       ) AS NullPercent,
       COUNT(DISTINCT mtaTax) AS DistinctCount,
       ROUND(
           100.0 * COUNT(DISTINCT mtaTax) / COUNT(*),
           2
       ) AS DistinctPercent
FROM dbo.anurag_bronze_trips;

-- DISTINCT mtaTax
SELECT DISTINCT(mtaTax) FROM dbo.anurag_bronze_trips;

-- MAX AND MIN TAX
SELECT MIN(mtaTax) as Min, MAX(mtaTax) as Max fROM  dbo.anurag_bronze_trips;


-- MTATAX VALUE PERCENTAGE ANALYSIS
SELECT 
    mtaTax,
    COUNT(*) AS TotalTrips,
    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER(),
        2
    ) AS PercentOfTotal
FROM dbo.anurag_bronze_trips
GROUP BY mtaTax
ORDER BY PercentOfTotal DESC;


-- PERCENTAGE OF mtaTax VALUES OTHER THAN 0.5

SELECT 
    ROUND(
        100.0 * COUNT(*) /
        (SELECT COUNT(*) FROM dbo.anurag_bronze_trips),
        2
    ) AS PercentOtherThanPointFive

FROM dbo.anurag_bronze_trips

WHERE mtaTax <> 0.5;


-------------------------------------------------------------------------------
---------------------------- 18."improvementSurcharge" Column  ----------------
-------------------------------------------------------------------------------

-- VERIFY THE DATA
SELECT TOP 10 improvementSurcharge from dbo.anurag_bronze_trips where improvementSurcharge is NOT NULL;

-- COLUMN PROFILING QUERY
SELECT 
       'improvementSurcharge' AS ColumnName,
       'varchar' AS DataType,

       COUNT(*) AS TotalRows,

       SUM(
           CASE 
               WHEN improvementSurcharge IS NULL THEN 1 
               ELSE 0 
           END
       ) AS NullCount,

       ROUND(
           100.0 * SUM(
               CASE 
                   WHEN improvementSurcharge IS NULL THEN 1 
                   ELSE 0 
               END
           ) / COUNT(*),
           2
       ) AS NullPercent,

       COUNT(DISTINCT improvementSurcharge) AS DistinctCount,

       ROUND(
           100.0 * COUNT(DISTINCT improvementSurcharge) / COUNT(*),
           2
       ) AS DistinctPercent

FROM dbo.anurag_bronze_trips;

-- DISTINCT CHARGES
SELECT DISTINCT(improvementSurcharge) from dbo.anurag_bronze_trips;

-- VALUE-WISE COUNT AND PERCENTAGE
SELECT 
    improvementSurcharge,
    COUNT(*) AS TotalTrips,
    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER(),
        2
    ) AS PercentOfTotal
FROM dbo.anurag_bronze_trips
GROUP BY improvementSurcharge
ORDER BY PercentOfTotal DESC;

-- MIN AND MAX VALUE OF improvementSurcharge
SELECT 
    MIN(TRY_CAST(improvementSurcharge AS FLOAT)) AS MinValue,
    MAX(TRY_CAST(improvementSurcharge AS FLOAT)) AS MaxValue
FROM dbo.anurag_bronze_trips;




-------------------------------------------------------------------------------
---------------------------- 19."tipAmount" Column  ---------------------------
-------------------------------------------------------------------------------

-- VERIFYING DATA
SELECT TOP 10 tipAmount from dbo.anurag_bronze_trips where tipAmount is Not NULL;



-- COLUMN PROFILING QUERY 
SELECT 
       'tipAmount' AS ColumnName,
       'float' AS DataType,
       COUNT(*) AS TotalRows,
       SUM(
           CASE 
               WHEN tipAmount IS NULL THEN 1 
               ELSE 0 
           END
       ) AS NullCount,
       ROUND(
           100.0 * SUM(
               CASE 
                   WHEN tipAmount IS NULL THEN 1 
                   ELSE 0 
               END
           ) / COUNT(*),
           2
       ) AS NullPercent,
       COUNT(DISTINCT tipAmount) AS DistinctCount,
       ROUND(
           100.0 * COUNT(DISTINCT tipAmount) / COUNT(*),
           2
       ) AS DistinctPercent
FROM dbo.anurag_bronze_trips;

-- MAX AND MIN TIP AMOUNT
SELECT MIN(tipAmount)  as min , MAX(tipAmount) as max from  dbo.anurag_bronze_trips;

-- TIP AMOUNT DISTRIBUTION
SELECT 
    tipAmount,

    COUNT(*) AS TotalTrips,

    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER(),
        2
    ) AS PercentOfTotal
FROM dbo.anurag_bronze_trips
GROUP BY tipAmount
ORDER BY PercentOfTotal DESC;


-------------------------------------------------------------------------------
---------------------------- 20."tollsAmount" Column  -------------------------
-------------------------------------------------------------------------------

--- VERIFY THE DATA
SELECT TOP 10 tollsAmount from dbo.anurag_bronze_trips;


-- COLUMN PROFILING QUERY 
SELECT 
       'tollsAmount' AS ColumnName,
       'float' AS DataType,
       COUNT(*) AS TotalRows,
       SUM(
           CASE 
               WHEN tollsAmount IS NULL THEN 1 
               ELSE 0 
           END
       ) AS NullCount,
       ROUND(
           100.0 * SUM(
               CASE 
                   WHEN tollsAmount IS NULL THEN 1 
                   ELSE 0 
               END
           ) / COUNT(*),
           2
       ) AS NullPercent,
       COUNT(DISTINCT tollsAmount) AS DistinctCount,
       ROUND(
           100.0 * COUNT(DISTINCT tollsAmount) / COUNT(*),
           2
       ) AS DistinctPercent
FROM dbo.anurag_bronze_trips;


-- MIN AND MAX TOLL AMOUNT
SELECT 
    MIN(tollsAmount) AS MinAmount,
    MAX(tollsAmount) AS MaxAmount
FROM dbo.anurag_bronze_trips;


-- TOLLS AMOUNT RANGE ANALYSIS
SELECT 
    CONCAT(
        FLOOR(tollsAmount / 10) * 10,
        ' - ',
        FLOOR(tollsAmount / 10) * 10 + 9
    ) AS TollRange,
    COUNT(*) AS TotalTrips,
    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER(),
        2
    ) AS PercentOfTotal
FROM dbo.anurag_bronze_trips
WHERE tollsAmount IS NOT NULL
GROUP BY FLOOR(tollsAmount / 10)
ORDER BY FLOOR(tollsAmount / 10);


-- TOLLS AMOUNT VALUE-WISE ANALYSIS (0 TO 9)
SELECT 
    FLOOR(tollsAmount) AS TollValue,
    COUNT(*) AS TotalTrips,
    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER(),
        2
    ) AS PercentOfTotal
FROM dbo.anurag_bronze_trips
WHERE tollsAmount >= 0
AND tollsAmount < 10
GROUP BY FLOOR(tollsAmount)
ORDER BY FLOOR(tollsAmount);




-------------------------------------------------------------------------------
---------------------------- 21."ehailFee" Column  ----------------------------
-------------------------------------------------------------------------------

-- COUNT NO OF NON NULLS
SELECT COUNT(*) ehailFee from dbo.anurag_bronze_trips where ehailFee is null;





-------------------------------------------------------------------------------
---------------------------- 22."totalAmount" Column  -------------------------
-------------------------------------------------------------------------------

-- VERIFYING DATA
SELECT TOP 10 totalAmount FROM dbo.anurag_bronze_trips;

-- COLUMN PROFILING QUERY 
SELECT 
       'totalAmount' AS ColumnName,
       'float' AS DataType,
       COUNT(*) AS TotalRows,
       SUM(
           CASE 
               WHEN totalAmount IS NULL THEN 1 
               ELSE 0 
           END
       ) AS NullCount,
       ROUND(
           100.0 * SUM(
               CASE 
                   WHEN totalAmount IS NULL THEN 1 
                   ELSE 0 
               END
           ) / COUNT(*),
           2
       ) AS NullPercent,
       COUNT(DISTINCT totalAmount) AS DistinctCount,
       ROUND(
           100.0 * COUNT(DISTINCT totalAmount) / COUNT(*),
           2
       ) AS DistinctPercent
FROM dbo.anurag_bronze_trips;

-- MIN AND MAX AMOUNT 
SELECT MIN(totalAmount) as "minimum amount" , MAX(totalAmount) as "maximum amount" 
FROM dbo.anurag_bronze_trips;

-- NEGATIVE TOTAL AMOUNT PERCENTAGE
SELECT 
    ROUND(
        100.0 * COUNT(*) /
        (SELECT COUNT(*) FROM dbo.anurag_bronze_trips),
        4
    ) AS NegativeAmountPercent
FROM dbo.anurag_bronze_trips
WHERE totalAmount < 0;

-- ZERO TOTAL AMOUNT PERCENTAGE
SELECT 
    ROUND(
        100.0 * COUNT(*) /
        (SELECT COUNT(*) FROM dbo.anurag_bronze_trips),
        4
    ) AS ZeroAmountPercent
FROM dbo.anurag_bronze_trips
WHERE totalAmount = 0;

-- POSITIVE TOTAL AMOUNT PERCENTAGE
SELECT 
    ROUND(
        100.0 * COUNT(*) /
        (SELECT COUNT(*) FROM dbo.anurag_bronze_trips),
        4
    ) AS PositiveAmountPercent
FROM dbo.anurag_bronze_trips
WHERE totalAmount > 0;

-- TOTAL AMOUNT RANGE ANALYSIS (0-9,10-19...)
SELECT 
    CONCAT(
        FLOOR(totalAmount / 10) * 10,
        ' - ',
        FLOOR(totalAmount / 10) * 10 + 9
    ) AS AmountRange,

    COUNT(*) AS TotalTrips,

    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER(),
        2
    ) AS PercentOfTotal
FROM dbo.anurag_bronze_trips
WHERE totalAmount IS NOT NULL
GROUP BY FLOOR(totalAmount / 10)
ORDER BY PercentOfTotal DESC;



-------------------------------------------------------------------------------
---------------------------- 23."tripType" Column  ----------------------------
-------------------------------------------------------------------------------


-- VERIFYING DATA
SELECT TOP 10 tripType FROM dbo.anurag_bronze_trips;


-- PROFILING QUERY
SELECT 
       'tripType' AS ColumnName,
       'int' AS DataType,
       COUNT(*) AS TotalRows,
       SUM(
           CASE 
               WHEN tripType IS NULL THEN 1 
               ELSE 0 
           END
       ) AS NullCount,
       ROUND(
           100.0 * SUM(
               CASE 
                   WHEN tripType IS NULL THEN 1 
                   ELSE 0 
               END
           ) / COUNT(*),
           2
       ) AS NullPercent,
       COUNT(DISTINCT tripType) AS DistinctCount,
       ROUND(
           100.0 * COUNT(DISTINCT tripType) / COUNT(*),
           2
       ) AS DistinctPercent
FROM dbo.anurag_bronze_trips;


-- TRIP TYPE DISTRIBUTION

SELECT 
    tripType,
    COUNT(*) AS TotalTrips,
    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER(),
        2
    ) AS PercentOfTotal
FROM dbo.anurag_bronze_trips
GROUP BY tripType
ORDER BY PercentOfTotal DESC;





-------------------------------------------------------------------------------
---------------------------- WHOLE TABLE VALID ROW PERCENTAGE -----------------
-------------------------------------------------------------------------------

SELECT 
    ROUND(
        100.0 * COUNT(*) / 
        (SELECT COUNT(*) FROM dbo.anurag_bronze_trips),
        2
    ) AS ValidRowsPercent

FROM dbo.anurag_bronze_trips

WHERE 
    vendorID IS NOT NULL
AND lpepPickupDatetime IS NOT NULL
AND lpepDropoffDatetime IS NOT NULL
AND passengerCount IS NOT NULL AND passengerCount >= 0
AND tripDistance IS NOT NULL AND tripDistance >= 0
AND fareAmount IS NOT NULL AND fareAmount >= 0
AND extra IS NOT NULL AND extra >= 0
AND mtaTax IS NOT NULL AND mtaTax >= 0
AND tipAmount IS NOT NULL AND tipAmount >= 0
AND tollsAmount IS NOT NULL AND tollsAmount >= 0
AND totalAmount IS NOT NULL AND totalAmount >= 0
AND rateCodeID IS NOT NULL
AND paymentType IS NOT NULL
AND storeAndFwdFlag IS NOT NULL;



