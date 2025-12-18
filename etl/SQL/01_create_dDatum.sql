/*
Osnovna dimenzijska tablica su datumi, napraviti tablicu od najranijeg do najkasnijeg datuma
*/
SET DATEFIRST 1; -- ponedjeljak prvi dan u tjednu

CREATE TABLE dDatum (
    sifDatum INT IDENTITY (1, 1) NOT NULL ,
    datum DATE,
    dan SMALLINT,
    mjesec SMALLINT,
    godina SMALLINT,
    danUTjednu SMALLINT,
    vikend SMALLINT,
    -- 0 proljeće, 3 zima
    dobaGodine SMALLINT
);

DECLARE @StartDate date = (SELECT CAST((MIN(OrderDate)) AS DATE)
                            FROM northwind.dbo.Orders);
DECLARE @EndDate date = GETDATE();
WITH seq(n) AS 
    (
    SELECT 0 UNION ALL SELECT n + 1 FROM seq
    WHERE n < DATEDIFF(DAY, @StartDate, @EndDate)
    ),
d(d) AS 
    (
    SELECT DATEADD(DAY, n, @StartDate) FROM seq
    ),
src AS (
    SELECT
    TheDate         = CONVERT(date, d),
    TheDay          = DATEPART(DAY,       d),
    TheDayName      = DATENAME(WEEKDAY,   d),
    TheWeek         = DATEPART(WEEK,      d),
    TheISOWeek      = DATEPART(ISO_WEEK,  d),
    TheDayOfWeek    = DATEPART(WEEKDAY,   d),
    TheMonth        = DATEPART(MONTH,     d),
    TheMonthName    = DATENAME(MONTH,     d),
    TheQuarter      = DATEPART(Quarter,   d),
    TheYear         = DATEPART(YEAR,      d),
    TheFirstOfMonth = DATEFROMPARTS(YEAR(d), MONTH(d), 1),
    TheLastOfYear   = DATEFROMPARTS(YEAR(d), 12, 31),
    TheDayOfYear    = DATEPART(DAYOFYEAR, d)
    FROM d
),
dim AS
(
  SELECT
    TheDate AS datum, 
    TheDay AS dan,
    TheMonth AS mjesec,
    TheYear AS godina,
    TheDayOfWeek AS danUTjednu,
    CASE WHEN TheDayOfWeek IN (6, 7) 
        THEN 1 ELSE 0 END
        AS vikend,
    CASE WHEN
        TheDate BETWEEN DATEFROMPARTS (DATEPART(YEAR, TheDate), 3, 21)  
                AND DATEFROMPARTS (DATEPART(YEAR, TheDate), 6, 20)
        THEN 0
        WHEN 
        TheDate BETWEEN DATEFROMPARTS (DATEPART(YEAR, TheDate), 6, 21)  
                AND DATEFROMPARTS (DATEPART(YEAR, TheDate), 9, 22)
        THEN 1
        WHEN 
        TheDate BETWEEN DATEFROMPARTS (DATEPART(YEAR, TheDate), 9, 23)  
                AND DATEFROMPARTS (DATEPART(YEAR, TheDate), 12, 20)
        THEN 2
        ELSE 3 END
    AS dobaGodine
  FROM src
)
INSERT INTO dDatum
SELECT 
    datum, 
    dan,
    mjesec,
    godina,
    danUTjednu,
    vikend,
    dobaGodine
FROM dim
OPTION (MAXRECURSION 0);