/*
    data_migration.sql
    -------------------
    Author: [Muhammadjon Ibrohimov]
    Course Project Part B2: Star Schema Data Population

    This script populates the star schema tables from the staging table.
    Each section includes explanatory comments to show understanding.
*/

------------------------------------
-- 1. Populating DimPatient
------------------------------------
-- Using DISTINCT to avoid duplicate patient records.
-- Only selecting relevant columns for patient dimension.
-- ON CONFLICT ensures duplicate PatientID doesn't break the insert.
INSERT INTO DimPatient (PatientID, Age, Sex, StressLevel, Income)
SELECT DISTINCT
    st.patient_id,       -- e.g., 'BMW7812'
    st.age,
    st.sex,
    st.stress_level,     -- from the dataset
    st.income
FROM staging_table st
WHERE st.patient_id IS NOT NULL
  AND st.patient_id <> ''
ON CONFLICT (PatientID) DO NOTHING;

------------------------------------
-- 2. Populating DimCountry
------------------------------------
-- Country is a separate dimension to allow future geographic analysis.
-- Removing null and empty entries.
INSERT INTO DimCountry (CountryName, Continent, Hemisphere)
SELECT DISTINCT
    st.country,
    st.continent,
    st.hemisphere
FROM staging_table st
WHERE st.country IS NOT NULL
  AND st.country <> ''
ON CONFLICT (CountryName) DO NOTHING;

------------------------------------
-- 3. Populating DimDiet
------------------------------------
-- Only known/valid diet types are inserted.
-- ON CONFLICT avoids duplicates on DietType.
INSERT INTO DimDiet (DietType)
SELECT DISTINCT
    st.diet
FROM staging_table st
WHERE st.diet IS NOT NULL
  AND st.diet IN ('Healthy','Average','Unhealthy')
ON CONFLICT (DietType) DO NOTHING;

------------------------------------
-- 4. Populating DimRiskFactor
------------------------------------
-- We manually insert known risk factors based on flags in dataset.
-- This dimension will be used in a bridge table.
INSERT INTO DimRiskFactor (RiskFactorName)
VALUES ('Diabetes'), ('Smoking'), ('Obesity')
ON CONFLICT (RiskFactorName) DO NOTHING;

------------------------------------
-- 5. Populating FactHeartAttackRisk
------------------------------------
-- This fact table links dimension tables via surrogate keys.
-- We use JOINs on natural keys to find those surrogate keys.
-- Blood pressure is split into systolic and diastolic parts.
-- Heart attack risk is converted to boolean logic.
INSERT INTO FactHeartAttackRisk (
    PatientKey, CountryKey, DietKey,
    Cholesterol, SystolicBP, DiastolicBP, HeartRate, BMI, Triglycerides, HeartAttackRisk
)
SELECT
    dp.PatientKey,
    dc.CountryKey,
    dd.DietKey,
    st.cholesterol,
    split_part(st.blood_pressure, '/', 1)::INT AS SystolicBP,
    split_part(st.blood_pressure, '/', 2)::INT AS DiastolicBP,
    st.heart_rate::INT,
    st.bmi,
    st.triglycerides,
    CASE WHEN st.heart_attack_risk = 1 THEN TRUE ELSE FALSE END
FROM staging_table st
-- Joining to dimension tables to retrieve foreign (surrogate) keys
JOIN DimPatient dp ON dp.PatientID = st.patient_id
JOIN DimCountry dc ON dc.CountryName = st.country
JOIN DimDiet dd ON dd.DietType = st.diet;

------------------------------------
-- 6. Populating BridgePatientRiskFactor
------------------------------------
-- This handles the many-to-many relationship between patients and risk factors.
-- We use multiple OR conditions to insert one row per valid risk factor.
INSERT INTO BridgePatientRiskFactor (PatientKey, RiskFactorKey)
SELECT
    dp.PatientKey,
    drf.RiskFactorKey
FROM staging_table st
JOIN DimPatient dp ON dp.PatientID = st.patient_id
JOIN DimRiskFactor drf ON 
    (st.diabetes = 1 AND drf.RiskFactorName = 'Diabetes')
 OR (st.smoking = 1 AND drf.RiskFactorName = 'Smoking')
 OR (st.obesity = 1 AND drf.RiskFactorName = 'Obesity');
