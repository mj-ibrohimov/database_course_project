-- Query 8: Count of Heart Attack Risk Cases by Continent
-- Business Question: How is heart attack risk distributed across continents?
-- This query calculates the number and percentage of patients flagged as high risk
-- for heart attacks within each continent. It provides insight into geographic
-- health trends and helps identify regions with elevated cardiovascular risk.

SELECT 
    dc.Continent,  -- Retrieves the name of the continent from the country dimension.

    COUNT(*) FILTER (WHERE fh.HeartAttackRisk = TRUE) AS high_risk_patients,  
    -- Counts only those patients marked as high risk for heart attack.
    -- FILTER clause ensures that only records with HeartAttackRisk = TRUE are counted.

    COUNT(*) AS total_patients,  
    -- Counts the total number of patients (both high and low risk) in each continent.

    ROUND(100.0 * COUNT(*) FILTER (WHERE fh.HeartAttackRisk = TRUE) / COUNT(*), 2) AS risk_percentage  
    -- Calculates the percentage of high-risk patients by dividing the count of high-risk
    -- by total patients and multiplying by 100.
    -- ROUND is used to format the result to 2 decimal places for readability.

FROM FactHeartAttackRisk fh  -- Fact table containing patient-level heart attack risk data.

JOIN DimCountry dc ON fh.CountryKey = dc.CountryKey  
-- Joins the fact table with the country dimension to access continent information.

GROUP BY dc.Continent  
-- Groups the results by continent to aggregate the counts and calculate risk per region.

ORDER BY risk_percentage DESC;  
-- Sorts the output so that continents with the highest risk percentage appear first.
