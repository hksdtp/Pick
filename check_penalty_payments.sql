-- =====================================================
-- CHECK PENALTY PAYMENTS AND FUND STATUS
-- =====================================================

-- 1. Check which penalties have been paid
SELECT 
    player_name,
    COUNT(*) as total_penalties,
    COUNT(CASE WHEN is_paid THEN 1 END) as paid_penalties,
    COUNT(CASE WHEN NOT is_paid THEN 1 END) as unpaid_penalties,
    SUM(CASE WHEN is_paid THEN amount ELSE 0 END) as paid_amount,
    SUM(CASE WHEN NOT is_paid THEN amount ELSE 0 END) as unpaid_amount
FROM penalties 
GROUP BY player_name
ORDER BY player_name;

-- 2. Check total paid vs unpaid
SELECT 
    'Total Penalties' as status,
    COUNT(*) as count,
    SUM(amount) as amount
FROM penalties
UNION ALL
SELECT 
    'Paid Penalties' as status,
    COUNT(*) as count,
    SUM(amount) as amount
FROM penalties WHERE is_paid = true
UNION ALL
SELECT 
    'Unpaid Penalties' as status,
    COUNT(*) as count,
    SUM(amount) as amount
FROM penalties WHERE is_paid = false;

-- 3. Check current fund status
SELECT 
    current_amount,
    target_amount,
    (current_amount::float / target_amount * 100) as percentage
FROM fund_status;

-- 4. Calculate what fund should be
SELECT 
    2000000 as initial_fund,
    SUM(CASE WHEN is_paid THEN amount ELSE 0 END) as paid_penalties,
    (2000000 + SUM(CASE WHEN is_paid THEN amount ELSE 0 END)) as expected_fund
FROM penalties;
