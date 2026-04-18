use world_layoffs;

select *
from clean_layoffs;

select max(total_laid_off) as max_total_layoffs,
	   max(percentage_laid_off) as max_percentage_layoffs
from clean_layoffs;

select sum(total_laid_off) as total_layoffs
from clean_layoffs;

select company ,sum(total_laid_off) as total_layoffs
from clean_layoffs
group by company 
order by total_layoffs desc
limit 10;
## "Top companies contributed the highest layoffs, indicating industry concentration"

select industry, sum(total_laid_off) as total_layoffs
from clean_layoffs
group by industry 
order by total_layoffs desc;

select country, sum(total_laid_off) as total_layoffs
from clean_layoffs
group by country 
order by total_layoffs desc;
## " Layoffs are concentrated in specific countries, reflecting economic impact."

select year(date) as year, sum(total_laid_off) as total_layoffs
from clean_layoffs
group by year(date)
order by 1;

select substring(date, 6,2) as month,
sum(total_laid_off) as total_layoffs
from clean_layoffs
group by month
order by 1;

select company, percentage_laid_off
from clean_layoffs
where percentage_laid_off = 1 
order by 1;
## " Some companies experienced complete shutdowns."

select company, funds_raised_millions, total_laid_off
from clean_layoffs
order by  funds_raised_millions
limit 10;

select stage, sum(total_laid_off) as total_layoffs
from clean_layoffs
group by stage
order by total_layoffs desc;

select * 
from (
		select company, year(date) as year, sum(total_laid_off) as total_layoffs,
        rank() over(partition by year(date) 
        order by sum(total_laid_off) desc) as rank_num
        from clean_layoffs
        group by company, year(date)
        ) t
        where rank_num <= 5;