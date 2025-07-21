-- =====================================================
-- CREATE EXPENSES TABLE
-- =====================================================
-- Run this in Supabase SQL Editor to fix the expenses error

-- 1. Create expenses table
CREATE TABLE IF NOT EXISTS expenses (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    amount INTEGER NOT NULL,
    description TEXT,
    expense_type VARCHAR(50) DEFAULT 'other',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. Enable RLS (Row Level Security)
ALTER TABLE expenses ENABLE ROW LEVEL SECURITY;

-- 3. Create policy for public access
CREATE POLICY "Allow all operations" ON expenses FOR ALL USING (true);

-- 4. Insert default expense data
INSERT INTO expenses (title, amount, description, expense_type) VALUES
('Thuê sân', 200000, 'Chi phí thuê sân pickleball', 'court_fee'),
('Nước uống', 50000, 'Nước uống cho các thành viên', 'other'),
('Bóng pickleball', 150000, 'Mua bóng pickleball mới', 'equipment'),
('Vợt dự phòng', 300000, 'Vợt dự phòng cho người mới', 'equipment');

-- 5. Verify the data
SELECT * FROM expenses ORDER BY expense_type, title;
