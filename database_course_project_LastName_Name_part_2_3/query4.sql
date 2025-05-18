-- Query 4 (Replaced): Rank countries by the percentage of patients with 2+ risk factors
-- Business Question: Which countries have the highest percentage of patients with multiple risk factors?
-- This query first calculates the count of risk factors for each patient.
-- The subquery 'risk_summary' aggregates risk factor counts per patient.
-- Then, by joining with country data, it calculates the percentage of patients in each country
-- that have two or more risk factors, and ranks the countries using RANK().
SELECT 
    dc.CountryName,  -- Retrieves the country name for grouping.
    ROUND(100.0 * COUNT(CASE WHEN risk_count >= 2 THEN 1 END) / COUNT(*), 2) AS percent_multi_risk,  -- Computes the percentage of patients with 2+ risk factors.
    RANK() OVER (ORDER BY ROUND(100.0 * COUNT(CASE WHEN risk_count >= 2 THEN 1 END) / COUNT(*), 2) DESC) AS country_rank  -- Ranks the countries by the calculated percentage.
FROM (
    SELECT 
        dp.PatientKey,  -- Unique identifier for each patient.
        COUNT(bprf.RiskFactorKey) AS risk_count  -- Counts the number of risk factors per patient.
    FROM BridgePatientRiskFactor bprf  -- Bridge table resolving many-to-many relationship.
    JOIN DimPatient dp ON bprf.PatientKey = dp.PatientKey  -- Joining with DimPatient to get patient details.
    GROUP BY dp.PatientKey  -- Grouping by patient to compute risk factor count.
) risk_summary
JOIN DimPatient dp ON risk_summary.PatientKey = dp.PatientKey  -- Join back to get patient details for risk distribution.
JOIN FactHeartAttackRisk f ON f.PatientKey = dp.PatientKey  -- Join fact table to link risk data.
JOIN DimCountry dc ON f.CountryKey = dc.CountryKey  -- Join with country dimension for geographic context.
GROUP BY dc.CountryName;  -- Group the final results by country.