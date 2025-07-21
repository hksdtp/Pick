-- =====================================================
-- INSERT PENALTY DATA FROM PREVIOUS MATCHES
-- =====================================================
-- Danh sách phạt từ trận đấu trước đó

-- Insert penalty records for previous match
-- Using match_id = 1 for the previous match
INSERT INTO penalties (player_id, player_name, match_id, amount, is_paid, created_at) VALUES
-- Ninh: 150K (3 penalties of 50K each)
(1, 'Ninh', 1, 50000, false, NOW() - INTERVAL '1 day'),
(1, 'Ninh', 1, 50000, false, NOW() - INTERVAL '1 day'),
(1, 'Ninh', 1, 50000, false, NOW() - INTERVAL '1 day'),

-- Đ.Anh: 100K (2 penalties of 50K each)
(2, 'Đ.Anh', 1, 50000, false, NOW() - INTERVAL '1 day'),
(2, 'Đ.Anh', 1, 50000, false, NOW() - INTERVAL '1 day'),

-- Hạnh: 100K (2 penalties of 50K each)
(3, 'Hạnh', 1, 50000, false, NOW() - INTERVAL '1 day'),
(3, 'Hạnh', 1, 50000, false, NOW() - INTERVAL '1 day'),

-- Linh: 100K (2 penalties of 50K each)
(4, 'Linh', 1, 50000, false, NOW() - INTERVAL '1 day'),
(4, 'Linh', 1, 50000, false, NOW() - INTERVAL '1 day'),

-- Duy: 100K (2 penalties of 50K each)
(5, 'Duy', 1, 50000, false, NOW() - INTERVAL '1 day'),
(5, 'Duy', 1, 50000, false, NOW() - INTERVAL '1 day'),

-- Chị Huyền: 50K (1 penalty)
(6, 'Chị Huyền', 1, 50000, false, NOW() - INTERVAL '1 day'),

-- Việt Anh: 150K (3 penalties of 50K each)
(7, 'Việt Anh', 1, 50000, false, NOW() - INTERVAL '1 day'),
(7, 'Việt Anh', 1, 50000, false, NOW() - INTERVAL '1 day'),
(7, 'Việt Anh', 1, 50000, false, NOW() - INTERVAL '1 day'),

-- Hương: 100K (2 penalties of 50K each)
(8, 'Hương', 1, 50000, false, NOW() - INTERVAL '1 day'),
(8, 'Hương', 1, 50000, false, NOW() - INTERVAL '1 day'),

-- Thảo: 50K (1 penalty)
(9, 'Thảo', 1, 50000, false, NOW() - INTERVAL '1 day'),

-- Mạnh: 100K (2 penalties of 50K each)
(10, 'Mạnh', 1, 50000, false, NOW() - INTERVAL '1 day'),
(10, 'Mạnh', 1, 50000, false, NOW() - INTERVAL '1 day');

-- Verify the inserted data
SELECT 
    player_name,
    COUNT(*) as penalty_count,
    SUM(amount) as total_amount,
    CASE 
        WHEN is_paid THEN 'Đã thanh toán'
        ELSE 'Chưa thanh toán'
    END as status
FROM penalties 
WHERE match_id = 1
GROUP BY player_name, is_paid
ORDER BY total_amount DESC, player_name;

-- Check total penalties
SELECT 
    COUNT(*) as total_penalties,
    SUM(amount) as total_amount,
    COUNT(CASE WHEN is_paid THEN 1 END) as paid_count,
    COUNT(CASE WHEN NOT is_paid THEN 1 END) as unpaid_count
FROM penalties 
WHERE match_id = 1;
