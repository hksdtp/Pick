-- =====================================================
-- PICKLEBALL CLUB DATA RESET SCRIPT
-- =====================================================
-- Sử dụng script này để reset toàn bộ dữ liệu về trạng thái ban đầu
-- CẢNH BÁO: Script này sẽ XÓA TẤT CẢ dữ liệu hiện có!

-- 1. Reset tất cả thống kê người chơi về mặc định
UPDATE players SET
    elo = 1000,                    -- ELO mặc định
    matches = 0,                   -- Số trận = 0
    wins = 0,                      -- Số thắng = 0  
    rank_points = 0,               -- Rank points = 0
    streak = 0,                    -- Streak = 0
    last_rank_change = 0           -- Thay đổi điểm gần nhất = 0
WHERE player_id > 0;

-- 2. Xóa toàn bộ lịch sử trận đấu
DELETE FROM match_history;

-- 3. Xóa toàn bộ lịch sử team combinations
DELETE FROM team_combinations;

-- 4. Xóa toàn bộ lịch sử opponent combinations  
DELETE FROM opponent_combinations;

-- 5. Reset auto-increment sequences (nếu cần)
-- ALTER SEQUENCE match_history_id_seq RESTART WITH 1;
-- ALTER SEQUENCE team_combinations_id_seq RESTART WITH 1;
-- ALTER SEQUENCE opponent_combinations_id_seq RESTART WITH 1;

-- =====================================================
-- VERIFICATION QUERIES
-- =====================================================
-- Chạy các query này để kiểm tra reset thành công:

-- Kiểm tra players đã reset
SELECT 
    name,
    elo,
    matches, 
    wins,
    rank_points,
    streak
FROM players 
ORDER BY name;

-- Kiểm tra các bảng đã trống
SELECT 'match_history' as table_name, COUNT(*) as record_count FROM match_history
UNION ALL
SELECT 'team_combinations', COUNT(*) FROM team_combinations  
UNION ALL
SELECT 'opponent_combinations', COUNT(*) FROM opponent_combinations;

-- Kiểm tra player rankings sau reset
SELECT * FROM player_rankings ORDER BY name;

-- =====================================================
-- EXPECTED RESULTS AFTER RESET
-- =====================================================
/*
Sau khi reset thành công:

1. TẤT CẢ PLAYERS:
   - ELO: 1000
   - Matches: 0  
   - Wins: 0
   - Rank Points: 0
   - Streak: 0
   - Rank Name: "Đồng"
   - Position: Theo thứ tự alphabet

2. LỊCH SỬ TRẬN ĐẤU: Trống (0 records)

3. TEAM COMBINATIONS: Trống (0 records)

4. OPPONENT COMBINATIONS: Trống (0 records)

5. PLAYER RANKINGS VIEW:
   - Tất cả cùng rank "Đồng"
   - Position theo thứ tự tên
   - Win rate: 0%
   - Streak: 0
*/

-- =====================================================
-- USAGE INSTRUCTIONS
-- =====================================================
/*
CÁCH SỬ DỤNG:

1. TRONG SUPABASE DASHBOARD:
   - Vào SQL Editor
   - Copy toàn bộ script này
   - Chạy từng phần hoặc toàn bộ
   - Kiểm tra kết quả bằng verification queries

2. TRONG ỨNG DỤNG:
   - Vào tab "Xếp hạng"  
   - Nhấn nút "Reset dữ liệu" (đỏ)
   - Xác nhận 2 lần
   - Nhập mật khẩu: 111
   - Chờ reset hoàn tất

3. SAU KHI RESET:
   - Tất cả người chơi về ELO 1000
   - Sẵn sàng cho season mới
   - Thuật toán tạo đội sẽ random hoàn toàn
   - Lần đầu chơi sẽ không có bias
*/
