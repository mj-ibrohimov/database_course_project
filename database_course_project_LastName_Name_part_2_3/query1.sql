-- Query 1: Top 5 countries with highest average heart attack risk
-- Business Question: Which countries exhibit the highest average risk of heart attack, and how do they compare?
-- This query aggregates patient risk on a country level, calculating the average risk for each country.
-- The CASE expression converts the boolean HeartAttackRisk flag into 1 (true) or 0 (false) for averaging.
-- GROUP BY ensures that the average is computed per country.
-- ORDER BY sorts the results in descending order, and LIMIT 5 returns the top five countries.
SELECT 
    dc.CountryName,  -- Retrieves the country name from the DimCountry table.
    ROUND(AVG(CASE WHEN f.HeartAttackRisk THEN 1 ELSE 0 END), 2) AS avg_risk  -- Calculates the average risk; true values treated as 1.
FROM FactHeartAttackRisk f  -- Fact table containing heart attack risk data.
JOIN DimCountry dc ON f.CountryKey = dc.CountryKey  -- Join on the foreign key to get country details.
GROUP BY dc.CountryName  -- Aggregates the result by each country.
ORDER BY avg_risk DESC  -- Orders the results from highest to lowest average risk.
LIMIT 5;  -- Limits the output to the top 5 results for visualization.
