-- =====================================================
-- CHECK EXPENSES AND PENALTIES SYNC
-- =====================================================

-- 1. Check current expenses
SELECT 
    id,
    expense_id,
    expense_type,
    description,
    amount,
    expense_date
FROM expenses 
ORDER BY id;

-- 2. Check penalties (should not be duplicated)
SELECT 
    player_name,
    COUNT(*) as penalty_count,
    SUM(amount) as total_amount,
    COUNT(CASE WHEN is_paid THEN 1 END) as paid_count,
    COUNT(CASE WHEN NOT is_paid THEN 1 END) as unpaid_count
FROM penalties 
GROUP BY player_name
ORDER BY total_amount DESC;

-- 3. Check for duplicate penalties
SELECT 
    player_name,
    match_id,
    amount,
    COUNT(*) as duplicate_count
FROM penalties
GROUP BY player_name, match_id, amount
HAVING COUNT(*) > 1;

-- 4. Check fund status
SELECT * FROM fund_status;

-- 5. Total summary
SELECT 
    'Expenses' as type,
    COUNT(*) as count,
    SUM(amount) as total_amount
FROM expenses
UNION ALL
SELECT 
    'Penalties' as type,
    COUNT(*) as count,
    SUM(amount) as total_amount
FROM penalties
UNION ALL
SELECT 
    'Unpaid Penalties' as type,
    COUNT(*) as count,
    SUM(amount) as total_amount
FROM penalties
WHERE NOT is_paid;
