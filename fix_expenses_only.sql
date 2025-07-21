-- =====================================================
-- FIX EXPENSES TABLE STRUCTURE
-- =====================================================
-- First check what columns exist, then fix the structure

-- 1. Check what columns exist in expenses table
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'expenses';

-- 3. Add missing columns if they don't exist
ALTER TABLE expenses ADD COLUMN IF NOT EXISTS title VARCHAR(200);
ALTER TABLE expenses ADD COLUMN IF NOT EXISTS expense_type VARCHAR(50) DEFAULT 'other';
ALTER TABLE expenses ADD COLUMN IF NOT EXISTS description TEXT;

-- 4. Enable RLS for expenses (if not already enabled)
ALTER TABLE expenses ENABLE ROW LEVEL SECURITY;

-- 5. Create policy for expenses (drop first if exists)
DROP POLICY IF EXISTS "Allow all operations on expenses" ON expenses;
CREATE POLICY "Allow all operations on expenses" ON expenses FOR ALL USING (true);

-- 6. Check what columns actually exist first
SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_name = 'expenses'
ORDER BY ordinal_position;

-- 7. Clear existing data and insert fresh data with all required columns
DELETE FROM expenses;

-- Insert with expense_id (assuming it's required)
INSERT INTO expenses (expense_id, expense_type, title, amount, description) VALUES
(1, 'court_fee', 'Thuê Sân', 2000000, 'Sân Pickleball Incanto'),
(2, 'misc_fee', 'Chi Phí Phát Sinh', 500000, 'Bóng, nước uống, v.v.');

-- 7. Verify expenses table
SELECT * FROM expenses ORDER BY expense_type;

-- 8. Check if penalties table exists and has data
SELECT
    COUNT(*) as total_penalties,
    SUM(amount) as total_penalty_amount
FROM penalties;

-- 9. Check fund status
SELECT * FROM fund_status;
