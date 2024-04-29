**Project-1**:- **World Layoffs Data Cleaning and Exploratory Analysis**
---
- Overview:- This project focuses on cleaning and analyzing a dataset related to global layoffs using SQL. The goals are to standardize data, remove duplicates, handle missing values, and explore trends and insights from the cleaned dataset.
- Dataset:- The dataset contains information about layoffs, including company details, industry, number of employees laid off, date, and more.
- Skills used:- SQL, CTEs, Window Functions, Data Cleaning, Data Manipulation, Joins, Data Analysis, Aggregate Functions
- Cleaning Process:-
    1. Removed duplicates using CTEs and window functions.
    2. Standardized data formats (e.g., dates, company names, industries).
    3. Handled null and empty values.
    4. Removed unnecessary data.
- Exploratory Data Analysis:-
    1. Investigated companies that had 100% of their workforce laid off, potentially indicating startups going out of business.
    2. Analyzed the scale of layoffs by exploring the maximum and minimum values for total employees laid off and percentage laid off.
    3. Identified companies, locations, and industries with the highest number of total layoffs.
    4. Examined layoff trends over time by analyzing the total employees laid off per country, per year, and calculated the monthly total and rolling sum.
- The following files are directly related to this project:
    - [layoffs.csv](https://github.com/DevaMarreddy/PortfolioProjects/blob/main/layoffs.csv) (dataset)
    - [World_Layoffs Project - Data Cleaning.sql](https://github.com/DevaMarreddy/PortfolioProjects/blob/main/World_Layoffs%20Project%20-%20Data%20Cleaning.sql) (SQL script for data cleaning)
    - [World_Layoffs Project - Exploratory Data Analysis.sql](https://github.com/DevaMarreddy/PortfolioProjects/blob/main/World_Layoffs%20Project%20-%20Exploratory%20Data%20Analysis.sql) (SQL script for Exploratory Data Analysis)
- Usage:- The cleaned and analyzed dataset can be used for reporting, visualizing layoff trends, exploring relationships between variables, and gaining insights into the global layoff landscape.
---



**Project-2**:- **Covid-19 Data Exploration**
---
- Overview:- This project aims to explore and analyze the Covid-19 pandemic data using SQL. The goal is to extract meaningful insights and patterns related to the spread, impact, and vaccination efforts across different locations worldwide.
- Dataset:- The dataset contains information about Covid-19, including location, date, total cases, new cases, total deaths, population, and vaccination data.
- Skills used:- SQL, Joins, CTEs, Window Functions, Aggregate Functions, Creating Views, Converting Data Types, Data Exploration, Data Analysis.
- Exploration Process:-
     1. Explored the total cases, new cases, total deaths, and population for different locations over time.
     2. Calculated the likelihood of dying if infected with Covid-19 by determining the death percentage for various locations.
     3. Analyzed the percentage of populations infected and identified countries with highest infection rates relative to population size.
     4. Investigated countries and continents with highest death counts per population to identify severely impacted regions.
     5. Evaluated the global impact by calculating total cases, deaths, and overall death percentage worldwide.
     6. Explored vaccination progress by analyzing the percentage of populations receiving at least one dose, and created a view for further analysis.
- The following files are directly related to this project:
    - [CovidDeaths.xlsx](https://github.com/DevaMarreddy/PortfolioProjects/blob/main/CovidDeaths.xlsx) & [CovidVaccinations.xlsx](https://github.com/DevaMarreddy/PortfolioProjects/blob/main/CovidVaccinations.xlsx) (datasets)
    - [COVID Portfolio Project - Data Exploration.sql](https://github.com/DevaMarreddy/PortfolioProjects/blob/main/COVID%20Portfolio%20Project%20-%20Data%20Exploration.sql) (SQL script for data exploration)
- Usage:- The analyzed Covid-19 data offers valuable insights into the pandemic's impact, enabling the identification of patterns and trends distribution of medical resources, and rollout of vaccination programs.
---
