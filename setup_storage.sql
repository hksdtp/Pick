-- Setup Storage for receipts
-- Run this in Supabase SQL Editor

-- 1. Create storage bucket for receipts
INSERT INTO storage.buckets (id, name, public) 
VALUES ('receipts', 'receipts', true)
ON CONFLICT (id) DO NOTHING;

-- 2. Create storage policies for receipts bucket

-- Allow public read access (anyone can view images)
CREATE POLICY "Allow public read access on receipts" 
ON storage.objects FOR SELECT 
USING (bucket_id = 'receipts');

-- Allow public upload (anyone can upload images)
CREATE POLICY "Allow public upload on receipts" 
ON storage.objects FOR INSERT 
WITH CHECK (bucket_id = 'receipts');

-- Allow public update (anyone can update images)
CREATE POLICY "Allow public update on receipts" 
ON storage.objects FOR UPDATE 
USING (bucket_id = 'receipts');

-- Allow public delete (anyone can delete images)
CREATE POLICY "Allow public delete on receipts" 
ON storage.objects FOR DELETE 
USING (bucket_id = 'receipts');

-- Alternative: If you want more restrictive policies, use these instead:
-- (Comment out the above policies and uncomment these)

/*
-- Allow authenticated users only
CREATE POLICY "Authenticated users can read receipts" 
ON storage.objects FOR SELECT 
USING (bucket_id = 'receipts' AND auth.role() = 'authenticated');

CREATE POLICY "Authenticated users can upload receipts" 
ON storage.objects FOR INSERT 
WITH CHECK (bucket_id = 'receipts' AND auth.role() = 'authenticated');

CREATE POLICY "Authenticated users can update receipts" 
ON storage.objects FOR UPDATE 
USING (bucket_id = 'receipts' AND auth.role() = 'authenticated');

CREATE POLICY "Authenticated users can delete receipts" 
ON storage.objects FOR DELETE 
USING (bucket_id = 'receipts' AND auth.role() = 'authenticated');
*/

-- 3. Verify bucket creation
SELECT * FROM storage.buckets WHERE id = 'receipts';

-- 4. Verify policies
SELECT * FROM pg_policies WHERE tablename = 'objects' AND policyname LIKE '%receipts%';
