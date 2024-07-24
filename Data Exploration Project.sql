-- Exploratory Data Analysis 

SELECT *
FROM layoffs_staging2;

SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT MIN(`date`), MAX(`date`)
FROM layoffs_staging2;

SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

SELECT *
FROM layoffs_staging2;

SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

SELECT YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 1 DESC;

SELECT stage, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;

SELECT company, SUM(percentage_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT company, AVG(percentage_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;



SELECT substring(`date`,6,2) AS `MONTH`, sum(total_laid_off)
FROM layoffs_staging2
group by `MONTH`
;

SELECT substring(`date`,1,7) AS `MONTH`, sum(total_laid_off)
FROM layoffs_staging2
group by `MONTH`
order by 1 asc
;


with Rolling_Total as 
(
SELECT substring(`date`,1,7) AS `MONTH`, sum(total_laid_off) as total_off
FROM layoffs_staging2
group by `MONTH`
order by 1 asc
)
select `MONTH`, total_off, sum(total_off) over(order by `MONTH`) as rolling_total
from Rolling_Total;


SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
order by 3 desc;

with Company_Year (company, years, total_laid_off) as
(
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
), company_year_rank as 
(select *, 
dense_rank() over (partition by years order by total_laid_off desc) as ranking
from Company_Year
)
select *
from company_year_rank
where ranking <= 5
;
