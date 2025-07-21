-- =====================================================
-- CHECK EXPENSES COLUMNS SIMPLE
-- =====================================================

-- Method 1: Check columns without schema filter
SELECT 
    column_name, 
    data_type, 
    is_nullable,
    column_default
FROM information_schema.columns
WHERE table_name = 'expenses'
ORDER BY ordinal_position;

-- Method 2: Try to describe table structure differently
SELECT 
    attname as column_name,
    format_type(atttypid, atttypmod) as data_type,
    NOT attnotnull as is_nullable
FROM pg_attribute 
WHERE attrelid = 'expenses'::regclass 
AND attnum > 0 
AND NOT attisdropped
ORDER BY attnum;

-- Method 3: Simple insert test to see what columns are required
-- This will fail but show us the error with column names
-- INSERT INTO expenses DEFAULT VALUES;
