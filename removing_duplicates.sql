-- 1. create database, create schema world_layoffs
-- 2. in tables, import dataset from layoffs.csv file, import as raw data (2361 records)

SELECT *
FROM layoffs;

-- First thing we want to do is create a staging table. This is the one we will work in and clean the data. We want a table with the raw data in case something happens

# create layoffs_staging table
CREATE TABLE layoffs_staging 
LIKE .layoffs;

# check new created table
SELECT *
FROM layoffs_staging;

# insert data from layoffs table
INSERT layoffs_staging 
SELECT * FROM world_layoffs.layoffs;

-- Remove Duplicates

# find duplicates
WITH duplicate_cte AS 
(
SELECT *,
ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging
)
SELECT * 
FROM duplicate_cte
WHERE row_num > 1;

# create new empty table from layoffs_staging (right click on layoffs_staging -> copy to clipboard -> create statement)  with `row_num` 
CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

# insert data from layoffs_staging
INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging;

# filter duplicates
SELECT * 
FROM layoffs_staging2
WHERE row_num > 1;

# delete duplicates
DELETE 
FROM layoffs_staging2
WHERE row_num > 1;
