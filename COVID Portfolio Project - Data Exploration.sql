/*
Covid 19 Data Exploration 

Skills used: Joins, CTE's, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types

*/

CREATE DATABASE IF NOT EXISTS ProjectPortfolio;

use ProjectPortfolio;

-- Imported the data from csv files (CovidDeaths & CovidVaccinations) and created the tables out of these csv files

-- Select Data that we are going to be starting with

Select Location, date, total_cases, new_cases, total_deaths, population
From CovidDeaths
Where continent is not null 
order by 1,2;


-- Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in your country

Select Location, date, total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From CovidDeaths
Where location like '%india%'
and continent is not null 
order by 1,2;


-- Total Cases vs Population
-- Calculates the percentage of Covid cases resulting in deaths in your country

Select Location, date, Population, total_cases,  (total_cases/population)*100 as PercentPopulationInfected
From CovidDeaths
Where location like '%india%'
order by 1,2;


-- Countries with Highest Infection Rate compared to Population

Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From CovidDeaths
Group by Location, Population
order by PercentPopulationInfected desc;

-- Countries with Highest Death Count per Population

Select Location, MAX(convert(Total_deaths, signed)) as TotalDeathCount
From CovidDeaths
Where continent is not null 
Group by Location
order by TotalDeathCount desc;



-- BREAKING THINGS DOWN BY CONTINENT

-- Showing contintents with the highest death count per population

Select continent, MAX(convert(Total_deaths, signed)) as TotalDeathCount
From CovidDeaths
Where continent is not null 
Group by continent
order by TotalDeathCount desc;



-- GLOBAL NUMBERS

Select SUM(new_cases) as total_cases, SUM(convert(new_deaths, signed)) as total_deaths, SUM(convert(new_deaths, signed))/SUM(new_cases)*100 as DeathPercentage
From CovidDeaths
where continent is not null 
order by 1,2;



-- Total Population vs Vaccinations
-- Shows Percentage of Population that has recieved at least one Covid Vaccine

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(vac.new_vaccinations, signed)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as TotalPeopleVaccinated
From CovidDeaths dea
Join CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
order by 2,3;


-- Using CTE to perform Calculation on Partition By in previous query

With PopulationvsVaccination (Continent, Location, Date, Population, New_Vaccinations, TotalPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(vac.new_vaccinations, signed)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as TotalPeopleVaccinated
From CovidDeaths dea
Join CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null)
Select *, (TotalPeopleVaccinated/Population)*100 as PercentageVaccinated
From PopulationvsVaccination;

-- Creating View to store data for later data exploration

Create View PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(vac.new_vaccinations, signed)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as TotalPeopleVaccinated
From CovidDeaths dea
Join CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null;

select * from PercentPopulationVaccinated;


