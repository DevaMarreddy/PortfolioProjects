/*
SQL Project -- Data Cleaning

Skills used: CTE's, Windows Functions, Converting Data Types, Data Manipulation, Joins

*/

create database if not exists world_layoffs;
use world_layoffs;

select * from layoffs;

-- Creating a duplicate table 'layoffs_clean' for data cleaning while preserving the original raw data in case of any issues.

create table layoffs_clean as
select * from layoffs;

select * from layoffs_clean;



-- 1. Remove Duplicates

with duplicate_cte as
(select *, 
row_number() over(partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions)
as rnk
from layoffs_clean)
select * from duplicate_cte where rnk > 1;

-- Since we can't perform a delete operation on a common table expression (CTE) in MySQL, let's create a new table called 'layoffs_clean2' with all the data from 'layoffs_clean', and include an additional 'rnk' column.

create table layoffs_clean2 as
select * from layoffs_clean where 1 = 2;

alter table layoffs_clean2 add column rnk int;

insert into layoffs_clean2
(select *, 
row_number() over(partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions)
as rnk
from layoffs_clean);

-- Now that we have all the data along with the 'rnk' column, let's delete the duplicate records where 'rnk' is greater than 1.

SET SQL_SAFE_UPDATES = 0; -- to perform delete or update operations we need to set this to 0.

delete from layoffs_clean2 where rnk > 1; -- Before performing the delete operation, it's a best practice to use select statement to review which records you are deleting.



-- 2. Standardize Data

select company, trim(company) from layoffs_clean2;

-- The 'company' column contains extra spaces before and after the word. We'll remove those using the TRIM() function.
update layoffs_clean2 set company = trim(company);

-- removing periods(.) from the 'country' column using replace()
update layoffs_clean2 set country = replace(country, '.', '');

-- noticed the Crypto has multiple different variations(Crypto, Crypto Currency') in 'industry' column. We need to standardize that - let's update all to Crypto
update layoffs_clean2 set industry = 'Crypto'
where industry like '%Crypto%';

-- The 'date' column currently has a text data type, which is invalid. Let's change it to the DATE(format - YYYY-MM-DD) datatype so that we can use it in the exploratory data analysis.
select `date`, str_to_date(`date`, '%m/%d/%Y') from layoffs_clean2;

update layoffs_clean2 set `date` = str_to_date(`date`, '%m/%d/%Y');

alter table layoffs_clean2 modify column `date` DATE;

-- if we look at 'industry' column it looks like we have some null and empty rows, let's take a look at these
SELECT DISTINCT industry
FROM layoffs_clean2
ORDER BY industry;

SELECT *
FROM layoffs_clean2
WHERE industry IS NULL 
OR industry = ''
ORDER BY industry;

-- It seems like Airbnb belongs to the travel industry. However, one record has a null value under the 'industry' column for Airbnb.
-- Let's Update the 'industry' column for rows with the same company name and location, filling null or blank 'industry' values with those from other records.
update layoffs_clean2 set industry = null where industry = ''; -- converting blanks to null values since those are typically easier to work with

update layoffs_clean2 t1
join layoffs_clean2 t2
on t1.company =  t2.company and
t1.location = t2.location
set t1.industry = t2.industry
where (t1.industry is null or t1.industry = '')
and t2.industry is not null;




-- 3. remove any columns and rows we need to

select * from layoffs_clean2
where total_laid_off is null and
percentage_laid_off is null;

-- Delete Useless data we can't really use
-- if both 'total_laid_off' and 'percentage_laid_off' columns are null, it seems unnecessary to have those records.
delete from layoffs_clean2
where total_laid_off is null and
percentage_laid_off is null;

-- let's drop the 'rnk' column that was added to find duplicate records, since we don't need that any more
alter table layoffs_clean2
drop column rnk;

select * from layoffs_clean2;