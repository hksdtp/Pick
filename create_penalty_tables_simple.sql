-- =====================================================
-- SIMPLE PENALTY SYSTEM SETUP
-- =====================================================
-- Run this in Supabase SQL Editor

-- 1. Create penalties table
CREATE TABLE IF NOT EXISTS penalties (
    id SERIAL PRIMARY KEY,
    player_id INTEGER NOT NULL,
    player_name VARCHAR(100) NOT NULL,
    match_id BIGINT NOT NULL,
    amount INTEGER DEFAULT 50000,
    is_paid BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    paid_at TIMESTAMP WITH TIME ZONE NULL
);

-- 2. Create fund_status table
CREATE TABLE IF NOT EXISTS fund_status (
    id SERIAL PRIMARY KEY,
    current_amount BIGINT DEFAULT 2000000,
    target_amount BIGINT DEFAULT 5000000,
    reward_description TEXT DEFAULT 'Đi ăn Lẩu Hải sản',
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 3. Insert initial fund status
INSERT INTO fund_status (current_amount, target_amount, reward_description) 
SELECT 2000000, 5000000, 'Đi ăn Lẩu Hải sản'
WHERE NOT EXISTS (SELECT 1 FROM fund_status);

-- 4. Enable RLS (Row Level Security)
ALTER TABLE penalties ENABLE ROW LEVEL SECURITY;
ALTER TABLE fund_status ENABLE ROW LEVEL SECURITY;

-- 5. Create policies for public access (adjust as needed)
CREATE POLICY "Allow all operations" ON penalties FOR ALL USING (true);
CREATE POLICY "Allow all operations" ON fund_status FOR ALL USING (true);

-- 6. Insert previous match penalty data
INSERT INTO penalties (player_id, player_name, match_id, amount, is_paid, created_at) VALUES
-- Ninh: 150K (3 penalties)
(1, 'Ninh', 1, 50000, false, NOW() - INTERVAL '1 day'),
(1, 'Ninh', 1, 50000, false, NOW() - INTERVAL '1 day'),
(1, 'Ninh', 1, 50000, false, NOW() - INTERVAL '1 day'),

-- Đ.Anh: 100K (2 penalties)
(2, 'Đ.Anh', 1, 50000, false, NOW() - INTERVAL '1 day'),
(2, 'Đ.Anh', 1, 50000, false, NOW() - INTERVAL '1 day'),

-- Hạnh: 100K (2 penalties)
(3, 'Hạnh', 1, 50000, false, NOW() - INTERVAL '1 day'),
(3, 'Hạnh', 1, 50000, false, NOW() - INTERVAL '1 day'),

-- Linh: 100K (2 penalties)
(4, 'Linh', 1, 50000, false, NOW() - INTERVAL '1 day'),
(4, 'Linh', 1, 50000, false, NOW() - INTERVAL '1 day'),

-- Duy: 100K (2 penalties)
(5, 'Duy', 1, 50000, false, NOW() - INTERVAL '1 day'),
(5, 'Duy', 1, 50000, false, NOW() - INTERVAL '1 day'),

-- Chị Huyền: 50K (1 penalty)
(6, 'Chị Huyền', 1, 50000, false, NOW() - INTERVAL '1 day'),

-- Việt Anh: 150K (3 penalties)
(7, 'Việt Anh', 1, 50000, false, NOW() - INTERVAL '1 day'),
(7, 'Việt Anh', 1, 50000, false, NOW() - INTERVAL '1 day'),
(7, 'Việt Anh', 1, 50000, false, NOW() - INTERVAL '1 day'),

-- Hương: 100K (2 penalties)
(8, 'Hương', 1, 50000, false, NOW() - INTERVAL '1 day'),
(8, 'Hương', 1, 50000, false, NOW() - INTERVAL '1 day'),

-- Thảo: 50K (1 penalty)
(9, 'Thảo', 1, 50000, false, NOW() - INTERVAL '1 day'),

-- Mạnh: 100K (2 penalties)
(10, 'Mạnh', 1, 50000, false, NOW() - INTERVAL '1 day'),
(10, 'Mạnh', 1, 50000, false, NOW() - INTERVAL '1 day');

-- 7. Verify the data
SELECT 
    player_name,
    COUNT(*) as penalty_count,
    SUM(amount) as total_amount
FROM penalties 
GROUP BY player_name
ORDER BY total_amount DESC;

-- 8. Create expenses table
CREATE TABLE IF NOT EXISTS expenses (
    id SERIAL PRIMARY KEY,
    expense_type VARCHAR(50) NOT NULL DEFAULT 'other',
    title VARCHAR(200) NOT NULL,
    amount BIGINT NOT NULL,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 9. Enable RLS for expenses
ALTER TABLE expenses ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow all operations on expenses" ON expenses FOR ALL USING (true);

-- 10. Insert default expenses data
INSERT INTO expenses (expense_type, title, amount, description) VALUES
('court_fee', 'Thuê Sân', 2000000, 'Sân Pickleball Incanto'),
('misc_fee', 'Chi Phí Phát Sinh', 500000, 'Bóng, nước uống, v.v.')
ON CONFLICT DO NOTHING;

-- 11. Check totals
SELECT
    COUNT(*) as total_penalties,
    SUM(amount) as total_amount
FROM penalties;

-- 12. Check expenses
SELECT * FROM expenses ORDER BY expense_type;
