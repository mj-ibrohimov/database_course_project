-- Query 7: Heart attack risk rank by BMI range
-- Business Question: Is there a BMI range that is more prone to heart attacks?
-- This query categorizes patients into BMI ranges and calculates the average risk (converted to 1/0).
-- The RANK() function is then used to order these BMI categories by average risk.
SELECT 
    CASE 
        WHEN BMI < 18.5 THEN 'Underweight'  -- Categorizes BMI below 18.5 as Underweight.
        WHEN BMI < 25 THEN 'Normal'         -- Categorizes BMI between 18.5 and 24.9 as Normal.
        WHEN BMI < 30 THEN 'Overweight'     -- Categorizes BMI between 25 and 29.9 as Overweight.
        ELSE 'Obese'                        -- Categorizes BMI of 30 and above as Obese.
    END AS bmi_category,  -- The BMI category label.
    ROUND(AVG(CASE WHEN f.HeartAttackRisk THEN 1 ELSE 0 END), 2) AS risk_rate,  -- Calculates average risk per BMI category.
    RANK() OVER (ORDER BY AVG(CASE WHEN f.HeartAttackRisk THEN 1 ELSE 0 END) DESC) AS risk_rank  -- Ranks categories by descending average risk.
FROM FactHeartAttackRisk f  -- Fact table with heart attack risk information.
GROUP BY bmi_category;  -- Groups records by computed BMI category.
