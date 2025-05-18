-- Query 2: Ranking of diet types by average BMI
-- Business Question: Which diets are associated with higher or lower body mass index (BMI)?
-- This query calculates the average BMI for each diet type.
-- RANK() OVER(...) assigns a rank based on average BMI in descending order.
-- GROUP BY groups the records by diet type from the DimDiet table.
SELECT 
    dd.DietType,  -- Retrieves the diet type (e.g., Healthy, Average, Unhealthy).
    ROUND(AVG(f.BMI), 2) AS avg_bmi,  -- Calculates the average BMI for each diet type.
    RANK() OVER (ORDER BY AVG(f.BMI) DESC) AS diet_rank  -- Uses RANK() to order diet types by average BMI.
FROM FactHeartAttackRisk f  -- Fact table for health metrics.
JOIN DimDiet dd ON f.DietKey = dd.DietKey  -- Join on diet dimension to classify BMI by diet type.
GROUP BY dd.DietType;  -- Groups the result per diet type.
