-- =====================================================
-- PENALTY FUND MANAGEMENT SYSTEM
-- =====================================================

-- Create penalties table
CREATE TABLE IF NOT EXISTS penalties (
    id SERIAL PRIMARY KEY,
    player_id INTEGER NOT NULL,
    player_name VARCHAR(100) NOT NULL,
    match_id BIGINT NOT NULL,
    amount INTEGER DEFAULT 50000, -- Penalty amount in VND
    is_paid BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    paid_at TIMESTAMP WITH TIME ZONE NULL
);

-- Create fund_status table to track current fund
CREATE TABLE IF NOT EXISTS fund_status (
    id SERIAL PRIMARY KEY,
    current_amount BIGINT DEFAULT 2000000, -- Starting fund: 2,000,000 VND
    target_amount BIGINT DEFAULT 5000000,  -- Target: 5,000,000 VND
    reward_description TEXT DEFAULT 'Đi ăn Lẩu Hải sản',
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Insert initial fund status if not exists
INSERT INTO fund_status (current_amount, target_amount, reward_description) 
SELECT 2000000, 5000000, 'Đi ăn Lẩu Hải sản'
WHERE NOT EXISTS (SELECT 1 FROM fund_status);

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_penalties_player_id ON penalties(player_id);
CREATE INDEX IF NOT EXISTS idx_penalties_match_id ON penalties(match_id);
CREATE INDEX IF NOT EXISTS idx_penalties_is_paid ON penalties(is_paid);

-- Enable RLS
ALTER TABLE penalties ENABLE ROW LEVEL SECURITY;
ALTER TABLE fund_status ENABLE ROW LEVEL SECURITY;

-- Create policies for authenticated users
CREATE POLICY "Allow all operations for authenticated users" ON penalties
    FOR ALL USING (true);

CREATE POLICY "Allow all operations for authenticated users" ON fund_status
    FOR ALL USING (true);

-- Create function to update fund when penalty is paid
CREATE OR REPLACE FUNCTION update_fund_on_penalty_payment()
RETURNS TRIGGER AS $$
BEGIN
    -- If penalty is being marked as paid
    IF NEW.is_paid = TRUE AND OLD.is_paid = FALSE THEN
        -- Add penalty amount to current fund
        UPDATE fund_status 
        SET current_amount = current_amount + NEW.amount,
            updated_at = NOW()
        WHERE id = 1;
        
        -- Set paid_at timestamp
        NEW.paid_at = NOW();
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger for automatic fund updates
DROP TRIGGER IF EXISTS penalty_payment_trigger ON penalties;
CREATE TRIGGER penalty_payment_trigger
    BEFORE UPDATE ON penalties
    FOR EACH ROW
    EXECUTE FUNCTION update_fund_on_penalty_payment();

-- Create view for penalty summary
CREATE OR REPLACE VIEW penalty_summary AS
SELECT 
    p.id,
    p.player_id,
    p.player_name,
    p.match_id,
    p.amount,
    p.is_paid,
    p.created_at,
    p.paid_at,
    CASE 
        WHEN p.is_paid THEN 'Đã thanh toán'
        ELSE 'Chưa thanh toán'
    END as status
FROM penalties p
ORDER BY p.is_paid ASC, p.created_at DESC;
