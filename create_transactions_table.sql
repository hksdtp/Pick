-- Create transactions table
CREATE TABLE IF NOT EXISTS transactions (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    transaction_type VARCHAR(20) NOT NULL CHECK (transaction_type IN ('income', 'expense')),
    title VARCHAR(255) NOT NULL,
    amount DECIMAL(15,2) NOT NULL,
    description TEXT,
    transaction_date TIMESTAMP WITH TIME ZONE NOT NULL,
    user_name VARCHAR(100) NOT NULL,
    icon VARCHAR(50) DEFAULT 'fas fa-arrow-up',
    receipt_urls TEXT[], -- Array of image URLs
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create index for better performance
CREATE INDEX IF NOT EXISTS idx_transactions_date ON transactions(transaction_date DESC);
CREATE INDEX IF NOT EXISTS idx_transactions_type ON transactions(transaction_type);

-- Create updated_at trigger
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_transactions_updated_at 
    BEFORE UPDATE ON transactions 
    FOR EACH ROW 
    EXECUTE FUNCTION update_updated_at_column();

-- Enable Row Level Security
ALTER TABLE transactions ENABLE ROW LEVEL SECURITY;

-- Create policy to allow all operations (adjust as needed for your security requirements)
CREATE POLICY "Allow all operations on transactions" ON transactions
    FOR ALL USING (true);

-- Insert sample data
INSERT INTO transactions (transaction_type, title, amount, description, transaction_date, user_name, icon) VALUES
('income', 'Tiền chuyển vào', 550000, 'C Tính ck tiền an', '2025-07-22 09:15:00+07', 'Thành viên', 'fas fa-arrow-down'),
('expense', 'Thuê sân', 300000, 'Sân pickleball Quận 7', '2025-07-21 14:30:00+07', 'Admin', 'fas fa-arrow-up'),
('expense', 'Mua nước', 120000, 'Nước uống cho thành viên', '2025-07-21 16:45:00+07', 'Admin', 'fas fa-shopping-cart');

-- Create penalties table
CREATE TABLE IF NOT EXISTS penalties (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    player_name VARCHAR(100) NOT NULL,
    amount DECIMAL(10,2) DEFAULT 50000,
    reason VARCHAR(255) DEFAULT 'Thua trận',
    match_date TIMESTAMP WITH TIME ZONE,
    is_paid BOOLEAN DEFAULT FALSE,
    paid_date TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create index for penalties
CREATE INDEX IF NOT EXISTS idx_penalties_paid ON penalties(is_paid);
CREATE INDEX IF NOT EXISTS idx_penalties_player ON penalties(player_name);
CREATE INDEX IF NOT EXISTS idx_penalties_date ON penalties(created_at DESC);

-- Create updated_at trigger for penalties
CREATE TRIGGER update_penalties_updated_at
    BEFORE UPDATE ON penalties
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- Enable Row Level Security for penalties
ALTER TABLE penalties ENABLE ROW LEVEL SECURITY;

-- Create policy for penalties
CREATE POLICY "Allow all operations on penalties" ON penalties
    FOR ALL USING (true);

-- Insert sample penalty data
INSERT INTO penalties (player_name, amount, reason, match_date, is_paid) VALUES
('Nguyễn Văn A', 50000, 'Thua trận', '2025-07-21 14:30:00+07', false),
('Trần Thị B', 50000, 'Thua trận', '2025-07-21 16:45:00+07', false),
('Lê Văn C', 50000, 'Thua trận', '2025-07-20 15:00:00+07', true);

-- Create storage bucket for receipts (run this in Supabase dashboard or via API)
-- INSERT INTO storage.buckets (id, name, public) VALUES ('receipts', 'receipts', true);

-- Create storage policy for receipts
-- CREATE POLICY "Allow public read access on receipts" ON storage.objects
--     FOR SELECT USING (bucket_id = 'receipts');

-- CREATE POLICY "Allow authenticated upload on receipts" ON storage.objects
--     FOR INSERT WITH CHECK (bucket_id = 'receipts');

-- CREATE POLICY "Allow authenticated update on receipts" ON storage.objects
--     FOR UPDATE USING (bucket_id = 'receipts');

-- CREATE POLICY "Allow authenticated delete on receipts" ON storage.objects
--     FOR DELETE USING (bucket_id = 'receipts');
