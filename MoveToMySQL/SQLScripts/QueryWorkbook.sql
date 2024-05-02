
select count(*) as 'Number of Duplicate Defendants' from(
SELECT `Plaintiff Name`, COUNT(*) AS `Occurrences`
FROM website_lawsuits_compiled_2
GROUP BY `Plaintiff Name`
HAVING COUNT(*) > 1) duplicate_defendant;

select count(*),`Plaintiff Name`
from website_lawsuits_compiled_2
where `Plaintiff Name` like "%Perla%"
group by `Plaintiff Name`;

SELECT YEAR(Date_of_Filing) AS Lawsuit_Year, COUNT(*) AS Total_Lawsuits
FROM lawsuits
GROUP BY YEAR(Date_of_Filing);

SELECT `State of Filing`, count(*) as ‘Total’ 
FROM Website_Lawsuits
GROUP BY `State of Filing`
ORDER BY count(*) desc;



SELECT DISTINCT RIGHT(`Date of Filing`, 4) AS `Filing_Year`
FROM website_lawsuits_compiled;

select `Plaintiff Name`, count(*) as 'Count of lawsuits for plaintiff', RIGHT(`Date of Filing`, 4) AS `Filing_Year` from 
website_lawsuits_compiled
group by `Plaintiff Name`, `Filing_Year`
order by count(*) desc;


select `State of Filing`, count(*) as 'Count of lawsuits for state', RIGHT(`Date of Filing`, 4) AS `Filing_Year` from 
website_lawsuits_compiled
group by `State of Filing`, `Filing_Year`
order by count(*) desc;


select `Industry`, `Website` , RIGHT(`Date of Filing`, 4) AS `Filing_Year`
from website_lawsuits_compiled
where `Industry`="Consumer Goods" and  website in (
select `Website` from website_lawsuits_compiled
where `Industry`="Consumer Durables & Apparel");


select count(*) from website_lawsuits_compiled
where `Industry`="Consumer Goods";

select `Website` from website_lawsuits_compiled
where `Industry`="Retailing";


select `Industry`, count(*) as 'count'
from website_lawsuits_compiled
group by `Industry`
order by count(*) desc;

select `Industry`, count(*) as 'Count of Industry Lawsuits', RIGHT(`Date of Filing`, 4) AS `Filing_Year` from 
website_lawsuits_compiled
where `Industry` in ("Consumer Durables & Apparel","Consumer Goods", "Consumer Discretionary", "Consumer Staples", "Retailing")
group by `Industry`, `Filing_Year`
order by count(*) desc;


SELECT 
    CASE 
        WHEN `Industry` LIKE 'Consumer%' THEN 'Consumer Goods/ Retail'
        WHEN `Industry` LIKE '%Beauty%' THEN 'Consumer Goods/ Retail'
        WHEN `Industry` LIKE '%Pet Products%' THEN 'Consumer Goods/ Retail'
        WHEN `Industry` LIKE 'Retailing' then 'Consumer Goods/ Retail'
        WHEN `Industry` LIKE '%Leisure Products%' THEN 'Consumer Goods/ Retail'
        WHEN `Industry` LIKE '%Household & Personal Products%' THEN 'Consumer Goods/ Retail'
        WHEN `Industry` Like '%Tobacco%' Or `Industry` like '%Food%' or `Industry` like '%Beverage%' THEN 'Food, Beverage, & Tobacco'
        WHEN `Industry` LIKE 'Medical' then 'Health Care Equipment & Services'
        when `Industry` Like '%Entertainment%' or `Industry` like '%Media%' then 'Media & Entertainment'
		When `Industry` like '%Professional Services%' then 'Commercial & Professional Services'
        When `Industry` like '%Automobile%' then 'Automobile/ Automobile Components'
        WHEN `Industry` like '%Pharmaceutical%' or `Industry` like '%Biotechnology%' then 'Pharmaceuticals, Biotechnology & Life Sciences'
        When `Industry` like '%Finance%' or `Industry` like '%Capital%' or `Industry` like '%Financial%' or `Industry` like '%bank%' then 'Finance'
        WHEN `Industry` like '%Construction%' or `Industry` like '%Material%' then 'Construction/Materials'
        when `Industry` like '%Software%' or `Industry` like '%Internet%' then 'Software/Internet Products and Services'
        when `Industry` like '%phone%' or `Industry` like '%Telecommunication%' or `Industry` like '%Communication%' or `Industry` like '%Technology%' then 'Telephone or Technology Services/Equipment'
        when `Industry` like '%Utility%' or `Industry` like 'Utilities' or `Industry` like '%Energy%'or `Industry` like '%Power%' then 'Utility Services and/or Equipment'
        when `Industry` like '%Airline%' or `Industry` like '%Transportation%' then 'Airline/Transportation Services'
        WHEN `Industry` like '%Services%' then 'Consumer Services'
        when `Industry` like '%None%' or `Industry` like 'N/A' then 'N/A'
        ELSE `Industry`
    END AS `Industry`,
    COUNT(*) AS 'count'
FROM 
    website_lawsuits_compiled
GROUP BY 
    CASE 
        WHEN `Industry` LIKE 'Consumer%' THEN 'Consumer Goods/ Retail'
        WHEN `Industry` LIKE '%Beauty%' THEN 'Consumer Goods/ Retail'
        WHEN `Industry` LIKE '%Pet Products%' THEN 'Consumer Goods/ Retail'
        WHEN `Industry` LIKE 'Retailing' then 'Consumer Goods/ Retail'
        WHEN `Industry` LIKE '%Leisure Products%' THEN 'Consumer Goods/ Retail'
        WHEN `Industry` LIKE '%Household & Personal Products%' THEN 'Consumer Goods/ Retail'
        WHEN `Industry` Like '%Tobacco%' Or `Industry` like '%Food%' or `Industry` like '%Beverage%' THEN 'Food, Beverage, & Tobacco'
        WHEN `Industry` LIKE 'Medical' then 'Health Care Equipment & Services'
        when `Industry` Like '%Entertainment%' or `Industry` like '%Media%' then 'Media & Entertainment'
		When `Industry` like '%Professional Services%' then 'Commercial & Professional Services'
        When `Industry` like '%Automobile%' then 'Automobile/ Automobile Components'
        WHEN `Industry` like '%Pharmaceutical%' or `Industry` like '%Biotechnology%' then 'Pharmaceuticals, Biotechnology & Life Sciences'
        When `Industry` like '%Finance%' or `Industry` like '%Capital%' or `Industry` like '%Financial%' or `Industry` like '%bank%' then 'Finance'
        WHEN `Industry` like '%Construction%' or `Industry` like '%Material%' then 'Construction/Materials'
        when `Industry` like '%Software%' or `Industry` like '%Internet%' then 'Software/Internet Products and Services'
        when `Industry` like '%phone%' or `Industry` like '%Telecommunication%' or `Industry` like '%Communication%' or `Industry` like '%Technology%' then 'Telephone or Technology Services/Equipment'
        when `Industry` like '%Utility%' or `Industry` like 'Utilities' or `Industry` like '%Energy%'or `Industry` like '%Power%' then 'Utility Services and/or Equipment'
        when `Industry` like '%Airline%' or `Industry` like '%Transportation%' then 'Airline/Transportation Services'
        WHEN `Industry` like '%Services%' then 'Consumer Services'
        when `Industry` like '%None%' or `Industry` like 'N/A' then 'N/A'
        ELSE `Industry`
    END 
ORDER BY 
    COUNT(*) DESC;








