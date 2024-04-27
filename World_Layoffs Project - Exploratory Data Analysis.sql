/*
SQL Project -- Exploratory Data Analysis

Skills used: CTE's, Windows Functions, Data Analysis, Aggregate Functions, Data Manipulation

*/

-- This project is a continuation of the World_Layoffs Project - Data Cleaning

use world_layoffs;
select * from layoffs_clean2;



-- Checking when the layoffs started and also determining the latest date when the most recent layoff occurred based on the dataset we have
select min(`date`), max(`date`) from layoffs_clean2;

-- Highest employees laid off (total_laid_off) and Highest percentage of employees laid off (percentage_laid_off) on a single day
select max(total_laid_off), max(percentage_laid_off) from layoffs_clean2;

-- Looking at the maximum and minimum percentage of employees laid off (percentage_laid_off) to see the scale of these layoffs
select max(percentage_laid_off), min(percentage_laid_off) from layoffs_clean2
where percentage_laid_off is not null;



-- If companies had percentage_laid_off = 1, which means that 100 percent of the company's employees were laid off
select * from layoffs_clean2
where percentage_laid_off = 1
order by company;
-- It appears that all of these were startups that went out of business during this period

-- Companies with the biggest single layoff
select company, `date`, total_laid_off
from layoffs_clean2
order by 3 desc limit 5;

-- Companies with the most total layoffs
select company, sum(total_laid_off)
from layoffs_clean2
group by company
order by 2 desc limit 10;

-- Locations with the most total layoffs
select location, sum(total_laid_off)
from layoffs_clean2
group by location
order by 2 desc limit 10;

-- Industries with the most total layoffs
select industry, sum(total_laid_off) as Total_Employees_Laid_Off
from layoffs_clean2
group by industry
order by 2 desc limit 10;

-- Retrieve total number of employees laid off per country
select country, sum(total_laid_off) as Total_Employees_Laid_Off
from layoffs_clean2
group by country order by 2 desc;

-- the total number of employees laid off each year
select year(`date`), sum(total_laid_off) as Total_Employees_Laid_Off
from layoffs_clean2
group by year(`date`) order by 1;

-- Identify stock market listed companies that have laid off the most number of employees
select company, stage, sum(total_laid_off) as Total_Employees_Laid_Off
from layoffs_clean2
where stage = 'Post-IPO'
group by company, stage
order by 3 desc limit 10;



-- This SQL query identifies the top 5 companies(across the world) annually with the highest number of layoffs.
with year_cte as
(select company, year(`date`) as years, sum(total_laid_off) as Total_Employees_Laid_Off
from layoffs_clean2
group by company, year(`date`)),
rank_cte as
(select company, years, Total_Employees_Laid_Off,
dense_rank() over(partition by years order by Total_Employees_Laid_Off desc) as ranking
from year_cte)
select * from rank_cte
where ranking <=5;

-- Below query calculates the monthly total and rolling sum of employees laid off based on our layoffs data
with date_cte as
(
select substring(`date`, 1, 7) as `Month`, sum(total_laid_off) as Total_Employees_Laid_Off
from layoffs_clean2
where substring(`date`, 1, 7) is not null 
group by `Month`
order by `Month`)
select `Month`, Total_Employees_Laid_Off, sum(Total_Employees_Laid_Off) over(order by `Month`) as Rolling_Laid_Off
from date_cte
order by `Month`;