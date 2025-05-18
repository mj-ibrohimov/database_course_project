-- Query 3: Average cholesterol by stress level and gender
-- Business Question: How does stress level and gender affect average cholesterol levels?
-- This query groups patients based on their gender and stress level, then computes the average cholesterol.
-- This helps understand the potential correlation between psychological factors and cholesterol.
SELECT 
    dp.Sex,  -- Retrieves patient's sex (Male/Female) from the DimPatient table.
    dp.StressLevel,  -- Retrieves the stress level recorded for each patient.
    ROUND(AVG(f.Cholesterol), 1) AS avg_cholesterol  -- Calculates the average cholesterol value, rounding to 1 decimal place.
FROM FactHeartAttackRisk f  -- Fact table with cholesterol measurements.
JOIN DimPatient dp ON f.PatientKey = dp.PatientKey  -- Joins to include demographic details of patients.
GROUP BY dp.Sex, dp.StressLevel  -- Groups by both gender and stress level for aggregated cholesterol values.
ORDER BY dp.Sex, dp.StressLevel;  -- Orders the result by sex and then stress level.