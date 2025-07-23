# 📁 Storage Setup Manual - Tạo bucket receipts

## ⚠️ **Lỗi Storage RLS Policy:**

Auto Setup đã thành công tạo database, nhưng gặp lỗi:
```
❌ new row violates row-level security policy
```

**Nguyên nhân:** Supabase Storage có RLS policy nghiêm ngặt, không cho phép tạo bucket qua API.

## 🔧 **Giải pháp: Tạo bucket thủ công**

### **Bước 1: Vào Supabase Dashboard**
1. Truy cập: https://supabase.com/dashboard/project/sevuymqauqrvsszyukbn
2. Đăng nhập tài khoản Supabase

### **Bước 2: Tạo Storage Bucket**
1. Sidebar → **Storage**
2. Click **"New bucket"**
3. **Bucket name**: `receipts`
4. **Public bucket**: ✅ **Enabled**
5. Click **"Create bucket"**

### **Bước 3: Cấu hình Policies (Tùy chọn)**
Nếu muốn policies tự động, chạy SQL này:

```sql
-- Allow public read access
CREATE POLICY "Allow public read access on receipts" 
ON storage.objects FOR SELECT 
USING (bucket_id = 'receipts');

-- Allow public upload
CREATE POLICY "Allow public upload on receipts" 
ON storage.objects FOR INSERT 
WITH CHECK (bucket_id = 'receipts');

-- Allow public update
CREATE POLICY "Allow public update on receipts" 
ON storage.objects FOR UPDATE 
USING (bucket_id = 'receipts');

-- Allow public delete
CREATE POLICY "Allow public delete on receipts" 
ON storage.objects FOR DELETE 
USING (bucket_id = 'receipts');
```

### **Bước 4: Kiểm tra hoạt động**
1. Vào app → Tab "Chi phí"
2. Thêm giao dịch mới → Upload ảnh
3. ✅ Nếu upload thành công = Done!

## 🎯 **Kết quả Auto Setup:**

### **✅ Đã hoàn thành:**
- ✅ **Database Tables**: transactions, penalties
- ✅ **Sample Data**: 3 giao dịch + 3 phạt
- ✅ **Indexes & Triggers**: Đầy đủ
- ✅ **RLS Policies**: Configured

### **⚠️ Cần làm thủ công:**
- 📁 **Storage Bucket**: Tạo "receipts" trong Dashboard
- 🔒 **Storage Policies**: Chạy SQL (tùy chọn)

## 🚀 **App đã sẵn sàng 95%!**

Chỉ cần tạo bucket "receipts" là hoàn tất 100%:

### **Trước tạo bucket:**
- ✅ Xem giao dịch: OK
- ✅ Thêm giao dịch: OK  
- ❌ Upload ảnh: Lỗi 403

### **Sau tạo bucket:**
- ✅ Xem giao dịch: OK
- ✅ Thêm giao dịch: OK
- ✅ Upload ảnh: OK
- ✅ **Perfect! 100%**

## 📱 **Quick Fix:**

```bash
1. Supabase Dashboard → Storage → New bucket
2. Name: "receipts", Public: ✅
3. Create → Done!
```

**Chỉ mất 30 giây! 🏓**
