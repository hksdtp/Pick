-- =====================================================
-- INSERT EXPENSES WITH CORRECT STRUCTURE
-- =====================================================
-- Based on the table structure we found

-- Clear existing data
DELETE FROM expenses;

-- Insert data with all required columns
INSERT INTO expenses (
    id, 
    expense_id, 
    description, 
    amount, 
    expense_date, 
    expense_type,
    receipt_url
) VALUES
(
    1, 
    1, 
    'Thuê Sân Pickleball Incanto', 
    2000000, 
    CURRENT_DATE, 
    'court_fee',
    NULL
),
(
    2, 
    2, 
    'Chi phí phát sinh: bóng, nước uống, v.v.', 
    500000, 
    CURRENT_DATE, 
    'misc_fee',
    NULL
);

-- Verify the inserted data
SELECT * FROM expenses ORDER BY id;
