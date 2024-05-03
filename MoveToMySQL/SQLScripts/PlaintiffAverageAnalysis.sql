set sql_safe_updates=0;
UPDATE website_lawsuits_compiled
set `Plaintiff Name`= UCWORDS(`Plaintiff Name`);

select count(*),  `Plaintiff Name`
from website_lawsuits_compiled
group by `Plaintiff Name` 
order by count(*) desc;

WITH TopPlaintiffs AS (
    SELECT
        wlc.`Plaintiff Name` AS PlaintiffName,
        COUNT(DISTINCT wlc.ID) AS TotalLawsuits
    FROM
        website_lawsuits_compiled wlc
    GROUP BY
        wlc.`Plaintiff Name`
    ORDER BY
        TotalLawsuits DESC
    LIMIT 200
)
SELECT
    RankedTimeInterval.PlaintiffName,
    TimeInterval,
    LawsuitDate,
    NextLawsuitDate,
    LawsuitID,
    NextLawsuitID
FROM (
    SELECT 
        PlaintiffName,
        LawsuitDate,
        NextLawsuitDate,
        TimeInterval,
        LawsuitID,
        NextLawsuitID,
        ROW_NUMBER() OVER (PARTITION BY PlaintiffName ORDER BY TimeInterval) AS RowNum
    FROM (
        SELECT
            wlc.`Plaintiff Name` AS PlaintiffName,
            wlc.`Date of Filing` AS LawsuitDate,
            LEAD(wlc.`Date of Filing`) OVER (PARTITION BY wlc.`Plaintiff Name` ORDER BY wlc.`Date of Filing`) AS NextLawsuitDate,
            DATEDIFF(LEAD(wlc.`Date of Filing`) OVER (PARTITION BY wlc.`Plaintiff Name` ORDER BY wlc.`Date of Filing`), wlc.`Date of Filing`) AS TimeInterval,
            wlc.ID AS LawsuitID,
            LEAD(wlc.ID) OVER (PARTITION BY wlc.`Plaintiff Name` ORDER BY wlc.`Date of Filing`) AS NextLawsuitID
        FROM 
            website_lawsuits_compiled wlc
    ) AS TimeIntervalSubquery
    WHERE NextLawsuitDate IS NOT NULL
) AS RankedTimeInterval
INNER JOIN TopPlaintiffs ON RankedTimeInterval.PlaintiffName = TopPlaintiffs.PlaintiffName
WHERE RowNum = 1;



WITH TopPlaintiffs AS (
    SELECT
        wlc.`Plaintiff Name` AS PlaintiffName,
        COUNT(DISTINCT wlc.ID) AS TotalLawsuits
    FROM
        website_lawsuits_compiled wlc
    GROUP BY
        wlc.`Plaintiff Name`
    ORDER BY
        TotalLawsuits DESC
    LIMIT 100
)
SELECT
    RankedTimeInterval.PlaintiffName,
    TotalLawsuits,
    TimeInterval,
    LawsuitDate,
    NextLawsuitDate,
    LawsuitID,
    NextLawsuitID
FROM (
    SELECT 
        PlaintiffName,
        LawsuitDate,
        NextLawsuitDate,
        TimeInterval,
        LawsuitID,
        NextLawsuitID,
        ROW_NUMBER() OVER (PARTITION BY PlaintiffName ORDER BY TimeInterval DESC) AS RowNum
    FROM (
        SELECT
            wlc.`Plaintiff Name` AS PlaintiffName,
            wlc.`Date of Filing` AS LawsuitDate,
            LEAD(wlc.`Date of Filing`) OVER (PARTITION BY wlc.`Plaintiff Name` ORDER BY wlc.`Date of Filing`) AS NextLawsuitDate,
            DATEDIFF(LEAD(wlc.`Date of Filing`) OVER (PARTITION BY wlc.`Plaintiff Name` ORDER BY wlc.`Date of Filing`), wlc.`Date of Filing`) AS TimeInterval,
            wlc.ID AS LawsuitID,
            LEAD(wlc.ID) OVER (PARTITION BY wlc.`Plaintiff Name` ORDER BY wlc.`Date of Filing`) AS NextLawsuitID
        FROM 
            website_lawsuits_compiled wlc
    ) AS TimeIntervalSubquery
    WHERE NextLawsuitDate IS NOT NULL
) AS RankedTimeInterval
INNER JOIN TopPlaintiffs ON RankedTimeInterval.PlaintiffName = TopPlaintiffs.PlaintiffName
WHERE RowNum = 1
ORDER BY TimeInterval DESC, RankedTimeInterval.PlaintiffName;

WITH TopPlaintiffs AS (
    SELECT
        wlc.`Plaintiff Name` AS PlaintiffName,
        COUNT(DISTINCT wlc.ID) AS TotalLawsuits
    FROM
        website_lawsuits_compiled wlc
    GROUP BY
        wlc.`Plaintiff Name`
    ORDER BY
        TotalLawsuits DESC
)
SELECT
    RankedTimeInterval.PlaintiffName,
    TotalLawsuits,
    TimeInterval,
    LawsuitDate,
    NextLawsuitDate,
    LawsuitID,
    NextLawsuitID
FROM (
    SELECT 
        PlaintiffName,
        LawsuitDate,
        NextLawsuitDate,
        TimeInterval,
        LawsuitID,
        NextLawsuitID,
        ROW_NUMBER() OVER (PARTITION BY PlaintiffName ORDER BY TimeInterval) AS RowNum
    FROM (
        SELECT
            wlc.`Plaintiff Name` AS PlaintiffName,
            wlc.`Date of Filing` AS LawsuitDate,
            LEAD(wlc.`Date of Filing`) OVER (PARTITION BY wlc.`Plaintiff Name` ORDER BY wlc.`Date of Filing`) AS NextLawsuitDate,
            DATEDIFF(LEAD(wlc.`Date of Filing`) OVER (PARTITION BY wlc.`Plaintiff Name` ORDER BY wlc.`Date of Filing`), wlc.`Date of Filing`) AS TimeInterval,
            wlc.ID AS LawsuitID,
            LEAD(wlc.ID) OVER (PARTITION BY wlc.`Plaintiff Name` ORDER BY wlc.`Date of Filing`) AS NextLawsuitID
        FROM 
            website_lawsuits_compiled wlc
    ) AS TimeIntervalSubquery
    WHERE NextLawsuitDate IS NOT NULL
) AS RankedTimeInterval
INNER JOIN TopPlaintiffs ON RankedTimeInterval.PlaintiffName = TopPlaintiffs.PlaintiffName
WHERE RowNum = 1;


WITH TopPlaintiffs AS (
    SELECT
        wlc.`Plaintiff Name` AS PlaintiffName,
        COUNT(DISTINCT wlc.ID) AS TotalLawsuits
    FROM
        website_lawsuits_compiled wlc
    GROUP BY
        wlc.`Plaintiff Name`
    ORDER BY
        TotalLawsuits DESC
    LIMIT 200
)
SELECT
    RankedTimeInterval.PlaintiffName,
    TotalLawsuits,
    TimeInterval,
    LawsuitDate,
    NextLawsuitDate,
    LawsuitID,
    NextLawsuitID
FROM (
    SELECT 
        PlaintiffName,
        LawsuitDate,
        NextLawsuitDate,
        TimeInterval,
        LawsuitID,
        NextLawsuitID,
        ROW_NUMBER() OVER (PARTITION BY PlaintiffName ORDER BY TimeInterval) AS RowNum
    FROM (
        SELECT
            wlc.`Plaintiff Name` AS PlaintiffName,
            wlc.`Date of Filing` AS LawsuitDate,
            LEAD(wlc.`Date of Filing`) OVER (PARTITION BY wlc.`Plaintiff Name` ORDER BY wlc.`Date of Filing`) AS NextLawsuitDate,
            DATEDIFF(LEAD(wlc.`Date of Filing`) OVER (PARTITION BY wlc.`Plaintiff Name` ORDER BY wlc.`Date of Filing`), wlc.`Date of Filing`) AS TimeInterval,
            wlc.ID AS LawsuitID,
            LEAD(wlc.ID) OVER (PARTITION BY wlc.`Plaintiff Name` ORDER BY wlc.`Date of Filing`) AS NextLawsuitID
        FROM 
            website_lawsuits_compiled wlc
    ) AS TimeIntervalSubquery
    WHERE NextLawsuitDate IS NOT NULL
) AS RankedTimeInterval
INNER JOIN TopPlaintiffs ON RankedTimeInterval.PlaintiffName = TopPlaintiffs.PlaintiffName
WHERE RowNum = 1;

WITH TopPlaintiffs AS (
    SELECT
        wlc.`Plaintiff Name` AS PlaintiffName,
        COUNT(DISTINCT wlc.ID) AS TotalLawsuits
    FROM
        website_lawsuits_compiled wlc
    GROUP BY
        wlc.`Plaintiff Name`
    ORDER BY
        TotalLawsuits DESC
)
SELECT
    RankedTimeInterval.PlaintiffName,
    TotalLawsuits,
    AVG(TimeInterval) AS AverageTimeInterval,
    MIN(LawsuitDate) AS EarliestLawsuitDate,
    MAX(NextLawsuitDate) AS LatestLawsuitDate
FROM (
    SELECT 
        PlaintiffName,
        LawsuitDate,
        NextLawsuitDate,
        DATEDIFF(NextLawsuitDate, LawsuitDate) AS TimeInterval
    FROM (
        SELECT
            wlc.`Plaintiff Name` AS PlaintiffName,
            wlc.`Date of Filing` AS LawsuitDate,
            LEAD(wlc.`Date of Filing`) OVER (PARTITION BY wlc.`Plaintiff Name` ORDER BY wlc.`Date of Filing`) AS NextLawsuitDate
        FROM 
            website_lawsuits_compiled wlc
    ) AS TimeIntervalSubquery
    WHERE NextLawsuitDate IS NOT NULL
) AS RankedTimeInterval
INNER JOIN TopPlaintiffs ON RankedTimeInterval.PlaintiffName = TopPlaintiffs.PlaintiffName
GROUP BY RankedTimeInterval.PlaintiffName
order by TotalLawsuits desc;

WITH LawsuitIntervals AS (
    SELECT
        DATEDIFF(LEAD(wlc.`Date of Filing`) OVER (ORDER BY wlc.`Date of Filing`), wlc.`Date of Filing`) * 24 AS TimeIntervalInHours
    FROM 
        website_lawsuits_compiled wlc
)
SELECT 
    AVG(TimeIntervalInHours) AS AverageTimeIntervalInHours,
    CONCAT('Every ', AVG(TimeIntervalInHours), ' hours a lawsuit is filed') AS Statement
FROM 
    LawsuitIntervals
WHERE TimeIntervalInHours IS NOT NULL;





WITH TopPlaintiffs AS (
    SELECT
        wlc.`Plaintiff Name` AS PlaintiffName,
        COUNT(DISTINCT wlc.ID) AS TotalLawsuits
    FROM
        website_lawsuits_compiled wlc
    GROUP BY
        wlc.`Plaintiff Name`
    ORDER BY
        TotalLawsuits DESC
	LIMIT 300

),
RankedTimeInterval AS (
    SELECT 
        PlaintiffName,
        LawsuitDate,
        NextLawsuitDate,
        TimeInterval,
        LawsuitID,
        NextLawsuitID,
        ROW_NUMBER() OVER (PARTITION BY PlaintiffName ORDER BY TimeInterval) AS RowNum
    FROM (
        SELECT
            wlc.`Plaintiff Name` AS PlaintiffName,
            wlc.`Date of Filing` AS LawsuitDate,
            LEAD(wlc.`Date of Filing`) OVER (PARTITION BY wlc.`Plaintiff Name` ORDER BY wlc.`Date of Filing`) AS NextLawsuitDate,
            DATEDIFF(LEAD(wlc.`Date of Filing`) OVER (PARTITION BY wlc.`Plaintiff Name` ORDER BY wlc.`Date of Filing`), wlc.`Date of Filing`) AS TimeInterval,
            wlc.ID AS LawsuitID,
            LEAD(wlc.ID) OVER (PARTITION BY wlc.`Plaintiff Name` ORDER BY wlc.`Date of Filing`) AS NextLawsuitID
        FROM 
            website_lawsuits_compiled wlc
    ) AS TimeIntervalSubquery
    WHERE NextLawsuitDate IS NOT NULL
)
SELECT 
    AVG(TimeInterval) AS AverageTimeInterval
FROM 
    RankedTimeInterval;
    
    
    
WITH TopPlaintiffs AS (
    SELECT
        wlc.`Plaintiff Name` AS PlaintiffName,
        COUNT(DISTINCT wlc.ID) AS TotalLawsuits
    FROM
        website_lawsuits_compiled wlc
    GROUP BY
        wlc.`Plaintiff Name`
    ORDER BY
        TotalLawsuits DESC
)
SELECT
    AVG(AverageTimeInterval) AS OverallAverageTimeInterval
FROM (
    SELECT
        RankedTimeInterval.PlaintiffName,
        TotalLawsuits,
        AVG(TimeInterval) AS AverageTimeInterval
    FROM (
        SELECT 
            PlaintiffName,
            LawsuitDate,
            NextLawsuitDate,
            DATEDIFF(NextLawsuitDate, LawsuitDate) AS TimeInterval
        FROM (
            SELECT
                wlc.`Plaintiff Name` AS PlaintiffName,
                wlc.`Date of Filing` AS LawsuitDate,
                LEAD(wlc.`Date of Filing`) OVER (PARTITION BY wlc.`Plaintiff Name` ORDER BY wlc.`Date of Filing`) AS NextLawsuitDate
            FROM 
                website_lawsuits_compiled wlc
        ) AS TimeIntervalSubquery
        WHERE NextLawsuitDate IS NOT NULL
    ) AS RankedTimeInterval
    INNER JOIN TopPlaintiffs ON RankedTimeInterval.PlaintiffName = TopPlaintiffs.PlaintiffName
    GROUP BY RankedTimeInterval.PlaintiffName, TotalLawsuits
) AS Averages;

WITH TopPlaintiffs AS (
    SELECT
        wlc.`Plaintiff Name` AS PlaintiffName,
        COUNT(DISTINCT wlc.ID) AS TotalLawsuits
    FROM
        website_lawsuits_compiled wlc
    GROUP BY
        wlc.`Plaintiff Name`
    ORDER BY
        TotalLawsuits DESC
)
SELECT
    AVG(TimeInterval) AS AverageTimeInterval
FROM (
    SELECT 
        PlaintiffName,
        LawsuitDate,
        NextLawsuitDate,
        TimeInterval,
        LawsuitID,
        NextLawsuitID,
        ROW_NUMBER() OVER (PARTITION BY PlaintiffName ORDER BY TimeInterval) AS RowNum
    FROM (
        SELECT
            wlc.`Plaintiff Name` AS PlaintiffName,
            wlc.`Date of Filing` AS LawsuitDate,
            LEAD(wlc.`Date of Filing`) OVER (PARTITION BY wlc.`Plaintiff Name` ORDER BY wlc.`Date of Filing`) AS NextLawsuitDate,
            DATEDIFF(LEAD(wlc.`Date of Filing`) OVER (PARTITION BY wlc.`Plaintiff Name` ORDER BY wlc.`Date of Filing`), wlc.`Date of Filing`) AS TimeInterval,
            wlc.ID AS LawsuitID,
            LEAD(wlc.ID) OVER (PARTITION BY wlc.`Plaintiff Name` ORDER BY wlc.`Date of Filing`) AS NextLawsuitID
        FROM 
            website_lawsuits_compiled wlc
    ) AS TimeIntervalSubquery
    WHERE NextLawsuitDate IS NOT NULL
) AS RankedTimeInterval
INNER JOIN TopPlaintiffs ON RankedTimeInterval.PlaintiffName = TopPlaintiffs.PlaintiffName
WHERE RowNum = 1;


