-- =====================================================
-- CLEAN DUPLICATE PENALTIES
-- =====================================================

-- 1. First, check what duplicates exist
SELECT 
    player_name,
    match_id,
    amount,
    COUNT(*) as duplicate_count,
    MIN(id) as keep_id,
    ARRAY_AGG(id ORDER BY id) as all_ids
FROM penalties
GROUP BY player_name, match_id, amount
HAVING COUNT(*) > 1;

-- 2. Delete duplicates, keeping only the first record for each player/match/amount
DELETE FROM penalties 
WHERE id NOT IN (
    SELECT MIN(id)
    FROM penalties
    GROUP BY player_name, match_id, amount
);

-- 3. Verify clean data
SELECT 
    player_name,
    COUNT(*) as penalty_count,
    SUM(amount) as total_amount
FROM penalties 
GROUP BY player_name
ORDER BY total_amount DESC;

-- 4. Check total after cleanup
SELECT 
    COUNT(*) as total_penalties,
    SUM(amount) as total_amount,
    COUNT(CASE WHEN is_paid THEN 1 END) as paid_count,
    COUNT(CASE WHEN NOT is_paid THEN 1 END) as unpaid_count
FROM penalties;
