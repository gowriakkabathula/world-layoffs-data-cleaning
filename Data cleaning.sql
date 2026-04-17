#Project: World Layoffs Data Cleaning
#--Description;
#--This project focuses on cleaning raw layoffs data by
#--1.Checking Duplicates
#--2.Removing Duplicates
#--3.Standardizing text fields
#--4.Handling inconsistent date formats
#--5.Managing missing Values
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

use world_layoffs;

select *
from layoffs;

rename table layoffs to raw_layoffs;

create table layoffs_staging 
like raw_layoffs;

insert layoffs_staging 
select * 
from raw_layoffs;

select *
from layoffs_staging;

    ---------------------------------------------------------------------------------
---      DATA CLEANING PROJECT : WORLD LAYOFFS
	---------------------------------------------------------------------------------
---  1.Checking duplicates   
---  2.Removing Duplicates
---  3.Standardize Data
---  4.Handling Missing Values

select *,
row_number() over(
partition by company,location,industry,total_laid_off,percentage_laid_off,date
        ) as row_nums
from layoffs_staging;

with duplicate_cte as
(
select *,
row_number() over(
partition by company,location,industry,total_laid_off,percentage_laid_off,stage,country,funds_raised_millions,date
        ) as row_nums
from layoffs_staging
)
select * 
from duplicate_cte
where row_nums > 1;

#--2.Removing Duplicates

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
  `row_nums` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select *
from layoffs_staging2;

insert into layoffs_staging2
select *,
row_number() over(
partition by company,location,industry,total_laid_off,percentage_laid_off,stage,country,funds_raised_millions,date
        ) as row_nums
from layoffs_staging;

select *
from layoffs_staging2
where row_nums > 1;

delete 
from layoffs_staging2
where row_nums > 1;

#--3.Standardizing data

select company
from layoffs_staging2;

update layoffs_staging2
set company = trim(company);

select *
from layoffs_staging2
where industry like 'crypto%';

update layoffs_staging2
set industry ='Crypto'
where industry like 'Crypto%';

select distinct industry
from layoffs_staging2;

select distinct country
from layoffs_staging2
order by 1;

select distinct country, trim(trailing '.' from country)
from layoffs_staging2
order by 1;

update layoffs_staging2
set country = trim(trailing '.' from country)
where country like 'United States%';


select * 
from layoffs_staging 
where country like 'United States';

select date 
from layoffs_staging2;

update layoffs_staging2
set date = case
	when date like '%/%' then str_to_date(date , '%m/%d/%Y')
	when date like '%-%' then str_to_date(date , '%m-%d-%Y')
else null
end;

alter table layoffs_staging2
modify column date DATE;



select *
from layoffs_staging2;

update layoffs_staging2
set industry = null
where industry = '';

select industry
from layoffs_staging2
where industry is null;

select * 
from layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company = t2.company
    and t1.location = t2.location
where t1.industry is null 
and t2.industry is not null;

update layoffs_staging2 t1 
join layoffs_staging2 t2
	on t1.company = t2.company 
set t1.industry = t2.industry 
where t1.industry is null
and t2.industry is not null;

select *
from layoffs_staging2
where percentage_laid_off = '';

update layoffs_staging2 
set percentage_laid_off = null
where percentage_laid_off = '';

select *
from layoffs_staging2
where percentage_laid_off is null;

delete 
from  layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

select *
from layoffs_staging2;

create table clean_layoffs as
select *
from layoffs_staging2;

select *
from clean_layoffs;
