-- =====================================================
-- DEBUG EXPENSES TABLE STRUCTURE
-- =====================================================
-- Run this first to see what columns exist

-- Check all columns in expenses table
SELECT 
    column_name, 
    data_type, 
    is_nullable,
    column_default
FROM information_schema.columns
WHERE table_name = 'expenses' AND table_schema = 'public'
ORDER BY ordinal_position;

-- Check if table exists and what data is in it
SELECT COUNT(*) as row_count FROM expenses;

-- Show sample data if any
SELECT * FROM expenses LIMIT 5;
