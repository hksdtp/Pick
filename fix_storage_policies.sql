-- Fix Storage Policies for receipts bucket
-- Run this in Supabase SQL Editor to fix upload issues

-- 1. Drop existing policies if any
DROP POLICY IF EXISTS "Allow public read access on receipts" ON storage.objects;
DROP POLICY IF EXISTS "Allow public upload on receipts" ON storage.objects;
DROP POLICY IF EXISTS "Allow public update on receipts" ON storage.objects;
DROP POLICY IF EXISTS "Allow public delete on receipts" ON storage.objects;

-- 2. Create new policies for receipts bucket

-- Allow anyone to read files in receipts bucket
CREATE POLICY "Public read access for receipts"
ON storage.objects FOR SELECT
USING (bucket_id = 'receipts');

-- Allow anyone to upload files to receipts bucket
CREATE POLICY "Public upload access for receipts"
ON storage.objects FOR INSERT
WITH CHECK (bucket_id = 'receipts');

-- Allow anyone to update files in receipts bucket
CREATE POLICY "Public update access for receipts"
ON storage.objects FOR UPDATE
USING (bucket_id = 'receipts')
WITH CHECK (bucket_id = 'receipts');

-- Allow anyone to delete files in receipts bucket
CREATE POLICY "Public delete access for receipts"
ON storage.objects FOR DELETE
USING (bucket_id = 'receipts');

-- 3. Verify bucket exists and is public
UPDATE storage.buckets 
SET public = true 
WHERE id = 'receipts';

-- 4. Check current policies
SELECT 
    schemaname,
    tablename,
    policyname,
    permissive,
    roles,
    cmd,
    qual,
    with_check
FROM pg_policies 
WHERE tablename = 'objects' 
AND policyname LIKE '%receipts%';

-- 5. Check bucket configuration
SELECT id, name, public, created_at 
FROM storage.buckets 
WHERE id = 'receipts';
