-- Query 5 (Replaced): Top 5 countries with highest average cholesterol
-- Business Question: Which countries have the highest average cholesterol levels?
-- This query aggregates cholesterol values per country, facilitating comparisons of regional cholesterol burdens.
-- The result is limited to top 5 countries for clear visualization.
SELECT 
    dc.CountryName,  -- Retrieves country name from DimCountry.
    ROUND(AVG(f.Cholesterol), 1) AS avg_cholesterol  -- Calculates the average cholesterol per country.
FROM FactHeartAttackRisk f  -- Fact table containing cholesterol values.
JOIN DimCountry dc ON f.CountryKey = dc.CountryKey  -- Joins to bring in country-level information.
GROUP BY dc.CountryName  -- Aggregates cholesterol by country.
ORDER BY avg_cholesterol DESC  -- Orders by highest average cholesterol.
