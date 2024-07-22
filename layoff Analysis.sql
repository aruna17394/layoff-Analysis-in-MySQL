SELECT *
FROM layoffs_staging2;


SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off  = 1
ORDER BY funds_raised_millions DESC;

SELECT Company,SUM(total_laid_off)
FROM  layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;




SELECT industry,SUM(total_laid_off)
FROM  layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;


SELECT country,SUM(total_laid_off)
FROM  layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

SELECT MIN(`date`),MAX(`date`)
FROM  layoffs_staging2;


SELECT SUBSTRING(`date`,1,7) AS `month`,SUM(total_laid_off)
FROM  layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `month`
ORDER BY 1 ASC;


WITH Rolling_Total AS
(SELECT SUBSTRING(`date`,1,7) AS `month`,SUM(total_laid_off) AS total_off
FROM  layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `month`
ORDER BY 1 ASC)
SELECT  `month`,total_off,SUM(total_off) OVER(ORDER BY  `month`) AS rolling_total
FROM rolling_total;


SELECT Company,YEAR(`date`),SUM(total_laid_off)
FROM  layoffs_staging2
GROUP BY company,YEAR(`date`)
ORDER BY 3 DESC;


WITH company_Year(company,years,total_laid_off)AS
(SELECT Company,YEAR(`date`),SUM(total_laid_off)
FROM  layoffs_staging2
GROUP BY company,YEAR(`date`)
),company_Year_Rank AS(
SELECT *,
DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC)AS RANKING
FROM company_Year
WHERE years IS NOT NULL)
SELECT *
FROM company_Year_Rank
WHERE Ranking<= 5
;










