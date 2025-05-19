
-- Data Cleaning in SQL

SELECT *
FROM layoffs;


-- Creating a demo database so as to maintain original data

select * into layoff_demo from layoffs

SELECT *
FROM layoff_demo;

-- Removing Duplicates using Count

SELECT 
company,"location",industry,total_laid_off,percentage_laid_off,"date",stage, country, funds_raised_millions, count(*) as cnt
from  layoff_demo
group by company,"location",industry,total_laid_off,percentage_laid_off,"date",stage, country, funds_raised_millions
having count(*) > 1

SELECT*
FROM layoff_demo
WHERE company = 'Casper';

-- Deleting Duplicates Using CTEs(a temporary table created within SQL)

WITH duplicate_cte AS
(
	SELECT *,
	ROW_NUMBER() OVER(
	PARTITION BY company,"location", 
	industry, total_laid_off, percentage_laid_off,"date", 
	stage, country, funds_raised_millions
	ORDER BY company ASC)
	as row_num
	FROM layoff_demo
)
	DELETE FROM duplicate_cte
	WHERE row_num > 1;

SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company,"location", 
industry, total_laid_off, percentage_laid_off,"date", 
stage, country, funds_raised_millions
ORDER BY company ASC)
as row_num
FROM layoff_demo

-- Ran Previous Duplicate Code to confirm that all duplicates have been deleted

SELECT 
company,"location",industry,total_laid_off,percentage_laid_off,"date",stage, country, funds_raised_millions, count(*) as cnt
from  layoff_demo
group by company,"location",industry,total_laid_off,percentage_laid_off,"date",stage, country, funds_raised_millions
having count(*) > 1;

-- Standardizing Data

SELECT company, TRIM(company)
FROM layoff_demo;

-- Using TRIM function to remove any unnecessary space in the company column

UPDATE layoff_demo
SET company = TRIM(company);


-- Standardizing Every Other Column

SELECT DISTINCT industry
FROM layoff_demo
ORDER BY 1;

SELECT *
FROM layoff_demo
WHERE industry IS NULL;


-- The data in Layoff_demo labeled some companies as part of the 'Crypto' & 'Cryptocurrency' Industry
-- That's a clear error in the industry classification, all companies related to Cryto should be under the Crypto Industry
-- To correct this, the following query is executed

UPDATE layoff_demo
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';


SELECT DISTINCT country
FROM layoff_demo
ORDER BY 1;

-- United States was displayed twice under the country column. To correct this,

SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
FROM layoff_demo
ORDER BY 1;

UPDATE layoff_demo
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';


SELECT DISTINCT company, industry
FROM layoff_demo
WHERE country like 'United States'

-- Using Join to Update demo table

UPDATE layoff_demo
SET layoff_demo.industry = o.industry
FROM layoff_demo s
inner join layoffs o
on s.company = o.company
;

SELECT "date"
FROM layoff_demo;

-- To check Data Types

SELECT *
FROM INFORMATION_SCHEMA.COLUMNS


SELECT *
FROM layoff_demo
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT DISTINCT industry
FROM layoff_demo


--Identifying Industry NULL values

SELECT *
FROM layoff_demo
WHERE industry IS NULL
OR industry = '';


-- Correcting Industry NULL values

SELECT *
FROM layoff_demo
WHERE  company = 'Airbnb';

SELECT *
FROM layoff_demo a
JOIN layoff_demo b
	ON a.company = b.company
WHERE (a.industry IS NULL OR b.industry ='')
AND b.industry IS NOT NULL;



SELECT *
FROM layoff_demo
WHERE  company = ('Bally''s Interactive')


SELECT a.company, a.industry, b.industry
FROM layoff_demo a
JOIN layoff_demo b
	ON a.company = b.company
WHERE (a.industry IS NULL OR b.industry ='')
AND b.industry IS NOT NULL;


UPDATE a
SET a.industry = b.industry
FROM layoff_demo a
JOIN layoff_demo b
	ON a.company = b.company
WHERE (a.industry IS NULL OR a.industry ='')
AND b.industry IS NOT NULL
AND b.industry != '';



-- Deleting all data where total_laid_off and percentage_laid_off is NULL 
-- This is because, the information regarding them could not be retrieved
-- Hence, leaving it could alter our decision or result significantly

SELECT *
FROM layoff_demo
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

DELETE 
FROM layoff_demo
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;


SELECT DISTINCT stage
FROM layoff_demo


UPDATE layoff_demo
SET percentage_laid_off = CAST(percentage_laid_off AS decimal (10,2));

SELECT CAST(percentage_laid_off AS decimal (10,2)) 
FROM layoff_demo


-- EXPLORATORY 
-- Running Queries for Analysis

-- Trend Analysis Over Time

--TOTAL LAYOFFS PER YEAR

SELECT YEAR("date")as "Year", SUM(total_laid_off) as total_laid_off_by_year
FROM layoff_demo
WHERE "date" IS NOT NULL
GROUP BY YEAR("date")
ORDER BY SUM(total_laid_off) DESC;

-- TOTAL LAYOFFS PER month

SELECT DATENAME(MONTH,("date"))as "Month", SUM(total_laid_off) as total_laid_off_by_year
FROM layoff_demo
WHERE "date" IS NOT NULL
GROUP BY DATENAME(MONTH,("date"))
ORDER BY SUM(total_laid_off) DESC;


-- AVERAGE PERCENTAGE LAYOFF PER YEAR

SELECT YEAR("date")as "Year", 
CAST(AVG(percentage_laid_off)as decimal (10,2)) as percentage_laid_off_by_year
FROM layoff_demo
WHERE "date" IS NOT NULL
GROUP BY YEAR("date")
ORDER BY AVG(percentage_laid_off) DESC;


-- AVERAGE PERCENTAGE LAYOFF PER MONTH

SELECT DATENAME(MONTH,("date"))as "Month", 
CAST(AVG(percentage_laid_off)as decimal (10,2)) as percentage_laid_off_by_year
FROM layoff_demo
WHERE "date" IS NOT NULL
GROUP BY DATENAME(MONTH,("date")) 
ORDER BY AVG(percentage_laid_off) DESC;




-- Monthly TREND BETWEEN PRE- & POST - IPO COMPANIES

SELECT DATENAME(MONTH,("date"))as "Month", 
CAST(AVG(percentage_laid_off)as decimal (10,2)) as percentage_laid_off_by_year, stage
FROM layoff_demo
WHERE "date" IS NOT NULL AND stage = 'Post-IPO' OR stage = 'Seed'
GROUP BY DATENAME(MONTH,("date")), stage
ORDER BY DATENAME(MONTH,("date")) ;


-- YEARLY TREND BETWEEN PRE- & POST - IPO COMPANIES - percentage_laid_off

SELECT YEAR("date")as "Year", 
CAST(AVG(percentage_laid_off)as decimal (10,2)) as avg_percentage_laid_off_by_year, stage
FROM layoff_demo
WHERE "date" IS NOT NULL AND stage = 'Post-IPO' OR stage = 'Seed'
GROUP BY YEAR("date"), stage
ORDER BY YEAR("date") DESC;



-- Monthly TREND BETWEEN PRE- & POST - IPO COMPANIES - Total Laid off

SELECT DATENAME(MONTH,("date"))as "Month",stage,
SUM(total_laid_off) as total_laid_off_by_year
FROM layoff_demo
WHERE "date" IS NOT NULL AND stage = 'Post-IPO' OR stage = 'Seed'
GROUP BY DATENAME(MONTH,("date")), DATEPART(MONTH,("date")),stage
ORDER BY DATEPART(MONTH,("date")) ;



-- YEARLY TREND BETWEEN PRE- & POST - IPO COMPANIES - Total Laid off

SELECT YEAR("date")as "Year", 
SUM(total_laid_off) as total_laid_off_by_year, stage
FROM layoff_demo
WHERE "date" IS NOT NULL AND stage = 'Post-IPO' OR stage = 'Seed'
GROUP BY YEAR("date"),stage
ORDER BY YEAR("date") ;


-- INDUSTRY ANALYSIS
-- Industry with highest total laid off in 2020,2021,2022 & 2023

SELECT industry, SUM(total_laid_off) as total_laid_off_by_industry_2020
FROM layoff_demo
WHERE "date" IS NOT NULL AND industry IS NOT NULL AND YEAR("date") = 2020
GROUP BY industry
ORDER BY SUM(total_laid_off) DESC ;


SELECT industry, SUM(total_laid_off) as total_laid_off_by_industry_2021
FROM layoff_demo
WHERE "date" IS NOT NULL AND industry IS NOT NULL AND YEAR("date") = 2021
GROUP BY industry
ORDER BY SUM(total_laid_off) DESC ;


SELECT industry, SUM(total_laid_off) as total_laid_off_by_industry_2022
FROM layoff_demo
WHERE "date" IS NOT NULL AND industry IS NOT NULL AND YEAR("date") = 2022
GROUP BY industry
ORDER BY SUM(total_laid_off) DESC ;


SELECT industry, SUM(total_laid_off) as total_laid_off_by_industry_2023
FROM layoff_demo
WHERE "date" IS NOT NULL AND industry IS NOT NULL AND YEAR("date") = 2023
GROUP BY industry
ORDER BY SUM(total_laid_off) DESC ;

-- TOP 5 MOST IMPACTED INDUSTRIES BY TOTAL AND PERCENTAGE FROM 2020-2023

SELECT TOP 5 industry, 
SUM(total_laid_off) as total_laid_off_by_industry
FROM layoff_demo
WHERE "date" IS NOT NULL AND industry IS NOT NULL 
GROUP BY industry
ORDER BY SUM(total_laid_off) DESC ;


SELECT TOP 5 industry, 
CAST(AVG(percentage_laid_off)as decimal (10,2)) as avg_percentage_laid_off_by_year
FROM layoff_demo
WHERE "date" IS NOT NULL AND industry IS NOT NULL 
GROUP BY industry
ORDER BY avg_percentage_laid_off_by_year DESC ;



-- AVERAGE LAYOFF PER YEAR FROM EACH INDUSTRY

SELECT industry, 
SUM(total_laid_off)/3 as Yearly_avg_total_laid_off_by_industry
FROM layoff_demo
WHERE "date" IS NOT NULL AND industry IS NOT NULL 
GROUP BY industry
ORDER BY SUM(total_laid_off)/3 DESC;

-- TOTAL LAYOFFS PER COUNTRY

SELECT country, SUM(total_laid_off) as total_laid_off_by_country
FROM layoff_demo
WHERE country IS NOT NULL 
GROUP BY country
ORDER BY SUM(total_laid_off) DESC ;



-- AVG PERCENTAGE LAY OFFS PER COUNTRY

SELECT country, 
CAST(AVG(percentage_laid_off)as decimal (10,2)) as avg_percentage_laid_off_by_year
FROM layoff_demo
WHERE country IS NOT NULL 
GROUP BY country
ORDER BY avg_percentage_laid_off_by_year DESC ;


-- CROSS DIMENSIONAL ANALYSIS
-- LAYOFFS BY INDUSTRY AND COUNTRY


SELECT country, industry, SUM(total_laid_off) as total_laid_off_by_country
FROM layoff_demo
WHERE country IS NOT NULL 
GROUP BY country,industry
ORDER BY country, total_laid_off_by_country DESC;



SELECT 
    industry,
    SUM(CASE WHEN YEAR([date]) = 2020 THEN total_laid_off ELSE 0 END) AS layoffs_2020,
    SUM(CASE WHEN YEAR([date]) = 2021 THEN total_laid_off ELSE 0 END) AS layoffs_2021,
    SUM(CASE WHEN YEAR([date]) = 2022 THEN total_laid_off ELSE 0 END) AS layoffs_2022,
    SUM(CASE WHEN YEAR([date]) = 2023 THEN total_laid_off ELSE 0 END) AS layoffs_2023,
    SUM(total_laid_off) AS total_layoffs_2020_2023
FROM layoff_demo
WHERE [date] IS NOT NULL AND industry IS NOT NULL
GROUP BY industry
ORDER BY total_layoffs_2020_2023 DESC;


SELECT stage, SUM(total_laid_off) AS total_layoffs
FROM layoff_demo
WHERE stage IS NOT NULL
GROUP BY stage
ORDER BY total_layoffs DESC;


SELECT stage, 
	SUM(CASE WHEN YEAR([date]) = 2020 THEN total_laid_off ELSE 0 END) AS layoffs_2020,
    SUM(CASE WHEN YEAR([date]) = 2021 THEN total_laid_off ELSE 0 END) AS layoffs_2021,
    SUM(CASE WHEN YEAR([date]) = 2022 THEN total_laid_off ELSE 0 END) AS layoffs_2022,
    SUM(CASE WHEN YEAR([date]) = 2023 THEN total_laid_off ELSE 0 END) AS layoffs_2023,
    SUM(total_laid_off) AS total_layoffs_2020_2023_by_stage
FROM layoff_demo
WHERE [date] IS NOT NULL AND stage IS NOT NULL
GROUP BY stage
ORDER BY total_layoffs_2020_2023_by_stage DESC;
