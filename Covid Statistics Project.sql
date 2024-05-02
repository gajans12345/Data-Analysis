-- Below are Queries Used in a Data Analaysis Project

--Key Statistics for Europe, Number of Tests Conducted, Number of Vaccinations, NUmber of test units, number of boosters
SELECT continent, MAX(total_tests)[Total Tests], MAX(total_vaccinations)[Total Vaccinations], MAX(total_boosters)[Total Boosters], AVG(positive_rate)[Positive Rate]
FROM CovidVaccine
Where continent = 'Europe'
GROUP BY continent

-- Key Statistics for Europe(Total # of cases, # of total deaths, # total death rate
SELECT continent, MAX(total_cases)[Total  Cases], MAX(total_deaths)[Total Deaths], (sum(total_deaths)/sum(total_cases)) * 100[Total Death Rate]
FROM CovidDeaths
WHERE continent is not NULL and continent = 'Europe'
Group BY continent


-- Looking at total cases, total deaths and the ratio per country in europe(Map)
SELECT Location, SUM(total_cases), SUM(total_deaths), (SUM(total_deaths)/SUM(total_cases)) * 100 [Death to Case Ratio]
FROM CovidDeaths
Where continent is not null and continent = 'Europe'
GROUP BY Location
order by 1,2

-- Total case vs population. What % of the population got COVID
SELECT Continent, (MAX(total_cases)/MAX(population))*100[Population Cases Ratio]
FROM CovidDeaths
WHERE continent is not NULL
GROUP BY Continent
order by 1,2

-- ICU VS VS DEAD in terms of total hosp patients
SELECT
    YEAR(date),
    MAX(icu_patients) AS total_icu_patients,
    MAX(total_deaths) AS total_deaths
FROM
    CovidDeaths
GROUP BY 
    YEAR(date)


-- At the peak, what % of the country had COVID
SELECT Continent, MAX(total_cases)[Highest # of Cases], MAX((total_cases/population))*100[Infected]
FROM CovidDeaths
WHERE Continent is not NULL
GROUP BY Continent
order by Infected desc;

-- Shwoing Countries with highest death count per population
SELECT YEAR(Date), MAX((new_vaccinations/population))*100[PeakPercentofPopulationDead]
FROM CovidVaccine
GROUP BY YEAR(date)
order by YEAR(date) desc


-- Line Slide Chart for Covid Deaths in Continents
SELECT continent, MAX(total_deaths)[Total Deaths]
FROM CovidDeaths
GROUP BY continent

--Death to Case Ratio vs Date
SELECT YEAR(date) AS year, (MAX(total_deaths)/MAX(total_cases)) * 100 [Death Ratio]
FROM CovidDeaths
GROUP BY YEAR(date)

-- Join( new cases vs new vaccinations IN 2 years)
SELECT
    YEAR(d.date),
    MAX((v.new_vaccinations/d.population))*100[Vaccinated]
FROM
    CovidDeaths d
    JOIN
    CovidVaccine v ON v.Location = d.Location AND v.date = d.date
GROUP by YEAR(d.date)
order by YEAR(d.date)













