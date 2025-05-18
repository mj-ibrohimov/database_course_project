-- View: patient_analytics_view
-- Purpose: Aggregate patient data for analysis, excluding surrogate keys and duplicates.
-- Columns:
--   patient_id, age, sex, country, diet_type: Demographic info.
--   cholesterol, systolic_bp, diastolic_bp, bmi: Health metrics.
--   exercise_hours, sedentary_hours, sleep_hours: Lifestyle data.
--   risk_factors_count: Total risk factors (e.g., Diabetes, Smoking).
--   heart_attack_risk: Boolean flag from medical history.

CREATE OR REPLACE VIEW patient_analytics_view AS
SELECT 
    p.patientid AS patient_id,
    p.age,
    p.sex,
    c.countryname AS country,
    p.diettype AS diet_type,
    hm.cholesterol,
    hm.systolicbp AS systolic_bp,
    hm.diastolicbp AS diastolic_bp,
    hm.bmi,
    l.exercisehoursperweek AS exercise_hours,
    l.sedentaryhoursperday AS sedentary_hours,
    l.sleephoursperday AS sleep_hours,
    (SELECT COUNT(*) 
     FROM patientriskfactor prf 
     WHERE prf.patientid = p.patientid) AS risk_factors_count,
    mh.heartattackrisk AS heart_attack_risk
FROM 
    patient p
    LEFT JOIN healthmetrics hm ON p.patientid = hm.patientid
    LEFT JOIN lifestyle l ON p.patientid = l.patientid
    LEFT JOIN medicalhistory mh ON p.patientid = mh.patientid
    LEFT JOIN country c ON p.countryname = c.countryname
-- Exclude surrogate keys (e.g., continentid) and ensure no duplicates
WHERE 
    p.patientid IS NOT NULL
GROUP BY 
    p.patientid, p.age, p.sex, c.countryname, p.diettype, 
    hm.cholesterol, hm.systolicbp, hm.diastolicbp, hm.bmi, 
    l.exercisehoursperweek, l.sedentaryhoursperday, l.sleephoursperday, 
    mh.heartattackrisk;