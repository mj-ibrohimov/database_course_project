-- Query 9: Patients with Multiple Risk Factors
-- Business Question: Which patients have the highest number of risk factors?
-- This query identifies the top 10 patients with the most associated risk factors.
-- It provides insight into individuals with complex health profiles that may require
-- targeted interventions or additional care.

SELECT 
    dp.PatientID,  
    -- Retrieves the patient’s unique ID (a business-friendly identifier).

    COUNT(bprf.RiskFactorKey) AS risk_factor_count  
    -- Counts how many distinct risk factors are linked to each patient.
    -- This is done using the bridge table that connects patients and risk factors
    -- in a many-to-many relationship.

FROM BridgePatientRiskFactor bprf  
-- Bridge table resolving the many-to-many relationship between patients and risk factors.

JOIN DimPatient dp ON dp.PatientKey = bprf.PatientKey  
-- Joins the bridge table with the patient dimension to retrieve the PatientID.

GROUP BY dp.PatientID  
-- Groups records by PatientID to aggregate the number of risk factors per patient.

ORDER BY risk_factor_count DESC  
-- Sorts the result in descending order to show patients with the most risk factors first.

LIMIT 10;  
-- Limits the output to the top 10 patients for clear visualization in a bar chart or table.
