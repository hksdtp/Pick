-- =====================================================
-- BATCH PENALTY PAYMENT SCRIPT
-- =====================================================
-- Use this to mark multiple penalties as paid at once

-- Example: Mark all Ninh's penalties as paid
UPDATE penalties 
SET is_paid = true, paid_at = NOW()
WHERE player_name = 'Ninh' AND is_paid = false;

-- Example: Mark all Hương's penalties as paid  
UPDATE penalties 
SET is_paid = true, paid_at = NOW()
WHERE player_name = 'Hương' AND is_paid = false;

-- Update fund status after batch payments
UPDATE fund_status 
SET current_amount = 2000000 + (
    SELECT COALESCE(SUM(amount), 0) 
    FROM penalties 
    WHERE is_paid = true
),
updated_at = NOW()
WHERE id = 1;

-- Verify results
SELECT 
    player_name,
    COUNT(CASE WHEN is_paid THEN 1 END) as paid_count,
    SUM(CASE WHEN is_paid THEN amount ELSE 0 END) as paid_amount,
    COUNT(CASE WHEN NOT is_paid THEN 1 END) as unpaid_count
FROM penalties 
GROUP BY player_name
ORDER BY player_name;

-- Check fund status
SELECT 
    current_amount,
    target_amount,
    ROUND((current_amount::numeric / target_amount * 100), 2) as percentage
FROM fund_status;
