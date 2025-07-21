-- =====================================================
-- SYNC FUND STATUS WITH PAID PENALTIES
-- =====================================================

-- 1. Check current situation
SELECT 
    'Current Fund' as item,
    current_amount as amount
FROM fund_status
UNION ALL
SELECT 
    'Paid Penalties' as item,
    COALESCE(SUM(amount), 0) as amount
FROM penalties 
WHERE is_paid = true;

-- 2. Calculate correct fund amount
-- Initial fund (2M from expenses) + paid penalties
UPDATE fund_status 
SET current_amount = 2000000 + (
    SELECT COALESCE(SUM(amount), 0) 
    FROM penalties 
    WHERE is_paid = true
),
updated_at = NOW()
WHERE id = 1;

-- 3. Verify the update
SELECT
    current_amount,
    target_amount,
    ROUND((current_amount::numeric / target_amount * 100), 2) as percentage,
    (target_amount - current_amount) as remaining_needed
FROM fund_status;

-- 4. Show penalty payment summary
SELECT 
    player_name,
    COUNT(CASE WHEN is_paid THEN 1 END) as paid_count,
    SUM(CASE WHEN is_paid THEN amount ELSE 0 END) as paid_amount,
    COUNT(CASE WHEN NOT is_paid THEN 1 END) as unpaid_count,
    SUM(CASE WHEN NOT is_paid THEN amount ELSE 0 END) as unpaid_amount
FROM penalties 
GROUP BY player_name
HAVING COUNT(CASE WHEN is_paid THEN 1 END) > 0
ORDER BY paid_amount DESC;
