/*
    data_migration.sql
    ------------------
    This script populates the physical database from a staging table. 
    The process includes:
    1. Inserting distinct values into lookup tables (e.g., Diet, Continent, Hemisphere).
    2. Establishing relationships between tables using JOINs.
    3. Inserting detailed patient, risk factor, health metrics, lifestyle, and medical history data.
    
    Note: The ON CONFLICT clauses ensure that duplicate entries (based on unique columns) are not inserted.
    This script assumes that the staging_table holds the raw data which is cleaned up as part of the data migration.
*/

/* ================================
   Step 1: Populate Diet Table
   -------------------------------
   Inserts unique diet types from the staging_table into the Diet table.
   The DISTINCT keyword ensures no duplicate diet values are inserted.
   ON CONFLICT DO NOTHING prevents errors if a diet type already exists.
*/
INSERT INTO Diet (diettype)
SELECT DISTINCT diet 
FROM staging_table
ON CONFLICT (diettype) DO NOTHING;

/* ================================
   Step 2: Populate Continent Table
   -------------------------------
   Inserts each unique continent from the staging_table into the Continent table.
   This helps to maintain a clean lookup for continent data and supports the foreign key relationship in the Country table.
*/
INSERT INTO Continent (continentname)
SELECT DISTINCT continent 
FROM staging_table
ON CONFLICT (continentname) DO NOTHING;

/* ================================
   Step 3: Populate Hemisphere Table
   -------------------------------
   Inserts each unique hemisphere value from the staging_table into the Hemisphere table.
   This table serves as a lookup for hemisphere data that will be referenced later in the Country table.
*/
INSERT INTO Hemisphere (hemispherename)
SELECT DISTINCT hemisphere 
FROM staging_table
ON CONFLICT (hemispherename) DO NOTHING;

/* ================================
   Step 4: Populate Country Table
   -------------------------------
   Inserts country data by joining the staging_table with the Continent and Hemisphere lookup tables.
   - The JOINs map each country's associated continent and hemisphere to their respective IDs.
   - ON CONFLICT ensures that if a country already exists, it isn’t duplicated.
*/
INSERT INTO Country (countryname, continentid, hemisphereid)
SELECT 
    st.country, 
    c.continentid, 
    h.hemisphereid
FROM staging_table st
JOIN Continent c ON st.continent = c.continentname
JOIN Hemisphere h ON st.hemisphere = h.hemispherename
ON CONFLICT (countryname) DO NOTHING;

/* ================================
   Step 5: Populate Patient Table
   -------------------------------
   Inserts patient records from the staging_table into the Patient table.
   This includes key patient details such as age, sex, stress level, income, country, and diet type.
   Note: The patientid is assumed to be provided by the staging table.
*/
INSERT INTO Patient (
    patientid, age, sex, stresslevel, income, countryname, diettype
)
SELECT 
    patient_id, 
    age, 
    sex, 
    stress_level, 
    income, 
    country, 
    diet
FROM staging_table;

/* ================================
   Step 6: Populate RiskFactor Table
   -------------------------------
   Manually inserts the distinct risk factors into the RiskFactor table.
   In this case, the risk factors 'Diabetes', 'Smoking', and 'Obesity' are added.
   These values will be used to create many-to-many relationships with patients.
*/
INSERT INTO RiskFactor (riskfactorname)
VALUES ('Diabetes'), ('Smoking'), ('Obesity');

/* ================================
   Step 7: Populate PatientRiskFactor Table (Many-to-Many Relationship)
   -------------------------------
   Maps patients to their risk factors based on flags in the staging_table.
   - The JOIN with RiskFactor uses conditional logic to determine which risk factor to assign.
   - For example, if the diabetes flag is 1, the corresponding Diabetes risk factor ID is inserted.
*/
INSERT INTO PatientRiskFactor (patientid, riskfactorid)
SELECT 
    st.patient_id, 
    rf.riskfactorid
FROM staging_table st
JOIN RiskFactor rf ON 
    (st.diabetes = 1 AND rf.riskfactorname = 'Diabetes') OR
    (st.smoking = 1 AND rf.riskfactorname = 'Smoking') OR
    (st.obesity = 1 AND rf.riskfactorname = 'Obesity');

/* ================================
   Step 8: Populate HealthMetrics Table
   -------------------------------
   Inserts various health metrics for each patient.
   - The blood pressure is stored in a combined format (e.g., '120/80') and is split into systolic and diastolic values.
   - SPLIT_PART is used to separate these values and then cast to INT for proper storage.
*/
INSERT INTO HealthMetrics (
    patientid, cholesterol, systolicbp, diastolicbp, heartrate, bmi, triglycerides
)
SELECT 
    patient_id, 
    cholesterol, 
    SPLIT_PART(blood_pressure, '/', 1)::INT AS systolicbp,
    SPLIT_PART(blood_pressure, '/', 2)::INT AS diastolicbp,
    heart_rate, 
    bmi, 
    triglycerides
FROM staging_table;

/* ================================
   Step 9: Populate Lifestyle Table
   -------------------------------
   Inserts lifestyle-related data for each patient.
   This includes exercise habits, sedentary behavior, physical activity frequency, and sleep duration.
*/
INSERT INTO Lifestyle (
    patientid, exercisehoursperweek, sedentaryhoursperday, 
    physicalactivitydaysperweek, sleephoursperday
)
SELECT 
    patient_id, 
    exercise_hours_per_week, 
    sedentary_hours_per_day, 
    physical_activity_days_per_week, 
    sleep_hours_per_day
FROM staging_table;

/* ================================
   Step 10: Populate MedicalHistory Table
   -------------------------------
   Inserts historical medical information for each patient.
   - The query converts textual or numerical indicators into BOOLEAN values for fields such as previous heart problems,
     medication use, and heart attack risk.
*/
INSERT INTO MedicalHistory (
    patientid, previousheartproblems, medicationuse, heartattackrisk
)
SELECT 
    patient_id, 
    previous_heart_problems::BOOLEAN, 
    medication_use::BOOLEAN, 
    heart_attack_risk::BOOLEAN
FROM staging_table;
