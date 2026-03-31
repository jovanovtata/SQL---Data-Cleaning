-- standardazing Data

SELECT company, trim(company)
FROM layoffs_staging2;

# trimovanje naziva kompanije
UPDATE layoffs_staging2
SET company = TRIM(company)
;

# pronalazenje jedinstvenog naziva industrije
SELECT DISTINCT industry
FROM layoffs_staging2
ORDER BY 1;

# see crypto named columns
SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%';

# update crypto names
UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

# see location
SELECT DISTINCT location
FROM layoffs_staging2
ORDER BY 1;

# see country
SELECT DISTINCT country
FROM layoffs_staging2
ORDER BY 1;

# problem found - United States with dot at the end
SELECT DISTINCT country
FROM layoffs_staging2
WHERE country LIKE 'United States%';

# update name
UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

-- FROMAT DATE
#format date
SELECT `date`,
str_to_date(`date`, '%m/%d/%Y')
FROM layoffs_staging2
;

UPDATE layoffs_staging2
SET `date` = str_to_date(`date`, '%m/%d/%Y')
;

SELECT `date`
FROM layoffs_staging2
;

#change column format, text -> date
ALTER TABLE layoffs_staging2
modify column `date` DATE;
