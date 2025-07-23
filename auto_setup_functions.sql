-- Auto Setup Functions for Supabase
-- Run this ONCE in Supabase SQL Editor to create RPC functions

-- Function to create transactions table
CREATE OR REPLACE FUNCTION create_transactions_table()
RETURNS json
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    result json;
BEGIN
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

    -- Create indexes
    CREATE INDEX IF NOT EXISTS idx_transactions_date ON transactions(transaction_date DESC);
    CREATE INDEX IF NOT EXISTS idx_transactions_type ON transactions(transaction_type);

    -- Create updated_at trigger function if not exists
    CREATE OR REPLACE FUNCTION update_updated_at_column()
    RETURNS TRIGGER AS $trigger$
    BEGIN
        NEW.updated_at = NOW();
        RETURN NEW;
    END;
    $trigger$ language 'plpgsql';

    -- Create trigger
    DROP TRIGGER IF EXISTS update_transactions_updated_at ON transactions;
    CREATE TRIGGER update_transactions_updated_at 
        BEFORE UPDATE ON transactions 
        FOR EACH ROW 
        EXECUTE FUNCTION update_updated_at_column();

    -- Enable RLS
    ALTER TABLE transactions ENABLE ROW LEVEL SECURITY;

    -- Create policy
    DROP POLICY IF EXISTS "Allow all operations on transactions" ON transactions;
    CREATE POLICY "Allow all operations on transactions" ON transactions
        FOR ALL USING (true);

    result := json_build_object(
        'success', true,
        'message', 'Transactions table created successfully'
    );
    
    RETURN result;
EXCEPTION
    WHEN OTHERS THEN
        result := json_build_object(
            'success', false,
            'message', 'Error creating transactions table: ' || SQLERRM
        );
        RETURN result;
END;
$$;

-- Function to create penalties table
CREATE OR REPLACE FUNCTION create_penalties_table()
RETURNS json
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    result json;
BEGIN
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

    -- Create indexes
    CREATE INDEX IF NOT EXISTS idx_penalties_paid ON penalties(is_paid);
    CREATE INDEX IF NOT EXISTS idx_penalties_player ON penalties(player_name);
    CREATE INDEX IF NOT EXISTS idx_penalties_date ON penalties(created_at DESC);

    -- Create trigger
    DROP TRIGGER IF EXISTS update_penalties_updated_at ON penalties;
    CREATE TRIGGER update_penalties_updated_at 
        BEFORE UPDATE ON penalties 
        FOR EACH ROW 
        EXECUTE FUNCTION update_updated_at_column();

    -- Enable RLS
    ALTER TABLE penalties ENABLE ROW LEVEL SECURITY;

    -- Create policy
    DROP POLICY IF EXISTS "Allow all operations on penalties" ON penalties;
    CREATE POLICY "Allow all operations on penalties" ON penalties
        FOR ALL USING (true);

    result := json_build_object(
        'success', true,
        'message', 'Penalties table created successfully'
    );
    
    RETURN result;
EXCEPTION
    WHEN OTHERS THEN
        result := json_build_object(
            'success', false,
            'message', 'Error creating penalties table: ' || SQLERRM
        );
        RETURN result;
END;
$$;

-- Function to insert sample data
CREATE OR REPLACE FUNCTION insert_sample_data()
RETURNS json
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    result json;
    transaction_count int;
    penalty_count int;
BEGIN
    -- Check if transactions table has data
    SELECT COUNT(*) INTO transaction_count FROM transactions;
    
    -- Insert sample transactions if empty
    IF transaction_count = 0 THEN
        INSERT INTO transactions (transaction_type, title, amount, description, transaction_date, user_name, icon) VALUES
        ('income', 'Tiền chuyển vào', 550000, 'C Tính ck tiền an', '2025-07-22T09:15:00+07:00', 'Thành viên', 'fas fa-arrow-down'),
        ('expense', 'Thuê sân', 300000, 'Sân pickleball Quận 7', '2025-07-21T14:30:00+07:00', 'Admin', 'fas fa-arrow-up'),
        ('expense', 'Mua nước', 120000, 'Nước uống cho thành viên', '2025-07-21T16:45:00+07:00', 'Admin', 'fas fa-shopping-cart');
    END IF;

    -- Check if penalties table has data
    SELECT COUNT(*) INTO penalty_count FROM penalties;
    
    -- Insert sample penalties if empty
    IF penalty_count = 0 THEN
        INSERT INTO penalties (player_name, amount, reason, match_date, is_paid) VALUES
        ('Nguyễn Văn A', 50000, 'Thua trận', '2025-07-21T14:30:00+07:00', false),
        ('Trần Thị B', 50000, 'Thua trận', '2025-07-21T16:45:00+07:00', false),
        ('Lê Văn C', 50000, 'Thua trận', '2025-07-20T15:00:00+07:00', true);
    END IF;

    result := json_build_object(
        'success', true,
        'message', 'Sample data inserted successfully',
        'transactions_inserted', CASE WHEN transaction_count = 0 THEN 3 ELSE 0 END,
        'penalties_inserted', CASE WHEN penalty_count = 0 THEN 3 ELSE 0 END
    );
    
    RETURN result;
EXCEPTION
    WHEN OTHERS THEN
        result := json_build_object(
            'success', false,
            'message', 'Error inserting sample data: ' || SQLERRM
        );
        RETURN result;
END;
$$;

-- Function to setup storage bucket (this will be called from JavaScript)
CREATE OR REPLACE FUNCTION setup_storage_bucket()
RETURNS json
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    result json;
BEGIN
    -- Note: Storage bucket creation must be done via JavaScript API
    -- This function just returns success for consistency
    result := json_build_object(
        'success', true,
        'message', 'Storage bucket setup should be done via JavaScript API'
    );
    
    RETURN result;
EXCEPTION
    WHEN OTHERS THEN
        result := json_build_object(
            'success', false,
            'message', 'Error in storage setup: ' || SQLERRM
        );
        RETURN result;
END;
$$;

-- Function to run complete auto setup
CREATE OR REPLACE FUNCTION run_auto_setup()
RETURNS json
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    result json;
    transactions_result json;
    penalties_result json;
    sample_data_result json;
    storage_result json;
BEGIN
    -- Step 1: Create transactions table
    SELECT create_transactions_table() INTO transactions_result;
    
    -- Step 2: Create penalties table
    SELECT create_penalties_table() INTO penalties_result;
    
    -- Step 3: Setup storage (placeholder)
    SELECT setup_storage_bucket() INTO storage_result;
    
    -- Step 4: Insert sample data
    SELECT insert_sample_data() INTO sample_data_result;

    result := json_build_object(
        'success', true,
        'message', 'Auto setup completed successfully',
        'steps', json_build_object(
            'transactions', transactions_result,
            'penalties', penalties_result,
            'storage', storage_result,
            'sample_data', sample_data_result
        )
    );
    
    RETURN result;
EXCEPTION
    WHEN OTHERS THEN
        result := json_build_object(
            'success', false,
            'message', 'Auto setup failed: ' || SQLERRM
        );
        RETURN result;
END;
$$;
