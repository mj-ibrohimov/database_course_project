-- Function: update_patient_column
-- Purpose: Dynamically updating a specified column for a patient by patient_id.
-- Parameters:
--   p_patient_id: The primary key of the patient (VARCHAR).
--   p_column_name: The name of the column to update (VARCHAR).
--   p_new_value: The new value to set (TEXT, converted to appropriate type).
-- Security: SECURITY DEFINER to ensure controlled access.
-- Returns: VOID

CREATE OR REPLACE FUNCTION update_patient_column(
    p_patient_id VARCHAR(10),
    p_column_name VARCHAR(50),
    p_new_value TEXT
) 
RETURNS VOID AS $$
DECLARE
    v_column_exists BOOLEAN;
BEGIN
    -- Step 1: Validate that the column exists in the patient table
    SELECT EXISTS (
        SELECT 1 
        FROM information_schema.columns 
        WHERE table_name = 'patient' 
        AND column_name = p_column_name
    ) INTO v_column_exists;

    -- Step 2: Raise an error if the column does not exist
    IF NOT v_column_exists THEN
        RAISE EXCEPTION 'Column "%" does not exist in the patient table.', p_column_name;
    END IF;

    -- Step 3: Dynamically build and execute the update query
    EXECUTE format(
        'UPDATE patient 
        SET %I = $1 
        WHERE patientid = $2', 
        p_column_name
    ) 
    USING p_new_value::text, p_patient_id;

    -- Step 4: Handle exceptions (e.g., invalid data type)
    EXCEPTION 
        WHEN invalid_text_representation THEN
            RAISE EXCEPTION 'Invalid data type for column "%".', p_column_name;
        WHEN others THEN
            RAISE;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;