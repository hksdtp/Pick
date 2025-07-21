-- =====================================================
-- EXPENSES TABLE FOR PICKLEBALL CLUB
-- =====================================================

-- Create expenses table
CREATE TABLE IF NOT EXISTS expenses (
    id SERIAL PRIMARY KEY,
    expense_type VARCHAR(50) NOT NULL, -- 'court_fee' or 'misc_fee'
    title VARCHAR(100) NOT NULL,
    amount BIGINT NOT NULL, -- Amount in VND
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Insert default data
INSERT INTO expenses (expense_type, title, amount, description) VALUES
('court_fee', 'Thuê Sân', 2000000, 'Sân Pickleball Incanto'),
('misc_fee', 'Chi Phí Phát Sinh', 500000, 'Bóng, nước uống, v.v.')
ON CONFLICT DO NOTHING;

-- Create RLS policies (if needed)
ALTER TABLE expenses ENABLE ROW LEVEL SECURITY;

-- Allow all operations for authenticated users
CREATE POLICY "Allow all operations for authenticated users" ON expenses
    FOR ALL USING (true);

-- Create updated_at trigger
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_expenses_updated_at 
    BEFORE UPDATE ON expenses 
    FOR EACH ROW 
    EXECUTE FUNCTION update_updated_at_column();
