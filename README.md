# Data Cleaning in MySQL – World Layoffs Dataset

## Project Overview

This project demonstrates a complete data cleaning workflow applied to a global layoffs dataset. The goal is to transform raw, inconsistent data into a reliable foundation suitable for Exploratory Data Analysis (EDA).

The project follows a four-phase cleaning pipeline, with each phase documented in a separate SQL file.

---

## Dataset

- **Source:** in tables, import dataset from `layoffs.csv` file, import as raw data (2361 records)
- **Table:** `layoffs` (imported into the `world_layoffs` schema)
- **Columns:** `company`, `location`, `industry`, `total_laid_off`, `percentage_laid_off`, `date`, `stage`, `country`, `funds_raised_millions`

---

## Project Structure

```
├── README.md
├── removing_duplicates.sql
├── standardizing_data.sql
├── null_blank_values.sql
├── remove_columns.sql
└── layoffs.csv
```

---

## Cleaning Phases

### 1. Removing Duplicates – `removing_duplicates.sql`
- Created a staging table (`layoffs_staging`) to preserve the original raw data
- Used `ROW_NUMBER()` with `PARTITION BY` across all columns to identify true duplicates
- Applied a second staging table (`layoffs_staging2`) as a workaround for MySQL's CTE deletion limitation
- Deleted all records where `row_num > 1`

### 2. Standardizing Data – `standardizing_data.sql`
- Trimmed leading/trailing whitespace from company names using `TRIM()`
- Unified inconsistent industry labels (e.g., `Crypto Currency` → `Crypto`)
- Removed trailing punctuation from country names
- Converted `date` column from `TEXT` to `DATE` type using `STR_TO_DATE()` and `ALTER TABLE`

### 3. Null and Blank Values – `null_blank_values.sql`
- Converted blank strings (`''`) to `NULL` to enable relational joins
- Used a self-join to populate missing `industry` values from matching company records
- Documented cases where population was not possible due to lack of reference data (e.g., Bally's Interactive)

### 4. Remove Unnecessary Columns – `remove_columns.sql`
- Deleted rows where both `total_laid_off` and `percentage_laid_off` are `NULL` (no analytical value)
- Dropped the `row_num` helper column after duplicate removal was complete

---

## Key Concepts Demonstrated

- Staging table strategy to protect raw data
- Window functions (`ROW_NUMBER`, `PARTITION BY`)
- Self-joins for data population
- Data type conversion (`STR_TO_DATE`, `ALTER TABLE`)
- NULL handling and standardization

---

## Tools Used

- MySQL
- MySQL Workbench
