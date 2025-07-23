# 🔧 Storage Fix Guide - Sửa lỗi Upload

## ⚠️ **Vấn đề hiện tại:**

Bucket "receipts" đã tồn tại nhưng upload bị lỗi:
```
❌ 403 Unauthorized: new row violates row-level security policy
```

**Nguyên nhân:** Storage RLS policies chưa được cấu hình đúng.

## 🎯 **3 cách fix:**

### **Cách 1: Chạy SQL Script (Recommended)**
1. **Vào Supabase Dashboard** → **SQL Editor**
2. **Chạy file**: `fix_storage_policies.sql`
3. **Test**: Click nút 🌩️ trong app

### **Cách 2: Sử dụng nút Fix trong App**
1. **Click nút 🔧 Fix Storage** (màu cam)
2. **Nhập mật khẩu**: "111"
3. **Copy SQL** từ console → Chạy trong Supabase
4. **Test**: Click nút 🌩️

### **Cách 3: Tạo Policies thủ công**
1. **Supabase Dashboard** → **Storage** → **Policies**
2. **New Policy** → **For INSERT**:
   ```sql
   CREATE POLICY "Public upload access for receipts"
   ON storage.objects FOR INSERT
   WITH CHECK (bucket_id = 'receipts');
   ```
3. **New Policy** → **For SELECT**:
   ```sql
   CREATE POLICY "Public read access for receipts"
   ON storage.objects FOR SELECT
   USING (bucket_id = 'receipts');
   ```

## 🧪 **Test sau khi fix:**

### **Bước 1: Test Storage**
- **Click nút 🌩️** (xanh dương)
- **Kết quả mong đợi**: "✅ Storage upload hoạt động hoàn hảo!"

### **Bước 2: Test Upload ảnh thật**
- **Nút ➕** → Thêm giao dịch
- **"Thêm ảnh hóa đơn"** → Chọn ảnh
- **Lưu** → Ảnh hiển thị trong chi tiết

## 🎯 **Kết quả sau fix:**

### **✅ Upload hoạt động:**
- Test file upload: OK
- Upload ảnh hóa đơn: OK
- Xem ảnh fullscreen: OK
- Public URLs: Accessible

### **🎮 App hoàn chỉnh 100%:**
- Database: ✅ Sync real-time
- Storage: ✅ Upload ảnh
- Features: ✅ Tất cả hoạt động
- Security: ✅ RLS configured

## 🚀 **Quick Fix (30 giây):**

```sql
-- Copy/paste vào Supabase SQL Editor:

CREATE POLICY "Public upload access for receipts"
ON storage.objects FOR INSERT
WITH CHECK (bucket_id = 'receipts');

CREATE POLICY "Public read access for receipts"
ON storage.objects FOR SELECT
USING (bucket_id = 'receipts');
```

**Sau đó test nút 🌩️ → Done! 🏓**

## 📋 **Troubleshooting:**

### **Nếu vẫn lỗi 403:**
1. Check bucket tồn tại: Storage → receipts ✅
2. Check bucket public: receipts → Public ✅
3. Check policies: SQL Editor → `SELECT * FROM pg_policies WHERE tablename = 'objects'`

### **Nếu policies không tạo được:**
1. Check permissions: Bạn có quyền admin?
2. Try different syntax: Dùng Dashboard UI thay vì SQL
3. Contact support: Supabase Discord/GitHub

## 🎉 **Sau khi fix thành công:**

App sẽ hoạt động hoàn hảo:
- 💰 **Quản lý tài chính**: Thu/chi với ảnh
- 🚫 **Quản lý phạt**: Reset tự động
- 📱 **Mobile-first**: UI như native app
- 🔄 **Real-time**: Sync đa thiết bị

**Perfect Pickleball Club App! 🏓🎉**
