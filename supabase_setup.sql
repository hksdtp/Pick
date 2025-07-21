-- Supabase Setup cho Pickleball Incanto Club
-- Chạy script này trong Supabase SQL Editor

-- 1. Tạo bảng players (người chơi)
CREATE TABLE IF NOT EXISTS players (
  id SERIAL PRIMARY KEY,
  player_id INTEGER NOT NULL UNIQUE,
  name VARCHAR(100) NOT NULL,
  elo INTEGER DEFAULT 0,
  matches INTEGER DEFAULT 0,
  wins INTEGER DEFAULT 0,
  rank_points INTEGER DEFAULT 0,
  streak INTEGER DEFAULT 0,
  last_rank_change INTEGER DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. Tạo bảng match_history (lịch sử trận đấu)
CREATE TABLE IF NOT EXISTS match_history (
  id SERIAL PRIMARY KEY,
  match_id BIGINT NOT NULL,
  match_date TIMESTAMP WITH TIME ZONE NOT NULL,
  team_a_player1_id INTEGER REFERENCES players(player_id),
  team_a_player1_name VARCHAR(100),
  team_a_player2_id INTEGER REFERENCES players(player_id),
  team_a_player2_name VARCHAR(100),
  team_b_player1_id INTEGER REFERENCES players(player_id),
  team_b_player1_name VARCHAR(100),
  team_b_player2_id INTEGER REFERENCES players(player_id),
  team_b_player2_name VARCHAR(100),
  score_a INTEGER NOT NULL,
  score_b INTEGER NOT NULL,
  winner CHAR(1) NOT NULL CHECK (winner IN ('A', 'B')),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 3. Tạo bảng expenses (chi phí)
CREATE TABLE IF NOT EXISTS expenses (
  id SERIAL PRIMARY KEY,
  expense_id BIGINT NOT NULL,
  description TEXT NOT NULL,
  amount INTEGER NOT NULL,
  expense_date DATE NOT NULL,
  expense_type VARCHAR(50) NOT NULL,
  receipt_url TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 4. Tạo bảng team_matrix (ma trận đội)
CREATE TABLE IF NOT EXISTS team_combinations (
  id SERIAL PRIMARY KEY,
  team_key VARCHAR(20) NOT NULL UNIQUE,
  player1_id INTEGER NOT NULL,
  player2_id INTEGER NOT NULL,
  combination_count INTEGER DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 5. Tạo bảng opponent_matrix (ma trận đối thủ)
CREATE TABLE IF NOT EXISTS opponent_combinations (
  id SERIAL PRIMARY KEY,
  opponent_key VARCHAR(20) NOT NULL UNIQUE,
  player1_id INTEGER NOT NULL,
  player2_id INTEGER NOT NULL,
  match_count INTEGER DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 6. Tạo indexes để tối ưu performance
CREATE INDEX IF NOT EXISTS idx_players_player_id ON players(player_id);
CREATE INDEX IF NOT EXISTS idx_players_rank_points ON players(rank_points DESC);
CREATE INDEX IF NOT EXISTS idx_match_history_date ON match_history(match_date DESC);
CREATE INDEX IF NOT EXISTS idx_match_history_match_id ON match_history(match_id);
CREATE INDEX IF NOT EXISTS idx_expenses_date ON expenses(expense_date DESC);
CREATE INDEX IF NOT EXISTS idx_team_combinations_key ON team_combinations(team_key);
CREATE INDEX IF NOT EXISTS idx_opponent_combinations_key ON opponent_combinations(opponent_key);

-- 7. Tạo function để tự động update timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- 8. Tạo triggers cho auto-update timestamp
CREATE TRIGGER update_players_updated_at BEFORE UPDATE ON players
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_team_combinations_updated_at BEFORE UPDATE ON team_combinations
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_opponent_combinations_updated_at BEFORE UPDATE ON opponent_combinations
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- 9. Insert dữ liệu mẫu (10 người chơi với điểm 0)
INSERT INTO players (player_id, name, elo, matches, wins, rank_points, streak, last_rank_change) VALUES
(1, 'Chị Hạnh', 0, 0, 0, 0, 0, 0),
(2, 'Thảo', 0, 0, 0, 0, 0, 0),
(3, 'Hương', 0, 0, 0, 0, 0, 0),
(4, 'Chị Huyền', 0, 0, 0, 0, 0, 0),
(5, 'Tính', 0, 0, 0, 0, 0, 0),
(6, 'Ninh', 0, 0, 0, 0, 0, 0),
(7, 'Linh', 0, 0, 0, 0, 0, 0),
(8, 'Mạnh', 0, 0, 0, 0, 0, 0),
(9, 'Việt Anh', 0, 0, 0, 0, 0, 0),
(10, 'Duy', 0, 0, 0, 0, 0, 0)
ON CONFLICT (player_id) DO NOTHING;

-- 10. Tạo RLS (Row Level Security) policies nếu cần
-- ALTER TABLE players ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE match_history ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE expenses ENABLE ROW LEVEL SECURITY;

-- 11. Tạo view để xem ranking
CREATE OR REPLACE VIEW player_rankings AS
SELECT 
    player_id,
    name,
    elo,
    matches,
    wins,
    CASE 
        WHEN matches > 0 THEN ROUND((wins::DECIMAL / matches::DECIMAL) * 100, 1)
        ELSE 0 
    END as win_rate,
    rank_points,
    CASE 
        WHEN rank_points >= 0 AND rank_points <= 29 THEN 'Đồng'
        WHEN rank_points >= 30 AND rank_points <= 59 THEN 'Bạc'
        WHEN rank_points >= 60 AND rank_points <= 89 THEN 'Vàng'
        WHEN rank_points >= 90 AND rank_points <= 119 THEN 'Kim Cương'
        WHEN rank_points >= 120 THEN 'Thách Đấu'
        ELSE 'Đồng'
    END as rank_name,
    streak,
    last_rank_change,
    ROW_NUMBER() OVER (ORDER BY rank_points DESC, wins DESC, matches ASC) as position
FROM players
ORDER BY rank_points DESC, wins DESC, matches ASC;

-- Hoàn thành setup!
-- Bây giờ có thể sử dụng ứng dụng với Supabase
