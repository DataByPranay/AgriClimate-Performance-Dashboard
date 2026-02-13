/* ============================================================
   PROJECT: Agriculture Data Analysis And Dashboard (Snowflake + S3 + Power BI)
   PURPOSE: External Stage Integration, Data Loading & Transformation
   ARCHITECTURE: AWS S3 → Snowflake Stage → Raw Table → Transformed Table
   ============================================================ */


/* ============================================================
   1️⃣ CREATE STORAGE INTEGRATION (AWS S3 CONNECTIVITY)
   ============================================================ */

CREATE OR REPLACE STORAGE INTEGRATION PBI_INTEGRATION
    TYPE = EXTERNAL_STAGE
    STORAGE_PROVIDER = S3
    ENABLED = TRUE
    STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::173235558131:role/Powerbi.role'
    STORAGE_ALLOWED_LOCATIONS = ('s3://powerbi.project.main/')
    COMMENT = 'Storage Integration for Power BI Agriculture Project';

-- Verify integration
DESC INTEGRATION PBI_INTEGRATION;



/* ============================================================
   2️⃣ DATABASE & SCHEMA SETUP
   ============================================================ */

CREATE OR REPLACE DATABASE POWERBI;

CREATE OR REPLACE SCHEMA POWERBI.PBI_DATA;

USE DATABASE POWERBI;
USE SCHEMA PBI_DATA;



/* ============================================================
   3️⃣ CREATE RAW TABLE (LANDING LAYER)
   ============================================================ */

CREATE OR REPLACE TABLE PBI_DATASET (
    YEAR INT,
    LOCATION STRING,
    AREA INT,
    RAINFALL FLOAT,
    TEMPERATURE FLOAT,
    SOIL_TYPE STRING,
    IRRIGATION STRING,
    YIELDS INT,
    HUMIDITY FLOAT,
    CROPS STRING,
    PRICE INT,
    SEASON STRING
);



/* ============================================================
   4️⃣ CREATE EXTERNAL STAGE (S3 CONNECTION)
   ============================================================ */

CREATE OR REPLACE STAGE PBI_STAGE
    URL = 's3://powerbi.project.main'
    STORAGE_INTEGRATION = PBI_INTEGRATION;



-- Verify files inside stage
LIST @PBI_STAGE;



/* ============================================================
   5️⃣ LOAD DATA FROM S3 INTO SNOWFLAKE
   ============================================================ */

COPY INTO PBI_DATASET
FROM @PBI_STAGE
FILE_FORMAT = (
    TYPE = CSV
    FIELD_DELIMITER = ','
    SKIP_HEADER = 1
)
ON_ERROR = 'CONTINUE';



/* ============================================================
   6️⃣ BASIC DATA VALIDATION
   ============================================================ */

SELECT COUNT(*) AS TOTAL_RECORDS FROM PBI_DATASET;

SELECT YEAR, COUNT(*) AS COUNT_PER_YEAR
FROM PBI_DATASET
GROUP BY YEAR
ORDER BY YEAR;



/* ============================================================
   7️⃣ CREATE TRANSFORMED TABLE (SILVER LAYER)
   ============================================================ */

CREATE OR REPLACE TABLE AGRICULTURE AS
SELECT *
FROM PBI_DATASET;



/* ============================================================
   8️⃣ BUSINESS TRANSFORMATIONS
   ============================================================ */

-- Example adjustment logic (Business Simulation)
UPDATE AGRICULTURE
SET 
    RAINFALL = 1.1 * RAINFALL,
    AREA     = 0.9 * AREA;



/* ============================================================
   9️⃣ ADD YEAR GROUPING (FEATURE ENGINEERING)
   ============================================================ */

ALTER TABLE AGRICULTURE
ADD COLUMN YEAR_GROUP STRING;

UPDATE AGRICULTURE
SET YEAR_GROUP = CASE
    WHEN YEAR BETWEEN 2004 AND 2009 THEN 'Y1'
    WHEN YEAR BETWEEN 2010 AND 2015 THEN 'Y2'
    WHEN YEAR BETWEEN 2016 AND 2019 THEN 'Y3'
    ELSE 'OTHER'
END;



/* ============================================================
   🔟 ADD RAINFALL CATEGORIZATION
   ============================================================ */

ALTER TABLE AGRICULTURE
ADD COLUMN RAINFALL_GROUP STRING;

UPDATE AGRICULTURE
SET RAINFALL_GROUP = CASE
    WHEN RAINFALL >= 255  AND RAINFALL < 1200 THEN 'LOW'
    WHEN RAINFALL >= 1200 AND RAINFALL < 2800 THEN 'MEDIUM'
    WHEN RAINFALL >= 2800 THEN 'HIGH'
    ELSE 'UNKNOWN'
END;



/* ============================================================
   1️⃣1️⃣ FINAL VALIDATION
   ============================================================ */

SELECT YEAR_GROUP, COUNT(*) 
FROM AGRICULTURE
GROUP BY YEAR_GROUP
ORDER BY YEAR_GROUP;

SELECT RAINFALL_GROUP, COUNT(*) 
FROM AGRICULTURE
GROUP BY RAINFALL_GROUP
ORDER BY RAINFALL_GROUP;

SELECT * FROM AGRICULTURE LIMIT 50;
