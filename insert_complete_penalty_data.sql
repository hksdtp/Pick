-- =====================================================
-- INSERT COMPLETE PENALTY DATA FROM PREVIOUS WEEK
-- =====================================================

-- First, clear existing penalty data to avoid confusion
DELETE FROM penalties WHERE match_id = 1;

-- Insert complete penalty data based on the list provided
-- Each penalty is 50K, so we create multiple records for each player

-- Ninh: 150K = 3 penalties
INSERT INTO penalties (player_id, player_name, match_id, amount, is_paid, created_at) VALUES
(1, 'Ninh', 1, 50000, false, NOW() - INTERVAL '1 day'),
(1, 'Ninh', 1, 50000, false, NOW() - INTERVAL '1 day'),
(1, 'Ninh', 1, 50000, false, NOW() - INTERVAL '1 day'),

-- Đ.Anh: 100K = 2 penalties
(2, 'Đ.Anh', 1, 50000, false, NOW() - INTERVAL '1 day'),
(2, 'Đ.Anh', 1, 50000, false, NOW() - INTERVAL '1 day'),

-- Hạnh: 100K = 2 penalties
(3, 'Hạnh', 1, 50000, false, NOW() - INTERVAL '1 day'),
(3, 'Hạnh', 1, 50000, false, NOW() - INTERVAL '1 day'),

-- Linh: 100K = 2 penalties
(4, 'Linh', 1, 50000, false, NOW() - INTERVAL '1 day'),
(4, 'Linh', 1, 50000, false, NOW() - INTERVAL '1 day'),

-- Duy: 100K = 2 penalties
(5, 'Duy', 1, 50000, false, NOW() - INTERVAL '1 day'),
(5, 'Duy', 1, 50000, false, NOW() - INTERVAL '1 day'),

-- Chị Huyền: 50K = 1 penalty
(6, 'Chị Huyền', 1, 50000, false, NOW() - INTERVAL '1 day'),

-- Việt Anh (V.A): 150K = 3 penalties
(7, 'Việt Anh', 1, 50000, false, NOW() - INTERVAL '1 day'),
(7, 'Việt Anh', 1, 50000, false, NOW() - INTERVAL '1 day'),
(7, 'Việt Anh', 1, 50000, false, NOW() - INTERVAL '1 day'),

-- Hương: 100K = 2 penalties
(8, 'Hương', 1, 50000, false, NOW() - INTERVAL '1 day'),
(8, 'Hương', 1, 50000, false, NOW() - INTERVAL '1 day'),

-- Thảo: 50K = 1 penalty
(9, 'Thảo', 1, 50000, false, NOW() - INTERVAL '1 day'),

-- Mạnh: 100K = 2 penalties
(10, 'Mạnh', 1, 50000, false, NOW() - INTERVAL '1 day'),
(10, 'Mạnh', 1, 50000, false, NOW() - INTERVAL '1 day');

-- Verify the complete data
SELECT 
    player_name,
    COUNT(*) as penalty_count,
    SUM(amount) as total_amount
FROM penalties 
WHERE match_id = 1
GROUP BY player_name
ORDER BY total_amount DESC, player_name;

-- Check total summary
SELECT 
    COUNT(*) as total_penalties,
    SUM(amount) as total_amount,
    COUNT(CASE WHEN is_paid THEN 1 END) as paid_count,
    COUNT(CASE WHEN NOT is_paid THEN 1 END) as unpaid_count
FROM penalties 
WHERE match_id = 1;

-- Expected result should be:
-- 21 total penalties
-- 1,050,000 VNĐ total amount
-- 0 paid, 21 unpaid
