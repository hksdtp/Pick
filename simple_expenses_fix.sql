-- =====================================================
-- SIMPLE EXPENSES FIX - NO COMPLEX COMMANDS
-- =====================================================

-- Drop and recreate expenses table completely
DROP TABLE IF EXISTS expenses CASCADE;

-- Create expenses table with correct structure
CREATE TABLE expenses (
    id SERIAL PRIMARY KEY,
    expense_type VARCHAR(50) NOT NULL DEFAULT 'other',
    title VARCHAR(200) NOT NULL,
    amount BIGINT NOT NULL,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE expenses ENABLE ROW LEVEL SECURITY;

-- Create policy
CREATE POLICY "Allow all operations on expenses" ON expenses FOR ALL USING (true);

-- Insert default data with explicit IDs
INSERT INTO expenses (id, expense_type, title, amount, description) VALUES
(1, 'court_fee', 'Thuê Sân', 2000000, 'Sân Pickleball Incanto'),
(2, 'misc_fee', 'Chi Phí Phát Sinh', 500000, 'Bóng, nước uống, v.v.');

-- Verify
SELECT * FROM expenses ORDER BY expense_type;
