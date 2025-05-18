-- Query 6: Average heart rate by number of risk factors
-- Business Question: Does the number of risk factors correlate with increased heart rate?
-- This query first calculates how many risk factors each patient has.
-- It then joins this information with the heart rate data and averages heart rate for each risk factor count.
-- This enables identification of trends between multi-risk exposure and cardiovascular stress.
SELECT 
    risk_counts.num_risk_factors,  -- The total number of risk factors for each patient.
    ROUND(AVG(f.HeartRate), 2) AS avg_heart_rate  -- Averages the heart rate for patients sharing the same number of risk factors.
FROM (
    SELECT 
        dp.PatientKey,  -- Unique patient identifier.
        COUNT(bprf.RiskFactorKey) AS num_risk_factors  -- Counting the risk factors per patient.
    FROM BridgePatientRiskFactor bprf  -- Bridge table providing risk factors per patient.
    JOIN DimPatient dp ON bprf.PatientKey = dp.PatientKey  -- Joining to match risk factors with patient records.
    GROUP BY dp.PatientKey  -- Grouping by PatientKey to get the risk factor count for each patient.
) risk_counts
JOIN FactHeartAttackRisk f ON f.PatientKey = risk_counts.PatientKey  -- Joining the aggregated risk factor counts with heart rate data.
GROUP BY risk_counts.num_risk_factors  -- Grouping by the number of risk factors.
ORDER BY num_risk_factors DESC;  -- Ordering results for better interpretation.