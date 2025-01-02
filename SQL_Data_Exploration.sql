--select * 
--from CovidDeaths
--order by 3,4

select * 
from CovidVaccinations
order by 3,4

-- Select Data that we are going to be using
select Location, date, total_cases, new_cases, total_deaths, population
from CovidDeaths
order by 1,2


-- Looking at Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in your country
select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as Death_percentage
from CovidDeaths
where location ='India'
order by 1,2


--Total cases vs Population
-- shows that percentage of population get covid
select Location, date, total_cases, population, (total_deaths/population)*100 as PercentPopulation
from CovidDeaths
--where location ='India'
order by 1,2

-- Looking at countries with highest infection rate compared to population
select Location,population, max(total_cases) as HighestInfectionCount, max(total_cases/population)*100 as PercentPopulationInfected
from CovidDeaths
--where location ='India'
group by Location,population
order by PercentPopulationInfected desc


-- showing the countries with highest death count per population
select Location, max(cast(total_deaths as int)) TotalDeathCount
from CovidDeaths
--where location ='India'
where continent is not null
group by Location
order by TotalDeathCount desc



-- let's break things down by continent
select location, max(cast(total_deaths as int)) TotalDeathCount
from CovidDeaths
--where location ='India'
where continent is null
group by location
order by TotalDeathCount desc


-- showing the continents with highest death count per population
select continent, max(cast(total_deaths as int)) TotalDeathCount
from CovidDeaths
--where location ='India'
where continent is not null
group by continent
order by TotalDeathCount desc


-- Global numbers
select sum(new_cases) as TotalNewCases, sum(cast(new_deaths as int)) as TotalNewDeaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as Death_percentage
from CovidDeaths
--where location ='India'
where continent is not null

order by 1,2


--------------------------------------------------------------------------------------

select * 
from CovidDeaths as d
join CovidVaccinations as v
on d.location=v.location
and d.date=v.date


--looking at Total population vs Vaccinations
select d.continent, d.location, d.date ,d.population, v.new_vaccinations
, sum(convert(int,v.new_vaccinations)) over (partition by d.location 
order by d.location, d.date) as RollingPeopleVaccinated
from CovidDeaths as d
join CovidVaccinations as v
on d.location=v.location
and d.date=v.date
where d.continent is not null --and d.location='India'
order by 2,3


-- use CTE
with PopVac(continent, location, date, population, new_vaccinations, RollingPeopleVaccinated)
as(
select d.continent, d.location, d.date ,d.population, v.new_vaccinations
, sum(convert(int,v.new_vaccinations)) over (partition by d.location 
order by d.location, d.date) as RollingPeopleVaccinated
from CovidDeaths as d
join CovidVaccinations as v
on d.location=v.location
and d.date=v.date
where d.continent is not null --and d.location='India'
--order by 2,3
)
select * ,(RollingPeopleVaccinated/population)*100 as RollingPeopleVaccinatedPercentage
from PopVac



--use TEMP Table
Drop table if exists #PercentPepVac
create table #PercentPepVac
(
continent nvarchar(255), 
location nvarchar(255), 
date datetime, 
population numeric,
new_vaccinations numeric, 
RollingPeopleVaccinated numeric
)

insert into #PercentPepVac
select d.continent, d.location, d.date ,d.population, v.new_vaccinations
, sum(convert(int,v.new_vaccinations)) over (partition by d.location 
order by d.location, d.date) as RollingPeopleVaccinated
from CovidDeaths as d
join CovidVaccinations as v
on d.location=v.location
and d.date=v.date
--where d.continent is not null --and d.location='India'
--order by 2,3

select * ,(RollingPeopleVaccinated/population)*100 as RollingPeopleVaccinatedPercentage
from #PercentPepVac



-- creating view to stre data for later visualization
create view PercPepVac as
select d.continent, d.location, d.date ,d.population, v.new_vaccinations
, sum(convert(int,v.new_vaccinations)) over (partition by d.location 
order by d.location, d.date) as RollingPeopleVaccinated
from CovidDeaths as d
join CovidVaccinations as v
on d.location=v.location
and d.date=v.date
where d.continent is not null --and d.location='India'
--order by 2,3

select * from PercPepVac