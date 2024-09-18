USE youtube_db;
SELECT FOLLOWERS
FROM top_youtuber_canada;

SELECT COUNTRY, `TOPIC OF INFLUENCE` FROM top_youtuber_canada;

/* 
channel_name	followers
Channel A	23M
Channel B	1.2M
Channel C	300K
After executing the steps above, the numeric_followers column should contain:

channel_name	numeric_followers
Channel A	23000000.00
Channel B	1200000.00
Channel C	300000.00
*/


ALTER TABLE `top_youtuber_canada` 
ADD COLUMN `NUMERIC FOLLOWERS` DECIMAL(10,2); 




-- Disable safe updates mode
SET SQL_SAFE_UPDATES = 0;

-- Example update with a condition based on row content
UPDATE `top_youtuber_canada`
SET `NUMERIC FOLLOWERS` = CASE
    WHEN `FOLLOWERS` LIKE '%M' THEN
        CAST(REPLACE(`FOLLOWERS`, 'M', '') AS DECIMAL(10,2)) * 1000000
    WHEN `FOLLOWERS` LIKE '%K' THEN
        CAST(REPLACE(`FOLLOWERS`, 'K', '') AS DECIMAL(10,2)) * 1000
    WHEN `FOLLOWERS` REGEXP '^[0-9]+(\.[0-9]+)?$' THEN
        CAST(`FOLLOWERS` AS DECIMAL(10,2))
    ELSE
        0
END
-- Example condition: Update rows where `FOLLOWERS` column has 'M' or 'K'
WHERE `FOLLOWERS` LIKE '%M' OR `FOLLOWERS` LIKE '%K';

-- Re-enable safe updates mode
SET SQL_SAFE_UPDATES = 1;


SELECT * FROM top_youtuber_canada;
ALTER TABLE `top_youtuber_canada` 
ADD COLUMN `NUMERIC POTENTIAL REACH` DECIMAL(10,2);

SET SQL_SAFE_UPDATES = 0;
UPDATE `top_youtuber_canada`
SET `NUMERIC POTENTIAL REACH` = CASE
    WHEN `POTENTIAL REACH` LIKE '%M' THEN
        CAST(REPLACE(`POTENTIAL REACH`, 'M', '') AS DECIMAL(10,2)) * 1000000
    WHEN `POTENTIAL REACH` LIKE '%K' THEN
        CAST(REPLACE(`POTENTIAL REACH`, 'K', '') AS DECIMAL(10,2)) * 1000
    WHEN `POTENTIAL REACH` REGEXP '^[0-9]+(\.[0-9]+)?$' THEN
        CAST(`POTENTIAL REACH` AS DECIMAL(10,2))
    ELSE
        0
END
-- Example condition: Update rows where `FOLLOWERS` column has 'M' or 'K'
WHERE `POTENTIAL REACH` LIKE '%M' OR `POTENTIAL REACH` LIKE '%K';

SET SQL_SAFE_UPDATES = 1;



/*EXTRACT YOUTUBE CHANNEL NAME FROM NAME 
COLUMN USE SUB STRING FUNCTION AND CHARINDEX */

SELECT LOCATE('@', `NAME`),`NAME`
FROM `top_youtuber_canada`;

CREATE VIEW `view_canada_youtubers` AS
SELECT
CAST(SUBSTRING(NAME, 1, LOCATE('@', NAME) -1)
as CHAR (100)) as `CHANNEL NAME`,
`NUMERIC FOLLOWERS`,
 `NUMERIC POTENTIAL REACH`
 FROM `top_youtuber_canada`;


